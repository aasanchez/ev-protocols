---
id: interfaces
slug: interfaces
---
# Interfaces

There is both a Sender (Typically Hub) as a Receiver interface for ClientInfo. It is advised to use the Push direction
from Sender to connected clients during normal operation. The Hub interface is meant to be used when the connected
client is not 100% sure the ClientInfo cache is still correct.

## Receiver Interface

Typically implemented by all parties connecting to a Hub.

With this interface the Hub can push the ClientInfo information to a connected client (eMSP/CPO etc) Example endpoint
structure: `/ocpi/cpo/2.0/clientinfo/{country_code}/{party_id}`

| Method                                                               | Description                                                                                                           |
|----------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| [GET](/ocpi/06-modules/10-hubclientinfo/05-interfaces.md#get-method) | Retrieve a ClientInfo object as it is stored in the connected clients system.                                         |
| POST                                                                 | n/a                                                                                                                   |
| [PUT](/ocpi/06-modules/10-hubclientinfo/05-interfaces.md#put-method) | Push new/updated ClientInfo object to the connect client.                                                             |
| PATCH                                                                | n/a                                                                                                                   |
| DELETE                                                               | n/a, Use [PUT](/ocpi/06-modules/10-hubclientinfo/05-interfaces.md#put-method), ClientInfo objects cannot be removed). |

### **GET** Method

If the Hub wants to check the status of a ClientInfo object in the connected clients system it might GET the object from
the connected clients system for validation purposes. The Hub is the owner of the objects, so it would be illogical if
the connected client system had a different status or was missing an object.

#### Request Parameters

The following parameters shall be provided as URL segments.

| Parameter    | Datatype                                                | Required | Description                                                |
|--------------|---------------------------------------------------------|----------|------------------------------------------------------------|
| country_code | [CiString](/ocpi/07-types/01-intro.md#cistring-type)(2) | yes      | Country code of the requested ClientInfo object.           |
| party_id     | [CiString](/ocpi/07-types/01-intro.md#cistring-type)(3) | yes      | Party ID (Provider ID) of the requested ClientInfo object. |

#### Response Data

The response contains the requested object.

|                                                                                            |       |                                  |
|--------------------------------------------------------------------------------------------|-------|----------------------------------|
| Type                                                                                       | Card. | Description                      |
| [ClientInfo](/ocpi/06-modules/10-hubclientinfo/06-object-description.md#clientinfo-object) | 1     | The requested ClientInfo object. |

### **PUT** Method

New or updated ClientInfo objects are pushed from the Hub to a connected client.

#### Request Body

In the put request a the new or updated ClientInfo object is send.

|                                                                                            |       |                                   |
|--------------------------------------------------------------------------------------------|-------|-----------------------------------|
| Type                                                                                       | Card. | Description                       |
| [ClientInfo](/ocpi/06-modules/10-hubclientinfo/06-object-description.md#clientinfo-object) | 1     | New or updated ClientInfo object. |

#### Request Parameters

The following parameters shall be provided as URL segments.

|              |                                                         |          |                                                                                |
|--------------|---------------------------------------------------------|----------|--------------------------------------------------------------------------------|
| Parameter    | Datatype                                                | Required | Description                                                                    |
| country_code | [CiString](/ocpi/07-types/01-intro.md#cistring-type)(2) | yes      | Country code of the eMSP sending this PUT request to the CPO system.           |
| party_id     | [CiString](/ocpi/07-types/01-intro.md#cistring-type)(3) | yes      | Party ID (Provider ID) of the eMSP sending this PUT request to the CPO system. |

#### Example: put a new ClientInfo object

```json
PUT To URL: https://www.server.com/ocpi/cpo/2.0/clientinfo/NL/ALL

{
  "country_code": "NL",
  "party_id": "ALL",
  "role": "CPO",
  "status": "PLANNED",
}
```

## Sender Interface

Typically implemented by the Hub.

This interface enables Receivers to request the current list of ClientInfo objects from the Sender, when needed.

| Method                                                                 | Description |
|------------------------------------------------------------------------|-------------|
| [GET](/ocpi/06-modules/10-hubclientinfo/05-interfaces.md#get-method-1) |             |
| POST                                                                   | n/a         |
| PUT                                                                    | n/a         |
| PATCH                                                                  | n/a         |
| DELETE                                                                 | n/a         |

### **GET** Method

Fetch information about clients connected to a Hub.

Endpoint structure definition:

`{locations_endpoint_url}?[date_from={date_from}]&amp;[date_to={date_to}]&[offset={offset}]&[limit={limit}]`

Examples:

* `https://www.server.com/ocpi/cpo/2.2.1/hubclientinfo/?date_from=2019-01-28T12:00:00&date_to=2019-01-29T12:00:00`
* `https://ocpi.server.com/2.2.1/hubclientinfo/?offset=50`
* `https://www.server.com/ocpi/2.2.1/hubclientinfo/?date_from=2019-01-29T12:00:00&limit=100`
* `https://www.server.com/ocpi/cpo/2.2.1/hubclientinfo/?offset=50&limit=100`

### Request Parameters

If additional parameters: `{date_from}` and/or `{date_to}` are provided, only ClientInfo objects with (`last_updated`)
between the given `{date_from}` (including) and `{date_to}` (excluding) will be returned.

This request is [paginated](/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#pagination), it supports
the [pagination](/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#paginated-request) related URL
parameters.

| Parameter | Datatype                                             | Required | Description                                                                                          |
|-----------|------------------------------------------------------|----------|------------------------------------------------------------------------------------------------------|
| date_from | [DateTime](/ocpi/07-types/01-intro.md#datetime-type) | no       | Only return ClientInfo that have `last_updated` after or equal to this Date/Time (inclusive).        |
| date_to   | [DateTime](/ocpi/07-types/01-intro.md#datetime-type) | no       | Only return ClientInfo that have `last_updated` up to this Date/Time, but not including (exclusive). |
| offset    | int                                                  | no       | The offset of the first object returned. Default is 0.                                               |
| limit     | int                                                  | no       | Maximum number of objects to GET.                                                                    |

### Response Data

The endpoint response with list of valid ClientInfo objects, the header will contain the
[pagination](/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#paginated-response) related headers.

Any older information that is not specified in the response is considered as no longer valid. Each object must contain
all required fields. Fields that are not specified may be considered as null values.

|                                                                                            |       |                                               |
|--------------------------------------------------------------------------------------------|-------|-----------------------------------------------|
| Type                                                                                       | Card. | Description                                   |
| [ClientInfo](/ocpi/06-modules/10-hubclientinfo/06-object-description.md#clientinfo-object) | \*    | List of all (or matching) ClientInfo objects. |
