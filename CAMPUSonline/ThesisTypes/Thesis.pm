package CAMPUSonline::ThesisTypes::Thesis;
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
my %attr_of :ATTR(:get<attr>);
my %metaclass_of :ATTR(:get<metaclass>);

__PACKAGE__->_factory(
    [ qw(        ID
        attr
        metaclass

    ) ],
    {
        'ID' => \%ID_of,
        'attr' => \%attr_of,
        'metaclass' => \%metaclass_of,
    },
    {
        'ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::long',
        'attr' => 'CAMPUSonline::ThesisTypes::KeyAttr',
        'metaclass' => 'CAMPUSonline::ThesisTypes::Metaclass',
    },
    {

        'ID' => 'ID',
        'attr' => 'attr',
        'metaclass' => 'metaclass',
    }
);

} # end BLOCK







1;


=pod

=head1 NAME

CAMPUSonline::ThesisTypes::Thesis

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
Thesis from the namespace http://www.campusonline.at/thesisservice/basetypes.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * ID


=item * attr


=item * metaclass




=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { # CAMPUSonline::ThesisTypes::Thesis
   ID =>  $some_value, # long
   attr =>  { value => $some_value },
   metaclass =>  { # CAMPUSonline::ThesisTypes::Metaclass
     name => $some_value, # SimpleNameType
     metaobj =>  { # CAMPUSonline::ThesisTypes::Metaobj
       type => $some_value, # SimpleTypeType
       attr =>  { value => $some_value },
     },
   },
 },




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

