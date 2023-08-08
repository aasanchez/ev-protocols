---
id: interfaces-and-endpoints
slug: /modules/sessions/interfaces-and-endpoints
---
# Interfaces and Endpoints

## Sender Interface

Typically implemented by market roles like: CPO.

| Method                                                                   | Description                                                                                                                                                                               |
|--------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [GET](/06-modules/04-sessions/05-interfaces-and-endpoints.md#get-method) | Fetch Session objects of charging sessions last updated between the `{date_from}` and `{date_to}`([paginated](/04-transport-and-format/01-json-http-implementation-guide.md#pagination)). |
| POST                                                                     | n/a                                                                                                                                                                                       |
| [PUT](/06-modules/04-sessions/05-interfaces-and-endpoints.md#put-method) | Setting Charging Preferences of an ongoing session.                                                                                                                                       |
| PATCH                                                                    | n/a                                                                                                                                                                                       |
| DELETE                                                                   | n/a                                                                                                                                                                                       |

### **GET** Method

Fetch Sessions from a CPO system.

Endpoint structure definition:

`{sessions_endpoint_url}?[date_from={date_from}]&amp;[date_to={date_to}]&amp;[offset={offset}]&amp;[limit={limit}]`

Examples:

* `https://www.server.com/ocpi/cpo/2.2.1/sessions/?date_from=2019-01-28T12:00:00&date_to=2019-01-29T12:00:00`
* `https://ocpi.server.com/2.2.1/sessions/?offset=50`
* `https://www.server.com/ocpi/2.2.1/sessions/?date_from=2019-01-29T12:00:00&limit=100`
* `https://www.server.com/ocpi/cpo/2.2.1/sessions/?offset=50&limit=100`

##### Request Parameters

Only Sessions with `last_update` between the given `{date_from}` (including) and `{date_to}` (excluding) will be
returned.

This request is [paginated](/04-transport-and-format/01-json-http-implementation-guide.md#pagination), it supports the
[pagination](/04-transport-and-format/01-json-http-implementation-guide.md#paginated-request) related URL parameters.

| Parameter | Datatype                                        | Required | Description                                                                                        |
|-----------|-------------------------------------------------|----------|----------------------------------------------------------------------------------------------------|
| date_from | [DateTime](/07-types/01-intro.md#datetime-type) | yes      | Only return Sessions that have `last_updated` after or equal to this Date/Time (inclusive).        |
| date_to   | [DateTime](/07-types/01-intro.md#datetime-type) | no       | Only return Sessions that have `last_updated` up to this Date/Time, but not including (exclusive). |
| offset    | int                                             | no       | The offset of the first object returned. Default is 0.                                             |
| limit     | int                                             | no       | Maximum number of objects to GET.                                                                  |

##### Response Data

The response contains a list of Session objects that match the given parameters in the request, the header will contain
the [pagination](/04-transport-and-format/01-json-http-implementation-guide.md#paginated-response) related headers.

Any older information that is not specified in the response is considered no longer valid. Each object must contain all
required fields. Fields that are not specified may be considered as null values.

|                                                                            |       |                                                            |
|----------------------------------------------------------------------------|-------|------------------------------------------------------------|
| Datatype                                                                   | Card. | Description                                                |
| [Session](/06-modules/04-sessions/06-object-description.md#session-object) | \*    | List of Session objects that match the request parameters. |

### **PUT** Method

Set/update the driver's Charging Preferences for this charging session.

Endpoint structure definition:

`{sessions_endpoint_url}/{session_id}/charging_preferences`

Examples:

* `https://www.server.com/ocpi/cpo/2.2.1/sessions/1234/charging_preferences`

:::note
The `/charging_preferences` URL suffix is required when setting Charging Preferences.
:::

##### Request Parameters

The following parameter has to be provided as URL segments.

| Parameter  | Datatype                                            | Required | Description                                                                 |
|------------|-----------------------------------------------------|----------|-----------------------------------------------------------------------------|
| session_id | [CiString](/07-types/01-intro.md#cistring-type)(36) | yes      | Session.id of the Session for which the Charging Preferences are to be set. |

##### Request Body

In the body, a [ChargingPreferences](/06-modules/04-sessions/06-object-description.md#chargingpreferences-object) object
has to be provided.

| Type                                                                                               | Card. | Description                                                  |
|----------------------------------------------------------------------------------------------------|-------|--------------------------------------------------------------|
| [ChargingPreferences](/06-modules/04-sessions/06-object-description.md#chargingpreferences-object) | 1     | Updated Charging Preferences of the driver for this Session. |

##### Response Data

The response contains a
[ChargingPreferencesResponse](/06-modules/04-sessions/07-data-types.md#chargingpreferencesresponse-enum) value.

| Type                                                                                                     | Card. | Description                                       |
|----------------------------------------------------------------------------------------------------------|-------|---------------------------------------------------|
| [ChargingPreferencesResponse](/06-modules/04-sessions/07-data-types.md#chargingpreferencesresponse-enum) | 1     | Response to the Charging Preferences PUT request. |

## Receiver Interface

Typically implemented by market roles like: eMSP and SCSP.

Sessions are [Client Owned
Objects](/04-transport-and-format/01-json-http-implementation-guide.md#client-owned-object-push), so the endpoints need
to contain the required extra fields:
{[party_id](/06-modules/02-credentials/06-object-description.md#credentials-object)} and
{[country_code](/06-modules/02-credentials/06-object-description.md#credentials-object)}.

Endpoint structure definition:

`{sessions_endpoint_url}/{country_code}/{party_id}/{session_id}`

Example:

* `https://www.server.com/ocpi/emsp/2.2.1/sessions/BE/BEC/1234`

| Method                                                                       | Description                                                                               |
|------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------|
| [GET](/06-modules/04-sessions/05-interfaces-and-endpoints.md#get-method-1)   | Retrieve a Session object from the eMSP's system with Session.id equal to `{session_id}`. |
| POST                                                                         | n/a                                                                                       |
| [PUT](/06-modules/04-sessions/05-interfaces-and-endpoints.md#put-method-1)   | Send a new/updated Session object to the eMSP.                                            |
| [PATCH](/06-modules/04-sessions/05-interfaces-and-endpoints.md#patch-method) | Update the Session object with Session.id equal to `{session_id}`.                        |
| DELETE                                                                       | n/a                                                                                       |

### **GET** Method

The CPO system might request the current version of a Session object from the eMSP's system to, for example, validate
the state, or because the CPO has received an error during a PATCH operation.

##### Request Parameters

The following parameters shall be provided as URL segments.

| Parameter    | Datatype                                            | Required | Description                                                                |
|--------------|-----------------------------------------------------|----------|----------------------------------------------------------------------------|
| country_code | [CiString](/07-types/01-intro.md#cistring-type)(2)  | yes      | Country code of the CPO performing the GET on the eMSP's system.           |
| party_id     | [CiString](/07-types/01-intro.md#cistring-type)(3)  | yes      | Party ID (Provider ID) of the CPO performing the GET on the eMSP's system. |
| session_id   | [CiString](/07-types/01-intro.md#cistring-type)(36) | yes      | id of the Session object to get from the eMSP's system.                    |

##### Response Data

The response contains the requested Session object.

|                                                                            |       |                           |
|----------------------------------------------------------------------------|-------|---------------------------|
| Datatype                                                                   | Card. | Description               |
| [Session](/06-modules/04-sessions/06-object-description.md#session-object) | 1     | Requested Session object. |

### **PUT** Method

Inform the eMSP's system about a new/updated Session object in the CPO's system.

When a PUT request is received for an existing
[Session](/06-modules/04-sessions/06-object-description.md#session-object) object (the object is PUT to the same URL),
The newly received [Session](/06-modules/04-sessions/06-object-description.md#session-object) object SHALL replace the
existing object.

Any `charging_periods` from the existing object SHALL be replaced by the `charging_periods` from the newly received
[Session](/06-modules/04-sessions/06-object-description.md#session-object) object. If the new
[Session](/06-modules/04-sessions/06-object-description.md#session-object) object does not contain `charging_periods`
(field is omitted or contains any empty list), the `charging_periods` of the existing object SHALL be removed (replaced
by the new empty list).

##### Request Body

The request contains the new or updated Session object.

| Type                                                                       | Card. | Description                    |
|----------------------------------------------------------------------------|-------|--------------------------------|
| [Session](/06-modules/04-sessions/06-object-description.md#session-object) | 1     | New or updated Session object. |

##### Request Parameters

The following parameters shall be provided as URL segments.

| Parameter    | Datatype                                            | Required | Description                                                                                                                                                    |
|--------------|-----------------------------------------------------|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code | [CiString](/07-types/01-intro.md#cistring-type)(2)  | yes      | Country code of the CPO performing this PUT on the eMSP's system. This SHALL be the same value as the `country_code` in the Session object being pushed.       |
| party_id     | [CiString](/07-types/01-intro.md#cistring-type)(3)  | yes      | Party ID (Provider ID) of the CPO performing this PUT on the eMSP's system. This SHALL be the same value as the `party_id` in the Session object being pushed. |
| session_id   | [CiString](/07-types/01-intro.md#cistring-type)(36) | yes      | id of the new or updated Session object.                                                                                                                       |

### **PATCH** Method

Same as the [PUT](/06-modules/04-sessions/05-interfaces-and-endpoints.md#put-method-1) method, but only the
fields/objects that need to be updated have to be present. Fields/objects which are not specified are considered
unchanged.

Any request to the PATCH method SHALL contain the `last_updated` field.

The PATCH method of the Session Receiver interface works on the entire
[Session](/06-modules/04-sessions/06-object-description.md#session-object) object only. It is not allowed to use extra
URL segments to try to PATCH fields of inner objects of the
[Session](/06-modules/04-sessions/06-object-description.md#session-object) object directly.

When a PATCH request contains the `charging_periods` field (inside a
[Session](/06-modules/04-sessions/06-object-description.md#session-object) object), this SHALL be processed as a request
to add all the [ChargingPeriod](/06-modules/05-cdrs/07-data-types.md#chargingperiod-class) objects to the existing
[Session](/06-modules/04-sessions/06-object-description.md#session-object) object. If the request `charging_periods`
list is omitted (or contains an empty list), no changes SHALL be made to the existing list of `charging_periods`.

If existing [ChargingPeriod](/06-modules/05-cdrs/07-data-types.md#chargingperiod-class) objects in a
[Session](/06-modules/04-sessions/06-object-description.md#session-object) need to be replaced or removed, the Sender
SHALL use the [PUT](/06-modules/04-sessions/05-interfaces-and-endpoints.md#put-method-1) method to replace the entire
[Session](/06-modules/04-sessions/06-object-description.md#session-object) object (including all the
`charging_periods`).

##### Example: update the total cost

Patching the `total_cost` needs to be done on the
[Session](/06-modules/04-sessions/06-object-description.md#session-object) Object.

``` json
PATCH https://www.server.com/ocpi/cpo/2.2.1/sessions/NL/TNM/101

{
  "total_cost": {
    "excl_vat": 0.6,
    "incl_vat": 0.66
  },
  "last_updated": "2019-06-23T08:11:00Z"
}
```

##### Example: adding a new ChargingPeriod

PATCH used to add a new [ChargingPeriod](/06-modules/05-cdrs/07-data-types.md#chargingperiod-class) to the Session and
updating all related fields.

``` json
PATCH https://www.server.com/ocpi/cpo/2.2.1/sessions/NL/TNM/101

{
  "kwh": 15,
  "charging_periods": [
    {
      "start_date_time": "2019-06-23T08:16:02Z",
      "dimensions": [
        {
          "type": "ENERGY",
          "volume": 2200
        }
      ]
    }
  ],
  "total_cost": {
    "excl_vat": 0.8,
    "incl_vat": 0.88
  },
  "last_updated": "2019-06-23T08:16:02Z"
}
```
