---
id: object-description
slug: object-description
---
# Object description

## *ChargingProfileResponse* Object

The ChargingProfileResponse object is send in the HTTP response body.

Because OCPI does not allow/require retries, it could happen that the asynchronous result url given by the eMSP is never
successfully called. The eMSP might have had a glitch, HTTP 500 returned, was offline for a moment etc. For the eMSP to
be able to reject to timeouts, it is important for the eMSP to know the timeout on a certain command.

| Property | Type                                                                                                                             | Card. | Description                                                                                                                                                         |
|----------|----------------------------------------------------------------------------------------------------------------------------------|-------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| result   | \<\</docs/ocpi/06-modules/09-charging-profiles/07-data-types.md#chargingprofileresponsetype-enum,ChargingProfileResponseType\>\> | 1     | Response from the CPO on the ChargingProfile request.                                                                                                               |
| timeout  | int                                                                                                                              | 1     | Timeout for this ChargingProfile request in seconds. When the Result is not received within this timeout, the eMSP can assume that the message might never be sent. |

## *ActiveChargingProfileResult* Object

The ActiveChargingProfileResult object is send by the CPO to the given `response_url` in a POST request. It contains the
result of the GET (ActiveChargingProfile) request send by the eMSP.

| Property | Type                                                                                                                         | Card. | Description                                                                                |
|----------|------------------------------------------------------------------------------------------------------------------------------|-------|--------------------------------------------------------------------------------------------|
| result   | \<\</docs/ocpi/06-modules/09-charging-profiles/07-data-types.md#chargingprofileresulttype-enum,ChargingProfileResultType\>\> | 1     | The EVSE will indicate if it was able to process the request for the ActiveChargingProfile |
| profile  | \<\</docs/ocpi/06-modules/09-charging-profiles/07-data-types.md#activechargingprofile-class,ActiveChargingProfile\>\>        | ?     | The requested ActiveChargingProfile, if the result field is set to: `ACCEPTED`             |

## *ChargingProfileResult* Object

The ChargingProfileResult object is send by the CPO to the given `response_url` in a POST request. It contains the
result of the PUT (SetChargingProfile) request send by the eMSP.

| Property | Type                                                                                                                         | Card. | Description                                                                        |
|----------|------------------------------------------------------------------------------------------------------------------------------|-------|------------------------------------------------------------------------------------|
| result   | \<\</docs/ocpi/06-modules/09-charging-profiles/07-data-types.md#chargingprofileresulttype-enum,ChargingProfileResultType\>\> | 1     | The EVSE will indicate if it was able to process the new/updated charging profile. |

## *ClearProfileResult* Object

The ClearProfileResult object is send by the CPO to the given `response_url` in a POST request. It contains the result
of the DELETE (ClearProfile) request send by the eMSP.

| Property | Type                                                                                                                         | Card. | Description                                                                                                  |
|----------|------------------------------------------------------------------------------------------------------------------------------|-------|--------------------------------------------------------------------------------------------------------------|
| result   | \<\</docs/ocpi/06-modules/09-charging-profiles/07-data-types.md#chargingprofileresulttype-enum,ChargingProfileResultType\>\> | 1     | The EVSE will indicate if it was able to process the removal of the charging profile (ClearChargingProfile). |

## *SetChargingProfile* Object

Object set to a CPO to set a Charging Profile.

| Property         | Type                                                                                                      | Card. | Description                                                                                                                                                         |
|------------------|-----------------------------------------------------------------------------------------------------------|-------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| charging_profile | \<\</docs/ocpi/06-modules/09-charging-profiles/07-data-types.md#chargingprofile-class,ChargingProfile\>\> | 1     | Contains limits for the available power or current over time.                                                                                                       |
| response_url     | \<\</docs/ocpi/07-types/01-intro.md#url-type,URL\>\>                                                      | 1     | URL that the ChargingProfileResult POST should be sent to. This URL might contain a unique ID to be able to distinguish between GET ActiveChargingProfile requests. |
