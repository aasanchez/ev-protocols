---
id: object-description
slug: object-description
---
# Object description

## *CDR* Object

The *CDR* object describes the charging session and its costs, how these costs are composed, etc.

The CDR object is different from the
[Session](/docs/ocpi/06-modules/04-sessions/06-object-description.md#session-object) object. The
[Session](/docs/ocpi/06-modules/04-sessions/06-object-description.md#session-object) object is dynamic as it reflects
the current state of the charging session. The information is meant to be viewed by the driver while the charging
session is ongoing.

The CDR on the other hand can be thought of as *sealed*, preserving the information valid at the moment in time the
underlying session was started. This is a requirement of the main use case for CDRs, namely invoicing. If e.g. a street
is renamed the day after a session took place, the driver should be presented with the name valid at the time the
session was started. This guarantees that the CDR will be recognized as correct by the driver and is not going to be
contested.

The *CDR* object shall always contain information like Location, EVSE, Tariffs and Token as they were **at the start**
of the charging session.

### ChargingPeriod

A CPO SHALL at least start (and add) a
[ChargingPeriod](/docs/ocpi/06-modules/05-cdrs/07-data-types.md#chargingperiod-class) every moment/event that has
relevance for the total costs of a CDR. During a charging session, different parameters change all the time, like the
amount of energy used, or the time of day. These changes can result in another Price Component of the Tariff becoming
active. When another Price Component becomes active, the CPO SHALL add a new Charging Period with at least all the
relevant information for the change to the other Price Component. The CPO is allowed to add more *in-between* Charging
Periods to a CDR though.

Examples of additional Charging Periods that are required to be added because another Price Component is becoming
active:

* When an energy changes in price after 17:00. The CPO has to start a new Charging Period at 17:00. The CPO also has to
  list the energy in kWh consumed until 17:00 in the Charging Period that ends at 17:00.

* When the price of a energy is higher when the EV is charging faster than 32A, a new Charging Period has to be added
  the moment the charging power goes over 32A. This may be a moment that is calculated by the CPO, as the Charge Point
  might not send the information to the CPO, but it can be interpolated by the CPO using the metering information before
  and after that moment.

### Step_size

When calculating the cost of a charging session, `step_size` SHALL only be taken into account once per
session for the [TariffDimensionType](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffdimensiontype-enum)
[`ENERGY`](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffdimensiontype-enum) and once for
[`PARKING_TIME`](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffdimensiontype-enum) and
[`TIME`](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffdimensiontype-enum) combined.

`step_size` is not taken into account when switching time based paying for charging to paying for parking (charging has
stopped but EV still connected). Example: `step_size` for both charging
([`TIME`](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffdimensiontype-enum)) and parking is 5 minutes. After
21 minutes of charging, the EV is full but remains connected for 7 more minutes. The cost of charging will be calculated
based on 21 minutes (not 25). The cost of parking will be calculated based on 10 minutes (`step_size` is 5).

`step_size` is not taken into account when switching from (for example) one
[`ENERGY`](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffdimensiontype-enum) based tariff element to another.
This is also true when switch from one
([`TIME`](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffdimensiontype-enum)) based tariff element to another
([`TIME`](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffdimensiontype-enum)) based tariff element, and one
[`PARKING_TIME`](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffdimensiontype-enum) tariff element to another
[`PARKING_TIME`](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffdimensiontype-enum) based tariff element.
Example: when charging is more expensive after 17:00. The `step_size` of the tariff before 17:00 will not be used when
charging starts before 17:00 and ends after 17:00. Only the `step_size` of the tariff
([PriceComponent](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#pricecomponent-class)) after 17:00 is taken into
account, for the total of the same amount for the session.

The `step_size` for the [PriceComponent](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#pricecomponent-class) that is
used to calculate the cost of such a *last*
[ChargingPeriod](/docs/ocpi/06-modules/05-cdrs/07-data-types.md#chargingperiod-class) SHALL be used. If the `step_size`
differs for the different [TariffElements](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffelement-class), the
`step_size` of the last relevant
[PriceComponent](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#pricecomponent-class) is used.

The `step_size` is not taken into account when switching between two Tariffs Example: A driver selects a different
[Charging Preference](/docs/ocpi/06-modules/04-sessions/06-object-description.md#set-charging-preferences)
[`profile_type`](/docs/ocpi/06-modules/04-sessions/07-data-types.md#profiletype-enum) during an ongoing charging
session, the different profile might have a different tariff.

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

In the cases that [`TIME`](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffdimensiontype-enum) and
[`PARKING_TIME`](/docs/ocpi/06-modules/06-tariffs/07-data-types.md#tariffdimensiontype-enum) Tariff Elements are both
used, `step_size` is only taken into account for the total parking duration\` Example: Time spent charging costs € 1.00
per hour and time spent parking (not charging) costs € 2.00 per hour. Both Price Components have a `step_size` of 10
minutes. If a driver charges 21 minutes, and keeps his EV connected while it is full for another 16 minutes, then the
step_size rounds the parking duration up to 20 minutes, making it a total of 41 minutes. Note that the charging duration
is not rounded up, as it is followed by another time based period.

| Property                   | Type                                                                                  | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|----------------------------|---------------------------------------------------------------------------------------|-------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code               | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(2)                          | 1     | ISO-3166 alpha-2 country code of the CPO that *owns* this CDR.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| party_id                   | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(3)                          | 1     | ID of the CPO that *owns* this CDR (following the ISO-15118 standard).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| id                         | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(39)                         | 1     | Uniquely identifies the CDR, the ID SHALL be unique per `country_code`/`party_id` combination. This field is longer than the usual 36 characters to allow for credit CDRs to have [something appended](/docs/ocpi/06-modules/05-cdrs/04-flow-and-lifecycle.md#credit-cdrs) to the original ID. Normal (non-credit) CDRs SHALL only have an ID with a maximum length of 36.                                                                                                                                                                                                                                                   |
| start_date_time            | [DateTime](/docs/ocpi/07-types/01-intro.md#datetime-type)                             | 1     | Start timestamp of the charging session, or in-case of a reservation (before the start of a session) the start of the reservation.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| end_date_time              | [DateTime](/docs/ocpi/07-types/01-intro.md#datetime-type)                             | 1     | The timestamp when the session was completed/finished, charging might have finished before the session ends, for example: EV is full, but parking cost also has to be paid.                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| session_id                 | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(36)                         | ?     | Unique ID of the Session for which this CDR is sent. Is only allowed to be omitted when the CPO has not implemented the Sessions module or this CDR is the result of a reservation that never became a charging session, thus no OCPI Session.                                                                                                                                                                                                                                                                                                                                                                               |
| cdr_token                  | [CdrToken](/docs/ocpi/06-modules/05-cdrs/07-data-types.md#cdrtoken-class)             | 1     | Token used to start this charging session, including all the relevant information to identify the unique token.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| auth_method                | [AuthMethod](/docs/ocpi/06-modules/05-cdrs/07-data-types.md#authmethod-enum)          | 1     | Method used for authentication. Multiple \<mod_cdrs_authmethod_enum,AuthMethods\>\> are possible during a charging sessions, for example when the session was started with a reservation: [ReserveNow](/docs/ocpi/06-modules/08-commands/06-object-description.md#reservenow-object): [`COMMAND`](/docs/ocpi/06-modules/05-cdrs/07-data-types.md#authmethod-enum). When the driver arrives and starts charging using a Token that is whitelisted: [`WHITELIST`](/docs/ocpi/06-modules/05-cdrs/07-data-types.md#authmethod-enum). The last method SHALL be used in the CDR.                                                   |
| authorization_reference    | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(36)                         | ?     | Reference to the authorization given by the eMSP. When the eMSP provided an `authorization_reference` in either: [real-time authorization](/docs/ocpi/06-modules/07-tokens/04-flow-and-lifecycle.md#real-time-authorization), [StartSession](/docs/ocpi/06-modules/08-commands/06-object-description.md#startsession-object) or [ReserveNow](/docs/ocpi/06-modules/08-commands/06-object-description.md#reservenow-object), this field SHALL contain the same value. When different `authorization_reference` values have been given by the eMSP that are relevant to this Session, the last given value SHALL be used here. |
| cdr_location               | [CdrLocation](/docs/ocpi/06-modules/05-cdrs/07-data-types.md#cdrlocation-class)       | 1     | Location where the charging session took place, including only the relevant [EVSE](/docs/ocpi/06-modules/03-locations/06-object-description.md#) and [Connector](/docs/ocpi/06-modules/03-locations/06-object-description.md#connector-object).                                                                                                                                                                                                                                                                                                                                                                              |
| meter_id                   | [string](/docs/ocpi/07-types/01-intro.md#string-type)(255)                            | ?     | Identification of the Meter inside the Charge Point.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| currency                   | [string](/docs/ocpi/07-types/01-intro.md#string-type)(3)                              | 1     | Currency of the CDR in ISO 4217 Code.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| tariffs                    | [Tariff](/docs/ocpi/06-modules/06-tariffs/06-object-description.md#tariff-object)     | \*    | List of relevant Tariffs, see: [Tariff](/docs/ocpi/06-modules/06-tariffs/06-object-description.md#tariff-object). When relevant, a *Free of Charge* tariff should also be in this list, and point to a defined *Free of Charge* Tariff.                                                                                                                                                                                                                                                                                                                                                                                      |
| charging_periods           | [ChargingPeriod](/docs/ocpi/06-modules/05-cdrs/07-data-types.md#chargingperiod-class) | \+    | List of Charging Periods that make up this charging session.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| signed_data                | [SignedData](/docs/ocpi/06-modules/05-cdrs/07-data-types.md#signeddata-class)         | ?     | Signed data that belongs to this charging Session.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| total_cost                 | [Price](/docs/ocpi/07-types/01-intro.md#price-class)                                  | 1     | Total sum of all the costs of this transaction in the specified currency.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| total_fixed_cost           | [Price](/docs/ocpi/07-types/01-intro.md#price-class)                                  | ?     | Total sum of all the fixed costs in the specified currency, except fixed price components of parking and reservation. The cost not depending on amount of time/energy used etc. Can contain costs like a start tariff.                                                                                                                                                                                                                                                                                                                                                                                                       |
| total_energy               | [number](/docs/ocpi/07-types/01-intro.md#number-type)                                 | 1     | Total energy charged, in kWh.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| total_energy_cost          | [Price](/docs/ocpi/07-types/01-intro.md#price-class)                                  | ?     | Total sum of all the cost of all the energy used, in the specified currency.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| total_time                 | [number](/docs/ocpi/07-types/01-intro.md#number-type)                                 | 1     | Total duration of the charging session (including the duration of charging and not charging), in hours.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| total_time_cost            | [Price](/docs/ocpi/07-types/01-intro.md#price-class)                                  | ?     | Total sum of all the cost related to duration of charging during this transaction, in the specified currency.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| total_parking_time         | [number](/docs/ocpi/07-types/01-intro.md#number-type)                                 | ?     | Total duration of the charging session where the EV was not charging (no energy was transferred between EVSE and EV), in hours.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| total_parking_cost         | [Price](/docs/ocpi/07-types/01-intro.md#price-class)                                  | ?     | Total sum of all the cost related to parking of this transaction, including fixed price components, in the specified currency.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| total_reservation_cost     | [Price](/docs/ocpi/07-types/01-intro.md#price-class)                                  | ?     | Total sum of all the cost related to a reservation of a Charge Point, including fixed price components, in the specified currency.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| remark                     | [string](/docs/ocpi/07-types/01-intro.md#string-type)(255)                            | ?     | Optional remark, can be used to provide additional human readable information to the CDR, for example: reason why a transaction was stopped.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| invoice_reference_id       | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(39)                         | ?     | This field can be used to reference an invoice, that will later be send for this CDR. Making it easier to link a CDR to a given invoice. Maybe even group CDRs that will be on the same invoice.                                                                                                                                                                                                                                                                                                                                                                                                                             |
| credit                     | boolean                                                                               | ?     | When set to `true`, this is a Credit CDR, and the field `credit_reference_id` needs to be set as well.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| credit_reference_id        | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(39)                         | ?     | Is required to be set for a Credit CDR. This SHALL contain the `id` of the CDR for which this is a Credit CDR.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| home_charging_compensation | boolean                                                                               | ?     | When set to `true`, this CDR is for a charging session using the home charger of the EV Driver for which the energy cost needs to be financial compensated to the EV Driver.                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| last_updated               | [DateTime](/docs/ocpi/07-types/01-intro.md#datetime-type)                             | 1     | Timestamp when this CDR was last updated (or created).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |

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
[ReserveNow](/docs/ocpi/06-modules/08-commands/06-object-description.md#reservenow-object) had a different
`authorization_reference` then the value returned by a [real-time
authorization](/docs/ocpi/06-modules/07-tokens/04-flow-and-lifecycle.md#real-time-authorization).
:::

:::note
When no `start_date_time` and/or `end_date_time` is known to the CPO, normally the CPO cannot send the CDR. If the MSP
and CPO both agree that they accept CDRs that miss either or both the `start_date_time` and `end_date_time`, and local
legislation allows billing of sessions where `start_date_time` and/or `end_date_time` are missing. Then, and only then,
the CPO could send a CDR where the `start_date_time` and/or `end_date_time` are set to: "1970-1-1T00:00:00Z.
:::

### Example of a CDR

```json
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
