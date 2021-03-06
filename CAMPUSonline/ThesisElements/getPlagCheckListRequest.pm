
package CAMPUSonline::ThesisElements::getPlagCheckListRequest;
use strict;
use warnings;

{ # BLOCK to scope variables

sub get_xmlns { 'http://www.campusonline.at/thesisservice/basetypes' }

__PACKAGE__->__set_name('getPlagCheckListRequest');
__PACKAGE__->__set_nillable();
__PACKAGE__->__set_minOccurs();
__PACKAGE__->__set_maxOccurs();
__PACKAGE__->__set_ref();

use base qw(
    SOAP::WSDL::XSD::Typelib::Element
    SOAP::WSDL::XSD::Typelib::ComplexType
);

our $XML_ATTRIBUTE_CLASS;
undef $XML_ATTRIBUTE_CLASS;

sub __get_attr_class {
    return $XML_ATTRIBUTE_CLASS;
}

use Class::Std::Fast::Storable constructor => 'none';
use base qw(SOAP::WSDL::XSD::Typelib::ComplexType);

Class::Std::initialize();

{ # BLOCK to scope variables

my %token_of :ATTR(:get<token>);
my %thesesType_of :ATTR(:get<thesesType>);

__PACKAGE__->_factory(
    [ qw(        token
        thesesType

    ) ],
    {
        'token' => \%token_of,
        'thesesType' => \%thesesType_of,
    },
    {
        'token' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
        'thesesType' => 'CAMPUSonline::ThesisTypes::SimpleThesisType',
    },
    {

        'token' => 'token',
        'thesesType' => 'thesesType',
    }
);

} # end BLOCK






} # end of BLOCK



1;


=pod

=head1 NAME

CAMPUSonline::ThesisElements::getPlagCheckListRequest

=head1 DESCRIPTION

Perl data type class for the XML Schema defined element
getPlagCheckListRequest from the namespace http://www.campusonline.at/thesisservice/basetypes.







=head1 PROPERTIES

The following properties may be accessed using get_PROPERTY / set_PROPERTY
methods:

=over

=item * token

 $element->set_token($data);
 $element->get_token();




=item * thesesType

 $element->set_thesesType($data);
 $element->get_thesesType();





=back


=head1 METHODS

=head2 new

 my $element = CAMPUSonline::ThesisElements::getPlagCheckListRequest->new($data);

Constructor. The following data structure may be passed to new():

 {
   token =>  $some_value, # string
   thesesType => $some_value, # SimpleThesisType
 },

=head1 AUTHOR

Generated by SOAP::WSDL

=cut

