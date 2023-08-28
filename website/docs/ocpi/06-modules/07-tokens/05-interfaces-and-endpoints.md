---
id: interfaces-and-endpoints
slug: interfaces-and-endpoints
---
# Interfaces and endpoints

There is both a Sender and a Receiver interface for Tokens. It is advised to use the Push direction from Sender to
Receiver during normal operation. The Sender interface is meant to be used when the Receiver is not 100% sure the Token
cache is still correct.

## Receiver Interface

Typically implemented by market roles like: CPO.

With this interface the Sender can push the Token information to the Receiver. Tokens is a [Client Owned
Object](/docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#client-owned-object-push), so the
end-points need to contain the required extra fields:
{[party_id](/docs/ocpi/06-modules/02-credentials/06-object-description.md#credentials-object)} and
{[country_code](/docs/ocpi/06-modules/02-credentials/06-object-description.md#credentials-object)}.

Endpoint structure definition:

`{token_endpoint_url}/{country_code}/{party_id}/{token_uid}[?type={type}]`

Example:

* `https://www.server.com/ocpi/cpo/2.2.1/tokens/NL/TNM/012345678`

| Method                                                                               | Description                                                                                                            |
|--------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| [GET](/docs/ocpi/06-modules/07-tokens/05-interfaces-and-endpoints.md#get-method)     | Retrieve a Token as it is stored in the CPO system.                                                                    |
| POST                                                                                 | n/a                                                                                                                    |
| [PUT](/docs/ocpi/06-modules/07-tokens/05-interfaces-and-endpoints.md#put-method)     | Push new/updated Token object to the CPO.                                                                              |
| [PATCH](/docs/ocpi/06-modules/07-tokens/05-interfaces-and-endpoints.md#patch-method) | Notify the CPO of partial updates to a Token.                                                                          |
| DELETE                                                                               | n/a, (Use [PUT](/docs/ocpi/06-modules/07-tokens/05-interfaces-and-endpoints.md#put-method), Tokens cannot be removed). |

### **GET** Method

If the eMSP wants to check the status of a Token in the CPO system it might GET the object from the CPO system for
validation purposes. The eMSP is the owner of the objects, so it would be illogical if the CPO system had a different
status or was missing an object.

#### Request Parameters

The following parameters: `country_code`, `party_id`, `token_uid` have to be provided as URL segments.

The parameter: `type` may be provided as an URL parameter

| Parameter    | Datatype                                                                     | Required | Description                                                                                                                      |
|--------------|------------------------------------------------------------------------------|----------|----------------------------------------------------------------------------------------------------------------------------------|
| country_code | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(2)                 | yes      | Country code of the eMSP requesting this GET from the CPO system.                                                                |
| party_id     | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(3)                 | yes      | Party ID (Provider ID) of the eMSP requesting this GET from the CPO system.                                                      |
| token_uid    | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(36)                | yes      | Token.uid of the Token object to retrieve.                                                                                       |
| type         | [TokenType](/docs/ocpi/06-modules/07-tokens/07-data-types.md#tokentype-enum) | no       | Token.type of the Token to retrieve. Default if omitted: [RFID](/docs/ocpi/06-modules/07-tokens/07-data-types.md#tokentype-enum) |

#### Response Data

The response contains the requested object.

| Type                                                                           | Card. | Description                 |
|--------------------------------------------------------------------------------|-------|-----------------------------|
| [Token](/docs/ocpi/06-modules/07-tokens/06-object-description.md#token-object) | 1     | The requested Token object. |

### **PUT** Method

New or updated Token objects are pushed from the eMSP to the CPO.

#### Request Body

In the put request a new or updated Token object is sent.

| Type                                                                           | Card. | Description                  |
|--------------------------------------------------------------------------------|-------|------------------------------|
| [Token](/docs/ocpi/06-modules/07-tokens/06-object-description.md#token-object) | 1     | New or updated Token object. |

#### Request Parameters

The following parameters: `country_code`, `party_id`, `token_uid` have to be provided as URL segments.

The parameter: `type` may be provided as an URL parameter

| Parameter    | Datatype                                                                     | Required | Description                                                                                                                                                     |
|--------------|------------------------------------------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(2)                 | yes      | Country code of the eMSP sending this PUT request to the CPO system. This SHALL be the same value as the `country_code` in the Token object being pushed.       |
| party_id     | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(3)                 | yes      | Party ID (Provider ID) of the eMSP sending this PUT request to the CPO system. This SHALL be the same value as the `party_id` in the Token object being pushed. |
| token_uid    | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(36)                | yes      | Token.uid of the (new) Token object (to replace).                                                                                                               |
| type         | [TokenType](/docs/ocpi/06-modules/07-tokens/07-data-types.md#tokentype-enum) | no       | Token.type of the Token of the (new) Token object (to replace). Default if omitted: [RFID](/docs/ocpi/06-modules/07-tokens/07-data-types.md#tokentype-enum)     |

#### Example: put a new Token

```json
PUT To URL: https://www.server.com/ocpi/cpo/2.2.1/tokens/NL/TNM/012345678

{
  "country_code": "NL",
  "party_id": "TNM",
  "uid": "012345678",
  "type": "RFID",
  "contract_id": "NL8ACC12E46L89",
  "visual_number": "DF000-2001-8999-1",
  "issuer": "TheNewMotion",
  "group_id": "DF000-2001-8999",
  "valid": true,
  "whitelist": "ALWAYS",
  "last_updated": "2015-06-29T22:39:09Z"
}
```

### **PATCH** Method

Same as the [PUT](/docs/ocpi/06-modules/07-tokens/05-interfaces-and-endpoints.md#put-method) method, but only the
fields/objects that have to be updated have to be present, other fields/objects that are not specified are considered
unchanged.

Any request to the PATCH method SHALL contain the `last_updated` field.

#### Example: invalidate a Token

```json
PATCH To URL: https://www.server.com/ocpi/cpo/2.2.1/tokens/NL/TNM/012345678

{
  "valid": false,
  "last_updated": "2019-06-19T02:11:11Z"
}
```

## Sender Interface

Typically implemented by market roles like: eMSP.

This interface enables the Receiver to request the current list of Tokens, when needed. Via the POST method it is
possible to authorize a single token.

| Method                                                                             | Description                     |
|------------------------------------------------------------------------------------|---------------------------------|
| [GET](/docs/ocpi/06-modules/07-tokens/05-interfaces-and-endpoints.md#get-method-1) |                                 |
| [POST](/docs/ocpi/06-modules/07-tokens/05-interfaces-and-endpoints.md#post-method) | Real-time authorization request |
| PUT                                                                                | n/a                             |
| PATCH                                                                              | n/a                             |
| DELETE                                                                             | n/a                             |

### **GET** Method

Fetch information about Tokens known in the eMSP systems.

Endpoint structure definition:

`{tokens_endpoint_url}?[date_from={date_from}]&amp;[date_to={date_to}]&[offset={offset}]&[limit={limit}]`

Examples:

* `https://www.server.com/ocpi/emsp/2.2.1/tokens/?date_from=2019-01-28T12:00:00&date_to=2019-01-29T12:00:00`
* `https://ocpi.server.com/2.2.1/tokens/?offset=50`
* `https://www.server.com/ocpi/2.2.1/tokens/?date_from=2019-01-29T12:00:00&limit=100`
* `https://www.server.com/ocpi/emsp/2.2.1/tokens/?offset=50&limit=100`

#### Request Parameters

If additional parameters: `{date_from}` and/or `{date_to}` are provided, only Tokens with (`last_updated`) between the
given `{date_from}` (including) and `{date_to}` (excluding) will be returned.

This request is [paginated](/docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#pagination), it
supports the [pagination](/docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#paginated-request)
related URL parameters. This request is
[paginated](/docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#pagination), it supports the
[pagination](/docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#paginated-request) related URL
parameters.

| Parameter | Datatype                                                  | Required | Description                                                                                      |
|-----------|-----------------------------------------------------------|----------|--------------------------------------------------------------------------------------------------|
| date_from | [DateTime](/docs/ocpi/07-types/01-intro.md#datetime-type) | no       | Only return Tokens that have `last_updated` after or equal to this Date/Time (inclusive).        |
| date_to   | [DateTime](/docs/ocpi/07-types/01-intro.md#datetime-type) | no       | Only return Tokens that have `last_updated` up to this Date/Time, but not including (exclusive). |
| offset    | int                                                       | no       | The offset of the first object returned. Default is 0.                                           |
| limit     | int                                                       | no       | Maximum number of objects to GET.                                                                |

#### Response Data

The endpoint response with list of valid Token objects, the header will contain the
[pagination](/docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#paginated-response) related
headers.

Any older information that is not specified in the response is considered as no longer valid. Each object must contain
all required fields. Fields that are not specified may be considered as null values.

| Type                                                                           | Card. | Description         |
|--------------------------------------------------------------------------------|-------|---------------------|
| [Token](/docs/ocpi/06-modules/07-tokens/06-object-description.md#token-object) | \*    | List of all tokens. |

### **POST** Method

Do a *real-time* authorization request to the eMSP system, validating if a Token might be used (at the optionally given
Location).

Endpoint structure definition:

`{tokens_endpoint_url}{token_uid}/authorize[?type={type}]`

The `/authorize` is required for the real-time authorize request.

Examples:

* `https://www.server.com/ocpi/emsp/2.2.1/tokens/012345678/authorize`
* `https://ocpi.server.com/2.2.1/tokens/012345678/authorize?type=RFID`

When the eMSP does not know the Token, the eMSP SHALL respond with an HTTP status code: 404 (Not Found).

When the eMSP receives a *real-time* authorization request from a CPO that contains too little information (no
LocationReferences provided) to determine if the Token might be used, the eMSP SHALL respond with the OCPI status:
[2002](/docs/ocpi/05-status-codes/05-status-codes.md#2xxx-client-errors)

#### Request Parameters

The parameter: `token_uid` has to be provided as URL segments.

The parameter: `type` may be provided as an URL parameter

| Parameter | Datatype                                                                     | Required | Description                                                                                                                                          |
|-----------|------------------------------------------------------------------------------|----------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| token_uid | [CiString](/docs/ocpi/07-types/01-intro.md#cistring-type)(36)                | yes      | Token.uid of the Token for which authorization is requested.                                                                                         |
| type      | [TokenType](/docs/ocpi/06-modules/07-tokens/07-data-types.md#tokentype-enum) | no       | Token.type of the Token for which this authorization is. Default if omitted: [RFID](/docs/ocpi/06-modules/07-tokens/07-data-types.md#tokentype-enum) |

#### Request Body

In the body an optional [LocationReferences](/docs/ocpi/06-modules/07-tokens/07-data-types.md#locationreferences-class)
object can be given. The eMSP SHALL then validate if the Token is allowed to be used at this Location, and if
applicable: which of the Locations EVSEs. The object with valid Location and EVSEs will be returned in the response.

| Type                                                                                            | Card. | Description                                                           |
|-------------------------------------------------------------------------------------------------|-------|-----------------------------------------------------------------------|
| [LocationReferences](/docs/ocpi/06-modules/07-tokens/07-data-types.md#locationreferences-class) | ?     | Location and EVSEs for which the Token is requested to be authorized. |

#### Response Data

When the token is known by the Sender, the response SHALL contain a
[AuthorizationInfo](/docs/ocpi/06-modules/07-tokens/06-object-description.md#authorizationinfo-object) object.

If the token is not known, the response SHALL contain the status code: `2004: Unknown Token`, and no `data` field.

| Type                                                                                                   | Card. | Description                                                                                                                        |
|--------------------------------------------------------------------------------------------------------|-------|------------------------------------------------------------------------------------------------------------------------------------|
| [AuthorizationInfo](/docs/ocpi/06-modules/07-tokens/06-object-description.md#authorizationinfo-object) | 1     | Contains information about the authorization, if the Token is allowed to charge and optionally which EVSEs are allowed to be used. |
