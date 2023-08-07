---
id: data-types
slug: /modules/tariffs/data-types
---
# Data types

## DayOfWeek *enum*

| Value     | Description |
|-----------|-------------|
| MONDAY    | Monday      |
| TUESDAY   | Tuesday     |
| WEDNESDAY | Wednesday   |
| THURSDAY  | Thursday    |
| FRIDAY    | Friday      |
| SATURDAY  | Saturday    |
| SUNDAY    | Sunday      |

## PriceComponent *class*

A Price Component describes how a certain amount of a certain dimension being consumed translates into an amount of
money owed.

| Property  | Type                                        | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                               |
|-----------|---------------------------------------------|-------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| type      | [TariffDimensionType](https://ocpi.dev)     | 1     | The dimension that is being priced                                                                                                                                                                                                                                                                                                                                                                                        |
| price     | [number](/07-types/01-intro.md#number-type) | 1     | Price per unit (excl. VAT) for this dimension.                                                                                                                                                                                                                                                                                                                                                                            |
| vat       | [number](/07-types/01-intro.md#number-type) | ?     | Applicable VAT percentage for this tariff dimension. If omitted, no VAT is applicable. Not providing a VAT is different from 0% VAT, which would be a value of 0.0 here.                                                                                                                                                                                                                                                  |
| step_size | int                                         | 1     | Minimum amount to be billed. That is, the dimension will be billed in this `step_size` blocks. Consumed amounts are rounded up to the smallest multiple of `step_size` that is greater than the consumed amount. For example: if `type` is `TIME` and `step_size` has a value of `300`, then time will be billed in blocks of 5 minutes. If 6 minutes were consumed, 10 minutes (2 blocks of `step_size`) will be billed. |

:::note
`step_size`: depends on the `type` and every `type` (except `FLAT`) defines a `step_size` multiplier, which is the size
of every *step* for that `type` in the given unit.
:::

For example: `PARKING_TIME` has the `step_size` multiplier: *1 second*, which means that the `step_size` of a Price
Component is multiplied by *1 second*. Thus a `step_size = 300` means `300 seconds` (`5 minutes`). This means that when
someone parked for 8 minutes they will be billed for 10 minutes. The parking time will be simply rounded up to the next
larger chunk of `step_size` (i.e. blocks of `300 seconds` in this example).

Another example: `ENERGY` has the `step_size` multiplied: *1 Wh*, which means that the `step_size` of a Price Component
is multiplied by *1 Wh*. Thus a `step_size = 1` with a `price = 0.25` will result in a cost calculation that uses the
charged Wh as precision. If someone charges their EV with 115.2 Wh, then they are billed for 116 Wh, resulting in total
cost of € 0.029. When `step_size = 25`, then the same amount would be billed for 101 to 125 Wh: € 0.031. When
`step_size = 500`, then the same amount will be billed for 1 to 500 Wh: € 0.125.

:::note
For more information about how `step_size` impacts the calculation of the cost of charging see: [CDR object
description](/06-modules/05-cdrs/06-object-description.md#step_size)
:::

:::note
Take into account that using `step_size` can be confusing for Drivers and other people. There may be local or national
regulations that regulate `step_size`. For example in The Netherlands telecom companies are required to at least offer
one subscription which is paid per second. To prevent confusion by the customer, we recommend to keep the `step_size` as
small as possible and mention them clearly in your offering.
:::

### Example Tariff

Example Tariff to explain the `step_size` when switching from one [Tariff Element](https://ocpi.dev) to
another:

* Charging fee of € 1.20 per hour (excl. VAT) before 17:00 with a `step_size` of 30 minutes (1800 seconds)
* Charging fee of € 2.40 per hour (excl. VAT) after 17:00 with a `step_size` of 15 minutes (900 seconds)
* Parking fee of € 1.00 per hour (excl. VAT) before 20:00 with a `step_size` of 15 minutes (900 seconds)

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "22",
  "currency": "EUR",
  "elements": [
    {
      "price_components": [
        {
          "type": "TIME",
          "price": 1.2,
          "step_size": 1800
        },
        {
          "type": "PARKING_TIME",
          "price": 1,
          "step_size": 900
        }
      ],
      "restrictions": {
        "start_time": "00:00",
        "end_time": "17:00"
      }
    },
    {
      "price_components": [
        {
          "type": "TIME",
          "price": 2.4,
          "step_size": 900
        },
        {
          "type": "PARKING_TIME",
          "price": 1,
          "step_size": 900
        }
      ],
      "restrictions": {
        "start_time": "17:00",
        "end_time": "20:00"
      }
    },
    {
      "price_components": [
        {
          "type": "TIME",
          "price": 2.4,
          "step_size": 900
        }
      ],
      "restrictions": {
        "start_time": "20:00",
        "end_time": "00:00"
      }
    }
  ],
  "last_updated": "2018-12-18T17:07:11Z"
}
```

##### Example: switching to different Tariff Element \#1

An EV driver plugs in at 16:55 and charges for 10 minutes (`TIME`). They then stop charging but stay plugged in for 2
more minutes (`PARKING_TIME`). The total session time is therefore 12 minutes. The parking time of 2 minutes is rounded
to 15 minutes according to the step size of the last parking time period.

As a result,t he session costs € 0.55 ex VAT.

A breakdown is as follows:

| Dimension     | Quantity   | Price ex VAT  | Cost ex VAT |
|---------------|------------|---------------|-------------|
| Charging time | 5 minutes  | 1.20 per hour | 0.10        |
| Charging time | 5 minutes  | 2.40 per hour | 0.20        |
| Time          | 15 minutes | 1.00 per hour | 0.25        |
| Total         |            |               | 0.55        |

##### Example: switching to different Tariff Element \#2

An EV driver plugs in at 16:35 and charges for 35 minutes (`TIME`). After that they immediately unplug and leave without
parking time.

As the charging time Price Component of the last Tariff Element being used has a `step_size` of 15 minutes, the total
charging time is rounded up from 35 to 45 minutes. When considering the already billed 25 minutes of charging time
before 17:00, we are left with 20 minutes to bill after 17:00.

That leads to a session fee of € 1.30. A breakdown is as follows:

| Dimension     | Quantity   | Price ex VAT  | Cost ex VAT |
|---------------|------------|---------------|-------------|
| Charging time | 25 minutes | 1.20 per hour | 0.50        |
| Charging time | 20 minutes | 2.40 per hour | 0.80        |
| Total         |            |               | 1.30        |

##### Example: switching to Free-of-Charge Tariff Element

When parking becomes free after 20:00, there will not be an active
[`PARKING_TIME`](https://ocpi.dev) [Price Component](https://ocpi.dev) nor a
[`TIME`](https://ocpi.dev) Price Component. So the last parking period that needs to be paid, which
is before 20:00, will be billed according to the `step_size` of the
[`PARKING_TIME`](https://ocpi.dev) [`PriceComponent`](https://ocpi.dev) before
20:00.

An EV driver plugs in at 19:40 and charges for 12 minutes (`TIME`). They then stop charging but stay plugged in for 20
more minutes (`PARKING_TIME`). The total session time is therefore 32 minutes.

The total of billable parking time for the session is 8 minutes. This is rounded up to 15 minutes according to the
step_size of the last time based Price Component that was active during the session. The extra 7 minutes are then added
to the last period with a Price Component with a time-based dimension, that is the one from 19:52 to 20:00. So the user
is billed € 0.60 for 15 minutes of parking and that makes a total session fee of € 0.80.

A breakdown is as follows:

| Dimension     | Quantity   | Price ex VAT  | Cost ex VAT |
|---------------|------------|---------------|-------------|
| Charging time | 12 minutes | 1.20 per hour | 0.20        |
| Time          | 15 minutes | 2.40 per hour | 0.60        |
| Total         |            |               | 0.80        |

## ReservationRestrictionType *enum*

| Value               | Description                                                                                                                                                                         |
|---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| RESERVATION         | Used in Tariff Elements to describe costs for a reservation.                                                                                                                        |
| RESERVATION_EXPIRES | Used in Tariff Elements to describe costs for a reservation that expires (i.e. driver does not start a charging session before [expiry_date](https://ocpi.dev) of the reservation). |

:::note
When a Tariff has both `RESERVATION` and `RESERVATION_EXPIRES` Tariff Elements, where both Tariff Elements have a
[TIME](https://ocpi.dev) Price Component, then the time based cost of an expired reservation will
be calculated based on the `RESERVATION_EXPIRES` Tariff Element.
:::

## TariffElement *class*

A Tariff Element is a group of Price Components that share a set of restrictions under which they apply.

That the Price Components share the same restrictions does not mean that at any time, they either all apply or all do
not apply. The reason is that applicable Price Components are looked up separately for each dimension, as described
under the [Tariff object](https://ocpi.dev). Therefore it is possible that a Price Component for one dimension
is found in a Tariff Element that occurs earlier in the list of Tariff Elements than for another dimension.

| Property         | Type                                   | Card. | Description                                                                                             |
|------------------|----------------------------------------|-------|---------------------------------------------------------------------------------------------------------|
| price_components | [PriceComponent](https://ocpi.dev)     | \+    | List of Price Components that each describe how a certain dimension is priced.                          |
| restrictions     | [TariffRestrictions](https://ocpi.dev) | ?     | Restrictions that describe under which circumstances the Price Components of this Tariff Element apply. |

## TariffDimensionType *enum*

| Value        | Description                                                                                                                                                                                         |
|--------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ENERGY       | Defined in kWh, `step_size` multiplier: 1 Wh                                                                                                                                                        |
| FLAT         | Flat fee without unit for `step_size`                                                                                                                                                               |
| PARKING_TIME | Time not charging: defined in hours, `step_size` multiplier: 1 second                                                                                                                               |
| TIME         | Time charging: defined in hours, `step_size` multiplier: 1 second Can also be used in combination with a [RESERVATION](https://ocpi.dev) restriction to describe the price of the reservation time. |

## TariffRestrictions *class*

A `TariffRestrictions` object describes if and when a Tariff Element becomes active or inactive during a Charging Session.

These restrictions are not to be interpreted as making the Tariff Element applicable or not applicable for the entire
Charging Session.

When more than one restriction is set, they are to be treated as a logical AND. So a Tariff Element is active if and
only if all of the properties in its `TariffRestrictions` match.

| Property     | Type                                            | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|--------------|-------------------------------------------------|-------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| start_time   | [string](/07-types/01-intro.md#string-type)(5)  | ?     | Start time of day in local time, the time zone is defined in the `time_zone` field of the [Location](https://ocpi.dev), for example 13:30, valid from this time of the day. Must be in 24h format with leading zeros. Hour/Minute separator: ":" Regex: `([0-1][0-9]|2[0-3]):[0-5][0-9]`                                                                                                                                                                                                                                                                                                                         |
| end_time     | [string](/07-types/01-intro.md#string-type)(5)  | ?     | End time of day in local time, the time zone is defined in the `time_zone` field of the [Location](https://ocpi.dev), for example 19:45, valid until this time of the day. Same syntax as `start_time`. If end_time \< start_time then the period wraps around to the next day. To stop at end of the day use: 00:00.                                                                                                                                                                                                                                                                                            |
| start_date   | [string](/07-types/01-intro.md#string-type)(10) | ?     | Start date in local time, the time zone is defined in the `time_zone` field of the [Location](https://ocpi.dev), for example: 2015-12-24, valid from this day (inclusive). Regex: `([12][0-9]{3})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])`                                                                                                                                                                                                                                                                                                                                                                      |
| end_date     | [string](/07-types/01-intro.md#string-type)(10) | ?     | End date in local time, the time zone is defined in the `time_zone` field of the [Location](https://ocpi.dev), for example: 2015-12-27, valid until this day (exclusive). Same syntax as `start_date`.                                                                                                                                                                                                                                                                                                                                                                                                           |
| min_kwh      | [number](/07-types/01-intro.md#number-type)     | ?     | Minimum consumed energy in kWh, for example 20, valid from this amount of energy (inclusive) being used.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| max_kwh      | [number](/07-types/01-intro.md#number-type)     | ?     | Maximum consumed energy in kWh, for example 50, valid until this amount of energy (exclusive) being used.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| min_current  | [number](/07-types/01-intro.md#number-type)     | ?     | Sum of the minimum current (in Amperes) over all phases, for example 5. When the EV is charging with more than, or equal to, the defined amount of current, this TariffElement is/becomes active. If the charging current is or becomes lower, this TariffElement is not or no longer valid and becomes inactive. This describes NOT the minimum current over the entire Charging Session. This restriction can make a TariffElement become active when the charging current is above the defined value, but the TariffElement MUST no longer be active when the charging current drops below the defined value. |
| max_current  | [number](/07-types/01-intro.md#number-type)     | ?     | Sum of the maximum current (in Amperes) over all phases, for example 20. When the EV is charging with less than the defined amount of current, this TariffElement becomes/is active. If the charging current is or becomes higher, this TariffElement is not or no longer valid and becomes inactive. This describes NOT the maximum current over the entire Charging Session. This restriction can make a TariffElement become active when the charging current is below this value, but the TariffElement MUST no longer be active when the charging current raises above the defined value.                   |
| min_power    | [number](/07-types/01-intro.md#number-type)     | ?     | Minimum power in kW, for example 5. When the EV is charging with more than, or equal to, the defined amount of power, this TariffElement is/becomes active. If the charging power is or becomes lower, this TariffElement is not or no longer valid and becomes inactive. This describes NOT the minimum power over the entire Charging Session. This restriction can make a TariffElement become active when the charging power is above this value, but the TariffElement MUST no longer be active when the charging power drops below the defined value.                                                      |
| max_power    | [number](/07-types/01-intro.md#number-type)     | ?     | Maximum power in kW, for example 20. When the EV is charging with less than the defined amount of power, this TariffElement becomes/is active. If the charging power is or becomes higher, this TariffElement is not or no longer valid and becomes inactive. This describes NOT the maximum power over the entire Charging Session. This restriction can make a TariffElement become active when the charging power is below this value, but the TariffElement MUST no longer be active when the charging power raises above the defined value.                                                                 |
| min_duration | int                                             | ?     | Minimum duration in seconds the Charging Session MUST last (inclusive). When the duration of a Charging Session is longer than the defined value, this TariffElement is or becomes active. Before that moment, this TariffElement is not yet active.                                                                                                                                                                                                                                                                                                                                                             |
| max_duration | int                                             | ?     | Maximum duration in seconds the Charging Session MUST last (exclusive). When the duration of a Charging Session is shorter than the defined value, this TariffElement is or becomes active. After that moment, this TariffElement is no longer active.                                                                                                                                                                                                                                                                                                                                                           |
| day_of_week  | [DayOfWeek](https://ocpi.dev)                   | \*    | Which day(s) of the week this TariffElement is active.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| reservation  | [ReservationRestrictionType](https://ocpi.dev)  | ?     | When this field is present, the TariffElement describes reservation costs. A reservation starts when the reservation is made, and ends when the driver starts charging on the reserved EVSE/Location, or when the reservation expires. A reservation can only have: [FLAT](https://ocpi.dev) and [TIME](https://ocpi.dev) TariffDimensions, where `TIME` is for the duration of the reservation.                                                                                                                                                                                                                 |

### Example: Tariff with max_power Tariff Restrictions

Example Tariff to explain the `max_power` Tariff Restriction:

* Charging fee of € 0.20 per kWh (excl. VAT) when charging with a power of less than 16 kW.
* Charging fee of € 0.35 per kWh (excl. VAT) when charging with a power between 16 and 32 kW.
* Charging fee of € 0.50 per kWh (excl. VAT) when charging with a power above 32 kW (implemented as fallback tariff
  without Restriction).

For a charging session where the EV charges the first kWh with a power of 6 kW, increases the power to 48 kW for the
next 40 kWh and reduces it again to 4 kW after that for another 0.5 kWh (probably due to physical limitations, i.e.
temperature of the battery), this tariff will result in costs of € 20.30 (excl. VAT). The costs are composed of the
following components:

* 1 kWh at 6 kW: € 0.20
* 40 kWh at 48 kW: € 20.00
* 0.5 kWh at 4 kW: € 0.10

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "1",
  "currency": "EUR",
  "type": "REGULAR",
  "elements": [
    {
      "price_components": [
        {
          "type": "ENERGY",
          "price": 0.2,
          "vat": 20,
          "step_size": 1
        }
      ],
      "restrictions": {
        "max_power": 16
      }
    },
    {
      "price_components": [
        {
          "type": "ENERGY",
          "price": 0.35,
          "vat": 20,
          "step_size": 1
        }
      ],
      "restrictions": {
        "max_power": 32
      }
    },
    {
      "price_components": [
        {
          "type": "ENERGY",
          "price": 0.5,
          "vat": 20,
          "step_size": 1
        }
      ]
    }
  ],
  "last_updated": "2018-12-05T12:01:09Z"
}
```

### Example: Tariff with max_duration Tariff Restrictions

A supermarket wants to allow their customer to charge for free. As most customers will be out of the store in 20
minutes, they allow free charging for 30 minutes. If a customer charges longer than that, they will charge them the
normal price per kWh. But as they want to discourage long usage of their Charge Points, charging becomes much more
expensive after 1 hour:

* First 30 minutes of charging is free.
* Charging fee of € 0.25 per kWh (excl. VAT) after 30 minutes.
* Charging fee of € 0.40 per kWh (excl. VAT) after 60 minutes.

For a charging session with a duration of 40 minutes where 5 kWh are charged during the first 30 minutes and another 1.2
kWh in the remaining 10 minutes of the session, this tariff will result in costs of € 0.30 (excl. VAT). The costs are
composed of the following components:

* 5 kWh for free: € 0.00
* 1.2 kWh at 0.25/kWh: € 0.30

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "2",
  "currency": "EUR",
  "type": "REGULAR",
  "elements": [
    {
      "price_components": [
        {
          "type": "ENERGY",
          "price": 0,
          "vat": 20,
          "step_size": 1
        }
      ],
      "restrictions": {
        "max_duration": 1800
      }
    },
    {
      "price_components": [
        {
          "type": "ENERGY",
          "price": 0.25,
          "vat": 20,
          "step_size": 1
        }
      ],
      "restrictions": {
        "max_duration": 3600
      }
    },
    {
      "price_components": [
        {
          "type": "ENERGY",
          "price": 0.4,
          "vat": 20,
          "step_size": 1
        }
      ]
    }
  ],
  "last_updated": "2018-12-05T13:12:44Z"
}
```

## TariffType *enum*

| Value          | Description                                                                                                                                                                                       |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| AD_HOC_PAYMENT | Used to describe that a Tariff is valid when ad-hoc payment is used at the Charge Point (for example: Debit or Credit card payment terminal).                                                     |
| PROFILE_CHEAP  | Used to describe that a Tariff is valid when [Charging Preference](https://ocpi.dev): [CHEAP](https://ocpi.dev) is set for the session.                                                           |
| PROFILE_FAST   | Used to describe that a Tariff is valid when [Charging Preference](https://ocpi.dev): [FAST](https://ocpi.dev) is set for the session.                                                            |
| PROFILE_GREEN  | Used to describe that a Tariff is valid when [Charging Preference](https://ocpi.dev): [GREEN](https://ocpi.dev) is set for the session.                                                           |
