---
id: cdrs
slug: modules/cdrs
---
# CDRs

:::tip Module Identifier
cdrs
:::

:::caution Data owner
CPO
:::

:::info Type
Functional Module
:::

A **Charge Detail Record** is the description of a concluded charging session. The CDR is the only billing-relevant
object. CDRs are sent from the CPO to the eMSP after the charging session has ended. Although there is no requirement to
send CDRs in (semi-) realtime, it is seen as good practice to send them as soon as possible. But if there is an
agreement between parties to send them, for example, once a month, that is also allowed by OCPI.

## Flow and Lifecycle

CDRs are created by the CPO. They most likely will be sent only to the eMSP that needs to pay the bill of the underlying
charging session. Because a CDR is for billing purposes, it cannot be changed or replaced once sent to the eMSP. Changes
are simply not allowed. Instead, a [Credit CDR](https://ocpi.dev) can be sent.

CDRs may be sent for charging locations that have not been published via the
[Location](https://ocpi.dev) module. This is typically for home chargers.

### Credit CDRs

As CDRs are used for billing and can be seen as a kind of invoice, they cannot be deleted. Instead, they have to be
credited.

When a CPO wants to make changes to a CDR that was already sent to the eMSP, the CPO has to send a Credit CDR for the
first CDR. This credit CDR SHALL have a different CDR.id which can be a completely different number, or it can be the id
of the original CDR with something appended like for example: `-C` to make it unique again. To indicate that a CDR is a
Credit CDR, the [`credit`](https://ocpi.dev) field has to be set to `true`. The Credit CDR references the old CDR
via the [`credit_reference_id`](https://ocpi.dev) field, which SHALL contain the [`id`](https://ocpi.dev) of the
original CDR. The Credit CDR will contain all the data of the original CDR. Only the values in the
[`total_cost`](https://ocpi.dev) field SHALL contain the negative amounts of the original CDR.

After having sent the Credit CDR, the CPO can send a new CDR with a new unique ID and the fields:
[`credit`](https://ocpi.dev) and [`credit_reference_id`](https://ocpi.dev) omitted.

:::note
How far back in time a CPO can send a Credit CDR is not defined by OCPI. It is up the business contracts between the
different parties involved, as there might be local laws involved etc.
:::

### Push model

When the CPO creates CDR(s) they push them to the relevant eMSP by calling [POST](https://ocpi.dev) on the eMSPs
CDRs endpoint with the newly created CDR(s). A CPO is not required to send *all* CDRs to *all* eMSPs, it is allowed to
only send CDRs to the eMSP that a CDR is relevant to.

CDRs should contain enough information (dimensions) to allow the eMSP to validate the total cost. It is advised to send
enough information to the eMSP so that they can calculate their own costs for billing their customers. An eMSP might
have a very different contract/pricing model with their EV drivers than the tariff structure of the CPO.

If the CPO, for any reason, wants to view a CDR it has posted to an eMSP's system, the CPO can retrieve the CDR by
performing a [GET](https://ocpi.dev) request on the eMSP's CDRs endpoint at the URL returned in the response to
the [POST](https://ocpi.dev).

### Pull model

eMSPs who do not support the Push model need to call [GET](https://ocpi.dev) on the CPO's CDRs endpoint to
receive a list of CDRs.

This [GET](https://ocpi.dev) can also be used in combination with the Push model to retrieve CDRs after the
system (re-)connects to a CPO, to get a list of CDRs *missed* during a downtime of the eMSP's system.

A CPO is not required to return all known CDRs, the CPO is allowed to return only the CDRs that are relevant for the
requesting eMSP.

## Interfaces and Endpoints

There are both, a Sender and a Receiver interface for CDRs. Depending on business requirements, parties can decide to
use the Sender Interface (Pull model), or the Receiver Interface (Push model), or both. Push is the preferred model to
use, because the Receiver will receive CDRs in semi-realtime when they are created by the CPO.

### Sender Interface

Typically implemented by market roles like: CPO.

The CDRs endpoint can be used to retrieve CDRs.

Endpoint structure definition:

`{cdr_endpoint_url}?[date_from={date_from}]&amp;[date_to={date_to}]&amp;[offset={offset}]&amp;[limit={limit}]`

Examples:

* `https://www.server.com/ocpi/cpo/2.2.1/cdrs/?date_from=2019-01-28T12:00:00&date_to=2019-01-29T12:00:00`
* `https://ocpi.server.com/2.2.1/cdrs/?offset=50`
* `https://www.server.com/ocpi/2.2.1/cdrs/?date_from=2019-01-29T12:00:00&limit=100`
* `https://www.server.com/ocpi/cpo/2.2.1/cdrs/?offset=50&limit=100`

| Method                  | Description                                                                                                                                                                                                                          |
|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [GET](https://ocpi.dev) | Fetch CDRs last updated (which in the current version of OCPI can only be the creation Date/Time) between the `{date_from}` and `{date_to}` ([paginated](/04-transport-and-format/01-json-http-implementation-guide.md#pagination)). |
| POST                    | n/a                                                                                                                                                                                                                                  |
| PUT                     | n/a                                                                                                                                                                                                                                  |
| PATCH                   | n/a                                                                                                                                                                                                                                  |
| DELETE                  | n/a                                                                                                                                                                                                                                  |

#### **GET** Method

Fetch CDRs from the CPO's system.

##### Request Parameters

If additional parameters: `{date_from}` and/or `{date_to}` are provided, only CDRs with `last_updated` between the given
`{date_from}` (including) and `{date_to}` (excluding) will be returned.

This request is [paginated](/04-transport-and-format/01-json-http-implementation-guide.md#pagination), it supports the
[pagination](/04-transport-and-format/01-json-http-implementation-guide.md#paginated-request) related URL parameters.

| Parameter | Datatype                               | Required | Description                                                                                    |
|-----------|----------------------------------------|----------|------------------------------------------------------------------------------------------------|
| date_from | [DateTime](/16-types.md#datetime-type) | no       | Only return CDRs that have `last_updated` after or equal to this Date/Time (inclusive).        |
| date_to   | [DateTime](/16-types.md#datetime-type) | no       | Only return CDRs that have `last_updated` up to this Date/Time, but not including (exclusive). |
| offset    | int                                    | no       | The offset of the first object returned. Default is 0.                                         |
| limit     | int                                    | no       | Maximum number of objects to GET.                                                              |

##### Response Data

The endpoint returns a list of CDRs matching the given parameters in the GET request, the header will contain the
[pagination](/04-transport-and-format/01-json-http-implementation-guide.md#paginated-response) related headers.

Any older information that is not specified in the response is considered no longer valid. Each object must contain all
required fields. Fields that are not specified may be considered as null values.

|                         |       |               |
|-------------------------|-------|---------------|
| Datatype                | Card. | Description   |
| [CDR](https://ocpi.dev) | \*    | List of CDRs. |

### Receiver Interface

Typically implemented by market roles like: eMSP.

The CDRs endpoint can be used to create and retrieve CDRs.

| Method                   | Description                   |
|--------------------------|-------------------------------|
| [GET](https://ocpi.dev)  | Retrieve an existing CDR.     |
| [POST](https://ocpi.dev) | Send a new CDR.               |
| PUT                      | n/a (CDRs cannot be replaced) |
| PATCH                    | n/a (CDRs cannot be updated)  |
| DELETE                   | n/a (CDRs cannot be removed)  |

#### GET Method

Fetch CDRs from the receivers system.

Endpoint structure definition:

No structure defined. This is open to the eMSP to define, the URL is provided to the CPO by the eMSP in the result of
the POST request. Therefore, OCPI does not define variables.

Example:

* `https://www.server.com/ocpi/2.2.1/cdrs/1234`

##### Response URL

To retrieve an existing URL from the eMSP's system, the URL, returned in the response to a POST of a new CDR, has to be
used.

##### Response Data

The endpoint returns the requested CDR, if it exists.

|                         |       |                       |
|-------------------------|-------|-----------------------|
| Datatype                | Card. | Description           |
| [CDR](https://ocpi.dev) | 1     | Requested CDR object. |

#### POST Method

Creates a new CDR.

The POST method should contain the full and final CDR object.

Endpoint structure definition:

`{cdr_endpoint_url}`

Example:

* `https://www.server.com/ocpi/2.2.1/cdrs/`

##### Request Body

In the POST request the new CDR object is sent.

| Type                    | Card. | Description     |
|-------------------------|-------|-----------------|
| [CDR](https://ocpi.dev) | 1     | New CDR object. |

##### Response Headers

The response should contain the URL to the just created CDR object in the eMSP's system.

| HTTP Header | Datatype                     | Required | Description                                                                                                        |
|-------------|------------------------------|----------|--------------------------------------------------------------------------------------------------------------------|
| Location    | [URL](/16-types.md#url-type) | yes      | URL to the newly created CDR in the eMSP's system, can be used by the CPO system to perform a GET on the same CDR. |

The eMSP returns the URL where the newly created CDR can be found. OCPI does not define a specific structure for this
URL.

Example:

* `https://www.server.com/ocpi/emsp/2.2.1/cdrs/123456`

## Object description

### *CDR* Object

The *CDR* object describes the charging session and its costs, how these costs are composed, etc.

The CDR object is different from the [Session](https://ocpi.dev) object. The
[Session](https://ocpi.dev) object is dynamic as it reflects the current state of the
charging session. The information is meant to be viewed by the driver while the charging session is ongoing.

The CDR on the other hand can be thought of as *sealed*, preserving the information valid at the moment in time the
underlying session was started. This is a requirement of the main use case for CDRs, namely invoicing. If e.g. a street
is renamed the day after a session took place, the driver should be presented with the name valid at the time the
session was started. This guarantees that the CDR will be recognized as correct by the driver and is not going to be
contested.

The *CDR* object shall always contain information like Location, EVSE, Tariffs and Token as they were **at the start**
of the charging session.

**ChargingPeriod:** A CPO SHALL at least start (and add) a [ChargingPeriod](https://ocpi.dev) every
moment/event that has relevance for the total costs of a CDR. During a charging session, different parameters change all
the time, like the amount of energy used, or the time of day. These changes can result in another Price Component of the
Tariff becoming active. When another Price Component becomes active, the CPO SHALL add a new Charging Period with at
least all the relevant information for the change to the other Price Component. The CPO is allowed to add more
*in-between* Charging Periods to a CDR though.

Examples of additional Charging Periods that are required to be added because another Price Component is becoming
active:

* When an energy changes in price after 17:00. The CPO has to start a new Charging Period at 17:00. The CPO also has to
  list the energy in kWh consumed until 17:00 in the Charging Period that ends at 17:00.

* When the price of a energy is higher when the EV is charging faster than 32A, a new Charging Period has to be added
  the moment the charging power goes over 32A. This may be a moment that is calculated by the CPO, as the Charge Point
  might not send the information to the CPO, but it can be interpolated by the CPO using the metering information before
  and after that moment.

**step_size:** When calculating the cost of a charging session, `step_size` SHALL only be taken into account once per
session for the [TariffDimensionType](https://ocpi.dev)
[`ENERGY`](https://ocpi.dev) and once for
[`PARKING_TIME`](https://ocpi.dev) and
[`TIME`](https://ocpi.dev) combined.

`step_size` is not taken into account when switching time based paying for charging to paying for parking (charging has
stopped but EV still connected). Example: `step_size` for both charging
([`TIME`](https://ocpi.dev)) and parking is 5 minutes. After 21 minutes of
charging, the EV is full but remains connected for 7 more minutes. The cost of charging will be calculated based on 21
minutes (not 25). The cost of parking will be calculated based on 10 minutes (`step_size` is 5).

`step_size` is not taken into account when switching from (for example) one
[`ENERGY`](https://ocpi.dev) based tariff element to another. This is also
true when switch from one ([`TIME`](https://ocpi.dev)) based tariff element to
another ([`TIME`](https://ocpi.dev)) based tariff element, and one
[`PARKING_TIME`](https://ocpi.dev) tariff element to another
[`PARKING_TIME`](https://ocpi.dev) based tariff element. Example: when
charging is more expensive after 17:00. The `step_size` of the tariff before 17:00 will not be used when charging starts
before 17:00 and ends after 17:00. Only the `step_size` of the tariff
([PriceComponent](https://ocpi.dev)) after 17:00 is taken into account, for the
total of the same amount for the session.

The `step_size` for the [PriceComponent](https://ocpi.dev) that is used to
calculate the cost of such a *last* [ChargingPeriod](https://ocpi.dev) SHALL be used. If the `step_size`
differs for the different [TariffElements](https://ocpi.dev), the `step_size` of
the last relevant [PriceComponent](https://ocpi.dev) is used.

The `step_size` is not taken into account when switching between two Tariffs Example: A driver selects a different
[Charging Preference](https://ocpi.dev)
[`profile_type`](https://ocpi.dev) during an ongoing charging session, the
different profile might have a different tariff.

The `step_size` uses the total amount of a certain unit used during a session, not only the last ChargingPeriod. In
other words, when the price of energy per kWh or the price of time per hour differs during a session,only the total
amount of energy or time is used in calculations with `step_size`. Example: Energy costs € 0.20 perkWh before 17:00 and
€ 0.27 per kWh after 17:00. Both Price Components have a `step_size` of 500 Wh. If a driver charges 4.3 kWh before 17:00
and 1.1 kWh after 17:00, a total of 5.4 kWh is charged. The `step_size` rounds this up to 5.5 kWh total. It does NOT
round the energy used after 17:00 to 1.5 kWh.

Example: Time costs € 5 per hour before 17:00 and € 7 per hour after 17:00. Both Price Components have a `step_size` of
10 minutes. If a driver charges 6 minutes before 17:00 and 22 minutes after 17:00, this makes a total of 28 minutes
charging. The `step_size` rounds this up to 30 minutes total, so 24 minutes after 17:00 will be billed. It does NOT
round the minutes after 17:00 to 30 minutes, which would have made a total of 36 minutes.

In the cases that [`TIME`](https://ocpi.dev) and
[`PARKING_TIME`](https://ocpi.dev) Tariff Elements are both used, `step_size`
is only taken into account for the total parking duration\` Example: Time spent charging costs € 1.00 per hour and time
spent parking (not charging) costs € 2.00 per hour. Both Price Components have a `step_size` of 10 minutes. If a driver
charges 21 minutes, and keeps his EV connected while it is full for another 16 minutes, then the step_size rounds the
parking duration up to 20 minutes, making it a total of 41 minutes. Note that the charging duration is not rounded up,
as it is followed by another time based period.

| Property                   | Type                                       | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                        |
|----------------------------|--------------------------------------------|-------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code               | [CiString](/16-types.md#cistring-type)(2)  | 1     | ISO-3166 alpha-2 country code of the CPO that *owns* this CDR.                                                                                                                                                                                                                                                                                                                                                                     |
| party_id                   | [CiString](/16-types.md#cistring-type)(3)  | 1     | ID of the CPO that *owns* this CDR (following the ISO-15118 standard).                                                                                                                                                                                                                                                                                                                                                             |
| id                         | [CiString](/16-types.md#cistring-type)(39) | 1     | Uniquely identifies the CDR, the ID SHALL be unique per `country_code`/`party_id` combination. This field is longer than the usual 36 characters to allow for credit CDRs to have [something appended](https://ocpi.dev) to the original ID. Normal (non-credit) CDRs SHALL only have an ID with a maximum length of 36.                                                                                                           |
| start_date_time            | [DateTime](/16-types.md#datetime-type)     | 1     | Start timestamp of the charging session, or in-case of a reservation (before the start of a session) the start of the reservation.                                                                                                                                                                                                                                                                                                 |
| end_date_time              | [DateTime](/16-types.md#datetime-type)     | 1     | The timestamp when the session was completed/finished, charging might have finished before the session ends, for example: EV is full, but parking cost also has to be paid.                                                                                                                                                                                                                                                        |
| session_id                 | [CiString](/16-types.md#cistring-type)(36) | ?     | Unique ID of the Session for which this CDR is sent. Is only allowed to be omitted when the CPO has not implemented the Sessions module or this CDR is the result of a reservation that never became a charging session, thus no OCPI Session.                                                                                                                                                                                     |
| cdr_token                  | [CdrToken](https://ocpi.dev)               | 1     | Token used to start this charging session, including all the relevant information to identify the unique token.                                                                                                                                                                                                                                                                                                                    |
| auth_method                | [AuthMethod](https://ocpi.dev)             | 1     | Method used for authentication. Multiple \<mod_cdrs_authmethod_enum,AuthMethods\>\> are possible during a charging sessions, for example when the session was started with a reservation: [ReserveNow](https://ocpi.dev): [`COMMAND`](https://ocpi.dev). When the driver arrives and starts charging using a Token that is whitelisted: [`WHITELIST`](https://ocpi.dev). The last method SHALL be used in the CDR.                 |
| authorization_reference    | [CiString](/16-types.md#cistring-type)(36) | ?     | Reference to the authorization given by the eMSP. When the eMSP provided an `authorization_reference` in either: [real-time authorization](https://ocpi.dev), [StartSession](https://ocpi.dev) or [ReserveNow](https://ocpi.dev), this field SHALL contain the same value. When different `authorization_reference` values have been given by the eMSP that are relevant to this Session, the last given value SHALL be used here. |
| cdr_location               | [CdrLocation](https://ocpi.dev)            | 1     | Location where the charging session took place, including only the relevant [EVSE](https://ocpi.dev) and [Connector](https://ocpi.dev).                                                                                                                                                                                                                                                                                            |
| meter_id                   | [string](/16-types.md#string-type)(255)    | ?     | Identification of the Meter inside the Charge Point.                                                                                                                                                                                                                                                                                                                                                                               |
| currency                   | [string](/16-types.md#string-type)(3)      | 1     | Currency of the CDR in ISO 4217 Code.                                                                                                                                                                                                                                                                                                                                                                                              |
| tariffs                    | [Tariff](https://ocpi.dev)                 | \*    | List of relevant Tariffs, see: [Tariff](https://ocpi.dev). When relevant, a *Free of Charge* tariff should also be in this list, and point to a defined *Free of Charge* Tariff.                                                                                                                                                                                                                                                   |
| charging_periods           | [ChargingPeriod](https://ocpi.dev)         | \+    | List of Charging Periods that make up this charging session.                                                                                                                                                                                                                                                                                                                                                                       |
| signed_data                | [SignedData](https://ocpi.dev)             | ?     | Signed data that belongs to this charging Session.                                                                                                                                                                                                                                                                                                                                                                                 |
| total_cost                 | [Price](/16-types.md#price-class)          | 1     | Total sum of all the costs of this transaction in the specified currency.                                                                                                                                                                                                                                                                                                                                                          |
| total_fixed_cost           | [Price](/16-types.md#price-class)          | ?     | Total sum of all the fixed costs in the specified currency, except fixed price components of parking and reservation. The cost not depending on amount of time/energy used etc. Can contain costs like a start tariff.                                                                                                                                                                                                             |
| total_energy               | [number](/16-types.md#number-type)         | 1     | Total energy charged, in kWh.                                                                                                                                                                                                                                                                                                                                                                                                      |
| total_energy_cost          | [Price](/16-types.md#price-class)          | ?     | Total sum of all the cost of all the energy used, in the specified currency.                                                                                                                                                                                                                                                                                                                                                       |
| total_time                 | [number](/16-types.md#number-type)         | 1     | Total duration of the charging session (including the duration of charging and not charging), in hours.                                                                                                                                                                                                                                                                                                                            |
| total_time_cost            | [Price](/16-types.md#price-class)          | ?     | Total sum of all the cost related to duration of charging during this transaction, in the specified currency.                                                                                                                                                                                                                                                                                                                      |
| total_parking_time         | [number](/16-types.md#number-type)         | ?     | Total duration of the charging session where the EV was not charging (no energy was transferred between EVSE and EV), in hours.                                                                                                                                                                                                                                                                                                    |
| total_parking_cost         | [Price](/16-types.md#price-class)          | ?     | Total sum of all the cost related to parking of this transaction, including fixed price components, in the specified currency.                                                                                                                                                                                                                                                                                                     |
| total_reservation_cost     | [Price](/16-types.md#price-class)          | ?     | Total sum of all the cost related to a reservation of a Charge Point, including fixed price components, in the specified currency.                                                                                                                                                                                                                                                                                                 |
| remark                     | [string](/16-types.md#string-type)(255)    | ?     | Optional remark, can be used to provide additional human readable information to the CDR, for example: reason why a transaction was stopped.                                                                                                                                                                                                                                                                                       |
| invoice_reference_id       | [CiString](/16-types.md#cistring-type)(39) | ?     | This field can be used to reference an invoice, that will later be send for this CDR. Making it easier to link a CDR to a given invoice. Maybe even group CDRs that will be on the same invoice.                                                                                                                                                                                                                                   |
| credit                     | boolean                                    | ?     | When set to `true`, this is a Credit CDR, and the field `credit_reference_id` needs to be set as well.                                                                                                                                                                                                                                                                                                                             |
| credit_reference_id        | [CiString](/16-types.md#cistring-type)(39) | ?     | Is required to be set for a Credit CDR. This SHALL contain the `id` of the CDR for which this is a Credit CDR.                                                                                                                                                                                                                                                                                                                     |
| home_charging_compensation | boolean                                    | ?     | When set to `true`, this CDR is for a charging session using the home charger of the EV Driver for which the energy cost needs to be financial compensated to the EV Driver.                                                                                                                                                                                                                                                       |
| last_updated               | [DateTime](/16-types.md#datetime-type)     | 1     | Timestamp when this CDR was last updated (or created).                                                                                                                                                                                                                                                                                                                                                                             |

:::note
The actual charging duration (energy being transferred between EVSE and EV) of a charging session can be calculated:
`total_charging_time = total_time - total_parking_time`.
:::

:::note
Having both a `credit` and a `credit_reference_id` might seem redundant. But it is seen as an advantage as a boolean
flag used in queries is much faster than simple string comparison of references.
:::

:::note
Different `authorization_reference` values might happen when for example a
[ReserveNow](https://ocpi.dev) had a different `authorization_reference` then the
value returned by a [real-time authorization](https://ocpi.dev).
:::

:::note
When no `start_date_time` and/or `end_date_time` is known to the CPO, normally the CPO cannot send the CDR. If the MSP
and CPO both agree that they accept CDRs that miss either or both the `start_date_time` and `end_date_time`, and local
legislation allows billing of sessions where `start_date_time` and/or `end_date_time` are missing. Then, and only then,
the CPO could send a CDR where the `start_date_time` and/or `end_date_time` are set to: "1970-1-1T00:00:00Z.
:::

#### Example of a CDR

``` json
{
  "country_code": "BE",
  "party_id": "BEC",
  "id": "12345",
  "start_date_time": "2015-06-29T21:39:09Z",
  "end_date_time": "2015-06-29T23:37:32Z",
  "cdr_token": {
    "country_code": "DE",
    "party_id": "TNM",
    "uid": "012345678",
    "type": "RFID",
    "contract_id": "DE8ACC12E46L89"
  },
  "auth_method": "WHITELIST",
  "cdr_location": {
    "id": "LOC1",
    "name": "Gent Zuid",
    "address": "F.Rooseveltlaan 3A",
    "city": "Gent",
    "postal_code": "9000",
    "country": "BEL",
    "coordinates": {
      "latitude": "3.729944",
      "longitude": "51.047599"
    },
    "evse_uid": "3256",
    "evse_id": "BE*BEC*E041503003",
    "connector_id": "1",
    "connector_standard": "IEC_62196_T2",
    "connector_format": "SOCKET",
    "connector_power_type": "AC_1_PHASE"
  },
  "currency": "EUR",
  "tariffs": [
    {
      "country_code": "BE",
      "party_id": "BEC",
      "id": "12",
      "currency": "EUR",
      "elements": [
        {
          "price_components": [
            {
              "type": "TIME",
              "price": 2,
              "vat": 10,
              "step_size": 300
            }
          ]
        }
      ],
      "last_updated": "2015-02-02T14:15:01Z"
    }
  ],
  "charging_periods": [
    {
      "start_date_time": "2015-06-29T21:39:09Z",
      "dimensions": [
        {
          "type": "TIME",
          "volume": 1.973
        }
      ],
      "tariff_id": "12"
    }
  ],
  "total_cost": {
    "excl_vat": 4,
    "incl_vat": 4.4
  },
  "total_energy": 15.342,
  "total_time": 1.973,
  "total_time_cost": {
    "excl_vat": 4,
    "incl_vat": 4.4
  },
  "last_updated": "2015-06-29T22:01:13Z"
}
```

## Data types

### AuthMethod *enum*

| Value        | Description                                                                                                                                                             |
|--------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| AUTH_REQUEST | Authentication request has been sent to the eMSP.                                                                                                                       |
| COMMAND      | Command like [StartSession](https://ocpi.dev) or [ReserveNow](https://ocpi.dev) used to start the Session, the Token provided in the Command was used as authorization. |
| WHITELIST    | Whitelist used for authentication, no request to the eMSP has been performed.                                                                                           |

### CdrDimension *class*

| Property | Type                                 | Card. | Description                                                                 |
|----------|--------------------------------------|-------|-----------------------------------------------------------------------------|
| type     | [CdrDimensionType](https://ocpi.dev) | 1     | Type of CDR dimension.                                                      |
| volume   | [number](/16-types.md#number-type)   | 1     | Volume of the dimension consumed, measured according to the dimension type. |

### CdrDimensionType *enum*

This enumeration contains allowed values for CdrDimensions, which are used to define dimensions of ChargingPeriods in
both `CDRs` and `Sessions`. Some of these values are not useful for `CDRs`, and SHALL therefor only be used in
`Sessions`, these are marked in the column: Session Only

| Value            | Session Only | Description                                                                                                                                                                                              |
|------------------|--------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| CURRENT          | Y            | Average charging current during this [ChargingPeriod](https://ocpi.dev): defined in A (Ampere). When negative, the current is flowing from the EV to the grid.                                           |
| ENERGY           |              | Total amount of energy (dis-)charged during this [ChargingPeriod](https://ocpi.dev): defined in kWh. When negative, more energy was feed into the grid then charged into the EV. Default step_size is 1. |
| ENERGY_EXPORT    | Y            | Total amount of energy feed back into the grid: defined in kWh.                                                                                                                                          |
| ENERGY_IMPORT    | Y            | Total amount of energy charged, defined in kWh.                                                                                                                                                          |
| MAX_CURRENT      |              | Sum of the maximum current over all phases, reached during this [ChargingPeriod](https://ocpi.dev): defined in A (Ampere).                                                                               |
| MIN_CURRENT      |              | Sum of the minimum current over all phases, reached during this [ChargingPeriod](https://ocpi.dev), when negative, current has flowed from the EV to the grid. Defined in A (Ampere).                    |
| MAX_POWER        |              | Maximum power reached during this [ChargingPeriod](https://ocpi.dev): defined in kW (Kilowatt).                                                                                                          |
| MIN_POWER        |              | Minimum power reached during this [ChargingPeriod](https://ocpi.dev): defined in kW (Kilowatt), when negative, the power has flowed from the EV to the grid.                                             |
| PARKING_TIME     |              | Time during this [ChargingPeriod](https://ocpi.dev) not charging: defined in hours, default step_size multiplier is 1 second.                                                                            |
| POWER            | Y            | Average power during this [ChargingPeriod](https://ocpi.dev): defined in kW (Kilowatt). When negative, the power is flowing from the EV to the grid.                                                     |
| RESERVATION_TIME |              | Time during this [ChargingPeriod](https://ocpi.dev) Charge Point has been reserved and not yet been in use for this customer: defined in hours, default step_size multiplier is 1 second.                |
| STATE_OF_CHARGE  | Y            | Current state of charge of the EV, in percentage, values allowed: 0 to 100. See note below.                                                                                                              |
| TIME             |              | Time charging during this [ChargingPeriod](https://ocpi.dev): defined in hours, default step_size multiplier is 1 second.                                                                                |

:::note
OCPI makes it possible to provide SoC in the Session object. This information can be useful to show the current State of
Charge to an EV driver during charging. Implementers should be aware that SoC is only available at some DC Chargers.
Which is currently a small amount of the total amount of Charge Points. Of these DC Chargers, only a small percentage
currently provides SoC via OCPP to the CPO. Then there is also the question if SoC is allowed to be provided to
third-parties as it can be seen as privacy-sensitive information. So if an implementer wants to show SoC in, for example
an App, care should be taken, to make the App work without SoC, as this will probably not always be available.
:::

### CdrLocation *class*

The *CdrLocation* class contains only the relevant information from the
[Location](https://ocpi.dev) object that is needed in a CDR.

| Property             | Type                                       | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|----------------------|--------------------------------------------|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| id                   | [CiString](/16-types.md#cistring-type)(36) | 1     | Uniquely identifies the location within the CPO's platform (and suboperator platforms). This field can never be changed, modified or renamed.                                                                                                                                                                                                                                                                                                                                                                                                      |
| name                 | [string](/16-types.md#string-type)(255)    | ?     | Display name of the location.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| address              | [string](/16-types.md#string-type)(45)     | 1     | Street/block name and house number if available.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| city                 | [string](/16-types.md#string-type)(45)     | 1     | City or town.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| postal_code          | [string](/16-types.md#string-type)(10)     | ?     | Postal code of the location, may only be omitted when the location has no postal code: in some countries charging locations at highways don't have postal codes.                                                                                                                                                                                                                                                                                                                                                                                   |
| state                | [string](/16-types.md#string-type)(20)     | ?     | State only to be used when relevant.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| country              | [string](/16-types.md#string-type)(3)      | 1     | ISO 3166-1 alpha-3 code for the country of this location.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| coordinates          | [GeoLocation](https://ocpi.dev)            | 1     | Coordinates of the location.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| evse_uid             | [CiString](/16-types.md#cistring-type)(36) | 1     | Uniquely identifies the EVSE within the CPO's platform (and suboperator platforms). For example a database unique ID or the actual *EVSE ID*. This field can never be changed, modified or renamed. This is the *technical* identification of the EVSE, not to be used as *human readable* identification, use the field: `evse_id` for that. Allowed to be set to: [`#NA`](/04-transport-and-format/01-json-http-implementation-guide.md#no-data-available) when this CDR is created for a reservation that never resulted in a charging session. |
| evse_id              | [CiString](/16-types.md#cistring-type)(48) | 1     | Compliant with the following specification for EVSE ID from "eMI3 standard version V1.0" (<http://emi3group.com/documents-links/>) "Part 2: business objects.". Allowed to be set to: [`#NA`](/04-transport-and-format/01-json-http-implementation-guide.md#no-data-available) when this CDR is created for a reservation that never resulted in a charging session.                                                                                                                                                                               |
| connector_id         | [CiString](/16-types.md#cistring-type)(36) | 1     | Identifier of the connector within the EVSE. Allowed to be set to: [`#NA`](/04-transport-and-format/01-json-http-implementation-guide.md#no-data-available) when this CDR is created for a reservation that never resulted in a charging session.                                                                                                                                                                                                                                                                                                  |
| connector_standard   | [ConnectorType](https://ocpi.dev)          | 1     | The standard of the installed connector. When this CDR is created for a reservation that never resulted in a charging session, this field can be set to any value and should be ignored by the Receiver.                                                                                                                                                                                                                                                                                                                                           |
| connector_format     | [ConnectorFormat](https://ocpi.dev)        | 1     | The format (socket/cable) of the installed connector. When this CDR is created for a reservation that never resulted in a charging session, this field can be set to any value and should be ignored by the Receiver.                                                                                                                                                                                                                                                                                                                              |
| connector_power_type | [PowerType](https://ocpi.dev)              | 1     | When this CDR is created for a reservation that never resulted in a charging session, this field can be set to any value and should be ignored by the Receiver.                                                                                                                                                                                                                                                                                                                                                                                    |

### CdrToken *class*

| Property     | Type                                       | Card. | Description                                                                                                                                                                                                                                                                                                                                                            |
|--------------|--------------------------------------------|-------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code | [CiString](/16-types.md#cistring-type)(2)  | 1     | ISO-3166 alpha-2 country code of the MSP that *owns* this Token.                                                                                                                                                                                                                                                                                                       |
| party_id     | [CiString](/16-types.md#cistring-type)(3)  | 1     | ID of the eMSP that *owns* this Token (following the ISO-15118 standard).                                                                                                                                                                                                                                                                                              |
| uid          | [CiString](/16-types.md#cistring-type)(36) | 1     | Unique ID by which this Token can be identified. This is the field used by the CPO's system (RFID reader on the Charge Point) to identify this token. Currently, in most cases: `type=RFID`, this is the RFID hidden ID as read by the RFID reader, but that is not a requirement. If this is a `type=APP_USER` Token, it will be a unique, by the eMSP, generated ID. |
| type         | [TokenType](https://ocpi.dev)              | 1     | Type of the token                                                                                                                                                                                                                                                                                                                                                      |
| contract_id  | [CiString](/16-types.md#cistring-type)(36) | 1     | Uniquely identifies the EV driver contract token within the eMSP's platform (and suboperator platforms). Recommended to follow the specification for eMA ID from "eMI3 standard version V1.0" (<http://emi3group.com/documents-links/>) "Part 2: business objects."                                                                                                    |

### ChargingPeriod *class*

A Charging Period consists of a start timestamp and a list of possible values that influence this period, for example:
amount of energy charged this period, maximum current during this period etc.

| Property        | Type                                       | Card. | Description                                                                                                                           |
|-----------------|--------------------------------------------|-------|---------------------------------------------------------------------------------------------------------------------------------------|
| start_date_time | [DateTime](/16-types.md#datetime-type)     | 1     | Start timestamp of the charging period. A period ends when the next period starts. The last period ends when the session ends.        |
| dimensions      | [CdrDimension](https://ocpi.dev)           | \+    | List of relevant values for this charging period.                                                                                     |
| tariff_id       | [CiString](/16-types.md#cistring-type)(36) | ?     | Unique identifier of the Tariff that is relevant for this Charging Period. If not provided, no Tariff is relevant during this period. |

### SignedData *class*

This class contains all the information of the signed data. Which encoding method is used, if needed, the public key and
a list of signed values.

| Property                | Type                                       | Card. | Description                                                                                                                                       |
|-------------------------|--------------------------------------------|-------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| encoding_method         | [CiString](/16-types.md#cistring-type)(36) | 1     | The name of the encoding used in the SignedData field. This is the name given to the encoding by a company or group of companies. See note below. |
| encoding_method_version | int                                        | ?     | Version of the EncodingMethod (when applicable)                                                                                                   |
| public_key              | [string](/16-types.md#string-type)(512)    | ?     | Public key used to sign the data, base64 encoded.                                                                                                 |
| signed_values           | [SignedValue](https://ocpi.dev)            | \+    | One or more signed values.                                                                                                                        |
| url                     | [string](/16-types.md#cistring-type)(512)  | ?     | URL that can be shown to an EV driver. This URL gives the EV driver the possibility to check the signed data from a charging session.             |

:::note
For the German Eichrecht, different solutions are used, all have (somewhat) different encodings. Below the table with
known implementations and the contact information for more information.
:::

| Name                       | Description                                | Contact                          |
|----------------------------|--------------------------------------------|----------------------------------|
| OCMF                       | Proposed by SAFE                           | <https://has-to-be.com>          |
| Alfen Eichrecht            | Alfen Eichrecht encoding / implementation. | <https://alfen.com/de/downloads> |
| EDL40 E-Mobility Extension | eBee smart technologies implementation     | <https://www.ebee.berlin>        |
| EDL40 Mennekes             | Mennekes implementation                    |                                  |

### SignedValue *class*

This class contains the signed and the plain/unsigned data. By decoding the data, the receiver can check if the content
has not been altered.

| Property    | Type                                       | Card. | Description                                                                                                                                                                                                                                                                                                         |
|-------------|--------------------------------------------|-------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| nature      | [CiString](/16-types.md#cistring-type)(32) | 1     | Nature of the value, in other words, the event this value belongs to. Possible values at moment of writing: - Start (value at the start of the Session) - End (signed value at the end of the Session) - Intermediate (signed values take during the Session, after Start, before End) Others might be added later. |
| plain_data  | [string](/16-types.md#string-type)(512)    | 1     | The un-encoded string of data. The format of the content depends on the EncodingMethod field.                                                                                                                                                                                                                       |
| signed_data | [string](/16-types.md#string-type)(5000)   | 1     | Blob of signed data, base64 encoded. The format of the content depends on the EncodingMethod field.                                                                                                                                                                                                                 |
