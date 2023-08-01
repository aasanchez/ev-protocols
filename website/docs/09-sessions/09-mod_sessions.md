---
id: intro
slug: /modules/sessions
---
# Sessions

:::tip Module Identifier
sessions
:::

:::caution Data owner
CPO
:::

:::info Type
Functional Module
:::

The Session object describes one charging session. The Session object is owned by the CPO back-end system, and can be
GET from the CPO system, or pushed by the CPO to another system.

## Flow and Lifecycle

### Push model

When the CPO creates a Session object they push it to the corresponding eMSP by calling
[PUT](https://ocpi.dev) on the eMSP's Sessions endpoint with the newly created Session object.

Any changes to a Session in the CPO system are sent to the eMSP system by calling [PATCH](https://ocpi.dev) on
the eMSP's Sessions endpoint with the updated Session object.

Sessions cannot be deleted, final status of a session is: `COMPLETED`.

When the CPO is not sure about the state or existence of a Session object in the eMSP's system, the CPO can call
[GET](https://ocpi.dev) on the eMSP's Sessions endpoint to validate the Session object in the eMSP's system.

### Pull model

eMSPs who do not support the Push model need to call [GET](https://ocpi.dev) on the CPO's Sessions endpoint
to receive a list of Sessions.

This [GET](https://ocpi.dev) method can also be used in combination with the Push model to retrieve Sessions
after the system (re-)connects to a CPO, to get a list Sessions *missed* during a downtime of the eMSP's system.

### Set: Charging Preferences

For a lot of smart charging use cases, input from the driver is needed. The smart charging algorithms need to be able to
give certain session priority over others. In other words they need to know how much energy an EV needs before what
time. Via a [PUT](https://ocpi.dev) request on the Sender Interface, during an ongoing session, the eMSP can
send [Charging Preferences](https://ocpi.dev) on behalf of the driver.

The eMSP can determine if an EVSE supports Charging Preferences by checking if the [EVSE
capabilities](https://ocpi.dev) contains:
[CHARGING_PREFERENCES_CAPABLE](https://ocpi.dev).

Via [Tariffs](https://ocpi.dev) the CPO can give different Charging Preferences different
prices. A [Connector](https://ocpi.dev) can have multiple
[Tariffs](https://ocpi.dev), one for each [ProfileType](https://ocpi.dev).

### Reservation

When a EV driver makes a Reservation for a Charge Point/EVSE, the Sender SHALL create a new Session object with `status`
= `RESERVED` When the Push model is used, the CPO SHALL push the new Session object to the Receiver.

When a reservation results in a charging session for the same `Token`, the Session object `status` to: `ACTIVE`

When a reservation does not result in a charging session, the Session object `status` SHALL be set to: `COMPLETED`.

A CDR might be created even if no energy was transferred to the EV, just for the costs of the reservation.

## Interfaces and Endpoints

### Sender Interface

Typically implemented by market roles like: CPO.

| Method                  | Description                                                                                                                                                                               |
|-------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [GET](https://ocpi.dev) | Fetch Session objects of charging sessions last updated between the `{date_from}` and `{date_to}`([paginated](/04-transport-and-format/01-json-http-implementation-guide.md#pagination)). |
| POST                    | n/a                                                                                                                                                                                       |
| [PUT](https://ocpi.dev) | Setting Charging Preferences of an ongoing session.                                                                                                                                       |
| PATCH                   | n/a                                                                                                                                                                                       |
| DELETE                  | n/a                                                                                                                                                                                       |

#### **GET** Method

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

| Parameter | Datatype                               | Required | Description                                                                                        |
|-----------|----------------------------------------|----------|----------------------------------------------------------------------------------------------------|
| date_from | [DateTime](/16-types.md#datetime-type) | yes      | Only return Sessions that have `last_updated` after or equal to this Date/Time (inclusive).        |
| date_to   | [DateTime](/16-types.md#datetime-type) | no       | Only return Sessions that have `last_updated` up to this Date/Time, but not including (exclusive). |
| offset    | int                                    | no       | The offset of the first object returned. Default is 0.                                             |
| limit     | int                                    | no       | Maximum number of objects to GET.                                                                  |

##### Response Data

The response contains a list of Session objects that match the given parameters in the request, the header will contain
the [pagination](/04-transport-and-format/01-json-http-implementation-guide.md#paginated-response) related headers.

Any older information that is not specified in the response is considered no longer valid. Each object must contain all
required fields. Fields that are not specified may be considered as null values.

|                             |       |                                                            |
|-----------------------------|-------|------------------------------------------------------------|
| Datatype                    | Card. | Description                                                |
| [Session](https://ocpi.dev) | \*    | List of Session objects that match the request parameters. |

#### **PUT** Method

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

| Parameter  | Datatype                                   | Required | Description                                                                 |
|------------|--------------------------------------------|----------|-----------------------------------------------------------------------------|
| session_id | [CiString](/16-types.md#cistring-type)(36) | yes      | Session.id of the Session for which the Charging Preferences are to be set. |

##### Request Body

In the body, a [ChargingPreferences](https://ocpi.dev) object has to be provided.

| Type                                    | Card. | Description                                                  |
|-----------------------------------------|-------|--------------------------------------------------------------|
| [ChargingPreferences](https://ocpi.dev) | 1     | Updated Charging Preferences of the driver for this Session. |

##### Response Data

The response contains a [ChargingPreferencesResponse](https://ocpi.dev) value.

| Type                                            | Card. | Description                                       |
|-------------------------------------------------|-------|---------------------------------------------------|
| [ChargingPreferencesResponse](https://ocpi.dev) | 1     | Response to the Charging Preferences PUT request. |

### Receiver Interface

Typically implemented by market roles like: eMSP and SCSP.

Sessions are [Client Owned Objects](/04-transport-and-format/01-json-http-implementation-guide.md#client-owned-object-push), so
the endpoints need to contain the required extra fields:
{[party_id](https://ocpi.dev)} and
{[country_code](https://ocpi.dev)}.

Endpoint structure definition:

`{sessions_endpoint_url}/{country_code}/{party_id}/{session_id}`

Example:

* `https://www.server.com/ocpi/emsp/2.2.1/sessions/BE/BEC/1234`

| Method                    | Description                                                                               |
|---------------------------|-------------------------------------------------------------------------------------------|
| [GET](https://ocpi.dev)   | Retrieve a Session object from the eMSP's system with Session.id equal to `{session_id}`. |
| POST                      | n/a                                                                                       |
| [PUT](https://ocpi.dev)   | Send a new/updated Session object to the eMSP.                                            |
| [PATCH](https://ocpi.dev) | Update the Session object with Session.id equal to `{session_id}`.                        |
| DELETE                    | n/a                                                                                       |

#### **GET** Method

The CPO system might request the current version of a Session object from the eMSP's system to, for example, validate
the state, or because the CPO has received an error during a PATCH operation.

##### Request Parameters

The following parameters shall be provided as URL segments.

| Parameter    | Datatype                                   | Required | Description                                                                |
|--------------|--------------------------------------------|----------|----------------------------------------------------------------------------|
| country_code | [CiString](/16-types.md#cistring-type)(2)  | yes      | Country code of the CPO performing the GET on the eMSP's system.           |
| party_id     | [CiString](/16-types.md#cistring-type)(3)  | yes      | Party ID (Provider ID) of the CPO performing the GET on the eMSP's system. |
| session_id   | [CiString](/16-types.md#cistring-type)(36) | yes      | id of the Session object to get from the eMSP's system.                    |

##### Response Data

The response contains the requested Session object.

|                             |       |                           |
|-----------------------------|-------|---------------------------|
| Datatype                    | Card. | Description               |
| [Session](https://ocpi.dev) | 1     | Requested Session object. |

#### **PUT** Method

Inform the eMSP's system about a new/updated Session object in the CPO's system.

When a PUT request is received for an existing [Session](https://ocpi.dev) object (the object is PUT to the
same URL), The newly received [Session](https://ocpi.dev) object SHALL replace the existing object.

Any `charging_periods` from the existing object SHALL be replaced by the `charging_periods` from the newly received
[Session](https://ocpi.dev) object. If the new [Session](https://ocpi.dev) object does not
contain `charging_periods` (field is omitted or contains any empty list), the `charging_periods` of the existing object
SHALL be removed (replaced by the new empty list).

##### Request Body

The request contains the new or updated Session object.

| Type                        | Card. | Description                    |
|-----------------------------|-------|--------------------------------|
| [Session](https://ocpi.dev) | 1     | New or updated Session object. |

##### Request Parameters

The following parameters shall be provided as URL segments.

| Parameter    | Datatype                                   | Required | Description                                                                                                                                                    |
|--------------|--------------------------------------------|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code | [CiString](/16-types.md#cistring-type)(2)  | yes      | Country code of the CPO performing this PUT on the eMSP's system. This SHALL be the same value as the `country_code` in the Session object being pushed.       |
| party_id     | [CiString](/16-types.md#cistring-type)(3)  | yes      | Party ID (Provider ID) of the CPO performing this PUT on the eMSP's system. This SHALL be the same value as the `party_id` in the Session object being pushed. |
| session_id   | [CiString](/16-types.md#cistring-type)(36) | yes      | id of the new or updated Session object.                                                                                                                       |

#### **PATCH** Method

Same as the [PUT](https://ocpi.dev) method, but only the fields/objects that need to be updated have to be
present. Fields/objects which are not specified are considered unchanged.

Any request to the PATCH method SHALL contain the `last_updated` field.

The PATCH method of the Session Receiver interface works on the entire [Session](https://ocpi.dev) object
only. It is not allowed to use extra URL segments to try to PATCH fields of inner objects of the
[Session](https://ocpi.dev) object directly.

When a PATCH request contains the `charging_periods` field (inside a [Session](https://ocpi.dev) object),
this SHALL be processed as a request to add all the [ChargingPeriod](https://ocpi.dev)
objects to the existing [Session](https://ocpi.dev) object. If the request `charging_periods` list is
omitted (or contains an empty list), no changes SHALL be made to the existing list of `charging_periods`.

If existing [ChargingPeriod](https://ocpi.dev) objects in a
[Session](https://ocpi.dev) need to be replaced or removed, the Sender SHALL use the
[PUT](https://ocpi.dev) method to replace the entire [Session](https://ocpi.dev) object
(including all the `charging_periods`).

##### Example: update the total cost

Patching the `total_cost` needs to be done on the [Session](https://ocpi.dev) Object.

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

PATCH used to add a new [ChargingPeriod](https://ocpi.dev) to the Session and updating
all related fields.

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

## Object description

### *Session* Object

The Session object describes one charging session. That doesn't mean it is required that energy has been transferred
between EV and the Charge Point. It is possible that the EV never took energy from the Charge Point because it was
instructed not to take energy by the driver. But as the EV was connected to the Charge Point, some form of start tariff,
park tariff or reservation cost might be relevant.

:::note
Although OCPI supports such pricing mechanisms, local laws might not allow this.
:::

It is recommended to add enough `ChargingPeriods` to a Session so that the eMSP is able to provide feedback to the EV
driver about the progress of the charging session. The ideal amount of transmitted Charging Periods depends on the
charging speed. The Charging Periods should be sufficient for useful feedback but they should not generate too much
unneeded traffic either. How many Charging Periods are transmitted is left to the CPO to decide. The following are just
some points to consider:

* Adding a new Charging Period every minute for an AC charging session can be too much as it will yield 180 Charging
  Periods for an (assumed to be) average 3h session.

* A new Charging Period every 30 minutes for a DC fast charging session is not enough as it will yield only one Charging
  Period for an (assumed to be) average 30min session.

It is also recommended to add Charging Periods for all moments that are relevant for the Tariff changes, see [CDR object
description](https://ocpi.dev) for more information.

For more information about how `step_size` impacts the calculation of the cost of charging also see the [CDR object
description](https://ocpi.dev).

| Property                | Type                                       | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                       |
|-------------------------|--------------------------------------------|-------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code            | [CiString](/16-types.md#cistring-type)(2)  | 1     | ISO-3166 alpha-2 country code of the CPO that *owns* this Session.                                                                                                                                                                                                                                                                                                                                                                |
| party_id                | [CiString](/16-types.md#cistring-type)(3)  | 1     | ID of the CPO that *owns* this Session (following the ISO-15118 standard).                                                                                                                                                                                                                                                                                                                                                        |
| id                      | [CiString](/16-types.md#cistring-type)(36) | 1     | The unique id that identifies the charging session in the CPO platform.                                                                                                                                                                                                                                                                                                                                                           |
| start_date_time         | [DateTime](/16-types.md#datetime-type)     | 1     | The timestamp when the session became [ACTIVE](https://ocpi.dev) in the Charge Point. When the session is still [PENDING](https://ocpi.dev), this field SHALL be set to the time the Session was created at the Charge Point. When a Session goes from [PENDING](https://ocpi.dev) to [ACTIVE](https://ocpi.dev), this field SHALL be updated to the moment the Session went to [ACTIVE](https://ocpi.dev) in the Charge Point.   |
| end_date_time           | [DateTime](/16-types.md#datetime-type)     | ?     | The timestamp when the session was completed/finished, charging might have finished before the session ends, for example: EV is full, but parking cost also has to be paid.                                                                                                                                                                                                                                                       |
| kwh                     | [number](/16-types.md#number-type)         | 1     | How many kWh were charged.                                                                                                                                                                                                                                                                                                                                                                                                        |
| cdr_token               | [CdrToken](https://ocpi.dev)               | 1     | Token used to start this charging session, including all the relevant information to identify the unique token.                                                                                                                                                                                                                                                                                                                   |
| auth_method             | [AuthMethod](https://ocpi.dev)             | 1     | Method used for authentication. This might change during a session, for example when the session was started with a reservation: [ReserveNow](https://ocpi.dev): [`COMMAND`](https://ocpi.dev). When the driver arrives and starts charging using a Token that is whitelisted: [`WHITELIST`](https://ocpi.dev).                                                                                                                   |
| authorization_reference | [CiString](/16-types.md#cistring-type)(36) | ?     | Reference to the authorization given by the eMSP. When the eMSP provided an `authorization_reference` in either: [real-time authorization](https://ocpi.dev), [StartSession](https://ocpi.dev) or [ReserveNow](https://ocpi.dev) this field SHALL contain the same value. When different `authorization_reference` values have been given by the eMSP that are relevant to this Session, the last given value SHALL be used here. |
| location_id             | [CiString](/16-types.md#cistring-type)(36) | 1     | Location.id of the Location object of this CPO, on which the charging session is/was happening.                                                                                                                                                                                                                                                                                                                                   |
| evse_uid                | [CiString](/16-types.md#cistring-type)(36) | 1     | EVSE.uid of the EVSE of this Location on which the charging session is/was happening. Allowed to be set to: [`#NA`](/04-transport-and-format/01-json-http-implementation-guide.md#no-data-available) when this session is created for a reservation, but no EVSE yet assigned to the driver.                                                                                                                                      |
| connector_id            | [CiString](/16-types.md#cistring-type)(36) | 1     | Connector.id of the Connector of this Location where the charging session is/was happening. Allowed to be set to: [`#NA`](/04-transport-and-format/01-json-http-implementation-guide.md#no-data-available) when this session is created for a reservation, but no connector yet assigned to the driver.                                                                                                                           |
| meter_id                | [string](/16-types.md#string-type)(255)    | ?     | Optional identification of the kWh meter.                                                                                                                                                                                                                                                                                                                                                                                         |
| currency                | [string](/16-types.md#string-type)(3)      | 1     | ISO 4217 code of the currency used for this session.                                                                                                                                                                                                                                                                                                                                                                              |
| charging_periods        | [ChargingPeriod](https://ocpi.dev)         | \*    | An optional list of Charging Periods that can be used to calculate and verify the total cost.                                                                                                                                                                                                                                                                                                                                     |
| total_cost              | [Price](/16-types.md#price-class)          | ?     | The total cost of the session in the specified currency. This is the price that the eMSP will have to pay to the CPO. A total_cost of 0.00 means free of charge. When omitted, i.e. no price information is given in the Session object, it does not imply the session is/was free of charge.                                                                                                                                     |
| status                  | [SessionStatus](https://ocpi.dev)          | 1     | The status of the session.                                                                                                                                                                                                                                                                                                                                                                                                        |
| last_updated            | [DateTime](/16-types.md#datetime-type)     | 1     | Timestamp when this Session was last updated (or created).                                                                                                                                                                                                                                                                                                                                                                        |

:::note
Different `authorization_reference` values might happen when for example a
[ReserveNow](https://ocpi.dev) had a different `authorization_reference` then the
value returned by a [real-time authorization](https://ocpi.dev).
:::

#### Examples

##### Simple Session example of just starting a session

``` json
{
  "country_code": "NL",
  "party_id": "STK",
  "id": "101",
  "start_date_time": "2020-03-09T10:17:09Z",
  "kwh": 0,
  "cdr_token": {
    "country_code": "NL",
    "party_id": "TST",
    "uid": "123abc",
    "type": "RFID",
    "contract_id": "NL-TST-C12345678-S"
  },
  "auth_method": "WHITELIST",
  "location_id": "LOC1",
  "evse_uid": "3256",
  "connector_id": "1",
  "currency": "EUR",
  "total_cost": {
    "excl_vat": 2.5
  },
  "status": "PENDING",
  "last_updated": "2020-03-09T10:17:09Z"
}
```

##### Simple Session example of a short finished session

``` json
{
  "country_code": "BE",
  "party_id": "BEC",
  "id": "101",
  "start_date_time": "2015-06-29T22:39:09Z",
  "end_date_time": "2015-06-29T23:50:16Z",
  "kwh": 41.12,
  "cdr_token": {
    "country_code": "NL",
    "party_id": "TST",
    "uid": "123abc",
    "type": "RFID",
    "contract_id": "NL-TST-C12345678-S"
  },
  "auth_method": "WHITELIST",
  "location_id": "LOC1",
  "evse_uid": "3256",
  "connector_id": "1",
  "currency": "EUR",
  "charging_periods": [
    {
      "start_date_time": "2015-06-29T22:39:09Z",
      "dimensions": [
        {
          "type": "ENERGY",
          "volume": 120
        },
        {
          "type": "MAX_CURRENT",
          "volume": 30
        }
      ]
    },
    {
      "start_date_time": "2015-06-29T22:40:54Z",
      "dimensions": [
        {
          "type": "ENERGY",
          "volume": 41000
        },
        {
          "type": "MIN_CURRENT",
          "volume": 34
        }
      ]
    },
    {
      "start_date_time": "2015-06-29T23:07:09Z",
      "dimensions": [
        {
          "type": "PARKING_TIME",
          "volume": 0.718
        }
      ],
      "tariff_id": "12"
    }
  ],
  "total_cost": {
    "excl_vat": 8.5,
    "incl_vat": 9.35
  },
  "status": "COMPLETED",
  "last_updated": "2015-06-29T23:50:17Z"
}
```

### *ChargingPreferences* Object

Contains the charging preferences of an EV driver.

| Property          | Type                                   | Card. | Description                                                                                                                                                                                                                                                                                                                        |
|-------------------|----------------------------------------|-------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| profile_type      | [ProfileType](https://ocpi.dev)        | 1     | Type of Smart Charging Profile selected by the driver. The [ProfileType](https://ocpi.dev) has to be supported at the [Connector](https://ocpi.dev) and for every supported [ProfileType](https://ocpi.dev), a [Tariff](https://ocpi.dev) MUST be provided. This gives the EV driver the option between different pricing options. |
| departure_time    | [DateTime](/16-types.md#datetime-type) | ?     | Expected departure. The driver has given this Date/Time as expected departure moment. It is only an estimation and not necessarily the Date/Time of the actual departure.                                                                                                                                                          |
| energy_need       | [number](/16-types.md#number-type)     | ?     | Requested amount of energy in kWh. The EV driver wants to have this amount of energy charged.                                                                                                                                                                                                                                      |
| discharge_allowed | boolean                                | ?     | The driver allows their EV to be discharged when needed, as long as the other preferences are met: EV is charged with the preferred energy (`energy_need`) until the preferred departure moment (`departure_time`). Default if omitted: **false**                                                                                  |

## Data types

### ChargingPreferencesResponse *enum*

An enum with possible responses to a [PUT Charging Preferences](https://ocpi.dev) request.

If a PUT with `ChargingPreferences` is received for an EVSE that does not have the capability
`CHARGING_PREFERENCES_CAPABLE`, the receiver should respond with an HTTP status of 404 and an OCPI status code of 2001
in the [OCPI response object](#response-format).

| Value                      | Description                                                                                                                 |
|----------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| ACCEPTED                   | Charging Preferences accepted, EVSE will try to accomplish them, although this is no guarantee that they will be fulfilled. |
| DEPARTURE_REQUIRED         | CPO requires `departure_time` to be able to perform Charging Preference based Smart Charging.                               |
| ENERGY_NEED_REQUIRED       | CPO requires `energy_need` to be able to perform Charging Preference based Smart Charging.                                  |
| NOT_POSSIBLE               | Charging Preferences contain a demand that the EVSE knows it cannot fulfill.                                                |
| PROFILE_TYPE_NOT_SUPPORTED | `profile_type` contains a value that is not supported by the EVSE.                                                          |

### ProfileType *enum*

Different smart charging profile types.

| Value   | Description                                                                                             |
|---------|---------------------------------------------------------------------------------------------------------|
| CHEAP   | Driver wants to use the cheapest charging profile possible.                                             |
| FAST    | Driver wants his EV charged as quickly as possible and is willing to pay a premium for this, if needed. |
| GREEN   | Driver wants his EV charged with as much regenerative (green) energy as possible.                       |
| REGULAR | Driver does not have special preferences.                                                               |

### SessionStatus *enum*

Defines the state of a session.

| Value       | Description                                                                                                                                                                                                                                                        |
|-------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ACTIVE      | The session has been accepted and is active. All pre-conditions were met: Communication between EV and EVSE (for example: cable plugged in correctly), EV or driver is authorized. EV is being charged, or can be charged. Energy is, or is not, being transfered. |
| COMPLETED   | The session has been finished successfully. No more modifications will be made to the Session object using this state.                                                                                                                                             |
| INVALID     | The Session object using this state is declared invalid and will not be billed.                                                                                                                                                                                    |
| PENDING     | The session is pending, it has not yet started. Not all pre-conditions are met. This is the initial state. The session might never become an *active* session.                                                                                                     |
| RESERVATION | The session is started due to a reservation, charging has not yet started. The session might never become an *active* session.                                                                                                                                     |
