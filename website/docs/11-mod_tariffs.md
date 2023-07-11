---
slug: tariffs
---
# Tariffs module

:::tip Module Identifier
tariffs
:::

:::caution Data owner
CPO
:::

:::info Type
Functional Module
:::

The Tariffs module gives eMSPs information about the tariffs used by the CPO.

## Flow and Lifecycle

### Push model

When the CPO creates a new Tariff they push them to the eMSPs by calling the [PUT](https://ocpi.dev) method on
the eMSPs Tariffs endpoint with the newly created Tariff object.

Any changes to the Tariff(s) in the CPO's system can be sent to the eMSPs systems by calling the
[PUT](https://ocpi.dev) method on the eMSPs Tariffs endpoint with the updated Tariff object.

When the CPO deletes a Tariff, they will update the eMSPs systems by calling [DELETE](https://ocpi.dev) on the
eMSPs Tariffs endpoint with the ID of the Tariff that was deleted.

When the CPO is not sure about the state or existence of a Tariff object in the system of an eMSP, the CPO can use a
[GET](https://ocpi.dev) request to validate the Tariff object in the eMSP's system.

### Pull model

eMSPs who do not support the Push model need to call [GET](https://ocpi.dev) on the CPO's Tariff endpoint to
receive all Tariffs, replacing the current list of known Tariffs with the newly received list.

## Interfaces and Endpoints

There is both a Sender and a Receiver interface for Tariffs. Advised is to use the push direction from Sender to
Receiver during normal operation. The Sender interface is meant to be used when the connection between two parties is
established to retrieve the current list of Tariffs objects, and when the Receiver is not 100% sure the Tariff cache is
still up-to-date.

### Sender Interface

Typically implemented by market roles like: CPO.

The Sender's Tariffs interface gives the Receiver the ability to request Tariffs information.

| Method                  | Description                                                                                                                 |
|-------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| [GET](https://ocpi.dev) | Returns Tariff objects from the CPO, last updated between the `{date_from}` and `{date_to}` ([paginated](https://ocpi.dev)) |
| POST                    | n/a                                                                                                                         |
| PUT                     | n/a                                                                                                                         |
| PATCH                   | n/a                                                                                                                         |
| DELETE                  | n/a                                                                                                                         |

#### **GET** Method

Fetch information about all Tariffs.

Endpoint structure definition:

`{tariffs_endpoint_url}?[date_from={date_from}]&[date_to={date_to}]&[offset={offset}]&[limit={limit}]`

Examples:

* `https://www.server.com/ocpi/cpo/2.2.1/tariffs/?date_from=2019-01-28T12:00:00&date_to=2019-01-29T12:00:00`
* `https://ocpi.server.com/2.2.1/tariffs/?offset=50`
* `https://www.server.com/ocpi/2.2.1/tariffs/?date_from=2019-01-29T12:00:00&limit=100`
* `https://www.server.com/ocpi/cpo/2.2.1/tariffs/?offset=50&limit=100`

##### Request Parameters

If additional parameters: `{date_from}` and/or `{date_to}` are provided, only Tariffs with `last_updated` between the
given `{date_from}` (including) and `{date_to}` (excluding) will be returned.

This request is [paginated](https://ocpi.dev), it supports the
[pagination](https://ocpi.dev) related URL parameters.

| Parameter | Datatype                     | Required | Description                                                                                       |
|-----------|------------------------------|----------|---------------------------------------------------------------------------------------------------|
| date_from | [DateTime](https://ocpi.dev) | no       | Only return Tariffs that have `last_updated` after or equal to this Date/Time (inclusive).        |
| date_to   | [DateTime](https://ocpi.dev) | no       | Only return Tariffs that have `last_updated` up to this Date/Time, but not including (exclusive). |
| offset    | int                          | no       | The offset of the first object returned. Default is 0.                                            |
| limit     | int                          | no       | Maximum number of objects to GET.                                                                 |

##### Response Data

The endpoint returns an object with a list of valid Tariffs, the header will contain the
[pagination](https://ocpi.dev) related headers.

Any older information that is not specified in the response is considered no longer valid. Each object must contain all
required fields. Fields that are not specified may be considered as null values.

| Type                       | Card. | Description          |
|----------------------------|-------|----------------------|
| [Tariff](https://ocpi.dev) | \*    | List of all tariffs. |

### Receiver Interface

Typically implemented by market roles like: eMSP and NSP.

Tariffs are [Client Owned Objects](https://ocpi.dev), so the
endpoints need to contain the required extra fields: {[party_id](https://ocpi.dev)}
and {[country_code](https://ocpi.dev)}.

Endpoint structure definition:

`{tariffs_endpoint_url}/{country_code}/{party_id}/{tariff_id}`

Example:

* `https://www.server.com/ocpi/cpo/2.2.1/tariffs/BE/BEC/12`

| Method                     | Description                                                                             |
|----------------------------|-----------------------------------------------------------------------------------------|
| [GET](https://ocpi.dev)    | Retrieve a Tariff as it is stored in the eMSP's system.                                 |
| POST                       | n/a                                                                                     |
| [PUT](https://ocpi.dev)    | Push new/updated Tariff object to the eMSP.                                             |
| PATCH                      | n/a                                                                                     |
| [DELETE](https://ocpi.dev) | Remove a Tariff object which is no longer in use and will not be used in future either. |

#### **GET** Method

If the CPO wants to check the status of a Tariff in the eMSP's system, it might GET the object from the eMSP's system
for validation purposes. After all, the CPO is the owner of the object, so it would be illogical if the eMSP's system
had a different status or was missing the object entirely.

##### Request Parameters

The following parameters SHALL be provided as URL segments.

| Parameter    | Datatype                         | Required | Description                                                                        |
|--------------|----------------------------------|----------|------------------------------------------------------------------------------------|
| country_code | [CiString](https://ocpi.dev)(2)  | yes      | Country code of the CPO performing the GET request on the eMSP's system.           |
| party_id     | [CiString](https://ocpi.dev)(3)  | yes      | Party ID (Provider ID) of the CPO performing the GET request on the eMSP's system. |
| tariff_id    | [CiString](https://ocpi.dev)(36) | yes      | Tariff.id of the Tariff object to retrieve.                                        |

##### Response Data

The response contains the requested object.

| Type                       | Card. | Description                  |
|----------------------------|-------|------------------------------|
| [Tariff](https://ocpi.dev) | 1     | The requested Tariff object. |

#### **PUT** Method

New or updated Tariff objects are pushed from the CPO to the eMSP.

##### Request Body

In the PUT request, the new or updated Tariff object is sent in the body.

| Type                       | Card. | Description                   |
|----------------------------|-------|-------------------------------|
| [Tariff](https://ocpi.dev) | 1     | New or updated Tariff object. |

##### Request Parameters

The following parameters SHALL be provided as URL segments.

| Parameter    | Datatype                         | Required | Description                                                                                                                                                          |
|--------------|----------------------------------|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code | [CiString](https://ocpi.dev)(2)  | yes      | Country code of the CPO performing the PUT request on the eMSP's system. This SHALL be the same value as the `country_code` in the Tariff object being pushed.       |
| party_id     | [CiString](https://ocpi.dev)(3)  | yes      | Party ID (Provider ID) of the CPO performing the PUT request on the eMSP's system. This SHALL be the same value as the `party_id` in the Tariff object being pushed. |
| tariff_id    | [CiString](https://ocpi.dev)(36) | yes      | Tariff.id of the Tariff object to create or replace.                                                                                                                 |

##### Example: New Tariff € 2 per hour charging time (not parking)

Example Request:

```shell
curl --request PUT --header "Authorization: Token <OCPI_TOKEN>" "https://www.server.com/ocpi/emsp/2.2.1/tariffs/NL/TNM/12"
```

Example Response:

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
          "step_size": 300
        }
      ]
    }
  ]
}
```

#### **DELETE** Method

Delete a Tariff object which is not used any more and will not be used in the future.

:::note

Before deleting a Tariff object, it is RECOMMENDED to ensure that the Tariff object is not referenced by any [Connector
object](https://ocpi.dev) within the `tariff_ids`.

:::

##### Request Parameters

The following parameters SHALL be provided as URL segments.

| Parameter    | Datatype                         | Required | Description                                                                        |
|--------------|----------------------------------|----------|------------------------------------------------------------------------------------|
| country_code | [CiString](https://ocpi.dev)(2)  | yes      | Country code of the CPO performing the PUT request on the eMSP's system.           |
| party_id     | [CiString](https://ocpi.dev)(3)  | yes      | Party ID (Provider ID) of the CPO performing the PUT request on the eMSP's system. |
| tariff_id    | [CiString](https://ocpi.dev)(36) | yes      | Tariff.id of the Tariff object to delete.                                          |

## Object description

### *Tariff* Object

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

| Property        | Type                              | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                |
|-----------------|-----------------------------------|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code    | [CiString](https://ocpi.dev)(2)   | 1     | ISO-3166 alpha-2 country code of the CPO that *owns* this Tariff.                                                                                                                                                                                                                                                                                                                                                          |
| party_id        | [CiString](https://ocpi.dev)(3)   | 1     | ID of the CPO that *owns* this Tariff (following the ISO-15118 standard).                                                                                                                                                                                                                                                                                                                                                  |
| id              | [CiString](https://ocpi.dev)(36)  | 1     | Uniquely identifies the tariff within the CPO's platform (and suboperator platforms).                                                                                                                                                                                                                                                                                                                                      |
| currency        | [string](https://ocpi.dev)(3)     | 1     | ISO-4217 code of the currency of this tariff.                                                                                                                                                                                                                                                                                                                                                                              |
| type            | [TariffType](https://ocpi.dev)    | ?     | Defines the type of the tariff. This allows for distinction in case of given [Charging Preferences](https://ocpi.dev). When omitted, this tariff is valid for all sessions.                                                                                                                                                                                                                                                |
| tariff_alt_text | [DisplayText](https://ocpi.dev)   | \*    | List of multi-language alternative tariff info texts.                                                                                                                                                                                                                                                                                                                                                                      |
| tariff_alt_url  | [URL](https://ocpi.dev)           | ?     | URL to a web page that contains an explanation of the tariff information in human readable form.                                                                                                                                                                                                                                                                                                                           |
| min_price       | [Price](https://ocpi.dev)         | ?     | When this field is set, a Charging Session with this tariff will at least cost this amount. This is different from a `FLAT` fee (Start Tariff, Transaction Fee), as a `FLAT` fee is a fixed amount that has to be paid for any Charging Session. A minimum price indicates that when the cost of a Charging Session is lower than this amount, the cost of the Session will be equal to this amount. (Also see note below) |
| max_price       | [Price](https://ocpi.dev)         | ?     | When this field is set, a Charging Session with this tariff will NOT cost more than this amount. (See note below)                                                                                                                                                                                                                                                                                                          |
| elements        | [TariffElement](https://ocpi.dev) | \+    | List of Tariff Elements.                                                                                                                                                                                                                                                                                                                                                                                                   |
| start_date_time | [DateTime](https://ocpi.dev)      | ?     | The time when this tariff becomes active, in UTC, `time_zone` field of the [Location](https://ocpi.dev) can be used to convert to local time. Typically used for a new tariff that is already given with the location, before it becomes active. (See note below)                                                                                                                                                          |
| end_date_time   | [DateTime](https://ocpi.dev)      | ?     | The time after which this tariff is no longer valid, in UTC, `time_zone` field if the [Location](https://ocpi.dev) can be used to convert to local time. Typically used when this tariff is going to be replaced with a different tariff in the near future. (See note below)                                                                                                                                              |
| energy_mix      | [EnergyMix](https://ocpi.dev)     | ?     | Details on the energy supplied with this tariff.                                                                                                                                                                                                                                                                                                                                                                           |
| last_updated    | [DateTime](https://ocpi.dev)      | 1     | Timestamp when this Tariff was last updated (or created).                                                                                                                                                                                                                                                                                                                                                                  |

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

#### Examples

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

## Data types

### DayOfWeek *enum*

| Value     | Description |
|-----------|-------------|
| MONDAY    | Monday      |
| TUESDAY   | Tuesday     |
| WEDNESDAY | Wednesday   |
| THURSDAY  | Thursday    |
| FRIDAY    | Friday      |
| SATURDAY  | Saturday    |
| SUNDAY    | Sunday      |

### PriceComponent *class*

A Price Component describes how a certain amount of a certain dimension being consumed translates into an amount of
money owed.

| Property  | Type                                    | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                               |
|-----------|-----------------------------------------|-------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| type      | [TariffDimensionType](https://ocpi.dev) | 1     | The dimension that is being priced                                                                                                                                                                                                                                                                                                                                                                                        |
| price     | [number](https://ocpi.dev)              | 1     | Price per unit (excl. VAT) for this dimension.                                                                                                                                                                                                                                                                                                                                                                            |
| vat       | [number](https://ocpi.dev)              | ?     | Applicable VAT percentage for this tariff dimension. If omitted, no VAT is applicable. Not providing a VAT is different from 0% VAT, which would be a value of 0.0 here.                                                                                                                                                                                                                                                  |
| step_size | int                                     | 1     | Minimum amount to be billed. That is, the dimension will be billed in this `step_size` blocks. Consumed amounts are rounded up to the smallest multiple of `step_size` that is greater than the consumed amount. For example: if `type` is `TIME` and `step_size` has a value of `300`, then time will be billed in blocks of 5 minutes. If 6 minutes were consumed, 10 minutes (2 blocks of `step_size`) will be billed. |

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
description](https://ocpi.dev)

:::

:::note

Take into account that using `step_size` can be confusing for Drivers and other people. There may be local or national
regulations that regulate `step_size`. For example in The Netherlands telecom companies are required to at least offer
one subscription which is paid per second. To prevent confusion by the customer, we recommend to keep the `step_size` as
small as possible and mention them clearly in your offering.

:::

#### Example Tariff

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

### ReservationRestrictionType *enum*

| Value               | Description                                                                                                                                                                         |
|---------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| RESERVATION         | Used in Tariff Elements to describe costs for a reservation.                                                                                                                        |
| RESERVATION_EXPIRES | Used in Tariff Elements to describe costs for a reservation that expires (i.e. driver does not start a charging session before [expiry_date](https://ocpi.dev) of the reservation). |

:::note

When a Tariff has both `RESERVATION` and `RESERVATION_EXPIRES` Tariff Elements, where both Tariff Elements have a
[TIME](https://ocpi.dev) Price Component, then the time based cost of an expired reservation will
be calculated based on the `RESERVATION_EXPIRES` Tariff Element.

:::

### TariffElement *class*

A Tariff Element is a group of Price Components that share a set of restrictions under which they apply.

That the Price Components share the same restrictions does not mean that at any time, they either all apply or all do
not apply. The reason is that applicable Price Components are looked up separately for each dimension, as described
under the [Tariff object](https://ocpi.dev). Therefore it is possible that a Price Component for one dimension
is found in a Tariff Element that occurs earlier in the list of Tariff Elements than for another dimension.

| Property         | Type                                   | Card. | Description                                                                                             |
|------------------|----------------------------------------|-------|---------------------------------------------------------------------------------------------------------|
| price_components | [PriceComponent](https://ocpi.dev)     | \+    | List of Price Components that each describe how a certain dimension is priced.                          |
| restrictions     | [TariffRestrictions](https://ocpi.dev) | ?     | Restrictions that describe under which circumstances the Price Components of this Tariff Element apply. |

### TariffDimensionType *enum*

| Value        | Description                                                                                                                                                                                         |
|--------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ENERGY       | Defined in kWh, `step_size` multiplier: 1 Wh                                                                                                                                                        |
| FLAT         | Flat fee without unit for `step_size`                                                                                                                                                               |
| PARKING_TIME | Time not charging: defined in hours, `step_size` multiplier: 1 second                                                                                                                               |
| TIME         | Time charging: defined in hours, `step_size` multiplier: 1 second Can also be used in combination with a [RESERVATION](https://ocpi.dev) restriction to describe the price of the reservation time. |

### TariffRestrictions *class*

A `TariffRestrictions` object describes if and when a Tariff Element becomes active or inactive during a Charging Session.

These restrictions are not to be interpreted as making the Tariff Element applicable or not applicable for the entire
Charging Session.

When more than one restriction is set, they are to be treated as a logical AND. So a Tariff Element is active if and
only if all of the properties in its `TariffRestrictions` match.

| Property     | Type                                           | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
|--------------|------------------------------------------------|-------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| start_time   | [string](https://ocpi.dev)(5)                  | ?     | Start time of day in local time, the time zone is defined in the `time_zone` field of the [Location](https://ocpi.dev), for example 13:30, valid from this time of the day. Must be in 24h format with leading zeros. Hour/Minute separator: ":" Regex: `([0-1][0-9]|2[0-3]):[0-5][0-9]`                                                                                                                                                                                                                                                                                                                         |
| end_time     | [string](https://ocpi.dev)(5)                  | ?     | End time of day in local time, the time zone is defined in the `time_zone` field of the [Location](https://ocpi.dev), for example 19:45, valid until this time of the day. Same syntax as `start_time`. If end_time \< start_time then the period wraps around to the next day. To stop at end of the day use: 00:00.                                                                                                                                                                                                                                                                                            |
| start_date   | [string](https://ocpi.dev)(10)                 | ?     | Start date in local time, the time zone is defined in the `time_zone` field of the [Location](https://ocpi.dev), for example: 2015-12-24, valid from this day (inclusive). Regex: `([12][0-9]{3})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])`                                                                                                                                                                                                                                                                                                                                                                      |
| end_date     | [string](https://ocpi.dev)(10)                 | ?     | End date in local time, the time zone is defined in the `time_zone` field of the [Location](https://ocpi.dev), for example: 2015-12-27, valid until this day (exclusive). Same syntax as `start_date`.                                                                                                                                                                                                                                                                                                                                                                                                           |
| min_kwh      | [number](https://ocpi.dev)                     | ?     | Minimum consumed energy in kWh, for example 20, valid from this amount of energy (inclusive) being used.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| max_kwh      | [number](https://ocpi.dev)                     | ?     | Maximum consumed energy in kWh, for example 50, valid until this amount of energy (exclusive) being used.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| min_current  | [number](https://ocpi.dev)                     | ?     | Sum of the minimum current (in Amperes) over all phases, for example 5. When the EV is charging with more than, or equal to, the defined amount of current, this TariffElement is/becomes active. If the charging current is or becomes lower, this TariffElement is not or no longer valid and becomes inactive. This describes NOT the minimum current over the entire Charging Session. This restriction can make a TariffElement become active when the charging current is above the defined value, but the TariffElement MUST no longer be active when the charging current drops below the defined value. |
| max_current  | [number](https://ocpi.dev)                     | ?     | Sum of the maximum current (in Amperes) over all phases, for example 20. When the EV is charging with less than the defined amount of current, this TariffElement becomes/is active. If the charging current is or becomes higher, this TariffElement is not or no longer valid and becomes inactive. This describes NOT the maximum current over the entire Charging Session. This restriction can make a TariffElement become active when the charging current is below this value, but the TariffElement MUST no longer be active when the charging current raises above the defined value.                   |
| min_power    | [number](https://ocpi.dev)                     | ?     | Minimum power in kW, for example 5. When the EV is charging with more than, or equal to, the defined amount of power, this TariffElement is/becomes active. If the charging power is or becomes lower, this TariffElement is not or no longer valid and becomes inactive. This describes NOT the minimum power over the entire Charging Session. This restriction can make a TariffElement become active when the charging power is above this value, but the TariffElement MUST no longer be active when the charging power drops below the defined value.                                                      |
| max_power    | [number](https://ocpi.dev)                     | ?     | Maximum power in kW, for example 20. When the EV is charging with less than the defined amount of power, this TariffElement becomes/is active. If the charging power is or becomes higher, this TariffElement is not or no longer valid and becomes inactive. This describes NOT the maximum power over the entire Charging Session. This restriction can make a TariffElement become active when the charging power is below this value, but the TariffElement MUST no longer be active when the charging power raises above the defined value.                                                                 |
| min_duration | int                                            | ?     | Minimum duration in seconds the Charging Session MUST last (inclusive). When the duration of a Charging Session is longer than the defined value, this TariffElement is or becomes active. Before that moment, this TariffElement is not yet active.                                                                                                                                                                                                                                                                                                                                                             |
| max_duration | int                                            | ?     | Maximum duration in seconds the Charging Session MUST last (exclusive). When the duration of a Charging Session is shorter than the defined value, this TariffElement is or becomes active. After that moment, this TariffElement is no longer active.                                                                                                                                                                                                                                                                                                                                                           |
| day_of_week  | [DayOfWeek](https://ocpi.dev)                  | \*    | Which day(s) of the week this TariffElement is active.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| reservation  | [ReservationRestrictionType](https://ocpi.dev) | ?     | When this field is present, the TariffElement describes reservation costs. A reservation starts when the reservation is made, and ends when the driver starts charging on the reserved EVSE/Location, or when the reservation expires. A reservation can only have: [FLAT](https://ocpi.dev) and [TIME](https://ocpi.dev) TariffDimensions, where `TIME` is for the duration of the reservation.                                                                                                                                                                                                                 |

#### Example: Tariff with max_power Tariff Restrictions

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

#### Example: Tariff with max_duration Tariff Restrictions

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

### TariffType *enum*

| Value          | Description                                                                                                                                                                                       |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| AD_HOC_PAYMENT | Used to describe that a Tariff is valid when ad-hoc payment is used at the Charge Point (for example: Debit or Credit card payment terminal).                                                     |
| PROFILE_CHEAP  | Used to describe that a Tariff is valid when [Charging Preference](https://ocpi.dev): [CHEAP](https://ocpi.dev) is set for the session.                                                           |
| PROFILE_FAST   | Used to describe that a Tariff is valid when [Charging Preference](https://ocpi.dev): [FAST](https://ocpi.dev) is set for the session.                                                            |
| PROFILE_GREEN  | Used to describe that a Tariff is valid when [Charging Preference](https://ocpi.dev): [GREEN](https://ocpi.dev) is set for the session.                                                           |
| REGULAR        | Used to describe that a Tariff is valid when using an RFID, without any Charging Preference, or when [Charging Preference](https://ocpi.dev): [REGULAR](https://ocpi.dev) is set for the session. |
