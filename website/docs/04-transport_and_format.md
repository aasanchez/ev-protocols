---
slug: transport-and-format
---
# Transport and format

## JSON / HTTP implementation guide

The OCPI protocol is based on HTTP and uses the JSON format. It follows a RESTful architecture for web services where
possible.

### Security and authentication

The interfaces are protected on the HTTP transport level, with SSL and token-based authentication. Please note that this
mechanism does **not** require client-side certificates for authentication, only server-side certificates to set up a
secure SSL connection.

### Authorization header

Every OCPI HTTP request MUST add an *Authorization* header. The header looks as follows:

```text
Authorization: Token ZWJmM2IzOTktNzc5Zi00NDk3LTliOWQtYWM2YWQzY2M0NGQyCg==
```

:::note

HTTP header names are case-insensitive

:::

The literal *Token* indicates that the token-based authentication mechanism is used, in OCPI this is called the
*credentials token*. [*Credentials tokens*](https://ocpi.dev) are exchanged via the
[credentials module](https://ocpi.dev). These are different *tokens* than the
[Tokens](https://ocpi.dev) exchanged via the [Token
Module](https://ocpi.dev): Tokens used by drivers to authorize charging. To prevent
confusion, when talking about the token used here in the HTTP Authorization header, call them: *Credentials Tokens*.

After the literal *Token*, there SHALL be one space, followed by the *encoded token*. The encoded token is obtained by
encoding the credentials token to an octet sequence with UTF-8 and then encoding that octet sequence with Base64
according to [RFC 4648](https://datatracker.ietf.org/doc/html/rfc4648#section-4).

So for example, to use the credentials token *example-token* in an OCPI request, one should include this header:

```text
Authorization: Token ZXhhbXBsZS10b2tlbgo=
```

:::note

Many OCPI 2.1.1 and 2.2 implementations do not Base64 encode the credentials token when including it in the
*Authorization* header. Since OCPI 2.2-d2 the OCPI specification documents clearly require Base64 encoding the
credentials token in the header value. Implementations that wish to be compatible with non-encoding 2.1.1 and 2.2
implementations have to choose the right way to parse and write authorization headers by either trial and error or
configuration flags.

:::

The credentials token must uniquely identify the requesting party. This way, the server can use the information in the
Authorization header to link the request to the correct requesting party's account.

If the header is missing or the credentials token doesn't match any known party then the server SHALL respond with an
HTTP `401 * Unauthorized` status code.

When a server receives a request with a valid [`CREDENTIALS_TOKEN_A`](https://ocpi.dev),
on another module than: [`credentials`](https://ocpi.dev) or
[`versions`](https://ocpi.dev), the server SHALL respond with an HTTP
`401 * Unauthorized` status code.

### Pull and Push

OCPI supports both **Pull** and **Push** models.

* **Push:** Changes in objects and new objects are sent (semi) real-time to the receiver.

* **Pull:** Receiver request a (full) list of objects periodically.

OCPI doesn't require parties to implement Push. Pull is required, a receiver needs to be able to get *in-sync* after a
period of connection loss.

It is possible to implement a Pull only OCPI implementation, it might be a good starting point for an OCPI
implementation. However, it is strongly advised to implement Push for production systems that have to handle some load,
especially when several clients are requesting long lists frequently. Push implementations tend to use fewer resources.
It is therefore advised to clients *pulling* lists from a server to do this on a relative low polling interval: think in
hours, not minutes, and to introduce some splay (randomize the length of the poll interface a bit).

### Request format

The request method can be any of [GET](https://ocpi.dev), POST, [PUT](https://ocpi.dev),
[PATCH](https://ocpi.dev) or DELETE. The OCPI protocol uses them in a way similar to REST APIs.

| Method                    | Description                                        |
|---------------------------|----------------------------------------------------|
| [GET](https://ocpi.dev)   | Fetches objects or information.                    |
| POST                      | Creates new objects or information.                |
| [PUT](https://ocpi.dev)   | Updates existing objects or information.           |
| [PATCH](https://ocpi.dev) | Partially updates existing objects or information. |
| DELETE                    | Removes existing objects or information.           |

The HTTP header: Content-Type SHALL be set to `application/json` for any request that contains a message body: POST, PUT
and PATCH. When no body is present, probably in a GET or DELETE, then the Content-Type header MAY be omitted.

#### GET

A server is not required to return all objects to a client, the server might for example not send all CDRs to a client,
because some CDRs do not belong to this client.

When a client receives objects from the server that contain invalid JSON or invalid OCPI objects (For example: missing
fields), the client has no way of letting this know to the server. It is advised to log these errors and contact the
server administrator about this. When a list of objects contains some objects that are correct and some with *problems*
the client should at least process the correct OCPI objects.

##### Pagination

All GET methods that return a list of objects have pagination, this allows a client and server to control the number of
objects returned in the response to a GET request, while still enabling the client to retrieve all objects by doing
multiple requests with different parameters. Without pagination, the server has to return all objects in one response
that could potentially contain millions of objects.

To enable pagination of the returned list of objects, additional URL parameters are allowed for the GET request and
additional headers need to be added to the response.

##### Paginated Request

The following table lists all the parameters that have to be supported but might be omitted by a client request.

| Parameter | Datatype                     | Description                                                                                                                                                                                                                                             |
|-----------|------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| date_from | [DateTime](https://ocpi.dev) | Only return objects that have `last_updated` after or equal to this Date/Time (inclusive).                                                                                                                                                              |
| date_to   | [DateTime](https://ocpi.dev) | Only return objects that have `last_updated` up to this Date/Time, but not including (exclusive).                                                                                                                                                       |
| offset    | int                          | The offset of the first object returned. Default is 0 (the first object).                                                                                                                                                                               |
| limit     | int                          | The maximum number of objects to GET. The server might decide to return fewer objects, either because there are no more objects, or the server limits the maximum number of objects to return. This is to prevent, for example, overloading the system. |

The `date_from` is inclusive and `date_to` exclusive, this way, when sequential requests with to the same end-point are
done, the next interval will have no overlap and the `date_from` of the next interval is simply the `date_to` of the
previous interval.

Example: With offset=0 and limit=10 the server shall return the first 10 records (if 10 objects match the request). Then
the next page starts with offset=10.

##### Paginated Response

For pagination to work correctly, it is important that multiple calls to the same URL (including query parameters):
result in the same objects being returned by the server. For this to be the case, the sequence of objects mustn't
change, or as little as possible. It is best practice to return the oldest objects first, that is, order the objects by
creation date ascending. While a client crawls over the pages (multiple GET requests every time to the *next* page
Link), a new object might be created on the server. The client detects this: the `X-Total-Count` will be higher on the
next call. Even so, the client does not have to retry any requests when this happens because only the last page will be
different. This means the client will not be required to crawl all pages all over again. When the client has reached to
last page it has retrieved all relevant pages and is up to date.

:::note

Some query parameters can cause concurrency problems. For example the `date_to` query parameter. When there are for
example 1000 objects matching a query for all objects with `date_to` before 2016-01-01. While crawling over the pages
one of these objects is updated. The client detects this: `X-Total-Count` will be lower in the next request. It is
advised to redo the previous GET with the `offset` lowered by 1 (if the `offset` was not 0) and after that continue
crawling the *next* page links.

:::

HTTP headers that have to be added to any paginated GET response.

| HTTP Header   | Datatype | Description                                                                                                                                                                                                                                                                                                                                                                                         |
|---------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Link          | String   | Link to the *next* page should be provided when this is NOT the last page. The Link should also contain any filters present in the original request. See the examples below.                                                                                                                                                                                                                        |
| X-Total-Count | int      | (Custom HTTP Header) The total number of objects available in the server system that match the given query (including the given query parameters, for example: `date_to` and `date_from` but excluding `limit` and `offset`) and that are available to this client. For example: The CPO server might return less CDR objects to an eMSP than the total number of CDRs available in the CPO system. |
| X-Limit       | int      | (Custom HTTP Header) The maximum number of objects that the server can return. Note that this is an upper limit. If there are not enough remaining objects to return, fewer objects than this upper limit number will be returned, X-Limit SHALL then still show the upper limit, not the number of objects returned.                                                                               |

:::note

HTTP header names are case-insensitive

:::

##### Pagination Examples

Example of a required OCPI pagination link header:

```text
Link: <https://www.server.com/ocpi/cpo/2.2.1/cdrs/?offset=150&limit=50>; rel="next"
```

After the client has called the given "next" page URL above the Link parameter will most likely look like this:

```text
Link: <https://www.server.com/ocpi/cpo/2.2.1/cdrs/?offset=200&limit=50>; rel="next"
```

Example of a query with filters: Client does a GET to:

```text
https://www.server.com/ocpi/cpo/2.2.1/cdrs/?date_from=2016-01-01T00:00:00Z&date_to=2016-12-31T23:59:59Z
```

The server should return (when the server has enough objects and the limit is the amount of objects the server wants to
send is 100.) *(This example should have been on 1 line, but didn't fit the paper width.)*

```text
Link: <https://www.server.com/ocpi/cpo/2.2.1/cdrs/?offset=100&limit=100&date_from=2016-01-01T00:00:00Z&date_to=2016-12-31T23:59:59Z>; rel="next"
```

Example of a server limiting the amount of objects returned: Client does a GET to:

```text
https://www.server.com/ocpi/cpo/2.2.1/cdrs/?limit=2000
```

The server should return (when the server has enough objects and the limit is the amount of objects the server wants to
send is 100.) The `X-Limit` HTTP header should be set to 100 as well.

```text
Link: <https://www.server.com/ocpi/cpo/2.2.1/cdrs/?offset=100&limit=100>; rel="next"
```

#### PUT

A PUT request must specify all required fields of an object (similar to a POST request). Optional fields that are not
included will revert to their default value which is either specified in the protocol or NULL.

#### PATCH

A PATCH request must only specify the object's identifier (if needed to identify this object) and the fields to be
updated. Any fields (both required or optional) that are left out remain unchanged.

The MIME-type of the request body is: `application/json` and may contain the data as documented for each endpoint.

In case a PATCH request fails, the client is expected to call the [GET](https://ocpi.dev) method to check the
state of the object in the other party's system. If the object doesn't exist, the client should do a
[PUT](https://ocpi.dev).

### Client Owned Object Push

Normal client/server RESTful services work in a way where the Server is the owner of the objects that are created. The
client requests a POST method with an object to the end-point URL. The response sent by the server will contain the URL
to the new object. The client will request only one server to create a new object, not multiple servers.

Many OCPI modules work differently: the client is the owner of the object and only pushes the information to one or more
servers for information sharing purposes. For example the CPO owns the Tariff objects and pushes them to a couple of
eMSPs, so each eMSP gains knowledge of the tariffs that the CPO will charge them for their customers' sessions. eMSP
might receive Tariff objects from multiple CPOs. They need to be able to make a distinction between the different
tariffs from different CPOs.

The distinction between objects from different CPOs/eMSPs is made based on a
{[country_code](https://ocpi.dev)} and
{[party_id](https://ocpi.dev)}. The
[country_code's](https://ocpi.dev) and
[party_id's](https://ocpi.dev) of the parties on the other platform are received
during the [credentials](https://ocpi.dev) handshake in the
[CredentialsRoles](https://ocpi.dev). The roles exchanged during the
[credentials](https://ocpi.dev) handshake provide the server with details needed
to determine which URLs a client might use.

Client Owned Object URL definition: `{base-ocpi-url}/{end-point}/{country-code}/{party-id}/{object-id}`

Example of a URL to a Client Owned Object

```text
https://www.server.com/ocpi/cpo/2.2.1/tariffs/NL/TNM/14
```

POST is not supported for these kinds of modules. PUT is used to send new objects to the servers.

To identify the owner of data, the party generating the information that is provided to other parties via OCPI, a *Data
owner* is provided at the beginning of every module that has a clear owner.

#### Errors

When a client tries to access an object with a URL that has a different
[country_code](https://ocpi.dev) and/or
[party_id](https://ocpi.dev) than one of the
[CredentialsRoles](https://ocpi.dev) given during the
[credentials](https://ocpi.dev) handshake, it is allowed to respond with an HTTP
`404` status code, this way blocking client access to objects that do not belong to them.

When a client pushes a Client Owned Object, but the `object-id` in the URL is different from the id in the object being
pushed, server implementations are advised to return an [OCPI status
code](https://ocpi.dev): [2001](https://ocpi.dev).

### Client Owned Object Pull

When doing a GET on the Sender interface of a module, the owner of an object can be determined by looking at the
{[country_code](https://ocpi.dev)} and
{[party_id](https://ocpi.dev)} in the object itself.

When one or more objects, returned in the response, do not meet one of the
[CredentialsRoles](https://ocpi.dev) given during the
[credentials](https://ocpi.dev) handshake, these objects may be ignored.

### Response format

The content that is sent with all the response messages is an *application/json* type and contains a JSON object with
the following properties:

| Property       | Type                         | Card.   | Description                                                                                                                                                                                           |
|----------------|------------------------------|---------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| data           | Array or Object or String    | \* or ? | Contains the actual response data object or list of objects from each request, depending on the cardinality of the response data, this is an array (card. \* or +), or a single object (card. 1 or ?) |
| status_code    | int                          | 1       | OCPI status code, as listed in [Status Codes](https://ocpi.dev), indicates how the request was handled. To avoid confusion with HTTP codes, OCPI status codes consist of four digits.                 |
| status_message | [string](https://ocpi.dev)   | ?       | An optional status message which may help when debugging.                                                                                                                                             |
| timestamp      | [DateTime](https://ocpi.dev) | 1       | The time this message was generated.                                                                                                                                                                  |

For brevity's sake, any further examples used in this specification will only contain the value of the "data" field. In
reality, it will always have to be wrapped in the above response format.

When a request cannot be accepted, the type response depends on the type of error. For more information see: [Status
codes](https://ocpi.dev)

For errors on the HTTP layer, use HTTP error response codes, including the response format above, that contains more
details. HTTP status codes are described on [w3.org](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html).

:::note

Earlier versions of the OCPI 2.2.1 did not clearly specify what should be in the `data` field of the response format for
every request. We advise that in cases where the specification does not explicitly specify what to put in the `data`
field for the response to a certain request, the platform receiving the response accept both the `data` field being
absent and the data field being present with any possible value. We also advise that in such cases, platform sending the
response leave the `data` field unset in the response format. This applies for example to PUT requests when pushing
Session objects, and PATCH requests to add charging periods to Sessions.

:::

* **Example:** Version information response (list of objects)

```json
{
  "data": [
    {
      "version": "2.1.1",
      "url": "https://example.com/ocpi/cpo/2.1.1"
    },
    {
      "version": "2.2",
      "url": "https://example.com/ocpi/cpo/2.2"
    }
  ],
  "status_code": 1000,
  "status_message": "Success",
  "timestamp": "2015-06-30T21:59:59Z"
}
```

* **Example:** Version details response (one object)

```json
{
  "data": {
    "version": "2.2",
    "endpoints": [
      {
        "identifier": "credentials",
        "role": "SENDER",
        "url": "https://example.com/ocpi/cpo/2.2/credentials"
      },
      {
        "identifier": "locations",
        "role": "SENDER",
        "url": "https://example.com/ocpi/cpo/2.2/locations"
      }
    ]
  },
  "status_code": 1000,
  "status_message": "Success",
  "timestamp": "2015-06-30T21:59:59Z"
}
```

* **Example:** Tokens GET Response with one Token object. (CPO end-point) (one object)

```json
{
  "data": {
    "country_code": "DE",
    "party_id": "TNM",
    "uid": "012345678",
    "type": "RFID",
    "contract_id": "FA54320",
    "visual_number": "DF000-2001-8999",
    "issuer": "TheNewMotion",
    "valid": true,
    "whitelist": "ALLOWED",
    "last_updated": "2015-06-29T22:39:09Z"
  },
  "status_code": 1000,
  "status_message": "Success",
  "timestamp": "2015-06-30T21:59:59Z"
}
```

* **Example:** Tokens GET Response with list of Token objects. (eMSP end-point) (list of objects)

```json
{
  "data": [
    {
      "country_code": "NL",
      "party_id": "TNM",
      "uid": "100012",
      "type": "RFID",
      "contract_id": "FA54320",
      "visual_number": "DF000-2001-8999",
      "issuer": "TheNewMotion",
      "valid": true,
      "whitelist": "ALWAYS",
      "last_updated": "2015-06-21T22:39:05Z"
    },
    {
      "country_code": "NL",
      "party_id": "TNM",
      "uid": "100013",
      "type": "RFID",
      "contract_id": "FA543A5",
      "visual_number": "DF000-2001-9000",
      "issuer": "TheNewMotion",
      "valid": true,
      "whitelist": "ALLOWED",
      "last_updated": "2015-06-28T11:21:09Z"
    },
    {
      "country_code": "NL",
      "party_id": "TNM",
      "uid": "100014",
      "type": "RFID",
      "contract_id": "FA543BB",
      "visual_number": "DF000-2001-9010",
      "issuer": "TheNewMotion",
      "valid": false,
      "whitelist": "ALLOWED",
      "last_updated": "2015-05-29T10:12:26Z"
    }
  ],
  "status_code": 1000,
  "status_message": "Success",
  "timestamp": "2015-06-30T21:59:59Z"
}
```

* **Example:** Response with an error (contains no data field)

```json
{
  "status_code": 2001,
  "status_message": "Missing required field: type",
  "timestamp": "2015-06-30T21:59:59Z"
}
```

### Message Routing

When the development of OCPI was started, it was designed for peer-to-peer communication between CPO and eMSP. This has
advantages, but also disadvantages. Having to set up and maintain OCPI connections to a lot of parties requires more
effort than doing it for only a couple of connections. By communication via one or more Hubs, the amount of OCPI
connections is reduced, while still being able to offer roaming to a lot of different parties and customers.

With the introduction of Message Routing, OCPI is now better usable for communication via Hubs.

All examples/sequence diagrams in this section use the roles CPO and eMSP as examples, they could be switched, it could
be other roles.

#### Platforms

With Message Routing functionality it also becomes possible to support Platforms that host multiple roles. A lot of
parties are not only CPO or eMSP. Most are both CPO and eMSP. Some parties are doing business in multiple countries,
which means to operate with different `country_codes` Some parties have a platform on which the host service for other
CPOs/eMSPs. Some parties are themselves CPO and host CPO services for others, but other parties are (themselves) not a
CPO or other role in the EV charging landscape but do provide service to CPOs/eMSPs, etc.

#### Message Routing Headers

When OCPI is used to communicate to/from a Platform or via a Hub (which is the most common usage of OCPI, only exception
is a peer-to-peer connection between two parties that both have only one OCPI party and role implemented.) the following
four HTTP headers are to be added to any request/response to allow messages to be routed.

When implementing OCPI these four headers SHALL be implemented for any request/response to/from a Functional Module.
This does not mean they have to be present in all request. There are situation/special request where some headers can or
shall be omitted, See: [Open Routing Request](https://ocpi.dev)

Only requests/responses from Function Modules: such as: [Tokens](https://ocpi.dev),
[Locations](https://ocpi.dev), [CDRs](https://ocpi.dev)
etc. SHALL be routed, so need the routing headers.

The requests/responses to/from Configuration Modules:
[Credentials](https://ocpi.dev),
[Versions](https://ocpi.dev) and [Hub Client
Info](https://ocpi.dev) are not to be routed, and are for Platform-to-Platform
or Platform-to-Hub communication. Thus routing headers SHALL NOT be used with these modules.

| HTTP Header            | Datatype                        | Description                                                          |
|------------------------|---------------------------------|----------------------------------------------------------------------|
| OCPI-to-party-id       | [CiString](https://ocpi.dev)(3) | *party id* of the connected party this message is to be sent to.     |
| OCPI-to-country-code   | [CiString](https://ocpi.dev)(2) | *country code* of the connected party this message is to be sent to. |
| OCPI-from-party-id     | [CiString](https://ocpi.dev)(3) | *party id* of the connected party this message is sent from.         |
| OCPI-from-country-code | [CiString](https://ocpi.dev)(2) | *country code* of the connected party this message is sent from.     |

:::note

HTTP header names are case-insensitive

:::

![OCPI Sequence Diagram Hub GET](./images/sd_get_simple.svg)

![OCPI Sequence Diagram Hub PUT with 2 Hubs](./images/sd_put_2_hubs.svg)

#### Broadcast Push

For simplicity, connected clients might push (POST, PUT, PATCH) information to all connected clients with an "opposite
role", for example: CPO pushing information to all eMSPs and NSPs, eMSP pushing information to all CPOs. (The role
"Other" is seen as an eMSP type of role, so Broadcast Push from a CPO is also sent to "Other". Messages from "Other" are
only sent to CPOs and not to eMSPs though.)

When using Broadcast Push, the Hub broadcasts received information to all connected clients. To send data through a Hub
might be very useful to share information like Locations or Tokens with all parties connected to the Hub that have
implemented the corresponding module. This means only one request to the Hub will be necessary, as all connected clients
will be served by the Hub.

To send a Broadcast Push, the client uses the party-id and country-code of the Hub in the *OCPI-to-* headers. The Hub
parses the request and sends a response to the client, which optionally contains its own party-id and country-code in
the *OCPI-from-* headers. The Hub then sends the pushed data to any client implementing the corresponding applicable
module, using its own party-id and country-code in the *OCPI-from-* headers. The client receiving a Push from a Hub
(with the Hubs information in the *OCPI-from-* headers) will respond to this Push with the Hubs party-id and
country-code in the *OCPI-to-* headers.

GET SHALL NOT be used in combination with Broadcast Push. If the requesting party wants to GET information of which it
does not know the receiving party, an [Open Routing Request](https://ocpi.dev)
MUST be used. (see below)

Broadcast Push SHALL only be used with information that is meant to be sent to all other parties. It is useful to share
data like [Tokens](https://ocpi.dev) and
[Locations](https://ocpi.dev), but not so much for
[CDRs](https://ocpi.dev) and [Sessions](https://ocpi.dev) as
these pieces of information are specific to only one party and are possibly even protected by GDPR or other laws.

:::note

For "Client Owned Objects", the party-id and country-code in the URL segments will still be the original party-id and
country-code from the original client sending the Broadcast Push to the Hub.

:::

![OCPI Sequence Diagram of a Broadcast Push from a CPO to multiple eMSPs](./images/sd_put_boardcast.svg)

#### Open Routing Request

When a Hub has the intelligence to route messages based on the content of the request, or the requesting party does not
know the destination of a request, the *OCPI-to-* headers can be omitted in the request towards the Hub. The Hub can
then decide to which party a request needs to be routed, or that it needs to be broadcasted if the destination cannot be
determined.

This has nothing to do with [Broadcast Push](https://ocpi.dev) though, as [Broadcast
Push](https://ocpi.dev) only works for the [Push
model](https://ocpi.dev), not for [GET](https://ocpi.dev) requests.

Open Routing Requests are possible for GET ([Not GET ALL](https://ocpi.dev)), POST, PUT, PATCH and
DELETE.

![Example sequence diagram of a open routing GET from a CPO via the Hub](./images/sd_get_openrouting.svg)

#### GET All via Hubs

A client (Receiver) can request a GET on the Sender interface of a module implemented by a Hub. To request a GET All
from a Hub, the client uses the party-id and country-code of the Hub in the *OCPI-to-* headers, and calls the GET method
on the Sender interface of a module.

The Hub can then combine objects from different connected parties and return them to the client.

The client can determine the owner of the objects by looking at the `county_code` and `party_id` in the individual
objects returned by the hub.

![OCPI Sequence Diagram of a GET All via the Hub.](./images/sd_get_all.svg)

#### Overview of required/optional routing headers for different scenarios

The following section shows which headers are required/optional and which *OCPI-to-*/*OCPI-from-* IDs need to be used.

This is not an exclusive list, combinations are possible.

##### Party to Party (without Hub)

This table contains the description of which headers are required to be used for which message when a request is sent
directly from one platform provider to another platform provider, without a Hub in between. The headers are addressing
the parties to/from which the message is sent, not the platform itself.

| Name            | Route                                                       | TO Headers       | FROM Headers     |
|-----------------|-------------------------------------------------------------|------------------|------------------|
| Direct request  | Requesting platform provider to Receiving platform provider | Receiving-party  | Requesting-party |
| Direct response | Receiving platform provider to Requesting platform provider | Requesting-party | Receiving-party  |

![Example sequence diagram of a GET for 1 Object from a CPO on one platform to an MSP on another platform directly (without a Hub)](./images/sd_platform_to_platform_direct.svg)

##### Party to Party via Hub

This table contains the description of which headers are required to be used for which message when a request is routed
from one platform to another platform via a Hub.

| Name            | Route                      | TO Headers       | FROM Headers     |
|-----------------|----------------------------|------------------|------------------|
| Direct request  | Requesting platform to Hub | Receiving-party  | Requesting-party |
| Direct request  | Hub to receiving platform  | Receiving-party  | Requesting-party |
| Direct response | Receiving platform to Hub  | Requesting-party | Receiving-party  |
| Direct response | Hub to requesting platform | Requesting-party | Receiving-party  |

![Example sequence diagram of a GET for 1 Object from one Platform to another Platform via a Hub](./images/sd_platform_hub_platform.svg)

##### Party to Party Broadcast Push

This table contains the description of which headers are required to be used for which message when a request is a
[Broadcast Push](https://ocpi.dev) to the Hub.

| Name               | Route                      | TO Headers       | FROM Headers     |
|--------------------|----------------------------|------------------|------------------|
| Broadcast request  | Requesting platform to Hub | Hub              | Requesting-party |
| Broadcast response | Hub to requesting platform | Requesting-party | Hub              |
| Broadcast request  | Hub to receiving platform  | Receiving-party  | Hub              |
| Broadcast response | Receiving platform to Hub  | Hub              | Receiving-party  |

![Example sequence diagram of Broadcast Push from one Platform to another Platform via a Hub](./images/sd_platform_hub_platform_broadcast.svg)

##### Party to Party Open Routing Request

This table contains the description of which headers are required to be used for which message when [the routing of a
request needs to be determined by the Hub itself](https://ocpi.dev). For an
Open Routing Request, the TO headers in the request from the requesting party to the Hub MUST be omitted.

| Name          | Route                      | TO Headers       | FROM Headers     |
|---------------|----------------------------|------------------|------------------|
| Open request  | Requesting platform to Hub |                  | Requesting-party |
| Open request  | Hub to receiving platform  | Receiving-party  | Requesting-party |
| Open response | Receiving platform to Hub  | Requesting-party | Receiving-party  |
| Open response | Hub to requesting platform | Requesting-party | Receiving-party  |

![Example sequence diagram of a open routing between platforms GET from a CPO via the Hub](./images/sd_get_openrouting_platform.svg)

#### GET All via Hubs

This table contains the description of which headers are required to be used when doing a [GET All via a
Hub](https://ocpi.dev). For a GET All via Hub: The HTTP Method SHALL be GET, The call is to a
Senders Interface, the TO headers in the request to the Hub has to be set to the Hub.

| Name                      | Route                      | TO Headers       | FROM Headers     |
|---------------------------|----------------------------|------------------|------------------|
| GET All via Hubs request  | Requesting platform to Hub | Hub              | Requesting-party |
| GET All via Hubs response | Hub to receiving platform  | Requesting-party | Hub              |

![OCPI Sequence Diagram of a GET All via the Hub](./images/sd_get_all_platform.svg)

#### Timestamps and Objects send via Hubs

When OCPI Objects are sent via Hubs, the `last_updated` fields SHALL NOT be updated by the Hub.

### No data available

There are rare situation, probably use cases not foreseen by the team developing OCPI, where a certain field, that is
required, cannot be filled. In such cases, and only in such cases, it is allowed to set a string field to the value:
`#NA`.

`#NA` is not allowed to be used when a party does not have or want to provide the data, but is able to provide the data
when they would spend time/resources to get/provide the data.

## Unique message IDs

For debugging issues, OCPI implementations are required to include unique IDs via HTTP headers in every
request/response.

| HTTP Header      | Description                                                                                                             |
|------------------|-------------------------------------------------------------------------------------------------------------------------|
| X-Request-ID     | Every request SHALL contain a unique request ID, the response to this request SHALL contain the same ID.                |
| X-Correlation-ID | Every request/response SHALL contain a unique correlation ID, every response to this request SHALL contain the same ID. |

:::note

HTTP header names are case-insensitive

:::

It is advised to used GUID/UUID as values for X-Request-ID and X-Correlation-ID.

When a Hub forwards a request to a party, the request to this party SHALL contain a new unique value in the X-Request-ID
HTTP header, not a copy of the X-Request-ID HTTP header taken from the incoming request that is being forwarded.

When a Hub forwards a request to a party, the request SHALL contain the same X-Correlation-ID HTTP header (with the same
value).

![Example sequence diagram of the uses of X-Request-ID and X-Correlation-ID in a peer-to-peer topology.](./images/unqiue_ids_pair2pair.svg)

![Example sequence diagram of the uses of X-Request-ID and X-Correlation-ID in a topology with a Hub.](./images/unqiue_ids_via_hub.svg)

## Interface endpoints

As OCPI contains multiple interfaces. Different endpoints are available for messaging. The protocol is designed such
that the exact URLs of the endpoints can be defined by each party. It also supports an interface per version.

The locations of all the version-specific endpoints can be retrieved by fetching the API information from the versions
endpoint. Each version-specific endpoint will then list the available endpoints for that version. It is strongly
recommended to insert the protocol version into the URL.

For example: `/ocpi/cpo/2.2.1/locations` and `/ocpi/emsp/2.2.1/locations`.

The URLs of the endpoints in this document are descriptive only. The exact URL can be found by fetching the endpoint
information from the API info endpoint and looking up the identifier of the endpoint.

| Operator interface        | Identifier  | Example URL                                      |
|---------------------------|-------------|--------------------------------------------------|
| Credentials               | credentials | `https://example.com/ocpi/cpo/2.2.1/credentials` |
| Charging location details | locations   | `https://example.com/ocpi/cpo/2.2.1/locations`   |

| eMSP interface            | Identifier  | Example URL                                       |
|---------------------------|-------------|---------------------------------------------------|
| Credentials               | credentials | `https://example.com/ocpi/emsp/2.2.1/credentials` |
| Charging location updates | locations   | `https://example.com/ocpi/emsp/2.2.1/locations`   |

## Offline behaviour

During communication over OCPI, one of the communicating parties might be unreachable for an undefined amount of time.
OCPI works event-based, new messages and status are pushed from one party to another. When communication is lost,
updates cannot be delivered.

OCPI messages SHOULD NOT be queued. When a client does a POST, PUT or PATCH request and that request fails or times out,
the client should not queue the message and retry the same message again later.

When the connection is re-established, it is up to the target-server of a connection to GET the current status from to
source-server to get back to a synchronized state.

For example:

* CDRs of the period of communication loss can be retrieved with a GET command on the CDRs module, with filters to
  retrieve only CDRs of the period since the last CDR has been received.

* Status of EVSEs (or Locations) can be retrieved by calling a GET on the Locations module.
