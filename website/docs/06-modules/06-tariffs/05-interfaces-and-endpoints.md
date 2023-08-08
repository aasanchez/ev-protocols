---
id: interfaces-and-endpoints
slug: /modules/tariffs/interfaces-and-endpoints
---
# Interfaces and Endpoints

There is both a Sender and a Receiver interface for Tariffs. Advised is to use the push direction from Sender to
Receiver during normal operation. The Sender interface is meant to be used when the connection between two parties is
established to retrieve the current list of Tariffs objects, and when the Receiver is not 100% sure the Tariff cache is
still up-to-date.

## Sender Interface

Typically implemented by market roles like: CPO.

The Sender's Tariffs interface gives the Receiver the ability to request Tariffs information.

| Method                  | Description                                                                                                                                                                         |
|-------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [GET](https://ocpi.dev) | Returns Tariff objects from the CPO, last updated between the `{date_from}` and `{date_to}` ([paginated](/04-transport-and-format/01-json-http-implementation-guide.md#pagination)) |
| POST                    | n/a                                                                                                                                                                                 |
| PUT                     | n/a                                                                                                                                                                                 |
| PATCH                   | n/a                                                                                                                                                                                 |
| DELETE                  | n/a                                                                                                                                                                                 |

### **GET** Method

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

This request is [paginated](/04-transport-and-format/01-json-http-implementation-guide.md#pagination), it supports the
[pagination](/04-transport-and-format/01-json-http-implementation-guide.md#paginated-request) related URL parameters.

| Parameter | Datatype                                        | Required | Description                                                                                       |
|-----------|-------------------------------------------------|----------|---------------------------------------------------------------------------------------------------|
| date_from | [DateTime](/07-types/01-intro.md#datetime-type) | no       | Only return Tariffs that have `last_updated` after or equal to this Date/Time (inclusive).        |
| date_to   | [DateTime](/07-types/01-intro.md#datetime-type) | no       | Only return Tariffs that have `last_updated` up to this Date/Time, but not including (exclusive). |
| offset    | int                                             | no       | The offset of the first object returned. Default is 0.                                            |
| limit     | int                                             | no       | Maximum number of objects to GET.                                                                 |

##### Response Data

The endpoint returns an object with a list of valid Tariffs, the header will contain the
[pagination](/04-transport-and-format/01-json-http-implementation-guide.md#paginated-response) related headers.

Any older information that is not specified in the response is considered no longer valid. Each object must contain all
required fields. Fields that are not specified may be considered as null values.

| Type                       | Card. | Description          |
|----------------------------|-------|----------------------|
| [Tariff](https://ocpi.dev) | \*    | List of all tariffs. |

## Receiver Interface

Typically implemented by market roles like: eMSP and NSP.

Tariffs are [Client Owned Objects](/04-transport-and-format/01-json-http-implementation-guide.md#client-owned-object-push), so the
endpoints need to contain the required extra fields: {[party_id](/06-modules/02-credentials/06-object-description.md#credentials-object)}
and {[country_code](/06-modules/02-credentials/06-object-description.md#credentials-object)}.

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

### **GET** Method

If the CPO wants to check the status of a Tariff in the eMSP's system, it might GET the object from the eMSP's system
for validation purposes. After all, the CPO is the owner of the object, so it would be illogical if the eMSP's system
had a different status or was missing the object entirely.

##### Request Parameters

The following parameters SHALL be provided as URL segments.

| Parameter    | Datatype                                            | Required | Description                                                                        |
|--------------|-----------------------------------------------------|----------|------------------------------------------------------------------------------------|
| country_code | [CiString](/07-types/01-intro.md#cistring-type)(2)  | yes      | Country code of the CPO performing the GET request on the eMSP's system.           |
| party_id     | [CiString](/07-types/01-intro.md#cistring-type)(3)  | yes      | Party ID (Provider ID) of the CPO performing the GET request on the eMSP's system. |
| tariff_id    | [CiString](/07-types/01-intro.md#cistring-type)(36) | yes      | Tariff.id of the Tariff object to retrieve.                                        |

##### Response Data

The response contains the requested object.

| Type                       | Card. | Description                  |
|----------------------------|-------|------------------------------|
| [Tariff](https://ocpi.dev) | 1     | The requested Tariff object. |

### **PUT** Method

New or updated Tariff objects are pushed from the CPO to the eMSP.

##### Request Body

In the PUT request, the new or updated Tariff object is sent in the body.

| Type                       | Card. | Description                   |
|----------------------------|-------|-------------------------------|
| [Tariff](https://ocpi.dev) | 1     | New or updated Tariff object. |

##### Request Parameters

The following parameters SHALL be provided as URL segments.

| Parameter    | Datatype                                            | Required | Description                                                                                                                                                          |
|--------------|-----------------------------------------------------|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code | [CiString](/07-types/01-intro.md#cistring-type)(2)  | yes      | Country code of the CPO performing the PUT request on the eMSP's system. This SHALL be the same value as the `country_code` in the Tariff object being pushed.       |
| party_id     | [CiString](/07-types/01-intro.md#cistring-type)(3)  | yes      | Party ID (Provider ID) of the CPO performing the PUT request on the eMSP's system. This SHALL be the same value as the `party_id` in the Tariff object being pushed. |
| tariff_id    | [CiString](/07-types/01-intro.md#cistring-type)(36) | yes      | Tariff.id of the Tariff object to create or replace.                                                                                                                 |

##### Example: New Tariff € 2 per hour charging time (not parking)

```json
PUT To URL: https://www.server.com/ocpi/emsp/2.2.1/tariffs/NL/TNM/12

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

### **DELETE** Method

Delete a Tariff object which is not used any more and will not be used in the future.

:::note
Before deleting a Tariff object, it is RECOMMENDED to ensure that the Tariff object is not referenced by any [Connector
object](/06-modules/03-locations/06-object-description.md#connector-object) within the `tariff_ids`.
:::

##### Request Parameters

The following parameters SHALL be provided as URL segments.

| Parameter    | Datatype                                            | Required | Description                                                                        |
|--------------|-----------------------------------------------------|----------|------------------------------------------------------------------------------------|
| country_code | [CiString](/07-types/01-intro.md#cistring-type)(2)  | yes      | Country code of the CPO performing the PUT request on the eMSP's system.           |
| party_id     | [CiString](/07-types/01-intro.md#cistring-type)(3)  | yes      | Party ID (Provider ID) of the CPO performing the PUT request on the eMSP's system. |
| tariff_id    | [CiString](/07-types/01-intro.md#cistring-type)(36) | yes      | Tariff.id of the Tariff object to delete.                                          |
