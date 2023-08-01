#!/usr/bin/env bash

function links(){
  file="$1"

  gsed -i 's|(#changelog.asciidoc#changelog_changelog)|(https://ocpi.dev)|g' "$file"

  gsed -i 's|(#credentials.asciidoc#credentials_credentials_endpoint)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#credentials.asciidoc#credentials_credentials_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#credentials.asciidoc#credentials_credentials_role_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#credentials.asciidoc#credentials_registration)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#credentials_credentials_role_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#credentials_delete_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#credentials_get_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#credentials_post_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#credentials_put_method)|(https://ocpi.dev)|g' "$file"
  
  gsed -i 's|(#evse_delete_with_status_update)|(https://ocpi.dev)|g' "$file"
  
  gsed -i 's|(#mod_cdrs.asciidoc#mod_cdrs_authmethod_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs.asciidoc#mod_cdrs_cdr_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs.asciidoc#mod_cdrs_cdr_token_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs.asciidoc#mod_cdrs_cdrs_module)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs.asciidoc#mod_cdrs_chargingperiod_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs.asciidoc#mod_cdrs_step_size)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs_authmethod_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs_cdr_location_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs_cdr_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs_cdr_token_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs_cdrdimension_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs_cdrdimensiontype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs_chargingperiod_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs_cpo_get_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs_credit_cdrs)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs_msp_get_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs_post_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs_signed_data_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_cdrs_signed_value_class)|(https://ocpi.dev)|g' "$file"

  gsed -i 's|(#mod_charging_profiles.asciidoc#mod_charging_profiles_module)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_active_charging_profile_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_active_charging_profiles_result_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_active_charging_profiles_result_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_charging_profile_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_charging_profile_period_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_charging_profiles_result_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_chargingrateunit)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_clear_profiles_result_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_cpo_delete_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_cpo_get_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_cpo_put_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_msp_post_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_msp_put_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_response_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_responsetype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_resulttype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_charging_profiles_set_charging_profile_object)|(https://ocpi.dev)|g' "$file"

  gsed -i 's|(#mod_commands.asciidoc#mod_commands_cancelreservation_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands.asciidoc#mod_commands_commands_module)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands.asciidoc#mod_commands_reservenow_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands.asciidoc#mod_commands_startsession_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands.asciidoc#mod_commands_stopsession_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands.asciidoc#mod_commands_unlockconnector_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands_cancelreservation_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands_commandresponse_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands_commandresponsetype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands_commandresult_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands_commandresulttype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands_commandtype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands_commandtype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands_cpo_post_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands_msp_post_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands_reservenow_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands_startsession_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands_stopsession_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_commands_unlockconnector_object)|(https://ocpi.dev)|g' "$file"

  gsed -i 's|(#mod_hub_client_info.asciidoc#mod_hub_client_info_module)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_hub_client_info_client_get)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_hub_client_info_client_put)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_hub_client_info_hub_client_info_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_hub_client_info_hub_connection_type_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_hub_client_info_hub_get)|(https://ocpi.dev)|g' "$file"
  
  gsed -i 's|(#mod_locations.asciidoc#mod_locations_businessdetails_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations.asciidoc#mod_locations_capability_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations.asciidoc#mod_locations_connector_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations.asciidoc#mod_locations_connectorformat_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations.asciidoc#mod_locations_connectortype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations.asciidoc#mod_locations_energymix_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations.asciidoc#mod_locations_evse_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations.asciidoc#mod_locations_geolocation_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations.asciidoc#mod_locations_location_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations.asciidoc#mod_locations_locations_module)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations.asciidoc#mod_locations_powertype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations.asciidoc)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_additionalgeolocation_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_businessdetails_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_capability_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_connector_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_connectorformat_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_connectortype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_emsp_interface)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_energymix_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_energysource_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_energysourcecategory_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_environmentalimpact_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_environmentalimpactcategory_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_evse_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_exceptionalperiod_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_facility_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_flow_and_lifecycle)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_geolocation_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_get_list_request_parameters)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_get_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_get_method_eMSP)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_get_object_request_parameters)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_hours_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_image_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_imagecategory_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_location_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_locations_module)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_parkingrestriction_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_parkingtype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_patch_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_powertype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_publish_token_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_put_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_regularhours_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_status_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_locations_statusschedule_class)|(https://ocpi.dev)|g' "$file"
  
  gsed -i 's|(#mod_sessions.asciidoc#mod_sessions_profile_type_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_sessions.asciidoc#mod_sessions_session_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_sessions.asciidoc#mod_sessions_sessions_module)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_sessions.asciidoc#mod_sessions_set_charging_preferences)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_sessions_charging_preferences_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_sessions_charging_preferences_response_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_sessions_cpo_get_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_sessions_cpo_put_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_sessions_msp_get_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_sessions_msp_put_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_sessions_patch_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_sessions_profile_type_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_sessions_session_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_sessions_sessionstatus_enum)|(https://ocpi.dev)|g' "$file"
  
  gsed -i 's|(#mod_tariffs.asciidoc#mod_tariffs_pricecomponent_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs.asciidoc#mod_tariffs_tariff_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs.asciidoc#mod_tariffs_tariffdimensiontype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs.asciidoc#mod_tariffs_tariffelement_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs.asciidoc#mod_tariffs_tariffs_module)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_cpo_get_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_dayofweek_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_delete_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_free_of_charge_tariff_example)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_msp_get_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_msp_get_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_pricecomponent_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_put_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_reservation_restriction_type)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_tariff_example_15_reservation_5_euro_per_hour)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_tariff_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_tariff_type)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_tariffdimensiontype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_tariffelement_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tariffs_tariffrestrictions_class)|(https://ocpi.dev)|g' "$file"
  
  gsed -i 's|(#mod_tokens.asciidoc#mod_tokens_real-time_authorization)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens.asciidoc#mod_tokens_token_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens.asciidoc#mod_tokens_tokens_module)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens.asciidoc#mod_tokens_tokentype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens_allowed_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens_authorizationinfo_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens_cpo_get_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens_locationreferences_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens_msp_get_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens_patch_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens_post_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens_put_method)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens_real-time_authorization)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens_token_object)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens_tokentype_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#mod_tokens_whitelisttype_enum)|(https://ocpi.dev)|g' "$file"
  
  gsed -i 's|(#status_codes.asciidoc#status_codes_2xxx_client_errors)|(/05-status-codes/05-status-codes.md#2xxx-client-errors)|g' "$file"
  gsed -i 's|(#status_codes.asciidoc#status_codes_3xxx_server_errors)|(/05-status-codes/05-status-codes.md#3xxx-server-errors)|g' "$file"
  gsed -i 's|(#status_codes.asciidoc#status_codes_status_codes)|(/05-status-codes/05-status-codes.md)|g' "$file"
  
  gsed -i 's|(#terminology.asciidoc#terminology_roles)|(/02-terminology-and-definitions/03-ev-charging-market-roles.md)|g' "$file"
  
  gsed -i 's|(#transport_and_format.asciidoc#transport_and_format_authorization_header)|(/04-transport-and-format/01-json-http-implementation-guide.md#authorization-header)|g' "$file"
  gsed -i 's|(#transport_and_format.asciidoc#transport_and_format_client_owned_object_push)|(/04-transport-and-format/01-json-http-implementation-guide.md#client-owned-object-push)|g' "$file"
  gsed -i 's|(#transport_and_format.asciidoc#transport_and_format_message_routing)|(/04-transport-and-format/01-json-http-implementation-guide.md#message-routing)|g' "$file"
  gsed -i 's|(#transport_and_format.asciidoc#transport_and_format_message_routing_broadcast_push)|(/04-transport-and-format/01-json-http-implementation-guide.md#broadcast-push)|g' "$file"
  gsed -i 's|(#transport_and_format.asciidoc#transport_and_format_message_routing_open_routing_request)|(/04-transport-and-format/01-json-http-implementation-guide.md#open-routing-request)|g' "$file"
  gsed -i 's|(#transport_and_format.asciidoc#transport_and_format_not_available)|(/04-transport-and-format/01-json-http-implementation-guide.md#no-data-available)|g' "$file"
  gsed -i 's|(#transport_and_format.asciidoc#transport_and_format_paginated_request)|(/04-transport-and-format/01-json-http-implementation-guide.md#paginated-request)|g' "$file"
  gsed -i 's|(#transport_and_format.asciidoc#transport_and_format_paginated_response)|(/04-transport-and-format/01-json-http-implementation-guide.md#paginated-response)|g' "$file"
  gsed -i 's|(#transport_and_format.asciidoc#transport_and_format_pagination)|(/04-transport-and-format/01-json-http-implementation-guide.md#pagination)|g' "$file"
  gsed -i 's|(#transport_and_format.asciidoc#transport_and_format_response_format)|(/04-transport-and-format/01-json-http-implementation-guide.md#response-format)|g' "$file"
  gsed -i 's|(#transport_and_format_get)|(#get-method)|g' "$file"
  gsed -i 's|(#transport_and_format_get_all_via_hubs)|(#get-all-via-hubs)|g' "$file" 
  gsed -i 's|(#transport_and_format_message_routing_broadcast_push)|(#broadcast-push)|g' "$file"
  gsed -i 's|(#transport_and_format_message_routing_open_routing_request)|(#open-routing-request)|g' "$file"
  gsed -i 's|(#transport_and_format_patch)|(#patch-method)|g' "$file"
  gsed -i 's|(#transport_and_format_pull_and_push)|(#pull-and-push)|g' "$file"
  gsed -i 's|(#transport_and_format_put)|(#put-method)|g' "$file"
  gsed -i 's|(#transport_and_format_response_format)|(#response-format)|g' "$file"
  
  gsed -i 's|(#types.asciidoc#mod_tokens_energy_contract)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#types.asciidoc#types_cistring_type)|(/16-types/16-types.md#cistring-type)|g' "$file"
  gsed -i 's|(#types.asciidoc#types_datetime_type)|(/16-types/16-types.md#datetime-type)|g' "$file"
  gsed -i 's|(#types.asciidoc#types_displaytext_class)|(/16-types/16-types.md#displaytext-class)|g' "$file"
  gsed -i 's|(#types.asciidoc#types_number_type)|(/16-types/16-types.md#number-type)|g' "$file"
  gsed -i 's|(#types.asciidoc#types_price_class)|(/16-types/16-types.md#price-class)|g' "$file"
  gsed -i 's|(#types.asciidoc#types_role_enum)|(/16-types/16-types.md#role-enum)|g' "$file"
  gsed -i 's|(#types.asciidoc#types_string_type)|(/16-types/16-types.md#string-type)|g' "$file"
  gsed -i 's|(#types.asciidoc#types_url_type)|(/16-types/16-types.md#url-type)|g' "$file"
  gsed -i 's|(#types_number_type)|(#number-type)|g' "$file"
  gsed -i 's|(#types_string_type)|(#string-type)|g' "$file"
  
  gsed -i 's|(#version_information_endpoint.asciidoc#versions_module)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#version_information_endpoint_endpoint_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#version_information_endpoint_interface_role_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#version_information_endpoint_moduleid_enum)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#version_information_endpoint_version_class)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#version_information_endpoint_version_details_endpoint)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#version_information_endpoint_version_information_endpoint)|(https://ocpi.dev)|g' "$file"
  gsed -i 's|(#version_information_endpoint_versionnumber_enum)|(https://ocpi.dev)|g' "$file"

}
