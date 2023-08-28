---
id: interfaces-and-endpoints
slug: interfaces-and-endpoints
---
# Interfaces and endpoints

The ChargingProfiles module consists of two interfaces: a Receiver interface that enables a Sender (and its clients) to
send ChargingProfiles to a Location/EVSE, and an Sender interface to receive the response from the Location/EVSE
asynchronously.

## Receiver Interface

Typically implemented by market roles like: CPO.

Example endpoint structures:

| Method                                                                                                 | Description                                                          |
|--------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|
| \<\</docs/ocpi/06-modules/09-charging-profiles/05-interfaces-and-endpoints.md#get-method,GET\>\>       | Gets the ActiveChargingProfile for a specific charging session.      |
| POST                                                                                                   | n/a                                                                  |
| \<\</docs/ocpi/06-modules/09-charging-profiles/05-interfaces-and-endpoints.md#put-method,PUT\>\>       | Creates/updates a ChargingProfile for a specific charging session.   |
| PATCH                                                                                                  | n/a                                                                  |
| \<\</docs/ocpi/06-modules/09-charging-profiles/05-interfaces-and-endpoints.md#delete-method,DELETE\>\> | Cancels an existing ChargingProfile for a specific charging session. |

### **GET** Method

Retrieves the ActiveChargingProfile as it is currently planned for the the given session.

Endpoint structure definition:

`{chargingprofiles_endpoint_url}{session_id}?duration={duration}&response_url={url}`

Example:

* `https://www.cpo.com/ocpi/2.2.1/chargingprofiles/1234?duration=900&response_url=https://www.msp.com/ocpi/2.2.1/chargingprofile/response?request_id=5678`

:::note
As it is not common to add a body to a GET request, all parameters are added to the URL.
:::

====== Request Parameters

The following parameters shall be provided as URL segments.

| Parameter    | Datatype                                                           | Required | Description                                                                                                                                                                                                                                                                        |
|--------------|--------------------------------------------------------------------|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| session_id   | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(36) | yes      | The unique id that identifies the session in the Receiver platform.                                                                                                                                                                                                                |
| duration     | int                                                                | yes      | Length of the requested ActiveChargingProfile in seconds Duration in seconds. \*                                                                                                                                                                                                   |
| response_url | \<\</docs/ocpi/07-types/01-intro.md#url-type,URL\>\>               | yes      | URL that the \<\</docs/ocpi/06-modules/09-charging-profiles/06-object-description.md#chargingprofileresult-object,ActiveChargingProfileResult\>\> POST should be sent to. This URL might contain a unique ID to be able to distinguish between GET ActiveChargingProfile requests. |

:::note
duration: Balance the duration between maximizing the information gained and the data usage and computation to execute
on the request. Warning: asking for longer duration than necessary might result in additional data costs, while its
added value diminishes with every change in the schedule.
:::

====== Response Data

The response contains the direct response from the Receiver, not the response from the EVSE itself. That information
will be sent via an asynchronous POST on the Sender interface if this response is `ACCEPTED`.

| Datatype                                                                                                                           | Card. | Description                                                                                                                                                                                                                                                      |
|------------------------------------------------------------------------------------------------------------------------------------|-------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| \<\</docs/ocpi/06-modules/09-charging-profiles/06-object-description.md#chargingprofileresponse-object,ChargingProfileResponse\>\> | 1     | Result of the ActiveChargingProfile request, by the Receiver (Typically CPO), not the location/EVSE. So this indicates if the Receiver understood the ChargingProfile request and was able to send it to the EVSE. This is not the response by the Charge Point. |

### **PUT** Method

Creates a new ChargingProfile on a session, or replaces an existing ChargingProfile on the EVSE.

Endpoint structure definition:

`{chargingprofiles_endpoint_url}{session_id}`

Example:

* `https://www.cpo.com/ocpi/2.2.1/chargingprofiles/1234`

====== Request Parameters

The following parameter shall be provided as URL segments.

| Parameter  | Datatype                                                           | Required | Description                                                         |
|------------|--------------------------------------------------------------------|----------|---------------------------------------------------------------------|
| session_id | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(36) | yes      | The unique id that identifies the session in the Receiver platform. |

### Request Body

The body contains a SetChargingProfile object, that contains the new ChargingProfile and a response URL.

| Type                                                                                                                     | Card. | Description                                                                                         |
|--------------------------------------------------------------------------------------------------------------------------|-------|-----------------------------------------------------------------------------------------------------|
| \<\</docs/ocpi/06-modules/09-charging-profiles/06-object-description.md#setchargingprofile-object,SetChargingProfile\>\> | 1     | SetChargingProfile object with information needed to set/update the Charging Profile for a session. |

====== Response Data

The response contains the direct response from the Receiver (Typically CPO), not the response from the EVSE itself, that
will be sent via an asynchronous POST on the Sender interface if this response is `ACCEPTED`.

| Datatype                                                                                                                           | Card. | Description                                                                                                                                                                                                                               |
|------------------------------------------------------------------------------------------------------------------------------------|-------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| \<\</docs/ocpi/06-modules/09-charging-profiles/06-object-description.md#chargingprofileresponse-object,ChargingProfileResponse\>\> | 1     | Result of the ChargingProfile PUT request, by the CPO (not the location/EVSE). So this indicates if the CPO understood the ChargingProfile PUT request and was able to send it to the EVSE. This is not the response by the Charge Point. |

### **DELETE** Method

Clears the ChargingProfile set by the eMSP on the given session.

Endpoint structure definition:

`{chargingprofiles_endpoint_url}{session_id}?response_url={url}`

Example:

* `https://www.cpo.com/ocpi/2.2.1/chargingprofiles/1234?response_url=https://www.server.com/example`

:::note
As it is not common to add a body to a DELETE request, all parameters are added to the URL.
:::

====== Request Parameters

The following parameters shall be provided as URL segments.

| Parameter    | Datatype                                                           | Required | Description                                                                                                                                                                                                                                                         |
|--------------|--------------------------------------------------------------------|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| session_id   | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(36) | yes      | The unique id that identifies the session in the Receiver platform.                                                                                                                                                                                                 |
| response_url | \<\</docs/ocpi/07-types/01-intro.md#url-type,URL\>\>               | yes      | URL that the \<\</docs/ocpi/06-modules/09-charging-profiles/06-object-description.md#clearprofileresult-object,ClearProfileResult\>\> POST should be sent to. This URL might contain a unique ID to be able to distinguish between DELETE ChargingProfile requests. |

====== Response Data

The response contains the direct response from the Receiver (typically CPO), not the response from the EVSE itself, that
will be sent via an asynchronous POST on the Sender interface if this response is `ACCEPTED`.

| Datatype                                                                                                                           | Card. | Description                                                                                                                                                                                                                                     |
|------------------------------------------------------------------------------------------------------------------------------------|-------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| \<\</docs/ocpi/06-modules/09-charging-profiles/06-object-description.md#chargingprofileresponse-object,ChargingProfileResponse\>\> | 1     | Result of the ChargingProfile DELETE request, by the CPO (not the location/EVSE). So this indicates if the CPO understood the ChargingProfile DELETE request and was able to send it to the EVSE. This is not the response by the Charge Point. |

## Sender Interface

Typically implemented by market roles like: SCSP.

The Sender interface receives the asynchronous responses.

| Method                                                                                             | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
|----------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| GET                                                                                                | n/a                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| \<\</docs/ocpi/06-modules/09-charging-profiles/05-interfaces-and-endpoints.md#post-method,POST\>\> | Receive the asynchronous response from the Charge Point.                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| \<\</docs/ocpi/06-modules/09-charging-profiles/05-interfaces-and-endpoints.md#put-method-1,PUT\>\> | Receiver (typically CPO) can send an updated ActiveChargingProfile when other inputs have made changes to existing profile. When the Receiver (typically CPO) sends a update profile to the EVSE, for an other reason then the Sender (Typically SCSP) asking, the Sender SHALL post an update to this interface. When a local input influence the ActiveChargingProfile in the EVSE AND the Receiver (typically CPO) is made aware of this, the Receiver SHALL post an update to this interface. |
| PUT                                                                                                | n/a                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| PATCH                                                                                              | n/a                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| DELETE                                                                                             | n/a                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

### **POST** Method

====== Request Parameters

There are no URL segment parameters required by OCPI.

As the Sender interface is called by the Receiver (typically CPO) on the URL given `response_url` in the Sender request
to the Receiver interface. It is up to the implementation of the Sender (typically SCSP) to determine what parameters
are put in the URL. The Sender sends a URL in the POST method body to the Receiver. The Receiver is required to use this
URL for the asynchronous response by the Charge Point. It is advised to make this URL unique for every request to
differentiate simultaneous commands, for example by adding a unique id as a URL segment.

Endpoint structure definition:

No structure defined. This is open to the eMSP to define, the URL is provided to the Receiver by the Sender. Therefor
OCPI does not define variables.

Examples:

* `https://www.server.com/ocpi/2.2.1/chargingprofiles/chargingprofile/12345678`
* `https://www.server.com/activechargingprofile/12345678`
* `https://www.server.com/clearprofile?request_id=12345678`
* `https://www.server.com/ocpi/2.2.1/12345678`

The content of the request body depends on the original request by the eMSP to which this POST is send as a result.

### Request Body

| Datatype                                                                                                                             | Card. | Description                                                             |
|--------------------------------------------------------------------------------------------------------------------------------------|-------|-------------------------------------------------------------------------|
| *Choice: one of three*                                                                                                               |       |                                                                         |
| \<\</docs/ocpi/06-modules/09-charging-profiles/06-object-description.md#chargingprofileresult-object,ActiveChargingProfileResult\>\> | 1     | Result of the GET ActiveChargingProfile request, from the Charge Point. |
| \<\</docs/ocpi/06-modules/09-charging-profiles/06-object-description.md#chargingprofileresult-object,ChargingProfileResult\>\>       | 1     | Result of the PUT ChargingProfile request, from the Charge Point.       |
| \<\</docs/ocpi/06-modules/09-charging-profiles/06-object-description.md#clearprofileresult-object,ClearProfileResult\>\>             | 1     | Result of the DELETE ChargingProfile request, from the Charge Point.    |

### Response Body

The response to the POST on the Sender interface SHALL contain the
\<\</docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#response-format,Response Format\>\> with the
data field omitted.

### **PUT** Method

Updates the Sender (typically SCSP) when the Receiver (typically CPO) knows the ActiveChargingProfile has changed.

The Receiver SHALL call this interface every time it knows changes have been made that influence the
ActiveChargingProfile for an ongoing session AND the Sender has at least once successfully called the charging profile
Receiver PUT interface for this session (SetChargingProfile). If the Receiver doesn't know the ActiveChargingProfile has
changed (EVSE does not notify the Receiver (typically CPO) of the change) it is not required to call this interface.

The Receiver SHALL NOT call this interface for any session where the Sender has never, successfully called the charging
profile Receiver PUT interface for this session (SetChargingProfile).

The Receiver SHALL send a useful relevant duration of ActiveChargingProfile to send to the Sender. As a guide: between 5
and 60 minutes. If the Sender wants a longer ActiveChargingProfile the Sender can always do a GET with a longer
duration.

Endpoint structure definition:

`{chargingprofiles_endpoint_url}{session_id}`

Example:

* `https://www.server.com/ocpi/2.2.1/chargingprofiles/1234`

====== Request Parameters

The following parameter shall be provided as URL segments.

| Parameter  | Datatype                                                           | Required | Description                                                         |
|------------|--------------------------------------------------------------------|----------|---------------------------------------------------------------------|
| session_id | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(36) | yes      | The unique id that identifies the session in the Receiver platform. |

### Request Body

The body contains the update ActiveChargingProfile, The ActiveChargingProfile is the charging profile as calculated by
the EVSE.

| Type                                                                                                                  | Card. | Description                                                                                                                                                                          |
|-----------------------------------------------------------------------------------------------------------------------|-------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| \<\</docs/ocpi/06-modules/09-charging-profiles/07-data-types.md#activechargingprofile-class,ActiveChargingProfile\>\> | 1     | The new ActiveChargingProfile. If there is no longer any charging profile active, the ActiveChargingProfile SHALL reflect this by showing the maximum charging capacity of the EVSE. |

### Response Body

The response to the PUT on the eMSP interface SHALL contain the
\<\</docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#response-format,Response Format\>\> with the
data field omitted.
