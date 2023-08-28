---
id: interfaces-and-endpoints
slug: interfaces-and-endpoints
---
# Interfaces and Endpoints

There are both, a Sender and a Receiver interface for CDRs. Depending on business requirements, parties can decide to
use the Sender Interface (Pull model), or the Receiver Interface (Push model), or both. Push is the preferred model to
use, because the Receiver will receive CDRs in semi-realtime when they are created by the CPO.

## Sender Interface

Typically implemented by market roles like: CPO.

The CDRs endpoint can be used to retrieve CDRs.

Endpoint structure definition:

`{cdr_endpoint_url}?[date_from={date_from}]&amp;[date_to={date_to}]&amp;[offset={offset}]&amp;[limit={limit}]`

Examples:

* `https://www.server.com/ocpi/cpo/2.2.1/cdrs/?date_from=2019-01-28T12:00:00&date_to=2019-01-29T12:00:00`
* `https://ocpi.server.com/2.2.1/cdrs/?offset=50`
* `https://www.server.com/ocpi/2.2.1/cdrs/?date_from=2019-01-29T12:00:00&limit=100`
* `https://www.server.com/ocpi/cpo/2.2.1/cdrs/?offset=50&limit=100`

| Method                                                                    | Description                                                                                                                                                                                                                               |
|---------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [GET](/ocpi/06-modules/05-cdrs/05-interfaces-and-endpoints.md#get-method) | Fetch CDRs last updated (which in the current version of OCPI can only be the creation Date/Time) between the `{date_from}` and `{date_to}` ([paginated](/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#pagination)). |
| POST                                                                      | n/a                                                                                                                                                                                                                                       |
| PUT                                                                       | n/a                                                                                                                                                                                                                                       |
| PATCH                                                                     | n/a                                                                                                                                                                                                                                       |
| DELETE                                                                    | n/a                                                                                                                                                                                                                                       |

### **GET** Method

Fetch CDRs from the CPO's system.

#### Request Parameters

If additional parameters: `{date_from}` and/or `{date_to}` are provided, only CDRs with `last_updated` between the given
`{date_from}` (including) and `{date_to}` (excluding) will be returned.

This request is [paginated](/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#pagination), it supports
the [pagination](/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#paginated-request) related URL
parameters.

| Parameter | Datatype                                             | Required | Description                                                                                    |
|-----------|------------------------------------------------------|----------|------------------------------------------------------------------------------------------------|
| date_from | [DateTime](/ocpi/07-types/01-intro.md#datetime-type) | no       | Only return CDRs that have `last_updated` after or equal to this Date/Time (inclusive).        |
| date_to   | [DateTime](/ocpi/07-types/01-intro.md#datetime-type) | no       | Only return CDRs that have `last_updated` up to this Date/Time, but not including (exclusive). |
| offset    | int                                                  | no       | The offset of the first object returned. Default is 0.                                         |
| limit     | int                                                  | no       | Maximum number of objects to GET.                                                              |

#### Response Data

The endpoint returns a list of CDRs matching the given parameters in the GET request, the header will contain the
[pagination](/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#paginated-response) related headers.

Any older information that is not specified in the response is considered no longer valid. Each object must contain all
required fields. Fields that are not specified may be considered as null values.

|                                                                     |       |               |
|---------------------------------------------------------------------|-------|---------------|
| Datatype                                                            | Card. | Description   |
| [CDR](/ocpi/06-modules/05-cdrs/06-object-description.md#cdr-object) | \*    | List of CDRs. |

## Receiver Interface

Typically implemented by market roles like: eMSP.

The CDRs endpoint can be used to create and retrieve CDRs.

| Method                                                                      | Description                   |
|-----------------------------------------------------------------------------|-------------------------------|
| [GET](/ocpi/06-modules/05-cdrs/05-interfaces-and-endpoints.md#get-method-1) | Retrieve an existing CDR.     |
| [POST](/ocpi/06-modules/05-cdrs/05-interfaces-and-endpoints.md#post-method) | Send a new CDR.               |
| PUT                                                                         | n/a (CDRs cannot be replaced) |
| PATCH                                                                       | n/a (CDRs cannot be updated)  |
| DELETE                                                                      | n/a (CDRs cannot be removed)  |

### GET Method

Fetch CDRs from the receivers system.

Endpoint structure definition:

No structure defined. This is open to the eMSP to define, the URL is provided to the CPO by the eMSP in the result of
the POST request. Therefore, OCPI does not define variables.

Example:

* `https://www.server.com/ocpi/2.2.1/cdrs/1234`

#### Response URL

To retrieve an existing URL from the eMSP's system, the URL, returned in the response to a POST of a new CDR, has to be
used.

#### Response Data

The endpoint returns the requested CDR, if it exists.

|                                                                     |       |                       |
|---------------------------------------------------------------------|-------|-----------------------|
| Datatype                                                            | Card. | Description           |
| [CDR](/ocpi/06-modules/05-cdrs/06-object-description.md#cdr-object) | 1     | Requested CDR object. |

### POST Method

Creates a new CDR.

The POST method should contain the full and final CDR object.

Endpoint structure definition:

`{cdr_endpoint_url}`

Example:

* `https://www.server.com/ocpi/2.2.1/cdrs/`

#### Request Body

In the POST request the new CDR object is sent.

| Type                                                                | Card. | Description     |
|---------------------------------------------------------------------|-------|-----------------|
| [CDR](/ocpi/06-modules/05-cdrs/06-object-description.md#cdr-object) | 1     | New CDR object. |

#### Response Headers

The response should contain the URL to the just created CDR object in the eMSP's system.

| HTTP Header | Datatype                                   | Required | Description                                                                                                        |
|-------------|--------------------------------------------|----------|--------------------------------------------------------------------------------------------------------------------|
| Location    | [URL](/ocpi/07-types/01-intro.md#url-type) | yes      | URL to the newly created CDR in the eMSP's system, can be used by the CPO system to perform a GET on the same CDR. |

The eMSP returns the URL where the newly created CDR can be found. OCPI does not define a specific structure for this
URL.

Example:

* `https://www.server.com/ocpi/emsp/2.2.1/cdrs/123456`
