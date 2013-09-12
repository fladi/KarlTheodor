package CAMPUSonline::ThesisTypes::ThesesIDs;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://www.campusonline.at/thesisservice/basetypes' };

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %ID_of :ATTR(:get<ID>);

__PACKAGE__->_factory(
    [ qw(        ID

    ) ],
    {
        'ID' => \%ID_of,
    },
    {
        'ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::long',
    },
    {

        'ID' => 'ID',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

CAMPUSonline::ThesisTypes::ThesesIDs

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
ThesesIDs from the namespace http://www.campusonline.at/thesisservice/basetypes.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * ID




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # CAMPUSonline::ThesisTypes::ThesesIDs
   ID =>  $some_value, # long
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut
