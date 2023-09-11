---
id: object-description
slug: object-description
---
# Object description

## *Session* Object

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
description](/docs/ocpi/06-modules/05-cdrs/06-object-description.md#cdr-object) for more information.

For more information about how `step_size` impacts the calculation of the cost of charging also see the [CDR object
description](/docs/ocpi/06-modules/05-cdrs/06-object-description.md#step_size).

| Property                | Type                                                                                   | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|-------------------------|----------------------------------------------------------------------------------------|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code            | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(2)                           | 1     | ISO-3166 alpha-2 country code of the CPO that *owns* this Session.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| party_id                | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(3)                           | 1     | ID of the CPO that *owns* this Session (following the ISO-15118 standard).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| id                      | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(36)                          | 1     | The unique id that identifies the charging session in the CPO platform.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| start_date_time         | [DateTime](/docs/ocpi/07-types/01-intro.md#datetime-type)                              | 1     | The timestamp when the session became [ACTIVE](/docs/ocpi/06-modules/04-sessions/07-data-types.md#sessionstatus-enum) in the Charge Point. When the session is still [PENDING](/docs/ocpi/06-modules/04-sessions/07-data-types.md#sessionstatus-enum), this field SHALL be set to the time the Session was created at the Charge Point. When a Session goes from [PENDING](/docs/ocpi/06-modules/04-sessions/07-data-types.md#sessionstatus-enum) to [ACTIVE](/docs/ocpi/06-modules/04-sessions/07-data-types.md#sessionstatus-enum), this field SHALL be updated to the moment the Session went to [ACTIVE](/docs/ocpi/06-modules/04-sessions/07-data-types.md#sessionstatus-enum) in the Charge Point. |
| end_date_time           | [DateTime](/docs/ocpi/07-types/01-intro.md#datetime-type)                              | ?     | The timestamp when the session was completed/finished, charging might have finished before the session ends, for example: EV is full, but parking cost also has to be paid.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| kwh                     | [number](/docs/ocpi/07-types/01-intro.md#number-type)                                  | 1     | How many kWh were charged.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| cdr_token               | [CdrToken](/docs/ocpi/06-modules/05-cdrs/07-data-types.md#cdrtoken-class)              | 1     | Token used to start this charging session, including all the relevant information to identify the unique token.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| auth_method             | [AuthMethod](/docs/ocpi/06-modules/05-cdrs/07-data-types.md#authmethod-enum)           | 1     | Method used for authentication. This might change during a session, for example when the session was started with a reservation: [ReserveNow](/docs/ocpi/06-modules/08-commands/06-object-description.md#reservenow-object): [`COMMAND`](/docs/ocpi/06-modules/05-cdrs/07-data-types.md#authmethod-enum). When the driver arrives and starts charging using a Token that is whitelisted: [`WHITELIST`](/docs/ocpi/06-modules/05-cdrs/07-data-types.md#authmethod-enum).                                                                                                                                                                                                                                  |
| authorization_reference | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(36)                          | ?     | Reference to the authorization given by the eMSP. When the eMSP provided an `authorization_reference` in either: [real-time authorization](/docs/ocpi/06-modules/07-tokens/04-flow-and-lifecycle.md#real-time-authorization), [StartSession](/docs/ocpi/06-modules/08-commands/06-object-description.md#startsession-object) or [ReserveNow](/docs/ocpi/06-modules/08-commands/06-object-description.md#reservenow-object) this field SHALL contain the same value. When different `authorization_reference` values have been given by the eMSP that are relevant to this Session, the last given value SHALL be used here.                                                                              |
| location_id             | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(36)                          | 1     | Location.id of the Location object of this CPO, on which the charging session is/was happening.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| evse_uid                | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(36)                          | 1     | EVSE.uid of the EVSE of this Location on which the charging session is/was happening. Allowed to be set to: [`#NA`](/docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#no-data-available) when this session is created for a reservation, but no EVSE yet assigned to the driver.                                                                                                                                                                                                                                                                                                                                                                                                   |
| connector_id            | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(36)                          | 1     | Connector.id of the Connector of this Location where the charging session is/was happening. Allowed to be set to: [`#NA`](/docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#no-data-available) when this session is created for a reservation, but no connector yet assigned to the driver.                                                                                                                                                                                                                                                                                                                                                                                        |
| meter_id                | [string](/docs/ocpi/07-types/01-intro.md#string-type)(255)                             | ?     | Optional identification of the kWh meter.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| currency                | [string](/docs/ocpi/07-types/01-intro.md#string-type)(3)                               | 1     | ISO 4217 code of the currency used for this session.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| charging_periods        | [ChargingPeriod](/docs/ocpi/06-modules/05-cdrs/07-data-types.md#chargingperiod-class)  | \*    | An optional list of Charging Periods that can be used to calculate and verify the total cost.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| total_cost              | [Price](/docs/ocpi/07-types/01-intro.md#price-class)                                   | ?     | The total cost of the session in the specified currency. This is the price that the eMSP will have to pay to the CPO. A total_cost of 0.00 means free of charge. When omitted, i.e. no price information is given in the Session object, it does not imply the session is/was free of charge.                                                                                                                                                                                                                                                                                                                                                                                                            |
| status                  | [SessionStatus](/docs/ocpi/06-modules/04-sessions/07-data-types.md#sessionstatus-enum) | 1     | The status of the session.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| last_updated            | [DateTime](/docs/ocpi/07-types/01-intro.md#datetime-type)                              | 1     | Timestamp when this Session was last updated (or created).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

:::note
Different `authorization_reference` values might happen when for example a
[ReserveNow](/docs/ocpi/06-modules/08-commands/06-object-description.md#reservenow-object) had a different
`authorization_reference` then the value returned by a [real-time
authorization](/docs/ocpi/06-modules/07-tokens/04-flow-and-lifecycle.md#real-time-authorization).
:::

### Examples

#### Simple Session example of just starting a session

```json
{
  "country_code": "NL",
  "party_id": "STK",
  "id": "101",
  "start_date_time": "2020-03-09T10:17:09Z",
  "kwh": 0.0,
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

#### Simple Session example of a short finished session

```json
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
    "excl_vat": 8.50,
    "incl_vat": 9.35
  },
  "status": "COMPLETED",
  "last_updated": "2015-06-29T23:50:17Z"
}
```

## *ChargingPreferences* Object

Contains the charging preferences of an EV driver.

| Property          | Type                                                                               | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|-------------------|------------------------------------------------------------------------------------|-------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| profile_type      | [ProfileType](/docs/ocpi/06-modules/04-sessions/07-data-types.md#profiletype-enum) | 1     | Type of Smart Charging Profile selected by the driver. The [ProfileType](/docs/ocpi/06-modules/04-sessions/07-data-types.md#profiletype-enum) has to be supported at the [Connector](/docs/ocpi/06-modules/03-locations/06-object-description.md#connector-object) and for every supported [ProfileType](/docs/ocpi/06-modules/04-sessions/07-data-types.md#profiletype-enum), a [Tariff](/docs/ocpi/06-modules/06-tariffs/06-object-description.md#tariff-object) MUST be provided. This gives the EV driver the option between different pricing options. |
| departure_time    | [DateTime](/docs/ocpi/07-types/01-intro.md#datetime-type)                          | ?     | Expected departure. The driver has given this Date/Time as expected departure moment. It is only an estimation and not necessarily the Date/Time of the actual departure.                                                                                                                                                                                                                                                                                                                                                                                   |
| energy_need       | [number](/docs/ocpi/07-types/01-intro.md#number-type)                              | ?     | Requested amount of energy in kWh. The EV driver wants to have this amount of energy charged.                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| discharge_allowed | boolean                                                                            | ?     | The driver allows their EV to be discharged when needed, as long as the other preferences are met: EV is charged with the preferred energy (`energy_need`) until the preferred departure moment (`departure_time`). Default if omitted: **false**                                                                                                                                                                                                                                                                                                           |
