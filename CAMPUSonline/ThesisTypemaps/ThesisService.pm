
package CAMPUSonline::ThesisTypemaps::ThesisService;
use strict;
use warnings;

our $typemap_1 = {
               'setPlagResultByThesisIDRequest/plagiarismReport/reportDoc/fileName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'getPlagCheckListResponse/thesesIDs/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::long',
               'setPlagResultByThesisIDRequest/plagiarismReport/reportDoc/content' => 'SOAP::WSDL::XSD::Typelib::Builtin::base64Binary',
               'getAllThesesMetadataResponse' => 'CAMPUSonline::ThesisElements::getAllThesesMetadataResponse',
               'setPlagResultByThesisIDRequest/plagiarismReport/reportUUID' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'setPlagResultByThesisIDResponse/errorMessage' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'getAllThesesMetadataResponse/thesis/metaclass/metaobj/type' => 'CAMPUSonline::ThesisTypes::SimpleTypeType',
               'getMetadataByThesisIDResponse/thesis/metaclass/metaobj' => 'CAMPUSonline::ThesisTypes::Metaobj',
               'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
               'setThesisStatusByIDResponse/errorMessage' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'setPlagResultByThesisIDRequest/plagiarismReport/reportDoc/fileCreatedOn' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
               'getAllThesesMetadataResponse/thesis/metaclass/metaobj/attr' => 'CAMPUSonline::ThesisTypes::KeyAttr',
               'getAllThesesMetadataRequest/state' => 'CAMPUSonline::ThesisTypes::state',
               'getMetadataByThesisIDRequest/classAttrKeySet' => 'CAMPUSonline::ThesisTypes::ClassAttrKeySet',
               'getPlagCheckListResponse/errorCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'getPlagCheckListRequest/token' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'setPlagResultByThesisIDRequest' => 'CAMPUSonline::ThesisElements::setPlagResultByThesisIDRequest',
               'getMetadataByThesisIDResponse' => 'CAMPUSonline::ThesisElements::getMetadataByThesisIDResponse',
               'getAllThesesMetadataResponse/thesis' => 'CAMPUSonline::ThesisTypes::Thesis',
               'getAllThesesMetadataResponse/errorCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'getPlagCheckListResponse' => 'CAMPUSonline::ThesisElements::getPlagCheckListResponse',
               'getDocumentByThesisIDResponse/document/attr' => 'CAMPUSonline::ThesisTypes::KeyAttr',
               'setPlagResultByThesisIDRequest/plagiarismReport/reportDoc/fileSize' => 'SOAP::WSDL::XSD::Typelib::Builtin::long',
               'getAllThesesMetadataResponse/thesis/metaclass/metaobj' => 'CAMPUSonline::ThesisTypes::Metaobj',
               'getDocumentByThesisIDResponse/errorCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'getMetadataByThesisIDRequest/classAttrKeySet/name' => 'CAMPUSonline::ThesisTypes::SimpleNameType',
               'setPlagResultByThesisIDRequest/plagiarismReport/pop' => 'SOAP::WSDL::XSD::Typelib::Builtin::float',
               'setPlagResultByThesisIDRequest/plagiarismReport/reportDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
               'getAllThesesMetadataRequest/token' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'setPlagResultByThesisIDRequest/plagiarismReport/submissionDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
               'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'getPlagCheckListResponse/thesesIDs' => 'CAMPUSonline::ThesisTypes::ThesesIDs',
               'getDocumentByThesisIDRequest/docType' => 'CAMPUSonline::ThesisTypes::SimpleDocType',
               'setPlagResultByThesisIDResponse/errorCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'getDocumentByThesisIDResponse' => 'CAMPUSonline::ThesisElements::getDocumentByThesisIDResponse',
               'Fault/detail' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'getDocumentByThesisIDResponse/document/type' => 'CAMPUSonline::ThesisTypes::SimpleNameType',
               'getDbSysdateResponse/errorCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'getDbSysdateResponse' => 'CAMPUSonline::ThesisElements::getDbSysdateResponse',
               'getAllThesesMetadataResponse/thesis/attr' => 'CAMPUSonline::ThesisTypes::KeyAttr',
               'getMetadataByThesisIDResponse/thesis/attr' => 'CAMPUSonline::ThesisTypes::KeyAttr',
               'getMetadataByThesisIDResponse/errorCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'getAllThesesMetadataRequest/thesesType' => 'CAMPUSonline::ThesisTypes::SimpleThesisType',
               'setThesisStatusByIDResponse/errorCode' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
               'getMetadataByThesisIDResponse/thesis' => 'CAMPUSonline::ThesisTypes::Thesis',
               'setPlagResultByThesisIDRequest/token' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'getMetadataByThesisIDResponse/errorMessage' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'setThesisStatusByIDRequest/statusDate' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
               'getDbSysdateResponse/sysdate' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'getAllThesesMetadataResponse/errorMessage' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'getMetadataByThesisIDRequest/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::long',
               'getMetadataByThesisIDRequest/attr' => 'CAMPUSonline::ThesisTypes::AttrKey',
               'getDocumentByThesisIDResponse/errorMessage' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'getDocumentByThesisIDResponse/document/docUrl' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
               'getDocumentByThesisIDResponse/document' => 'CAMPUSonline::ThesisTypes::DocumentClass',
               'getMetadataByThesisIDResponse/thesis/metaclass' => 'CAMPUSonline::ThesisTypes::Metaclass',
               'setThesisStatusByIDRequest/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::long',
               'setPlagResultByThesisIDResponse' => 'CAMPUSonline::ThesisElements::setPlagResultByThesisIDResponse',
               'getAllThesesMetadataRequest/state/from' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
               'setPlagResultByThesisIDRequest/plagiarismReport/reportDoc/fileChangedOn' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
               'getDocumentByThesisIDRequest' => 'CAMPUSonline::ThesisElements::getDocumentByThesisIDRequest',
               'getAllThesesMetadataRequest/classAttrKeySet/attr' => 'CAMPUSonline::ThesisTypes::AttrKey',
               'getDbSysdateResponse/errorMessage' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'getAllThesesMetadataRequest/attr' => 'CAMPUSonline::ThesisTypes::AttrKey',
               'getMetadataByThesisIDResponse/thesis/metaclass/name' => 'CAMPUSonline::ThesisTypes::SimpleNameType',
               'setThesisStatusByIDResponse' => 'CAMPUSonline::ThesisElements::setThesisStatusByIDResponse',
               'getDbSysdateRequest/token' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'setPlagResultByThesisIDRequest/plagiarismReport/reportDoc' => 'CAMPUSonline::ThesisTypes::PlagiatsDoc',
               'setPlagResultByThesisIDRequest/plagiarismReport' => 'CAMPUSonline::ThesisTypes::PlagReport',
               'setPlagResultByThesisIDRequest/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::long',
               'getMetadataByThesisIDResponse/thesis/metaclass/metaobj/type' => 'CAMPUSonline::ThesisTypes::SimpleTypeType',
               'getAllThesesMetadataRequest/classAttrKeySet/name' => 'CAMPUSonline::ThesisTypes::SimpleNameType',
               'getMetadataByThesisIDRequest/token' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'setThesisStatusByIDRequest/token' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'getDocumentByThesisIDRequest/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::long',
               'setThesisStatusByIDRequest/status' => 'CAMPUSonline::ThesisTypes::SimpleStateType',
               'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
               'getDbSysdateRequest' => 'CAMPUSonline::ThesisElements::getDbSysdateRequest',
               'getMetadataByThesisIDRequest/classAttrKeySet/attr' => 'CAMPUSonline::ThesisTypes::AttrKey',
               'setThesisStatusByIDRequest' => 'CAMPUSonline::ThesisElements::setThesisStatusByIDRequest',
               'getMetadataByThesisIDRequest' => 'CAMPUSonline::ThesisElements::getMetadataByThesisIDRequest',
               'getAllThesesMetadataRequest/state/to' => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
               'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::token',
               'getPlagCheckListRequest/thesesType' => 'CAMPUSonline::ThesisTypes::SimpleThesisType',
               'getDocumentByThesisIDRequest/token' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'getPlagCheckListRequest' => 'CAMPUSonline::ThesisElements::getPlagCheckListRequest',
               'setPlagResultByThesisIDRequest/plagiarismReport/serviceName' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'setPlagResultByThesisIDRequest/plagiarismReport/reportDoc/mimeType' => 'CAMPUSonline::ThesisTypes::SimpleMimeType',
               'getAllThesesMetadataResponse/thesis/metaclass' => 'CAMPUSonline::ThesisTypes::Metaclass',
               'getAllThesesMetadataRequest' => 'CAMPUSonline::ThesisElements::getAllThesesMetadataRequest',
               'getAllThesesMetadataRequest/classAttrKeySet' => 'CAMPUSonline::ThesisTypes::ClassAttrKeySet',
               'getMetadataByThesisIDResponse/thesis/metaclass/metaobj/attr' => 'CAMPUSonline::ThesisTypes::KeyAttr',
               'getPlagCheckListResponse/errorMessage' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
               'getAllThesesMetadataResponse/thesis/metaclass/name' => 'CAMPUSonline::ThesisTypes::SimpleNameType',
               'getMetadataByThesisIDResponse/thesis/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::long',
               'getAllThesesMetadataResponse/thesis/ID' => 'SOAP::WSDL::XSD::Typelib::Builtin::long'
             };
;

sub get_class {
  my $name = join '/', @{ $_[1] };
  return $typemap_1->{ $name };
}

sub get_typemap {
    return $typemap_1;
}

1;

__END__

__END__

=pod

=head1 NAME

CAMPUSonline::ThesisTypemaps::ThesisService - typemap for ThesisService

=head1 DESCRIPTION

Typemap created by SOAP::WSDL for map-based SOAP message parsers.

=cut

