#!/usr/bin/perl
#
# vim: ai ts=1 sts=1 et sw=1 ft=perl
#
# Copyright (c) 2013, Michael Fladischer <michael.fladischer@medunigraz.at>
#               2013, Peter Reibnegger <peter.reibnegger@medunigraz.at>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

package KarlTheodor::Middleware;

# We try to use clean coding style.
use strict;
use warnings;

# Load system packages.
use Encode qw(encode);
use Getopt::Long;
use Config::General;
use Pod::Usage;
use Log::Log4perl;
use Storable;
use Array::Diff;
use MIME::Base64;
use Data::UUID;
use List::Util;
use Try::Tiny;
use DateTime;
use LWP::UserAgent;
use IPC::Run;
use JSON;

# Load webservices packages.
use CAMPUSonline::ThesisTypes::SimpleThesisType;
use CAMPUSonline::ThesisTypes::SimpleKeyType;
use CAMPUSonline::ThesisInterfaces::ThesisService::ThesisServicePort;
use WebService::iThenticate::Client;

# Default values for command line options.
my %options = (
 help    => 0,
 man     => 0,
 verbose => 0,
 config  => "karltheodor.conf"
);

# Parse command line arguments.
GetOptions(
 'help|?'     => \$options{help},
 'man'        => \$options{man},
 'config|c=s' => \$options{config},
) or pod2usage(2);

pod2usage(1) if $options{help};
pod2usage( -exitval => 0, -verbose => 2 ) if $options{man};

# Load configuration file for logging and other options.
Log::Log4perl::init( $options{config} );
( $options{config} ) = ( $options{config} =~ /^(.*)$/g );
my %conf = Config::General->new( $options{config} )->getall;

# Untaint values. Ugly, I know ...
# TODO: Create regex patterns to validate each parameter.
( $ENV{'PATH'} )                     = ( $ENV{'PATH'}                     =~ /^(.*)$/g );
( $conf{'campusonline.url'} )        = ( $conf{'campusonline.url'}        =~ /^(.*)$/g );
( $conf{'karltheodor.storage'} )     = ( $conf{'karltheodor.storage'}     =~ /^(.*)$/g );
( $conf{'karltheodor.wkhtmltopdf'} ) = ( $conf{'karltheodor.wkhtmltopdf'} =~ /^(.*)$/g );

# Initialize loggers for each partizipating component.
my %logger = (
 kt => Log::Log4perl->get_logger('karltheodor'),
 co => Log::Log4perl->get_logger('campusonline'),
 it => Log::Log4perl->get_logger('ithenticate'),
);

$logger{kt}->info("Starting run.");

# Instantiate new LWP user agent for downloads.
my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->cookie_jar( { use_dv => 0, use_text => 1 } );
$ua->add_handler("request_send",  sub { my $request = shift; $logger{kt}->debug(sprintf("Useragent request: %s %s", $request->method, $request->uri)); return });
$ua->add_handler("response_done", sub { my $response = shift; $logger{kt}->debug(sprintf("Useragent response: %s", $response->code)); return });

# Initialize Storable persistence file.
my $db = {};
if ( -e $conf{'karltheodor.storage'} ) {
 $logger{kt}->debug( "Reading state DB: ", $conf{'karltheodor.storage'} );
 $db = retrieve( $conf{'karltheodor.storage'} );
}

# Initialize webservice interfaces.
my %iface = (
 co => CAMPUSonline::ThesisInterfaces::ThesisService::ThesisServicePort->new( { proxy => $conf{'campusonline.url'}, } ),
 it => WebService::iThenticate::Client->new(
  {
   username => $conf{'ithenticate.username'},
   password => $conf{'ithenticate.password'},
   url      => $conf{'ithenticate.url'},
  }
 ),
);

# Work-around for transport compression, which seems to be broken in RPC::XML since Perl 5.18.
$iface{it}->{rpc_client}->{__compress}    = "deflate";
$iface{it}->{rpc_client}->{__compress_re} = qr/FOO/;

# Authenticating with iThenticate, acquiring a SID token.
$logger{it}->debug("Logging in to iThenticate");

#try {
my $response = $iface{it}->login;
$logger{it}->debug( "Aquired SID token: ", $response->sid );

#}
#catch {
# $logger{it}->logdie("Failed to connect to iThenticate!");
#};

# Search for remote folder group and create if it does not exists.
my $group = List::Util::first { $_->{name} eq $conf{'karltheodor.group'} } @{ $iface{it}->list_folder_groups()->groups() || [] };
if ( !$group ) {
 $logger{it}->warn( "Creating new folder group: ", $conf{'karltheodor.group'} );
 try {
  $group = $iface{it}->add_folder_group( { name => $conf{'karltheodor.group'} } );
 }
 catch {
  $logger{it}->logdie("Failed to connect to iThenticate!");
 };
}

# Parse thesis types and map them to iThenticate folder IDs.
my @types = split( /\s*,\s*/, $conf{'karltheodor.types'} );

# Fetch remote folders.
my $folders;
try {
 $folders = $iface{it}->list_folders()->folders();
}
catch {
 $logger{it}->logdie("Failed to connect to iThenticate!");
};

# Process upload workflow for all configured thesis types.
foreach my $type (@types) {
 $logger{kt}->debug( "Processing thesis type: ", $type );

 # Search for folder on remote side with the same name as the thesis type.
 my $folder = List::Util::first { $_->{name} eq $type } @{ $folders || [] };
 if ( !$folder ) {

  # Create folder in folder group.
  $logger{it}->warn( "Creating new folder: ", $type );
  try {
   $folder = $iface{it}->add_folder(
    {
     name           => $type,
     description    => "Folder for " . $type,
     folder_group   => $group->{id},
     exclude_quotes => 1,
     add_to_index   => 0,
    }
   );
  }
  catch {
   $logger{it}->logdie("Failed to connect to iThenticate!");
  };

 }

 # Fetch list of documents current type awaiting plagiarism check from CAMPUSonline.
 $logger{co}->debug("Fetching documents waiting for plagiarism check");
 my $documents = $iface{co}->getPlagCheckList(
  {
   token      => $conf{'campusonline.token'},
   thesesType => $type,
  },
  ,
 );
 if ( $documents->get_errorCode() != 0 ) {
  $logger{co}->logdie( "Failed to connect to CAMPUSonline: ", $documents->get_errorMessage() );
 }
 if ( $documents->get_thesesIDs() ) {
  $logger{co}->debug( "Number of documents waiting for plagiarism check: ", scalar @{ $documents->get_thesesIDs()->get_ID() } );
 }
 else {
  $logger{co}->debug("No documents waiting for plagiarism check");
  next;
 }

 # Initialize UUID generator.
 my $ug = new Data::UUID;

 # Walk over all documents fetched.
 foreach my $thesis ( @{ $documents->get_thesesIDs()->get_ID() } ) {
  if ( grep { $db->{$_}->{thesis} eq "" . $thesis } keys %{$db} ) {
   $logger{kt}->debug( "Known ThesisID: ", $thesis );
   next;
  }
  $logger{kt}->info( "New ThesisID: ", $thesis );

  my $metadata = $iface{co}->getMetadataByThesisID(
   {
    token           => $conf{'campusonline.token'},
    ID              => $thesis,
    classAttrKeySet => [
     {
      name => "text",
      attr => CAMPUSonline::ThesisTypes::AttrKey->new( { xmlattr => { key => "ALL" } } ),
     },
     {
      name => "author",
      attr => CAMPUSonline::ThesisTypes::AttrKey->new( { xmlattr => { key => "ALL" } } ),
     },
     {
      name => "base",
      attr => CAMPUSonline::ThesisTypes::AttrKey->new( { xmlattr => { key => "ALL" } } ),
     },
    ],
   },
   ,
  );

  if ( $metadata->get_errorCode() != 0 ) {
   $logger{co}->error( "Failed to connect to CAMPUSonline: ", $metadata->get_errorMessage() );
   next;
  }

  # This is going to be so fucking ugly ... I'm not really proud of it.
  # Build a map of attributes so we can query our metadata in a more convenient
  # way later during the upload.
  my $attributes = {};

  foreach my $mc ( @{ $metadata->get_thesis->get_metaclass } ) {
   $attributes->{ $mc->get_name() } = [];
   foreach my $mo ( @{ $mc->get_metaobj } ) {
    my $obj = {};
    foreach my $at ( @{ $mo->get_attr } ) {
     $obj->{ $at->attr->get_key } = $at;
    }
    push @{ $attributes->{ $mc->get_name() } }, $obj;
   }
  }

  # CAMPUSonline provides us with one-shot URLs to download the document for each thesis.
  $logger{co}->debug( "Requesting one-shot download URL for thesis document: ", $thesis );
  my $document = $iface{co}->getDocumentByThesisID(
   {
    token   => $conf{'campusonline.token'},
    ID      => $thesis,
    docType => "VOLLTEXT",
   }
  );

  if ( $document->get_errorCode() != 0 ) {
   $logger{co}->error( "Failed to connect to CAMPUSonline: ", $document->get_errorMessage() );
   next;
  }

  my $url = sprintf( "%s%s", $document->get_document()->get_docUrl(), $conf{'campusonline.token'} );

  # Fetch document from temporary URL provided by CAMPUSonline.
  $logger{co}->debug( "Downloading document from: ", $url );
  my $content = $ua->get($url);

  if ( !$content ) {
   $logger{kt}->error( "Could not download document: ", $url );
   next;
  }

  # Upload to iThenticate.
  $logger{it}->debug( "Uploading document to iThenticate: ", $folder->{id} );
  my $upload;
  try {
   $upload = $iface{it}->add_document(
    {
     title        => encode('UTF-8', "" . ( grep { $_->{LANG}     eq $attributes->{BASE}->[0]->{OLANG} } @{ $attributes->{TEXT} } )[0]->{TIT}, Encode::FB_CROAK),
     author_first => encode('UTF-8', "" . ( grep { "" . $_->{TYP} eq "A" } @{ $attributes->{AUTHOR} } )[0]->{FN}, Encode::FB_CROAK),
     author_last  => encode('UTF-8', "" . ( grep { "" . $_->{TYP} eq "A" } @{ $attributes->{AUTHOR} } )[0]->{LN}, Encode::FB_CROAK),
     filename     => $thesis . '.pdf',
     upload       => $content->content,
     folder       => $folder->{id},
     submit_to    => 1,
     non_blocking_upload => 1,
    }
   );
  }
  catch {
   $logger{it}->error("Failed to upload document to iThenticate!");
  };

  if ( !$upload or $upload->api_status() != 200 ) {
   $logger{it}->error( "Failed to upload document to iThenticate: ", );
   next;
  }

  # Store records of uploaded documents in state DB.
  # Create a new random UUID for each uploaded document.
  # CO wants this when uploading the report.
  foreach ( @{ $upload->uploaded() } ) {
   $logger{kt}->debug( "Storing record of uploaded document in state DB: ", $_->{id} );
   $db->{ $_->{id} } = {
    thesis => "" . $thesis,
    date   => DateTime->now()->epoch(),
    uuid   => $ug->create_str(),
    type   => "VOLLTEXT",
    parts  => [],
    purge  => 0,
   };
  }
  store( $db, $conf{'karltheodor.storage'} )
    or $logger{kt}->logdie( "Failed to store state to DB file: ", $conf{'karltheodor.storage'} );
 }
}

# All uploads done.

# Iterate over all entries in the state DB in order to check the iThenticate status.
$logger{kt}->debug("Checking remote documents for their status...");

for my $doc ( keys %$db ) {
 # Fetch document status.
 $logger{it}->debug( "Retrieving status for document ID: ", $doc );
 my $document = $iface{it}->get_document( { id => $doc } );

 # Check if document status marks it as ready for report download.
 foreach my $file ( @{ $document->documents() } ) {
  if ( !$db->{ $file->{id} } ) {
   $logger{kt}->warn( "Document not found in state DB, ignoring it: ", $file->{id} );
   next;
  }
  if ( $file->{is_pending} != 0 ) {
   $logger{kt}->debug( "Document is still pending: ", $file->{id} );
   next;
  }
  if ( $file->{error} ) {
   $logger{kt}->error( "Error in uploaded document: ", $file->{error} );
   $db->{ $file->{id} }->{purge} = 1;
   next;
  }

  # Download reports.
  $logger{kt}->debug( "Processing plagiarism reports for document ID: ", $file->{id} );

  foreach my $part ( @{ $file->{parts} } ) {

   # Skip already uploaded parts.
   $logger{kt}->debug( "Checking for already uploaded plagiarism reports for document ID: ", $file->{id} );
   if ( grep { $_ = $part->{id} } @{ $db->{ $file->{id} }->{parts} } ) {
    $logger{kt}->debug( "Part already successfully uploaded, skipping: ", $part->{id} );
    next;
   }

   # Fetch report information.
   my $report = $iface{it}->get_report( { id => $part->{id}, } );

   # https://api.ithenticate.com/report/12686466/similarity
   my ($report_id) = $report->report->{report_url} =~ m/\/(\d+)\//g;
   $logger{kt}->debug("Found report ID: ", $report_id);

   # Download report.
   $ua->get( $report->report->{view_only_url} );

   #$ua->get(sprintf("https://api.ithenticate.com/paper/%d?cv=1&lang=en_us&output=json", $report_id));

   #$ua->get(sprintf("https://api.ithenticate.com/en_us/paper/%d/glyph?page=1&count=10&cv=1&lang=en_us&output=json", $report_id));

   #$ua->get(sprintf("https://api.ithenticate.com/paper/%d/primary/similarity?tl=0&cv=1&lang=en_us&output=json", $report_id));

   $logger{kt}->info("Starting PDF report retrieval: ", $report_id);
   my $response = $ua->post(
    sprintf("https://api.ithenticate.com/paper/%d/queue_pdf?&lang=en_us&output=json", $report_id),
    'Content-type'   => 'application/json;charset=utf-8',
    Content          => '{"as":1,"or_type":"similarity"}',
   );
   my $status = 0;
   my $pdf_url = "";
   my $status_url = (decode_json $response->content)->{url};
   while ($status == 0) {
    $response = $ua->get(sprintf("%s?lang=en_us&output=json", $status_url));
    my $body = decode_json $response->content;
    $status = $body->{ready};
    $pdf_url = $body->{url};
    sleep 10;
   }

   $response = $ua->get($pdf_url);

   if ( !$response ) {
    $logger{kt}->error( "Could not download document: ", $report->report->{view_only_url} );
   }

   # Convert to PDF/A if template is set.
   #gs -dPDFA=1 -dBATCH -dNOPAUSE -dNOOUTERSAVE -dUseCIEColor -sProcessColorModel=DeviceCMYK -sDEVICE=pdfwrite -sOutputFile=out-a.pdf PDFA_def.ps input.ps

   # Upload to report to CAMPUSonline.
   $logger{co}->info( "Uploading plagiarism report for ThesisID: ", $db->{ $file->{id} }->{thesis} );
   my $result = $iface{co}->setPlagResultByThesisID(
    {
     token            => $conf{'campusonline.token'},
     ID               => $db->{ $file->{id} }->{thesis},
     plagiarismReport => {
      reportUUID     => $db->{ $file->{id} }->{uuid},
      submissionDate => DateTime->from_epoch( { epoch => $db->{ $file->{id} }->{date} } )->iso8601(),
      reportDate     => DateTime->now()->iso8601(),
      serviceName    => 'iThenticate',
      pop            => $file->{percent_match},
      reportDoc      => {
       fileName      => sprintf("iThenticate_%s.pdf", $part->{id}),
       mimeType      => "application/pdf",
       fileSize      => length $response->content,
       fileCreatedOn => DateTime->now()->iso8601(),
       fileChangedOn => DateTime->now()->iso8601(),
       content       => encode_base64($response->content),
      },
     },
    },
    ,
   );
   if ( $result->get_errorCode() != 0 ) {
    $logger{co}->error( "Failed to connect to CAMPUSonline: ", $result->get_errorCode(), $result->get_errorMessage() );
    next;
   }

   # Mark uploaded part.
   $logger{kt}->debug( "Successfully uploaded part: ", $part->{id} );
   push @{ $db->{ $file->{id} }->{parts} }, $part->{id};
  }

  # Check if all parts were uploaded.
  my @diff = map { $_->{id} } @{ $file->{parts} };
  if ( Array::Diff->diff( \@diff, $db->{ $file->{id} }->{parts} )->count == 0 ) {
   $logger{kt}->debug( "Marking document for purge from state DB: ", $file->{id} );
   $db->{ $file->{id} }->{purge} = 1;
  }
  else {
   $logger{kt}->warn( "Not all parts were successfully uploaded, queueing for next run: ", $file->{id} );
  }
 }

}

# Iterate over stored documents to check for elements to be purged.
for my $doc ( grep { $db->{$_}->{purge} == 1 } keys %$db ) {

 # Remove document on iThenticate side.
 $logger{it}->debug( "Removing document ID: ", $doc );
 $iface{it}->trash_document( { id => $doc } );

 # Remove entry from database.
 $logger{kt}->debug( "Removing entry from state DB for document: ", $doc );
 delete $db->{$doc};
 store( $db, $conf{'karltheodor.storage'} )
   or $logger{kt}->logdie( "Can't store state database: ", $conf{'karltheodor.storage'} );

}

$logger{kt}->info("Finished run.")
__END__

=head1 NAME

KarlTheodor - Plagiarism middleware for CAMPUSonline and iThenticate

=head1 SYNOPSIS

KarlTheodor/Middleware.pl -c ~/.karltheodor.conf

Options:
   -help            brief help message
   -man             full documentation
   -config <file>   location of configuration file

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=item B<-config>

Path to the configuration file.

=back

=head1 DESCRIPTION

B<This program> will connect to CAMPUSonline Thesis-Webservice and search for theses that are queued
for plagiarism check. It will then download the attached document (assumed PDF) and upload it to
iThenticate. State information is stored in a database file which is then read to look for documents
that have been uploaded to iThenticate before. Those documents that were successfully processed by
iThenticate, a report is downloaded and optionally converted to PDF. The report is than attached to
the thesis in CAMPUSonline and removed from iThenticate.

=cut
