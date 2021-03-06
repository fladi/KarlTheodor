package CAMPUSonline::ThesisTypes::KeyAttr;
use strict;
use warnings;


__PACKAGE__->_set_element_form_qualified(1);

sub get_xmlns { 'http://www.campusonline.at/thesisservice/basetypes' };

our $XML_ATTRIBUTE_CLASS = 'CAMPUSonline::ThesisTypes::KeyAttr::_KeyAttr::XmlAttr';

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use base qw(
    SOAP::WSDL::XSD::Typelib::ComplexType
    SOAP::WSDL::XSD::Typelib::Builtin::string
);

package CAMPUSonline::ThesisTypes::KeyAttr::_KeyAttr::XmlAttr;
use base qw(SOAP::WSDL::XSD::Typelib::AttributeSet);

{ # BLOCK to scope variables

my %key_of :ATTR(:get<key>);

__PACKAGE__->_factory(
    [ qw(
        key
    ) ],
    {

        key => \%key_of,
    },
    {
        key => 'CAMPUSonline::ThesisTypes::SimpleKeyType',
    }
);

} # end BLOCK



1;


=pod

=head1 NAME

CAMPUSonline::ThesisTypes::KeyAttr

=head1 DESCRIPTION

Perl data type class for the XML Schema defined complexType
KeyAttr from the namespace http://www.campusonline.at/thesisservice/basetypes.






=head2 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over



=back


=head1 METHODS

=head2 new

Constructor. The following data structure may be passed to new():

 { value => $some_value },



=head2 attr

NOTE: Attribute documentation is experimental, and may be inaccurate.
See the correspondent WSDL/XML Schema if in question.

This class has additional attributes, accessibly via the C<attr()> method.

attr() returns an object of the class CAMPUSonline::ThesisTypes::KeyAttr::_KeyAttr::XmlAttr.

The following attributes can be accessed on this object via the corresponding
get_/set_ methods:

=over

=item * key



This attribute is of type L<CAMPUSonline::ThesisTypes::SimpleKeyType|CAMPUSonline::ThesisTypes::SimpleKeyType>.


=back




=head1 AUTHOR

Generated by SOAP::WSDL

=cut

