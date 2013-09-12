package CAMPUSonline::ThesisInterfaces::ThesisService::ThesisServicePort;
use strict;
use warnings;
use Class::Std::Fast::Storable;
use Scalar::Util qw(blessed);
use base qw(SOAP::WSDL::Client::Base);

# only load if it hasn't been loaded before
require CAMPUSonline::ThesisTypemaps::ThesisService
    if not CAMPUSonline::ThesisTypemaps::ThesisService->can('get_class');

sub START {
    $_[0]->set_proxy('http://devline.medunigraz.at/mug_devj/ws/thesisservice_v3.0/services/ThesisServicePort') if not $_[2]->{proxy};
    $_[0]->set_class_resolver('CAMPUSonline::ThesisTypemaps::ThesisService')
        if not $_[2]->{class_resolver};

    $_[0]->set_prefix($_[2]->{use_prefix}) if exists $_[2]->{use_prefix};
}

sub getDocumentByThesisID {
    my ($self, $body, $header) = @_;
    die "getDocumentByThesisID must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'getDocumentByThesisID',
        soap_action => 'urn:service#getDocumentByThesisID',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( CAMPUSonline::ThesisElements::getDocumentByThesisIDRequest )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}


sub getMetadataByThesisID {
    my ($self, $body, $header) = @_;
    die "getMetadataByThesisID must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'getMetadataByThesisID',
        soap_action => 'urn:service#getMetadataByThesisID',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( CAMPUSonline::ThesisElements::getMetadataByThesisIDRequest )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}


sub getAllThesesMetadata {
    my ($self, $body, $header) = @_;
    die "getAllThesesMetadata must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'getAllThesesMetadata',
        soap_action => 'urn:service#getAllThesesMetadata',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( CAMPUSonline::ThesisElements::getAllThesesMetadataRequest )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}


sub setThesisStatusByID {
    my ($self, $body, $header) = @_;
    die "setThesisStatusByID must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'setThesisStatusByID',
        soap_action => 'urn:service#setThesisStatusByID',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( CAMPUSonline::ThesisElements::setThesisStatusByIDRequest )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}


sub setPlagResultByThesisID {
    my ($self, $body, $header) = @_;
    die "setPlagResultByThesisID must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'setPlagResultByThesisID',
        soap_action => 'urn:service#setPlagResultByThesisID',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( CAMPUSonline::ThesisElements::setPlagResultByThesisIDRequest )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}


sub getPlagCheckList {
    my ($self, $body, $header) = @_;
    die "getPlagCheckList must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'getPlagCheckList',
        soap_action => 'urn:service#getPlagCheckList',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( CAMPUSonline::ThesisElements::getPlagCheckListRequest )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}


sub getDbSysdate {
    my ($self, $body, $header) = @_;
    die "getDbSysdate must be called as object method (\$self is <$self>)" if not blessed($self);
    return $self->SUPER::call({
        operation => 'getDbSysdate',
        soap_action => 'urn:service#getDbSysdate',
        style => 'document',
        body => {
            

           'use'            => 'literal',
            namespace       => 'http://schemas.xmlsoap.org/wsdl/soap/',
            encodingStyle   => '',
            parts           =>  [qw( CAMPUSonline::ThesisElements::getDbSysdateRequest )],
        },
        header => {
            
        },
        headerfault => {
            
        }
    }, $body, $header);
}




1;



__END__

=pod

=head1 NAME

CAMPUSonline::ThesisInterfaces::ThesisService::ThesisServicePort - SOAP Interface for the ThesisService Web Service

=head1 SYNOPSIS

 use CAMPUSonline::ThesisInterfaces::ThesisService::ThesisServicePort;
 my $interface = CAMPUSonline::ThesisInterfaces::ThesisService::ThesisServicePort->new();

 my $response;
 $response = $interface->getDocumentByThesisID();
 $response = $interface->getMetadataByThesisID();
 $response = $interface->getAllThesesMetadata();
 $response = $interface->setThesisStatusByID();
 $response = $interface->setPlagResultByThesisID();
 $response = $interface->getPlagCheckList();
 $response = $interface->getDbSysdate();



=head1 DESCRIPTION

SOAP Interface for the ThesisService web service
located at http://devline.medunigraz.at/mug_devj/ws/thesisservice_v3.0/services/ThesisServicePort.

=head1 SERVICE ThesisService



=head2 Port ThesisServicePort



=head1 METHODS

=head2 General methods

=head3 new

Constructor.

All arguments are forwarded to L<SOAP::WSDL::Client|SOAP::WSDL::Client>.

=head2 SOAP Service methods

Method synopsis is displayed with hash refs as parameters.

The commented class names in the method's parameters denote that objects
of the corresponding class can be passed instead of the marked hash ref.

You may pass any combination of objects, hash and list refs to these
methods, as long as you meet the structure.

List items (i.e. multiple occurences) are not displayed in the synopsis.
You may generally pass a list ref of hash refs (or objects) instead of a hash
ref - this may result in invalid XML if used improperly, though. Note that
SOAP::WSDL always expects list references at maximum depth position.

XML attributes are not displayed in this synopsis and cannot be set using
hash refs. See the respective class' documentation for additional information.



=head3 getDocumentByThesisID



Returns a L<CAMPUSonline::ThesisElements::getDocumentByThesisIDResponse|CAMPUSonline::ThesisElements::getDocumentByThesisIDResponse> object.

 $response = $interface->getDocumentByThesisID( {
    token =>  $some_value, # string
    ID =>  $some_value, # long
    docType => $some_value, # SimpleDocType
  },,
 );

=head3 getMetadataByThesisID



Returns a L<CAMPUSonline::ThesisElements::getMetadataByThesisIDResponse|CAMPUSonline::ThesisElements::getMetadataByThesisIDResponse> object.

 $response = $interface->getMetadataByThesisID( {
    token =>  $some_value, # string
    ID =>  $some_value, # long
    attr => ,
    classAttrKeySet =>  { # CAMPUSonline::ThesisTypes::ClassAttrKeySet
      name => $some_value, # SimpleNameType
      attr => ,
    },
  },,
 );

=head3 getAllThesesMetadata



Returns a L<CAMPUSonline::ThesisElements::getAllThesesMetadataResponse|CAMPUSonline::ThesisElements::getAllThesesMetadataResponse> object.

 $response = $interface->getAllThesesMetadata( {
    token =>  $some_value, # string
    thesesType => $some_value, # SimpleThesisType
    state =>  { # CAMPUSonline::ThesisTypes::state
      from =>  $some_value, # dateTime
      to =>  $some_value, # dateTime
    },
    attr => ,
    classAttrKeySet =>  { # CAMPUSonline::ThesisTypes::ClassAttrKeySet
      name => $some_value, # SimpleNameType
      attr => ,
    },
  },,
 );

=head3 setThesisStatusByID



Returns a L<CAMPUSonline::ThesisElements::setThesisStatusByIDResponse|CAMPUSonline::ThesisElements::setThesisStatusByIDResponse> object.

 $response = $interface->setThesisStatusByID( {
    token =>  $some_value, # string
    ID =>  $some_value, # long
    status => $some_value, # SimpleStateType
    statusDate =>  $some_value, # dateTime
  },,
 );

=head3 setPlagResultByThesisID



Returns a L<CAMPUSonline::ThesisElements::setPlagResultByThesisIDResponse|CAMPUSonline::ThesisElements::setPlagResultByThesisIDResponse> object.

 $response = $interface->setPlagResultByThesisID( {
    token =>  $some_value, # string
    ID =>  $some_value, # long
    plagiarismReport =>  { # CAMPUSonline::ThesisTypes::PlagReport
      reportUUID =>  $some_value, # string
      submissionDate =>  $some_value, # dateTime
      reportDate =>  $some_value, # dateTime
      serviceName =>  $some_value, # string
      pop =>  $some_value, # float
      reportDoc =>  { # CAMPUSonline::ThesisTypes::PlagiatsDoc
        fileName =>  $some_value, # string
        mimeType => $some_value, # SimpleMimeType
        fileSize =>  $some_value, # long
        fileCreatedOn =>  $some_value, # dateTime
        fileChangedOn =>  $some_value, # dateTime
        content =>  $some_value, # base64Binary
      },
    },
  },,
 );

=head3 getPlagCheckList



Returns a L<CAMPUSonline::ThesisElements::getPlagCheckListResponse|CAMPUSonline::ThesisElements::getPlagCheckListResponse> object.

 $response = $interface->getPlagCheckList( {
    token =>  $some_value, # string
    thesesType => $some_value, # SimpleThesisType
  },,
 );

=head3 getDbSysdate



Returns a L<CAMPUSonline::ThesisElements::getDbSysdateResponse|CAMPUSonline::ThesisElements::getDbSysdateResponse> object.

 $response = $interface->getDbSysdate( {
    token =>  $some_value, # string
  },,
 );



=head1 AUTHOR

Generated by SOAP::WSDL on Thu Jul 18 12:00:04 2013

=cut
