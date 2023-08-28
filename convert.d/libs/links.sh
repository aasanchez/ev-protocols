#!/usr/bin/env bash

function replace(){
  target="$2"
  replacement="$1"
  file="$3"
  gsed -i "s|$target|$replacement|g" "$file"
}



function links(){
  file="$1"

  replace "<<docs/ocpi/02-terminology-and-definitions/03-ev-charging-market-roles.md,"  "<<terminology.asciidoc#terminology_roles," "$file"

  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#authorization-header,"      "<<transport_and_format.asciidoc#transport_and_format_authorization_header," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#broadcast-push,"            "<<transport_and_format.asciidoc#transport_and_format_message_routing_broadcast_push," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#broadcast-push,"            "<<transport_and_format_message_routing_broadcast_push," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#client-owned-object-push,"  "<<transport_and_format.asciidoc#transport_and_format_client_owned_object_push," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#get-all-via-hubs,"          "<<transport_and_format_get_all_via_hubs," "$file" 
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#get-method,"                "<<transport_and_format_get," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#message-routing,"           "<<transport_and_format.asciidoc#transport_and_format_message_routing," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#no-data-available,"         "<<transport_and_format.asciidoc#transport_and_format_not_available," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#open-routing-request,"      "<<transport_and_format.asciidoc#transport_and_format_message_routing_open_routing_request," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#open-routing-request,"      "<<transport_and_format_message_routing_open_routing_request," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#paginated-request,"         "<<transport_and_format.asciidoc#transport_and_format_paginated_request," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#paginated-response,"        "<<transport_and_format.asciidoc#transport_and_format_paginated_response," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#pagination,"                "<<transport_and_format.asciidoc#transport_and_format_pagination,"    "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#patch-method,"              "<<transport_and_format_patch," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#pull-and-push,"             "<<transport_and_format_pull_and_push," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#put-method,"                "<<transport_and_format_put," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#response-format,"           "<<transport_and_format.asciidoc#transport_and_format_response_format," "$file"
  replace "<<docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#response-format,"           "<<transport_and_format_response_format," "$file"

  replace "<<docs/ocpi/05-status-codes/05-status-codes.md#2xxx-client-errors,"  "<<status_codes.asciidoc#status_codes_2xxx_client_errors," "$file"
  replace "<<docs/ocpi/05-status-codes/05-status-codes.md#3xxx-server-errors,"  "<<status_codes.asciidoc#status_codes_3xxx_server_errors," "$file"
  replace "<<docs/ocpi/05-status-codes/05-status-codes.md,"                     "<<status_codes.asciidoc#status_codes_status_codes," "$file"

  replace "<<docs/ocpi/06-modules/01-versions/01-intro.md,"                               "<<version_information_endpoint.asciidoc#versions_module," "$file"
  replace "<<docs/ocpi/06-modules/01-versions/02-information-endpoint.md#version-class,"  "<<version_information_endpoint_version_class," "$file"
  replace "<<docs/ocpi/06-modules/01-versions/02-information-endpoint.md,"                "<<version_information_endpoint_version_information_endpoint," "$file"
  replace "<<docs/ocpi/06-modules/01-versions/03-details-endpoint.md#endpoint-class,"     "<<version_information_endpoint_endpoint_class," "$file"
  replace "<<docs/ocpi/06-modules/01-versions/03-details-endpoint.md#interfacerole-enum," "<<version_information_endpoint_interface_role_enum," "$file"
  replace "<<docs/ocpi/06-modules/01-versions/03-details-endpoint.md#moduleid-enum,"      "<<version_information_endpoint_moduleid_enum," "$file"
  replace "<<docs/ocpi/06-modules/01-versions/03-details-endpoint.md#versionnumber-enum," "<<version_information_endpoint_versionnumber_enum," "$file"
  replace "<<docs/ocpi/06-modules/01-versions/03-details-endpoint.md,"                    "<<version_information_endpoint_version_details_endpoint," "$file"

  replace "<<docs/ocpi/06-modules/02-credentials/01-intro.md,"                                  "<<credentials.asciidoc#credentials_credentials_endpoint," "$file"
  replace "<<docs/ocpi/06-modules/02-credentials/03-use-cases.md#registration,"                 "<<credentials.asciidoc#credentials_registration," "$file"
  replace "<<docs/ocpi/06-modules/02-credentials/05-interfaces-and-endpoints.md#delete-method," "<<credentials_delete_method," "$file"
  replace "<<docs/ocpi/06-modules/02-credentials/05-interfaces-and-endpoints.md#get-method,"    "<<credentials_get_method," "$file"
  replace "<<docs/ocpi/06-modules/02-credentials/05-interfaces-and-endpoints.md#post-method,"   "<<credentials_post_method," "$file"
  replace "<<docs/ocpi/06-modules/02-credentials/05-interfaces-and-endpoints.md#put-method,"    "<<credentials_put_method," "$file"
  replace "<<docs/ocpi/06-modules/02-credentials/06-object-description.md#credentials-object,"  "<<credentials.asciidoc#credentials_credentials_object," "$file"
  replace "<<docs/ocpi/06-modules/02-credentials/07-data-types.md#credentialsrole-class,"       "<<credentials.asciidoc#credentials_credentials_role_class," "$file"
  replace "<<docs/ocpi/06-modules/02-credentials/07-data-types.md#credentialsrole-class,"       "<<credentials_credentials_role_class," "$file"

  replace "<<docs/ocpi/06-modules/03-locations/01-intro.md,"                                                  "<<mod_locations.asciidoc#mod_locations_locations_module," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/01-intro.md,"                                                  "<<mod_locations.asciidoc," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/01-intro.md,"                                                  "<<mod_locations_locations_module," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/04-flow-and-lifecycle.md,"                                     "<<mod_locations_flow_and_lifecycle," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/04-flow-and-lifecycle.md#delete-with-status-update,"           "<<evse_delete_with_status_update," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#get-list-request-parameters,"   "<<mod_locations_get_list_request_parameters," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#get-method,"                    "<<mod_locations_get_method," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#get-method-1,"                  "<<mod_locations_get_method_eMSP," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#get-object-request-parameters," "<<mod_locations_get_object_request_parameters," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#patch-method,"                  "<<mod_locations_patch_method," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#put-method,"                    "<<mod_locations_put_method," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#receiver-interface,"            "<<mod_locations_emsp_interface," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/06-object-description.md#,"                                    "<<mod_locations.asciidoc#mod_locations_evse_object," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/06-object-description.md#connector-object,"                    "<<mod_locations.asciidoc#mod_locations_connector_object," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/06-object-description.md#connector-object,"                    "<<mod_locations_connector_object," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/06-object-description.md#evse-object,"                         "<<mod_locations_evse_object," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/06-object-description.md#location-object,"                     "<<mod_locations.asciidoc#mod_locations_location_object," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/06-object-description.md#location-object,"                     "<<mod_locations_location_object," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#additionalgeolocation-class,"                 "<<mod_locations_additionalgeolocation_class," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#businessdetails-class,"                       "<<mod_locations.asciidoc#mod_locations_businessdetails_class," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#businessdetails-class,"                       "<<mod_locations_businessdetails_class," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#capability-enum,"                             "<<mod_locations.asciidoc#mod_locations_capability_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#capability-enum,"                             "<<mod_locations_capability_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#connectorformat-enum,"                        "<<mod_locations.asciidoc#mod_locations_connectorformat_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#connectorformat-enum,"                        "<<mod_locations_connectorformat_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#connectortype-enum,"                          "<<mod_locations.asciidoc#mod_locations_connectortype_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#connectortype-enum,"                          "<<mod_locations_connectortype_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#energymix-class,"                             "<<mod_locations.asciidoc#mod_locations_energymix_class," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#energymix-class,"                             "<<mod_locations_energymix_class," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#energysource-class,"                          "<<mod_locations_energysource_class," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#energysourcecategory-enum,"                   "<<mod_locations_energysourcecategory_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#environmentalimpact-class,"                   "<<mod_locations_environmentalimpact_class," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#environmentalimpactcategory-enum,"            "<<mod_locations_environmentalimpactcategory_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#evse-object,"                                 "<<mod_locations.asciidoc#mod_locations_geolocation_class," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#exceptionalperiod-class,"                     "<<mod_locations_exceptionalperiod_class," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#facility-enum,"                               "<<mod_locations_facility_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#geolocation-class,"                           "<<mod_locations_geolocation_class," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#hours-class,"                                 "<<mod_locations_hours_class," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#image-class,"                                 "<<mod_locations_image_class," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#imagecategory-enum,"                          "<<mod_locations_imagecategory_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#parkingrestriction-enum,"                     "<<mod_locations_parkingrestriction_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#parkingtype-enum,"                            "<<mod_locations_parkingtype_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#powertype-enum,"                              "<<mod_locations.asciidoc#mod_locations_powertype_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#powertype-enum,"                              "<<mod_locations_powertype_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#publishtokentype-class,"                      "<<mod_locations_publish_token_class," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#regularhours-class,"                          "<<mod_locations_regularhours_class," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#status-enum,"                                 "<<mod_locations_status_enum," "$file"
  replace "<<docs/ocpi/06-modules/03-locations/07-data-types.md#statusschedule-class,"                        "<<mod_locations_statusschedule_class," "$file"

  replace "<<docs/ocpi/06-modules/04-sessions/01-intro.md,"                                         "<<mod_sessions.asciidoc#mod_sessions_sessions_module," "$file"
  replace "<<docs/ocpi/06-modules/04-sessions/05-interfaces-and-endpoints.md#get-method,"           "<<mod_sessions_cpo_get_method," "$file"
  replace "<<docs/ocpi/06-modules/04-sessions/05-interfaces-and-endpoints.md#get-method-1,"         "<<mod_sessions_msp_get_method," "$file"
  replace "<<docs/ocpi/06-modules/04-sessions/05-interfaces-and-endpoints.md#patch-method,"         "<<mod_sessions_patch_method," "$file"
  replace "<<docs/ocpi/06-modules/04-sessions/05-interfaces-and-endpoints.md#put-method,"           "<<mod_sessions_cpo_put_method," "$file"
  replace "<<docs/ocpi/06-modules/04-sessions/05-interfaces-and-endpoints.md#put-method-1,"         "<<mod_sessions_msp_put_method," "$file"
  replace "<<docs/ocpi/06-modules/04-sessions/06-object-description.md#chargingpreferences-object," "<<mod_sessions_charging_preferences_object," "$file"
  replace "<<docs/ocpi/06-modules/04-sessions/06-object-description.md#session-object,"             "<<mod_sessions.asciidoc#mod_sessions_session_object," "$file"
  replace "<<docs/ocpi/06-modules/04-sessions/06-object-description.md#session-object,"             "<<mod_sessions_session_object," "$file"
  replace "<<docs/ocpi/06-modules/04-sessions/06-object-description.md#set-charging-preferences,"   "<<mod_sessions.asciidoc#mod_sessions_set_charging_preferences," "$file"
  replace "<<docs/ocpi/06-modules/04-sessions/07-data-types.md#chargingpreferencesresponse-enum,"   "<<mod_sessions_charging_preferences_response_enum," "$file"
  replace "<<docs/ocpi/06-modules/04-sessions/07-data-types.md#profiletype-enum,"                   "<<mod_sessions.asciidoc#mod_sessions_profile_type_enum," "$file"
  replace "<<docs/ocpi/06-modules/04-sessions/07-data-types.md#profiletype-enum,"                   "<<mod_sessions_profile_type_enum," "$file"
  replace "<<docs/ocpi/06-modules/04-sessions/07-data-types.md#sessionstatus-enum,"                 "<<mod_sessions_sessionstatus_enum," "$file"

  replace "<<docs/ocpi/06-modules/05-cdrs/01-intro.md,"                                 "<<mod_cdrs.asciidoc#mod_cdrs_cdrs_module," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/04-flow-and-lifecycle.md#credit-cdrs,"        "<<mod_cdrs_credit_cdrs," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/05-interfaces-and-endpoints.md#get-method,"   "<<mod_cdrs_cpo_get_method," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/05-interfaces-and-endpoints.md#get-method-1," "<<mod_cdrs_msp_get_method," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/05-interfaces-and-endpoints.md#post-method,"  "<<mod_cdrs_post_method," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/06-object-description.md#cdr-object,"         "<<mod_cdrs.asciidoc#mod_cdrs_cdr_object," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/06-object-description.md#cdr-object,"         "<<mod_cdrs_cdr_object," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/06-object-description.md#step_size,"          "<<mod_cdrs.asciidoc#mod_cdrs_step_size," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/07-data-types.md#authmethod-enum,"            "<<mod_cdrs.asciidoc#mod_cdrs_authmethod_enum," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/07-data-types.md#authmethod-enum,"            "<<mod_cdrs_authmethod_enum," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/07-data-types.md#cdrdimension-class,"         "<<mod_cdrs_cdrdimension_class," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/07-data-types.md#cdrdimensiontype-enum,"      "<<mod_cdrs_cdrdimensiontype_enum," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/07-data-types.md#cdrlocation-class,"          "<<mod_cdrs_cdr_location_class," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/07-data-types.md#cdrtoken-class,"             "<<mod_cdrs.asciidoc#mod_cdrs_cdr_token_object," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/07-data-types.md#cdrtoken-class,"             "<<mod_cdrs_cdr_token_object," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/07-data-types.md#chargingperiod-class,"       "<<mod_cdrs.asciidoc#mod_cdrs_chargingperiod_class," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/07-data-types.md#chargingperiod-class,"       "<<mod_cdrs_chargingperiod_class," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/07-data-types.md#signeddata-class,"           "<<mod_cdrs_signed_data_class," "$file"
  replace "<<docs/ocpi/06-modules/05-cdrs/07-data-types.md#signedvalue-class,"          "<<mod_cdrs_signed_value_class," "$file"

  replace "<<docs/ocpi/06-modules/06-tariffs/01-intro.md,"                                                    "<<mod_tariffs.asciidoc#mod_tariffs_tariffs_module," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/05-interfaces-and-endpoints.md#delete-method,"                   "<<mod_tariffs_delete_method," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/05-interfaces-and-endpoints.md#get-method,"                      "<<mod_tariffs_cpo_get_method," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/05-interfaces-and-endpoints.md#get-method,"                      "<<mod_tariffs_msp_get_method," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/05-interfaces-and-endpoints.md#get-method-1,"                    "<<mod_tariffs_msp_get_method," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/05-interfaces-and-endpoints.md#put-method,"                      "<<mod_tariffs_put_method," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/06-object-description.md#free-of-charge-tariff-example,"         "<<mod_tariffs_free_of_charge_tariff_example," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/06-object-description.md#tariff-example-with-reservation-price," "<<mod_tariffs_tariff_example_15_reservation_5_euro_per_hour," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/06-object-description.md#tariff-object,"                         "<<mod_tariffs.asciidoc#mod_tariffs_tariff_object," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/06-object-description.md#tariff-object,"                         "<<mod_tariffs_tariff_object," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/07-data-types.md#dayofweek-enum,"                                "<<mod_tariffs_dayofweek_enum," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/07-data-types.md#pricecomponent-class,"                          "<<mod_tariffs.asciidoc#mod_tariffs_pricecomponent_class," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/07-data-types.md#pricecomponent-class,"                          "<<mod_tariffs_pricecomponent_class," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/07-data-types.md#reservationrestrictiontype-enum,"               "<<mod_tariffs_reservation_restriction_type," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffdimensiontype-enum,"                      "<<mod_tariffs.asciidoc#mod_tariffs_tariffdimensiontype_enum," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffdimensiontype-enum,"                      "<<mod_tariffs_tariffdimensiontype_enum," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffelement-class,"                           "<<mod_tariffs.asciidoc#mod_tariffs_tariffelement_class," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffelement-class,"                           "<<mod_tariffs_tariffelement_class," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffrestrictions-class,"                      "<<mod_tariffs_tariffrestrictions_class," "$file"
  replace "<<docs/ocpi/06-modules/06-tariffs/07-data-types.md#tarifftype-enum,"                               "<<mod_tariffs_tariff_type," "$file"

  replace "<<docs/ocpi/06-modules/07-tokens/01-intro.md,"                                       "<<mod_tokens.asciidoc#mod_tokens_tokens_module," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/04-flow-and-lifecycle.md#real-time-authorization,"  "<<mod_tokens.asciidoc#mod_tokens_real-time_authorization," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/04-flow-and-lifecycle.md#real-time-authorization,"  "<<mod_tokens_real-time_authorization," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/05-interfaces-and-endpoints.md#get-method,"         "<<mod_tokens_cpo_get_method," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/05-interfaces-and-endpoints.md#get-method-1,"       "<<mod_tokens_msp_get_method," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/05-interfaces-and-endpoints.md#patch-method,"       "<<mod_tokens_patch_method," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/05-interfaces-and-endpoints.md#post-method,"        "<<mod_tokens_post_method," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/05-interfaces-and-endpoints.md#put-method,"         "<<mod_tokens_put_method," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/06-object-description.md#authorizationinfo-object," "<<mod_tokens_authorizationinfo_object," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/06-object-description.md#token-object,"             "<<mod_tokens.asciidoc#mod_tokens_token_object," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/06-object-description.md#token-object,"             "<<mod_tokens_token_object," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/07-data-types.md#allowedtype-enum,"                 "<<mod_tokens_allowed_enum," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/07-data-types.md#energycontract-class,"             "<<mod_tokens.asciidoc#mod_tokens_energy_contract," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/07-data-types.md#locationreferences-class,"         "<<mod_tokens_locationreferences_class," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/07-data-types.md#tokentype-enum,"                   "<<mod_tokens.asciidoc#mod_tokens_tokentype_enum," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/07-data-types.md#tokentype-enum,"                   "<<mod_tokens_tokentype_enum," "$file"
  replace "<<docs/ocpi/06-modules/07-tokens/07-data-types.md#whitelisttype-enum,"               "<<mod_tokens_whitelisttype_enum," "$file"

  replace "<<docs/ocpi/06-modules/08-commands/01-intro.md,"                                       "<<mod_commands.asciidoc#mod_commands_commands_module," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/05-interfaces-and-endpoints.md#post-method,"        "<<mod_commands_cpo_post_method," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/05-interfaces-and-endpoints.md#post-method-1,"      "<<mod_commands_msp_post_method," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/06-object-description.md#cancelreservation-object," "<<mod_commands.asciidoc#mod_commands_cancelreservation_object," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/06-object-description.md#cancelreservation-object," "<<mod_commands_cancelreservation_object," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/06-object-description.md#commandresponse-object,"   "<<mod_commands_commandresponse_object," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/06-object-description.md#commandresult-object,"     "<<mod_commands_commandresult_object," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/06-object-description.md#reservenow-object,"        "<<mod_commands.asciidoc#mod_commands_reservenow_object," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/06-object-description.md#reservenow-object,"        "<<mod_commands_reservenow_object," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/06-object-description.md#startsession-object,"      "<<mod_commands.asciidoc#mod_commands_startsession_object," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/06-object-description.md#startsession-object,"      "<<mod_commands_startsession_object," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/06-object-description.md#stopsession-object,"       "<<mod_commands.asciidoc#mod_commands_stopsession_object," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/06-object-description.md#stopsession-object,"       "<<mod_commands_stopsession_object," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/06-object-description.md#unlockconnector-object,"   "<<mod_commands.asciidoc#mod_commands_unlockconnector_object," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/06-object-description.md#unlockconnector-object,"   "<<mod_commands_unlockconnector_object," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/07-data-types.md#commandresponsetype-enum,"         "<<mod_commands_commandresponsetype_enum," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/07-data-types.md#commandresulttype-enum,"           "<<mod_commands_commandresulttype_enum," "$file"
  replace "<<docs/ocpi/06-modules/08-commands/07-data-types.md#commandtype-enum,"                 "<<mod_commands_commandtype_enum," "$file"

  replace "<<docs/ocpi/06-modules/09-charging-profiles/01-intro.md,"                                              "<<mod_charging_profiles.asciidoc#mod_charging_profiles_module," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/05-interfaces-and-endpoints.md#delete-method,"             "<<mod_charging_profiles_cpo_delete_method," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/05-interfaces-and-endpoints.md#get-method,"                "<<mod_charging_profiles_cpo_get_method," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/05-interfaces-and-endpoints.md#post-method,"               "<<mod_charging_profiles_msp_post_method," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/05-interfaces-and-endpoints.md#put-method,"                "<<mod_charging_profiles_cpo_put_method," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/05-interfaces-and-endpoints.md#put-method-1,"              "<<mod_charging_profiles_msp_put_method," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/06-object-description.md#chargingprofileresponse-object,"  "<<mod_charging_profiles_response_object," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/06-object-description.md#chargingprofileresult-object,"    "<<mod_charging_profiles_active_charging_profiles_result_object," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/06-object-description.md#chargingprofileresult-object,"    "<<mod_charging_profiles_charging_profiles_result_object," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/06-object-description.md#clearprofileresult-object,"       "<<mod_charging_profiles_clear_profiles_result_object," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/06-object-description.md#setchargingprofile-object,"       "<<mod_charging_profiles_set_charging_profile_object," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/07-data-types.md#activechargingprofile-class,"             "<<mod_charging_profiles_active_charging_profile_class," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/07-data-types.md#chargingprofile-class,"                   "<<mod_charging_profiles_charging_profile_class," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/07-data-types.md#chargingprofileperiod-class,"             "<<mod_charging_profiles_charging_profile_period_class," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/07-data-types.md#chargingprofileresponsetype-enum,"        "<<mod_charging_profiles_responsetype_enum," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/07-data-types.md#chargingprofileresulttype-enum,"          "<<mod_charging_profiles_resulttype_enum," "$file"
  replace "<<docs/ocpi/06-modules/09-charging-profiles/07-data-types.md#chargingrateunit-enum,"                   "<<mod_charging_profiles_chargingrateunit," "$file"

  replace "<<docs/ocpi/06-modules/10-hubclientinfo/01-intro.md,"                                "<<mod_hub_client_info.asciidoc#mod_hub_client_info_module," "$file"
  replace "<<docs/ocpi/06-modules/10-hubclientinfo/05-interfaces.md#get-method,"                "<<mod_hub_client_info_client_get," "$file"
  replace "<<docs/ocpi/06-modules/10-hubclientinfo/05-interfaces.md#get-method-1,"              "<<mod_hub_client_info_hub_get," "$file"
  replace "<<docs/ocpi/06-modules/10-hubclientinfo/05-interfaces.md#put-method,"                "<<mod_hub_client_info_client_put," "$file"
  replace "<<docs/ocpi/06-modules/10-hubclientinfo/06-object-description.md#clientinfo-object," "<<mod_hub_client_info_hub_client_info_object," "$file"
  replace "<<docs/ocpi/06-modules/10-hubclientinfo/07-data-types.md#connectionstatus-enum,"     "<<mod_hub_client_info_hub_connection_type_enum," "$file"
  
  replace "<<docs/ocpi/07-types/01-intro.md#cistring-type,"     "<<types.asciidoc#types_cistring_type," "$file"
  replace "<<docs/ocpi/07-types/01-intro.md#datetime-type,"     "<<types.asciidoc#types_datetime_type," "$file"
  replace "<<docs/ocpi/07-types/01-intro.md#displaytext-class," "<<types.asciidoc#types_displaytext_class," "$file"
  replace "<<docs/ocpi/07-types/01-intro.md#number-type,"       "<<types.asciidoc#types_number_type," "$file"
  replace "<<docs/ocpi/07-types/01-intro.md#number-type,"       "<<types_number_type," "$file"
  replace "<<docs/ocpi/07-types/01-intro.md#price-class,"       "<<types.asciidoc#types_price_class," "$file"
  replace "<<docs/ocpi/07-types/01-intro.md#role-enum,"         "<<types.asciidoc#types_role_enum," "$file"
  replace "<<docs/ocpi/07-types/01-intro.md#string-type,"       "<<types.asciidoc#types_string_type," "$file"
  replace "<<docs/ocpi/07-types/01-intro.md#string-type,"       "<<types_string_type," "$file"
  replace "<<docs/ocpi/07-types/01-intro.md#url-type,"          "<<types.asciidoc#types_url_type," "$file"

  replace "<<https://EV-protocols," "<<changelog.asciidoc#changelog_changelog," "$file"

}
