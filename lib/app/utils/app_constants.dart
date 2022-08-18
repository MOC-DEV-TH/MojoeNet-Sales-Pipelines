const app_version = '1.0';

// staging url
const BASE_URL = 'http://mojoenet.myanmaronlinecreations.com';

// live url
// 'http://mojoenet.com';

//get storage key
const TOKEN = 'token';
const UID = 'uid';
const ALL_DDL_DATA = 'all_drop_down_data';

const SOURCE = 'source';
const SOURCE_INDEX = 'source-index';

const BUSINESS_TYPE = 'business_type';
const BUSINESS_TYPE_OTHER = 'business_type_other';
const BUSINESS_TYPE_INDEX = 'business_type_index';

const SME = 'sme';
const BUSINESS_NAME = 'business_name';
const DIVISION = 'division';
const TOWNSHIP = 'township';
const ADDRESS = 'address';

const DESIGNATION = 'designation';
const DESIGNATION_OTHER = 'designation_other';
const DESIGNATION_INDEX = 'designation-index';

const CONTACT_NUMBER = 'contact_number';
const SECONDARY_CONTACT_NUMBER = '_secondary_contact_number';

const CONTACT_PERSON = 'contact_person';

const CONTRACTED_DETAIL_PACKAGE_INDEX = 'contracted_detail_package_index';

const EMAIL = 'email';
const POTENTIAL = 'potential';

//param for api
const UID_PARAM = '&uid=';
const APP_VERSION = '&app_version=';
const LEAD_ID = '&leadId=';
const BUSINESS_NAME_PARAM = '&business_name=';
const CONTACT_NUMBER_PARAM = '&contact_number=';
const STATUS_PARAM = '&status=';

const API_URL = BASE_URL + '/api/';
const LOGIN_URL = API_URL + "sale_admin_login";
const GET_ACTIVITY_OVERVIEW_BY_UID_URL =
    API_URL + "get_activity_overview_by_uid?";
const GET_LEAD_LIST_BY_UID_URL = API_URL + "get_lead_list_by_uid?";
const GET_ALL_DDL_DATA_URL = API_URL + "get_sale_ddl_data";
const GET_ACTIVITY_BUSINESS_DETAIL_URL = API_URL + "get_activity_detail?";
const POST_LEAD_FORM_DATA_URL = API_URL + "post_lead_form_data";
const GET_CONTRACTED_LEAD_URL = API_URL + "get_contracted_lead_lists_by_uid?";
const GET_CONTRACTED_DETAIL_URL = API_URL + "get_contracted_detail?";
const POST_CONTRACTED_DETAIL = API_URL + "post_contracted_data";
