---
id: object-description
slug: /modules/tariffs/object-description
---
# Object description

## *Tariff* Object

A Tariff object consists of a list of one or more Tariff Elements, which in turn consist of Price Components.

A Tariff Element is a group of Price Components that apply under the same conditions. The rules for the conditions under
which a Tariff Element applies are known as its "restrictions".

A Price Component describes how the usage of a particular dimension (time, energy, etcetera) is mapped to an amount of
money owed.

This system of Tariffs, Tariff Elements and Price Components can be used to create complex Tariff structures.

When the list of Tariff Elements contains more than one Element that has a Price Component for a certain dimension, then
the first Tariff Element with a Price Component for that dimension in the list with matching Tariff Restrictions will be
used. Only one Price Component per dimension can be active at any point in time, but multiple Price Components for
different dimensions can be active at once. That is you can have an ENERGY component and a TIME component active at the
same time, but only those ones that are in the first Tariff Element that has a Price Component for that dimension and
that has restrictions that match at that time.

When no Tariff Element with a specific Dimension is found for which the Restrictions match, and there is no Tariff
Element in the list with the given Dimension without Restrictions, there will be no costs for that Tariff Dimension.

It is advised to always add a "default" Price Component per dimension.

This can be achieved by adding a Tariff Element without restrictions after all other occurrences of the same dimension
in the list of Tariff Elements.

Such a Tariff Element will act as fallback when there is no other Tariff Element that has matching restrictions and that
contains a Price Component for that dimension.

To define a "Free of Charge" tariff in OCPI, a Tariff containing one Tariff Element with no restrictions containing one
Price Component with `type` = `FLAT` and `price` = `0.00` has to be provided.

See: [Free of Charge Tariff example](https://ocpi.dev)

:::note
There are no parameters related to price rounding in the Tariff object or any of it constituent objects. Nor does the
specification text of this module give any requirements about how to do price rounding. The reason for this that price
rounding has to be done according to rules and restrictions set by applicable laws, contracts between the parties using
OCPI and the currency used. The OCPI specification stays out of these matters.
:::

| Property        | Type                                                   | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                |
|-----------------|--------------------------------------------------------|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code    | [CiString](/07-types/01-intro.md#cistring-type)(2)     | 1     | ISO-3166 alpha-2 country code of the CPO that *owns* this Tariff.                                                                                                                                                                                                                                                                                                                                                          |
| party_id        | [CiString](/07-types/01-intro.md#cistring-type)(3)     | 1     | ID of the CPO that *owns* this Tariff (following the ISO-15118 standard).                                                                                                                                                                                                                                                                                                                                                  |
| id              | [CiString](/07-types/01-intro.md#cistring-type)(36)    | 1     | Uniquely identifies the tariff within the CPO's platform (and suboperator platforms).                                                                                                                                                                                                                                                                                                                                      |
| currency        | [string](/07-types/01-intro.md#string-type)(3)         | 1     | ISO-4217 code of the currency of this tariff.                                                                                                                                                                                                                                                                                                                                                                              |
| type            | [TariffType](https://ocpi.dev)                         | ?     | Defines the type of the tariff. This allows for distinction in case of given [Charging Preferences](https://ocpi.dev). When omitted, this tariff is valid for all sessions.                                                                                                                                                                                                                                                |
| tariff_alt_text | [DisplayText](/07-types/01-intro.md#displaytext-class) | \*    | List of multi-language alternative tariff info texts.                                                                                                                                                                                                                                                                                                                                                                      |
| tariff_alt_url  | [URL](/07-types/01-intro.md#url-type)                  | ?     | URL to a web page that contains an explanation of the tariff information in human readable form.                                                                                                                                                                                                                                                                                                                           |
| min_price       | [Price](/07-types/01-intro.md#price-class)             | ?     | When this field is set, a Charging Session with this tariff will at least cost this amount. This is different from a `FLAT` fee (Start Tariff, Transaction Fee), as a `FLAT` fee is a fixed amount that has to be paid for any Charging Session. A minimum price indicates that when the cost of a Charging Session is lower than this amount, the cost of the Session will be equal to this amount. (Also see note below) |
| max_price       | [Price](/07-types/01-intro.md#price-class)             | ?     | When this field is set, a Charging Session with this tariff will NOT cost more than this amount. (See note below)                                                                                                                                                                                                                                                                                                          |
| elements        | [TariffElement](https://ocpi.dev)                      | \+    | List of Tariff Elements.                                                                                                                                                                                                                                                                                                                                                                                                   |
| start_date_time | [DateTime](/07-types/01-intro.md#datetime-type)        | ?     | The time when this tariff becomes active, in UTC, `time_zone` field of the [Location](https://ocpi.dev) can be used to convert to local time. Typically used for a new tariff that is already given with the location, before it becomes active. (See note below)                                                                                                                                                          |
| end_date_time   | [DateTime](/07-types/01-intro.md#datetime-type)        | ?     | The time after which this tariff is no longer valid, in UTC, `time_zone` field if the [Location](https://ocpi.dev) can be used to convert to local time. Typically used when this tariff is going to be replaced with a different tariff in the near future. (See note below)                                                                                                                                              |
| energy_mix      | [EnergyMix](https://ocpi.dev)                          | ?     | Details on the energy supplied with this tariff.                                                                                                                                                                                                                                                                                                                                                                           |
| last_updated    | [DateTime](/07-types/01-intro.md#datetime-type)        | 1     | Timestamp when this Tariff was last updated (or created).                                                                                                                                                                                                                                                                                                                                                                  |

:::note
`min_price`: As the VAT might be built up of different parts, there might be situations where minimum cost including VAT
is reached earlier or later than the minimum cost excluding VAT. So as a rule, they both apply: - The total cost of a
Charging Session excluding VAT can never be lower than the `min_price` excluding VAT. - The total cost of a Charging
Session including VAT can never be lower than the `min_price` including VAT.
:::

:::note
`max_price`: As the VAT might be built up of different parts, there might be situations where maximum cost including VAT
is reached earlier or later than the maximum cost excluding VAT. So as a rule, they both apply: - The total cost of a
Charging Session excluding VAT can never be higher than the `max_price` excluding VAT. - The total cost of a Charging
Session including VAT can never be higher than the `max_price` including VAT.
:::

:::note
`start_date_time` and `end_date_time`: When the Tariff of a Charge Point (Location) is changed during an ongoing
charging session, it is common to not switch the Tariff until the ongoing session is finished. But this is NOT a
requirement of OCPI, it is even possible with OCPI. Changing tariffs during an ongoing session is in many countries not
allowed by consumer legislation. When charging at a Charge Point, a driver accepts the tariff which is valid when they
start their charging session. If the Tariff of the Charge Point would change during the charging session, the driver
might get billed something they didn't agree to when starting the session.
:::

:::note
The fields: `tariff_alt_text` and `tariff_alt_url` may be used separately, or in combination with each other or even
combined with the structured list of Tariff Elements. When a Tariff contains both the `tariff_alt_text` and `elements`
fields, the `tariff_alt_text` SHALL only contain additional tariff information in human-readable text, not the price
information that is also available via the `elements` field. The reason for this is that the eMSP might have additional
fees they want to include in communication with their customer.
:::

### Examples

In the following section, a few different pricing strategies will be explained with some Tariff examples. For
simplicity, we will use the euro as the currency in all of the examples if not mentioned otherwise.

##### Simple Tariff example € 0.25 per kWh$

* Energy
  * € 0.25 per kWh (excl. VAT)
  * 10% VAT
  * Billed per 1 Wh

This tariff will result in costs of € 5.00 (excl. VAT) or € 5.50 (incl. VAT) when 20 kWh are charged.

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "16",
  "currency": "EUR",
  "elements": [
    {
      "price_components": [
        {
          "type": "ENERGY",
          "price": 0.25,
          "vat": 10,
          "step_size": 1
        }
      ]
    }
  ],
  "last_updated": "2018-12-17T11:16:55Z"
}
```

##### Tariff example € 0.25 per kWh + start fee

* Start or transaction fee
  * € 0.50 (excl. VAT)
  * 20% VAT
* Energy
  * € 0.25 per kWh (excl. VAT)
  * 10% VAT
  * Billed per 1 Wh

This tariff will result in total cost of € 5.50 (excl. VAT) or € 6.10 (incl. VAT) when 20 kWh are charged.

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "17",
  "currency": "EUR",
  "elements": [
    {
      "price_components": [
        {
          "type": "FLAT",
          "price": 0.5,
          "vat": 20,
          "step_size": 1
        },
        {
          "type": "ENERGY",
          "price": 0.25,
          "vat": 10,
          "step_size": 1
        }
      ]
    }
  ],
  "last_updated": "2018-12-17T11:36:01Z"
}
```

##### Tariff example € 0.25 per kWh + minimum price

* Minimum price
  * € 0.50 (excl. VAT)
  * € 0.55 (incl. VAT, which is 10%)
* Energy
  * € 0.25 per kWh (excl. VAT)
  * 10% VAT
  * Billed per 1 Wh

This tariff will result in costs of € 5.00 (excl. VAT) or € 5.50 (incl. VAT) when 20 kWh are charged. But if less than 2
kWh is charged, € 0.50 (excl. VAT) or € 0.55 (incl. VAT) will be billed.

This is different from a start fee as can be seen when compared to the example above.

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "20",
  "currency": "EUR",
  "min_price": {
    "excl_vat": 0.5,
    "incl_vat": 0.55
  },
  "elements": [
    {
      "price_components": [
        {
          "type": "ENERGY",
          "price": 0.25,
          "vat": 10,
          "step_size": 1
        }
      ]
    }
  ],
  "last_updated": "2018-12-17T16:45:21Z"
}
```

##### Tariff example € 0.25 per kWh + parking fee + start fee

* Start or transaction fee
  * € 0.50 (excl. VAT)
  * 20% VAT
* Energy
  * € 0.25 per kWh (excl. VAT)
  * 10% VAT
  * Billed per 1 Wh
* Parking
  * € 2.00 per hour (excl. VAT)
  * 20% VAT
  * Billed per 15 min (900 seconds)

For a charging session where 20 kWh are charged and the vehicle is parked for 40 minutes after the session ended, this
tariff will result in costs of € 7.00 (excl. VAT) or € 7.90 (incl. VAT). Because the parking time is billed per 15
minutes, the driver has to pay for 45 minutes of parking even though they left 40 minutes after their vehicle stopped
charging.

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "18",
  "currency": "EUR",
  "elements": [
    {
      "price_components": [
        {
          "type": "FLAT",
          "price": 0.5,
          "vat": 20,
          "step_size": 1
        },
        {
          "type": "ENERGY",
          "price": 0.25,
          "vat": 10,
          "step_size": 1
        },
        {
          "type": "PARKING_TIME",
          "price": 2,
          "vat": 20,
          "step_size": 900
        }
      ]
    }
  ],
  "last_updated": "2018-12-17T11:44:10Z"
}
```

##### Tariff example € 0.25 per kWh + start fee + max price + tariff end date

* Maximum price
  * € 10 (excl. VAT)
  * € 11 (incl. VAT, which is 10%)
* Start or transaction fee
  * € 0.50 (excl. VAT)
  * 20% VAT
* Energy
  * € 0.25 per kWh (excl. VAT)
  * 10% VAT
  * Billed per 1 Wh

This tariff has an end date: 30 June 2019, which is typically used when a tariff is going to be replaced by a new
tariff. A [Connector](https://ocpi.dev) of a
[Location](https://ocpi.dev) can have multiple Tariffs (IDs) assigned. By assigning
both, the old and the new tariff ID, they will automatically be replaced. It is not required to update all Locations at
the same time, the old tariff can also be removed later.

For a charging session where 50 kWh are charged, this tariff will result in costs of € 10.00 (excl. VAT) or € 11.00
(incl. VAT) due to the price limit. If only 30 kWh were charged, the costs would be € 8.00 (excl. VAT) and € 8.85 (incl.
VAT), as the start fee combined with the energy costs would be lower than the defined max price.

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "16",
  "currency": "EUR",
  "max_price": {
    "excl_vat": 10,
    "incl_vat": 11
  },
  "elements": [
    {
      "price_components": [
        {
          "type": "FLAT",
          "price": 0.5,
          "vat": 20,
          "step_size": 1
        },
        {
          "type": "ENERGY",
          "price": 0.25,
          "vat": 10,
          "step_size": 1
        }
      ]
    }
  ],
  "end_date_time": "2019-06-30T23:59:59Z",
  "last_updated": "2018-12-17T17:15:01Z"
}
```

##### Simple Tariff example € 2 per hour

An example of a tariff where the driver does not pay per kWh, but for the time of using the Charge Point.

* Charging Time
  * € 2.00 per hour (excl. VAT)
  * 10% VAT
  * Billed per 1 min (60 seconds)

As this is tariff only has a `TIME` price_component, the driver will not be billed for time they are not charging:
`PARKING_TIME`

For a charging session of 2.5 hours, this tariff will result in costs of € 5.00 (excl. VAT) or € 5.50 (incl. VAT).

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "12",
  "currency": "EUR",
  "elements": [
    {
      "price_components": [
        {
          "type": "TIME",
          "price": 2,
          "vat": 10,
          "step_size": 60
        }
      ]
    }
  ],
  "last_updated": "2015-06-29T20:39:09Z"
}
```

##### Simple Tariff example € 3 per hour, € 5 per hour parking

Example of a tariff where the driver pays for the time of using the Charge Point, but pays more when the car is no
longer charging, to discourage the EV driver of leaving his EV connected when it is already full.

* Charging Time
  * € 3.00 per hour (excl. VAT)
  * 10% VAT
  * Billed per 1 min (60 seconds)
* Parking
  * € 5.00 per hour (excl. VAT)
  * 20% VAT
  * Billed per 5 min (300 seconds)

A charging session of 2.5 hours (charging), where the vehicle is parked for 42 more minutes after charging ended,
results in a total session time of 150 minutes (charging) + 42 minutes (parking). This session with this tariff will
result in total cost of € 11.25 (excl. VAT) or € 12.75 (incl. VAT). Because the parking time is billed per 5 minutes,
the driver has to pay for 45 minutes of parking even though they left 42 minutes after their vehicle stopped charging.

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "21",
  "currency": "EUR",
  "elements": [
    {
      "price_components": [
        {
          "type": "TIME",
          "price": 3,
          "vat": 10,
          "step_size": 60
        },
        {
          "type": "PARKING_TIME",
          "price": 5,
          "vat": 20,
          "step_size": 300
        }
      ]
    }
  ],
  "last_updated": "2018-12-17T17:00:43Z"
}
```

##### Ad-Hoc simple Tariff example with multiple languages

For ad-hoc charging (paying for charging without a contract), the Tariff Elements are not as important. The eMSP is not
involved when a driver uses ad-hoc payment at the Charge Point, so no CDR is sent to an eMSP. Having a good human
readable text is much more useful.

* Charging Time
  * € 1.90 per hour (excl. VAT)
  * 5.2% VAT
  * Billed per 5 minutes (300 seconds)

For a charging session of 2.5 hours, this tariff will result in costs of € 4.75 (excl. VAT) or € 5.00 (incl. VAT).

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "12",
  "currency": "EUR",
  "type": "AD_HOC_PAYMENT",
  "tariff_alt_text": [
    {
      "language": "en",
      "text": "2.00 euro p/hour including VAT."
    },
    {
      "language": "nl",
      "text": "2.00 euro p/uur inclusief BTW."
    }
  ],
  "elements": [
    {
      "price_components": [
        {
          "type": "TIME",
          "price": 1.9,
          "vat": 5.2,
          "step_size": 300
        }
      ]
    }
  ],
  "last_updated": "2015-06-29T20:39:09Z"
}
```

##### Ad-Hoc Tariff example not possible with OCPI

For this example, the credit card start tariff is € 0.50, but when using a debit card it is only € 0.25.

Such a tariff cannot be modeled with OCPI. But by modeling it as € 0.50 start tariff where debit card users are given a
discount in the final CDR of € 0.25, nobody is likely to complain. The `tariff_alt_text` explains this clearly.

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "19",
  "currency": "EUR",
  "type": "AD_HOC_PAYMENT",
  "tariff_alt_text": [
    {
      "language": "en",
      "text": "2.00 euro p/hour, start tariff debit card: 0.25 euro, credit card: 0.50 euro including VAT."
    },
    {
      "language": "nl",
      "text": "2.00 euro p/uur, starttarief bankpas: 0,25 euro, creditkaart: 0,50 euro inclusief BTW."
    }
  ],
  "elements": [
    {
      "price_components": [
        {
          "type": "FLAT",
          "price": 0.4,
          "vat": 25,
          "step_size": 1
        },
        {
          "type": "TIME",
          "price": 1.9,
          "vat": 5.2,
          "step_size": 300
        }
      ]
    }
  ],
  "last_updated": "2018-12-29T15:55:58Z"
}
```

##### Simple Tariff example with alternative URL

This examples shows the use of `tariff_alt_url`.

This examples shows a `PROFILE_CHEAP` tariff, which is a smart charging tariff. Drivers are able to select this tariff
by setting the `profile_type` in their [Charging
Preferences](https://ocpi.dev) to `CHEAP`. In such case, the price might not
be fixed, but depend on the real-time energy prices. To explain this to the driver, a short text inside
`tariff_alt_text` might not be the best solution. Showing a graph could be better. Therefore it is also possible to
provide an URL in `tariff_alt_url` to a site that explains the tariff better and in more detail.

* Start or transaction fee
  * € 0.50 (excl. VAT)
  * 20% VAT
* Energy
  * € 0.25 per kWh (excl. VAT)
  * 10% VAT
  * Billed per 0.1 kWh (100 Wh)

For a charging session where 20.45 kWh are charged: this tariff will result in:

* Start fee: € 0.50 (excl. VAT), € 0.60 (incl. VAT)
* Energy costs: € 5.13 (excl. VAT), € 5.64 (incl. VAT)
* Total: € 5.63 (excl. VAT), € 6.24 (incl. VAT)

if the announced prices were billed. Because the energy is billed per 0.1 kWh, the driver has to pay for 20.5 kWh even
though they only charged 20.45 kWh.

The twist here is that this tariff makes use of `tariff_alt_url` which links to a page with real-time energy prices of
the operator, where is shown that the actual price per kWh is different. With an assumed current energy price of € 0.22
per kWh (excl. VAT), which is shown or explained on the page linked by `tariff_alt_url`, the resulting costs:

* Start fee: € 0.50 (excl. VAT), € 0.60 (incl. VAT)
* Energy costs: € 4.51 (excl. VAT), € 4.96 (incl. VAT)
* Total: € 5.01 (excl. VAT), € 5.56 (incl. VAT)

A breakdown for computing the price as the `elements` field of the Tariff says, with an energy price of € 0.25 / kWh, is
as follows:

| Dimension | Quantity  | Price ex VAT | Cost ex VAT | VAT | Cost inc VAT |
|-----------|-----------|--------------|-------------|-----|--------------|
| Flat      | 1         | 0.50         | 0.50        | 20% | 0.60         |
| Energy    | 20.45 kWh | 0.25 per kWh | 5.13        | 10% | 5.64         |
| Total     |           |              | 5.63        |     | 6.24         |

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "13",
  "currency": "EUR",
  "type": "PROFILE_CHEAP",
  "tariff_alt_url": "https://company.com/tariffs/13",
  "elements": [
    {
      "price_components": [
        {
          "type": "FLAT",
          "price": 0.5,
          "vat": 20,
          "step_size": 1
        },
        {
          "type": "ENERGY",
          "price": 0.25,
          "vat": 10,
          "step_size": 100
        }
      ]
    }
  ],
  "last_updated": "2015-06-29T20:39:09Z"
}
```

##### Complex Tariff example

* Start or transaction fee
  * € 2.50 (excl. VAT)
  * 15% VAT
* Charging Time
  * When charging with less than 32A
    * € 1.00 per hour (excl. VAT)
    * 20% VAT
    * Billed per 15 min (900 seconds)
  * When charging with more than 32A on weekdays
    * € 2.00 per hour (excl. VAT)
    * 20% VAT
    * Billed per 10 min (600 seconds)
  * When charging with more than 32A on weekends
    * € 1.25 per hour (excl. VAT)
    * 20% VAT
    * Billed per 10 min (600 seconds)
* Parking
  * On weekdays between 09:00 and 18:00
    * € 5 per hour (excl. VAT)
    * 10% VAT
    * Billed per 5 min (300 seconds)
  * On Saturday between 10:00 and 17:00
    * € 6 per hour (excl. VAT)
    * 10% VAT
    * Billed per 5 min (300 seconds)

For a charging session on a Monday morning starting at 09:30 which takes 2:45 hours (165 minutes), where the driver uses
a maximum of 16A of current and is parking for additional 42 minutes afterwards, this tariff will result in costs of €
9.00 (excl. VAT) or € 10.30 (incl. VAT) for a total session time of 165 minutes (charging) + 42 minutes (parking).

A breakdown is as follows:

| Dimension     | Quantity    | Price ex VAT  | Cost ex VAT | VAT | Cost inc VAT |
|---------------|-------------|---------------|-------------|-----|--------------|
| Flat          | 1           | 2.50          | 2.50        | 15% | 2.875        |
| Charging time | 165 minutes | 1.00 per hour | 2.75        | 20% | 3.30         |
| Parking time  | 45 minutes  | 5.00 per hour | 3.75        | 10% | 4.125        |
| Total         |             |               | 9.00        |     | 10.30        |

The step_size of the last time-based period is 5 so the parking time duration of 42 minutes is rounded up to 45. As such
the driver has to pay for 45 minutes of parking while they were actually only parking for 42 minutes.

The charging time is not affected by step_size because it is followed by another time-based period.

For a charging session on a Saturday afternoon starting at 13:30 which takes 1:54 hours (114 minutes), where the driver
uses a minimum of 43A of current (all the time, which is only theoretically possible) and is parking for additional 71
minutes afterwards, this tariff will result in a total cost of € 12.28 (excl. VAT) or € 13.861 (incl. VAT). A breakdown
is as follows:

| Dimension     | Quantity    | Price ex VAT  | Cost ex VAT | VAT | Cost inc VAT |
|---------------|-------------|---------------|-------------|-----|--------------|
| Flat          | 1           | 2.50          | 2.50        | 15% | 2.875        |
| Charging time | 114 minutes | 1.25 per hour | 2.28        | 20% | 2.736        |
| Parking time  | 75 minutes  | 6.00 per hour | 7.50        | 10% | 8.25         |
| Total         |             |               | 12.28       |     | 13.861       |

The cost for parking time is 7.50, reflecting 75 minutes of parking, because the step_size of the last time-based period
is applied to the 71 actual minutes of parking.

The charging time is again not affected by step_size because it is followed by parking time.

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "14",
  "currency": "EUR",
  "type": "REGULAR",
  "tariff_alt_url": "https://company.com/tariffs/14",
  "elements": [
    {
      "price_components": [
        {
          "type": "FLAT",
          "price": 2.5,
          "vat": 15,
          "step_size": 1
        }
      ]
    },
    {
      "price_components": [
        {
          "type": "TIME",
          "price": 1,
          "vat": 20,
          "step_size": 900
        }
      ],
      "restrictions": {
        "max_current": 32
      }
    },
    {
      "price_components": [
        {
          "type": "TIME",
          "price": 2,
          "vat": 20,
          "step_size": 600
        }
      ],
      "restrictions": {
        "min_current": 32,
        "day_of_week": [
          "MONDAY",
          "TUESDAY",
          "WEDNESDAY",
          "THURSDAY",
          "FRIDAY"
        ]
      }
    },
    {
      "price_components": [
        {
          "type": "TIME",
          "price": 1.25,
          "vat": 20,
          "step_size": 600
        }
      ],
      "restrictions": {
        "min_current": 32,
        "day_of_week": [
          "SATURDAY",
          "SUNDAY"
        ]
      }
    },
    {
      "price_components": [
        {
          "type": "PARKING_TIME",
          "price": 5,
          "vat": 10,
          "step_size": 300
        }
      ],
      "restrictions": {
        "start_time": "09:00",
        "end_time": "18:00",
        "day_of_week": [
          "MONDAY",
          "TUESDAY",
          "WEDNESDAY",
          "THURSDAY",
          "FRIDAY"
        ]
      }
    },
    {
      "price_components": [
        {
          "type": "PARKING_TIME",
          "price": 6,
          "vat": 10,
          "step_size": 300
        }
      ],
      "restrictions": {
        "start_time": "10:00",
        "end_time": "17:00",
        "day_of_week": [
          "SATURDAY"
        ]
      }
    }
  ],
  "last_updated": "2015-06-29T20:39:09Z"
}
```

##### Free of Charge Tariff example

In this example no VAT is given because it is not necessary (as the `price` is `0.00`). This might not always be the
case though and it is of course permitted to add a VAT, even if the `price` is set to zero.

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "15",
  "currency": "EUR",
  "elements": [
    {
      "price_components": [
        {
          "type": "FLAT",
          "price": 0,
          "step_size": 0
        }
      ]
    }
  ],
  "last_updated": "2015-06-29T20:39:09Z"
}
```

##### Tariff example with reservation price

* Reservation
  * € 5.00 per hour (excl. VAT)
  * 20% VAT
  * Billed per 1 min (60 seconds)
* Start or transaction fee
  * € 0.50 (excl. VAT)
  * 20% VAT
* Energy
  * € 0.25 per kWh (excl. VAT)
  * 10% VAT
  * Billed per 1 Wh

For a charging session that was started 15 minutes after the reservation time, where the driver charges 20 kWh, this
tariff will result in costs of € 6.75 (excl. VAT) or € 7.60 (incl. VAT).

A breakdown is as follows:

| Dimension   | Quantity   | Price ex VAT  | Cost ex VAT | VAT | Cost inc VAT |
|-------------|------------|---------------|-------------|-----|--------------|
| Flat        | 1          | 0.50          | 0.50        | 20% | 0.60         |
| Energy      | 20 kWh     | 0.25 per kWh  | 5.00        | 10% | 5.50         |
| Reservation | 15 minutes | 5.00 per hour | 1.25        | 20% | 1.50         |
| Total       |            |               | 6.75        |     | 7.60         |

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "20",
  "currency": "EUR",
  "elements": [
    {
      "price_components": [
        {
          "type": "TIME",
          "price": 5,
          "vat": 20,
          "step_size": 60
        }
      ],
      "restrictions": {
        "reservation": "RESERVATION"
      }
    },
    {
      "price_components": [
        {
          "type": "FLAT",
          "price": 0.5,
          "vat": 20,
          "step_size": 1
        },
        {
          "type": "ENERGY",
          "price": 0.25,
          "vat": 10,
          "step_size": 1
        }
      ]
    }
  ],
  "last_updated": "2019-02-03T17:00:11Z"
}
```

##### Tariff example with reservation price and fee

* Reservation
  * € 2.00 reservation fee (excl. VAT)
  * € 5.00 per hour (excl. VAT)
  * 20% VAT
  * Billed per 5 min (300 seconds)
* Start or transaction fee
  * € 0.50 (excl. VAT)
  * 20% VAT
* Energy
  * € 0.25 per kWh (excl. VAT)
  * 10% VAT
  * Billed per 1 Wh

For a charging session that was started 13 minutes after the reservation time, where the driver charges 20 kWh, this
tariff will result in costs of € 8.75 (excl. VAT) or € 10.00 (incl. VAT). Because the reservation fee is billed per 5
minutes, the driver has to pay for 15 minutes of reservation even though they started the charging session 13 minutes
after the reservation time.

A breakdown is as follows:

| Dimension    | Quantity   | Price ex VAT  | Cost ex VAT | VAT | Cost inc VAT |
|--------------|------------|---------------|-------------|-----|--------------|
| Flat         | 1          | 2.00          | 2.00        | 20% | 2.40         |
| Parking time | 15 minutes | 5.00 per hour | 1.25        | 20% | 1.50         |
| Flat         | 1          | 0.50          | 0.50        | 20% | 0.60         |
| Energy       | 20 kWh     | 0.25 per kWh  | 5.00        | 10% | 5.50         |
| Total        |            |               | 8.75        |     | 10.00        |

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "20",
  "currency": "EUR",
  "elements": [
    {
      "price_components": [
        {
          "type": "FLAT",
          "price": 2,
          "vat": 20,
          "step_size": 1
        },
        {
          "type": "TIME",
          "price": 5,
          "vat": 20,
          "step_size": 300
        }
      ],
      "restrictions": {
        "reservation": "RESERVATION"
      }
    },
    {
      "price_components": [
        {
          "type": "FLAT",
          "price": 0.5,
          "vat": 20,
          "step_size": 1
        },
        {
          "type": "ENERGY",
          "price": 0.25,
          "vat": 10,
          "step_size": 1
        }
      ]
    }
  ],
  "last_updated": "2019-02-03T17:00:11Z"
}
```

##### Tariff example with reservation price and expire fee

* Reservation
  * € 4.00 reservation expiration fee (excl. VAT) (*billed when a reservation expires and is not followed by a charging
    session*)
  * € 2.00 per hour (excl. VAT)
  * 20% VAT
  * Billed per 10 min (600 seconds)
* Start or transaction fee
  * € 0.50 (excl. VAT)
  * 20% VAT
* Energy
  * € 0.25 per kWh (excl. VAT)
  * 10% VAT
  * Billed per 1 Wh

This example is very similar to [Tariff example with reservation
price](https://ocpi.dev) with the difference that expired reservations cost
something and that reservation time is billed per 10 minutes. Also, the price for reservation is different.

For a charging session that was started 22 minutes after the reservation time, where the driver charges 20 kWh, this
tariff will result in costs of € 6.50 (excl. VAT) or € 7.30 (incl. VAT). Because the reservation fee is billed per 10
minutes, the driver has to pay for 30 minutes of reservation even though they started the charging session 22 minutes
after the reservation time.

A breakdown of this scenario is as follows:

| Dimension | Quantity   | Price ex VAT  | Cost ex VAT | VAT | Cost inc VAT |
|-----------|------------|---------------|-------------|-----|--------------|
| Time      | 30 minutes | 2.00 per hour | 1.00        | 20% | 1.20         |
| Flat      | 1          | 0.50          | 0.50        | 20% | 0.60         |
| Energy    | 20 kWh     | 0.25 per kWh  | 5.00        | 10% | 5.50         |
| Total     |            |               | 6.50        |     | 7.30         |

If the driver did not start a charging session and the reservation expired after the reserved time of 1 hour, the tariff
would have resulted in costs of € 6.00 (excl. VAT) or € 7.20 (incl. VAT). In case a reservation is not used, the driver
has to pay the full amount of reserved time as well as an additional expiration fee as compensation for not charging at
all.

A breakdown of this scenario is as follows:

| Dimension | Quantity   | Price ex VAT  | Cost ex VAT | VAT | Cost inc VAT |
|-----------|------------|---------------|-------------|-----|--------------|
| Flat      | 1          | 4.00          | 4.00        | 20% | 4.80         |
| Time      | 60 minutes | 2.00 per hour | 2.00        | 20% | 2.40         |
| Total     |            |               | 6.00        |     | 7.20         |

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "20",
  "currency": "EUR",
  "elements": [
    {
      "price_components": [
        {
          "type": "FLAT",
          "price": 4,
          "vat": 20,
          "step_size": 1
        }
      ],
      "restrictions": {
        "reservation": "RESERVATION_EXPIRES"
      }
    },
    {
      "price_components": [
        {
          "type": "TIME",
          "price": 2,
          "vat": 20,
          "step_size": 600
        }
      ],
      "restrictions": {
        "reservation": "RESERVATION"
      }
    },
    {
      "price_components": [
        {
          "type": "FLAT",
          "price": 0.5,
          "vat": 20,
          "step_size": 1
        },
        {
          "type": "ENERGY",
          "price": 0.25,
          "vat": 10,
          "step_size": 1
        }
      ]
    }
  ],
  "last_updated": "2019-02-03T17:00:11Z"
}
```

##### Tariff example with reservation time and expire time

* Reservation
  * € 3.00 per hour (excl. VAT)
  * € 6.00 per hour (excl. VAT) (*billed when a reservation expires and is not followed by a charging session*)
  * 20% VAT
  * Billed per 10 min (600 seconds)
* Start or transaction fee
  * € 0.50 (excl. VAT)
  * 20% VAT
* Energy
  * € 0.25 per kWh (excl. VAT)
  * 10% VAT
  * Billed per 1 Wh

This example is very similar to [Tariff example with reservation
price](https://ocpi.dev) with the difference that expired reservations cost
something and that reservation time is billed per 10 minutes. Also, the price for reservation is different.

For a charging session that was started 22 minutes after the reservation time, where the driver charges 20 kWh, this
tariff will result in costs of € 7.00 (excl. VAT) or € 7.90 (incl. VAT). Because the reservation fee is billed per 10
minutes, the driver has to pay for 30 minutes of reservation even though they started the charging session 22 minutes
after the reservation time.

A breakdown of this scenario is as follows:

| Dimension | Quantity   | Price ex VAT  | Cost ex VAT | VAT | Cost inc VAT |
|-----------|------------|---------------|-------------|-----|--------------|
| Time      | 30 minutes | 3.00 per hour | 1.50        | 20% | 1.80         |
| Flat      | 1          | 0.50          | 0.50        | 20% | 0.60         |
| Energy    | 20 kWh     | 0.25 per kWh  | 5.00        | 10% | 5.50         |
| Total     |            |               | 7.00        |     | 7.90         |

If the driver did not start a charging session and the reservation expired after the reserved time of 1.5 hours, the
tariff would have resulted in costs of € 9.00 (excl. VAT) or € 10.80 (incl. VAT). In case a reservation is not used, the
driver has to pay the expiration fee as compensation for not charging at all.

A breakdown of this scenario is as follows:

| Dimension | Quantity   | Price ex VAT  | Cost ex VAT | VAT | Cost inc VAT |
|-----------|------------|---------------|-------------|-----|--------------|
| Time      | 90 minutes | 6.00 per hour | 9.00        | 20% | 10.80        |
| Total     |            |               | 9.00        |     | 10.80        |

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "20",
  "currency": "EUR",
  "elements": [
    {
      "price_components": [
        {
          "type": "TIME",
          "price": 6,
          "vat": 20,
          "step_size": 600
        }
      ],
      "restrictions": {
        "reservation": "RESERVATION_EXPIRES"
      }
    },
    {
      "price_components": [
        {
          "type": "TIME",
          "price": 3,
          "vat": 20,
          "step_size": 600
        }
      ],
      "restrictions": {
        "reservation": "RESERVATION"
      }
    },
    {
      "price_components": [
        {
          "type": "FLAT",
          "price": 0.5,
          "vat": 20,
          "step_size": 1
        },
        {
          "type": "ENERGY",
          "price": 0.25,
          "vat": 10,
          "step_size": 1
        }
      ]
    }
  ],
  "last_updated": "2019-02-03T17:00:11Z"
}
```
