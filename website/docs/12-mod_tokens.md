---
id: tokens
slug: modules/tokens
---
# Tokens

:::tip Module Identifier
tokens
:::

:::caution Data owner
MSP
:::

:::info Type
Functional Module
:::

The tokens module gives CPOs knowledge of the token information of an eMSP. eMSPs can push Token information to CPOs,
CPOs can build a cache of known Tokens. When a request to authorize comes from a Charge Point, the CPO can check against
this cache. With this cached information they know to which eMSP they can later send a CDR.

## Flow and Lifecycle

### Push model

When the eMSP creates a new Token object they push it to the CPO by calling [PUT](https://ocpi.dev) on the CPO's
Tokens endpoint with the newly created Token object.

Any changes to Token in the eMSP system are sent to the CPO system by calling either the [PUT](https://ocpi.dev)
or the [PATCH](https://ocpi.dev) on the CPO's Tokens endpoint with the updated Token(s).

When the eMSP invalidates a Token (deleting is not possible), the eMSP will send the updated Token (with the field:
valid set to `false`, by calling, either the [PUT](https://ocpi.dev) or the [PATCH](https://ocpi.dev) on
the CPO's Tokens endpoint with the updated Token.

When the eMSP is not sure about the state or existence of a Token object in the CPO system, the eMSP can call the
[GET](https://ocpi.dev) to validate the Token object in the CPO system.

### Pull model

When a CPO is not sure about the state of the list of known Tokens, or wants to request the full list as a start-up of
their system, the CPO can call the [GET](https://ocpi.dev) on the eMSP's Token endpoint to receive all Tokens,
updating already known Tokens and adding new received Tokens to it own list of Tokens. This is not intended for
real-time operation, requesting the full list of tokens for every authorization will put to much strain on systems. It
is intended for getting in-sync with the server, or to get a list of all tokens (from a server without Push mode) every
X hours.

### Real-time authorization

An eMSP might want their Tokens to be authorized *real-time*, not white-listed. For this the eMSP has to implement the
[POST Authorize request](https://ocpi.dev) and set the Token.whitelist field to `NEVER` for Tokens they want to
have authorized *real-time*.

If an eMSP doesn't want real-time authorization, the [POST Authorize request](https://ocpi.dev) doesn't have to
be implemented as long as all their Tokens have Token.whitelist set to `ALWAYS`.

When an eMSP does not want to Push the full list of tokens to CPOs, the CPOs will need to call the [POST Authorize
request](https://ocpi.dev) to check if a Token is known by the eMSP, and if it is valid.

:::note
Doing real-time authorization of RFID will mean a longer delay of the authorization process, which might result in bad
user experience at the Charge Point. So care should be taken to keep delays in processing the request to an absolute
minimum.
:::

:::note
Real-time authorization might be asked for a charging location that is not published via the
[Location](https://ocpi.dev) module, typically a private charger. In most cases this is expected to
result in: `ALLOWED`.
:::

:::note
If real-time authorization is asked for a location, the eMSP SHALL NOT validate that charging is possible based on
information like opening hours or EVSE status etc. as this information might not be up to date.
:::

## Interfaces and endpoints

There is both a Sender and a Receiver interface for Tokens. It is advised to use the Push direction from Sender to
Receiver during normal operation. The Sender interface is meant to be used when the Receiver is not 100% sure the Token
cache is still correct.

### Receiver Interface

Typically implemented by market roles like: CPO.

With this interface the Sender can push the Token information to the Receiver. Tokens is a [Client Owned
Object](/04-transport-and-format/01-json-http-implementation-guide.md#client-owned-object-push), so the end-points need to contain
the required extra fields: {[party_id](https://ocpi.dev)} and
{[country_code](https://ocpi.dev)}.

Endpoint structure definition:

`{token_endpoint_url}/{country_code}/{party_id}/{token_uid}[?type={type}]`

Example:

* `https://www.server.com/ocpi/cpo/2.2.1/tokens/NL/TNM/012345678`

| Method                    | Description                                                   |
|---------------------------|---------------------------------------------------------------|
| [GET](https://ocpi.dev)   | Retrieve a Token as it is stored in the CPO system.           |
| POST                      | n/a                                                           |
| [PUT](https://ocpi.dev)   | Push new/updated Token object to the CPO.                     |
| [PATCH](https://ocpi.dev) | Notify the CPO of partial updates to a Token.                 |
| DELETE                    | n/a, (Use [PUT](https://ocpi.dev), Tokens cannot be removed). |

#### **GET** Method

If the eMSP wants to check the status of a Token in the CPO system it might GET the object from the CPO system for
validation purposes. The eMSP is the owner of the objects, so it would be illogical if the CPO system had a different
status or was missing an object.

##### Request Parameters

The following parameters: `country_code`, `party_id`, `token_uid` have to be provided as URL segments.

The parameter: `type` may be provided as an URL parameter

| Parameter    | Datatype                                   | Required | Description                                                                       |
|--------------|--------------------------------------------|----------|-----------------------------------------------------------------------------------|
| country_code | [CiString](/16-types.md#cistring-type)(2)  | yes      | Country code of the eMSP requesting this GET from the CPO system.                 |
| party_id     | [CiString](/16-types.md#cistring-type)(3)  | yes      | Party ID (Provider ID) of the eMSP requesting this GET from the CPO system.       |
| token_uid    | [CiString](/16-types.md#cistring-type)(36) | yes      | Token.uid of the Token object to retrieve.                                        |
| type         | [TokenType](https://ocpi.dev)              | no       | Token.type of the Token to retrieve. Default if omitted: [RFID](https://ocpi.dev) |

##### Response Data

The response contains the requested object.

| Type                      | Card. | Description                 |
|---------------------------|-------|-----------------------------|
| [Token](https://ocpi.dev) | 1     | The requested Token object. |

#### **PUT** Method

New or updated Token objects are pushed from the eMSP to the CPO.

##### Request Body

In the put request a new or updated Token object is sent.

| Type                      | Card. | Description                  |
|---------------------------|-------|------------------------------|
| [Token](https://ocpi.dev) | 1     | New or updated Token object. |

##### Request Parameters

The following parameters: `country_code`, `party_id`, `token_uid` have to be provided as URL segments.

The parameter: `type` may be provided as an URL parameter

| Parameter    | Datatype                                   | Required | Description                                                                                                                                                     |
|--------------|--------------------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code | [CiString](/16-types.md#cistring-type)(2)  | yes      | Country code of the eMSP sending this PUT request to the CPO system. This SHALL be the same value as the `country_code` in the Token object being pushed.       |
| party_id     | [CiString](/16-types.md#cistring-type)(3)  | yes      | Party ID (Provider ID) of the eMSP sending this PUT request to the CPO system. This SHALL be the same value as the `party_id` in the Token object being pushed. |
| token_uid    | [CiString](/16-types.md#cistring-type)(36) | yes      | Token.uid of the (new) Token object (to replace).                                                                                                               |
| type         | [TokenType](https://ocpi.dev)              | no       | Token.type of the Token of the (new) Token object (to replace). Default if omitted: [RFID](https://ocpi.dev)                                                    |

##### Example: put a new Token

``` json
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

#### **PATCH** Method

Same as the [PUT](https://ocpi.dev) method, but only the fields/objects that have to be updated have to be
present, other fields/objects that are not specified are considered unchanged.

Any request to the PATCH method SHALL contain the `last_updated` field.

##### Example: invalidate a Token

``` json
PATCH To URL: https://www.server.com/ocpi/cpo/2.2.1/tokens/NL/TNM/012345678

{
  "valid": false,
  "last_updated": "2019-06-19T02:11:11Z"
}
```

### Sender Interface

Typically implemented by market roles like: eMSP.

This interface enables the Receiver to request the current list of Tokens, when needed. Via the POST method it is
possible to authorize a single token.

| Method                   | Description                     |
|--------------------------|---------------------------------|
| [GET](https://ocpi.dev)  |                                 |
| [POST](https://ocpi.dev) | Real-time authorization request |
| PUT                      | n/a                             |
| PATCH                    | n/a                             |
| DELETE                   | n/a                             |

#### **GET** Method

Fetch information about Tokens known in the eMSP systems.

Endpoint structure definition:

`{tokens_endpoint_url}?[date_from={date_from}]&amp;[date_to={date_to}]&[offset={offset}]&[limit={limit}]`

Examples:

* `https://www.server.com/ocpi/emsp/2.2.1/tokens/?date_from=2019-01-28T12:00:00&date_to=2019-01-29T12:00:00`
* `https://ocpi.server.com/2.2.1/tokens/?offset=50`
* `https://www.server.com/ocpi/2.2.1/tokens/?date_from=2019-01-29T12:00:00&limit=100`
* `https://www.server.com/ocpi/emsp/2.2.1/tokens/?offset=50&limit=100`

##### Request Parameters

If additional parameters: `{date_from}` and/or `{date_to}` are provided, only Tokens with (`last_updated`) between the
given `{date_from}` (including) and `{date_to}` (excluding) will be returned.

This request is [paginated](/04-transport-and-format/01-json-http-implementation-guide.md#pagination), it supports the
[pagination](/04-transport-and-format/01-json-http-implementation-guide.md#paginated-request) related URL parameters. This request
is [paginated](/04-transport-and-format/01-json-http-implementation-guide.md#pagination), it supports the
[pagination](/04-transport-and-format/01-json-http-implementation-guide.md#paginated-request) related URL parameters.

| Parameter | Datatype                               | Required | Description                                                                                      |
|-----------|----------------------------------------|----------|--------------------------------------------------------------------------------------------------|
| date_from | [DateTime](/16-types.md#datetime-type) | no       | Only return Tokens that have `last_updated` after or equal to this Date/Time (inclusive).        |
| date_to   | [DateTime](/16-types.md#datetime-type) | no       | Only return Tokens that have `last_updated` up to this Date/Time, but not including (exclusive). |
| offset    | int                                    | no       | The offset of the first object returned. Default is 0.                                           |
| limit     | int                                    | no       | Maximum number of objects to GET.                                                                |

##### Response Data

The endpoint response with list of valid Token objects, the header will contain the
[pagination](/04-transport-and-format/01-json-http-implementation-guide.md#paginated-response) related headers.

Any older information that is not specified in the response is considered as no longer valid. Each object must contain
all required fields. Fields that are not specified may be considered as null values.

| Type                      | Card. | Description         |
|---------------------------|-------|---------------------|
| [Token](https://ocpi.dev) | \*    | List of all tokens. |

#### **POST** Method

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
[2002](/05-status_codes.md#2xxx-client-errors)

##### Request Parameters

The parameter: `token_uid` has to be provided as URL segments.

The parameter: `type` may be provided as an URL parameter

| Parameter | Datatype                                   | Required | Description                                                                                           |
|-----------|--------------------------------------------|----------|-------------------------------------------------------------------------------------------------------|
| token_uid | [CiString](/16-types.md#cistring-type)(36) | yes      | Token.uid of the Token for which authorization is requested.                                          |
| type      | [TokenType](https://ocpi.dev)              | no       | Token.type of the Token for which this authorization is. Default if omitted: [RFID](https://ocpi.dev) |

##### Request Body

In the body an optional [LocationReferences](https://ocpi.dev) object can be given. The eMSP SHALL
then validate if the Token is allowed to be used at this Location, and if applicable: which of the Locations EVSEs. The
object with valid Location and EVSEs will be returned in the response.

| Type                                   | Card. | Description                                                           |
|----------------------------------------|-------|-----------------------------------------------------------------------|
| [LocationReferences](https://ocpi.dev) | ?     | Location and EVSEs for which the Token is requested to be authorized. |

##### Response Data

When the token is known by the Sender, the response SHALL contain a
[AuthorizationInfo](https://ocpi.dev) object.

If the token is not known, the response SHALL contain the status code: `2004: Unknown Token`, and no `data` field.

| Type                                  | Card. | Description                                                                                                                        |
|---------------------------------------|-------|------------------------------------------------------------------------------------------------------------------------------------|
| [AuthorizationInfo](https://ocpi.dev) | 1     | Contains information about the authorization, if the Token is allowed to charge and optionally which EVSEs are allowed to be used. |

## Object description

### *AuthorizationInfo* Object

| Property                | Type                                          | Card. | Description                                                                                                                                                                                          |
|-------------------------|-----------------------------------------------|-------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| allowed                 | [AllowedType](https://ocpi.dev)               | 1     | Status of the Token, and whether charging is allowed at the optionally given location.                                                                                                               |
| token                   | [Token](https://ocpi.dev)                     | 1     | The complete Token object for which this authorization was requested.                                                                                                                                |
| location                | [LocationReferences](https://ocpi.dev)        | ?     | Optional reference to the location if it was included in the request, and if the EV driver is allowed to charge at that location. Only the EVSEs the EV driver is allowed to charge at are returned. |
| authorization_reference | [CiString](/16-types.md#cistring-type)(36)    | ?     | Reference to the authorization given by the eMSP, when given, this reference will be provided in the relevant [Session](https://ocpi.dev) and/or [CDR](https://ocpi.dev).                            |
| info                    | [DisplayText](/16-types.md#displaytext-class) | ?     | Optional display text, additional information to the EV driver.                                                                                                                                      |

### *Token* Object

| Property             | Type                                                              | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|----------------------|-------------------------------------------------------------------|-------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code         | [CiString](/16-types.md#cistring-type)(2)                         | 1     | ISO-3166 alpha-2 country code of the MSP that *owns* this Token.                                                                                                                                                                                                                                                                                                                                                                                                                                |
| party_id             | [CiString](/16-types.md#cistring-type)(3)                         | 1     | ID of the eMSP that *owns* this Token (following the ISO-15118 standard).                                                                                                                                                                                                                                                                                                                                                                                                                       |
| uid                  | [CiString](/16-types.md#cistring-type)(36)                        | 1     | Unique ID by which this Token, combined with the Token type, can be identified. This is the field used by CPO system (RFID reader on the Charge Point) to identify this token. Currently, in most cases: type=RFID, this is the RFID hidden ID as read by the RFID reader, but that is not a requirement. If this is a `APP_USER` or `AD_HOC_USER` Token, it will be a uniquely, by the eMSP, generated ID. This field is named `uid` instead of `id` to prevent confusion with: `contract_id`. |
| type                 | [TokenType](https://ocpi.dev)                                     | 1     | Type of the token                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| contract_id          | [CiString](/16-types.md#cistring-type)(36)                        | 1     | Uniquely identifies the EV Driver contract token within the eMSP's platform (and suboperator platforms). Recommended to follow the specification for eMA ID from "eMI3 standard version V1.0" (<http://emi3group.com/documents-links/>) "Part 2: business objects."                                                                                                                                                                                                                             |
| visual_number        | [string](/16-types.md#string-type)(64)                            | ?     | Visual readable number/identification as printed on the Token (RFID card), might be equal to the contract_id.                                                                                                                                                                                                                                                                                                                                                                                   |
| issuer               | [string](/16-types.md#string-type)(64)                            | 1     | Issuing company, most of the times the name of the company printed on the token (RFID card), not necessarily the eMSP.                                                                                                                                                                                                                                                                                                                                                                          |
| group_id             | [CiString](/16-types.md#cistring-type)(36)                        | ?     | This ID groups a couple of tokens. This can be used to make two or more tokens work as one, so that a session can be started with one token and stopped with another, handy when a card and key-fob are given to the EV-driver. Beware that OCPP 1.5/1.6 only support group_ids (it is called parentId in OCPP 1.5/1.6) with a maximum length of 20.                                                                                                                                            |
| valid                | boolean                                                           | 1     | Is this Token valid                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| whitelist            | [WhitelistType](https://ocpi.dev)                                 | 1     | Indicates what type of white-listing is allowed.                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| language             | [string](/16-types.md#string-type)(2)                             | ?     | Language Code ISO 639-1. This optional field indicates the Token owner's preferred interface language. If the language is not provided or not supported then the CPO is free to choose its own language.                                                                                                                                                                                                                                                                                        |
| default_profile_type | [ProfileType](https://ocpi.dev)                                   | ?     | The default [Charging Preference](https://ocpi.dev). When this is provided, and a charging session is started on an Charge Point that support Preference base Smart Charging and support this [ProfileType](https://ocpi.dev), the Charge Point can start using this [ProfileType](https://ocpi.dev), without this having to be set via: [Set Charging Preferences](https://ocpi.dev).                                                                                                          |
| energy_contract      | [EnergyContract](#mod_tokens.asciidoc#mod_tokens_energy_contract) | ?     | When the Charge Point supports using your own energy supplier/contract at a Charge Point, information about the energy supplier/contract is needed so the CPO knows which energy supplier to use. NOTE: In a lot of countries it is currently not allowed/possible to use a drivers own energy supplier/contract at a Charge Point.                                                                                                                                                             |
| last_updated         | [DateTime](/16-types.md#datetime-type)                            | 1     | Timestamp when this Token was last updated (or created).                                                                                                                                                                                                                                                                                                                                                                                                                                        |

The combination of *uid* and *type* should be unique for every token within the eMSP's system.

:::note
OCPP supports group_id (or ParentID as it is called in OCPP 1.5/1.6) OCPP 1.5/1.6 only support group ID's with maximum
length of string(20), case insensitive. As long as EV-driver can be expected to charge at an OCPP 1.5/1.6 Charge Point,
it is adviced to not used a group_id longer then 20.
:::

#### Examples

##### Simple APP_USER example

``` json
{
  "country_code": "DE",
  "party_id": "TNM",
  "uid": "bdf21bce-fc97-11e8-8eb2-f2801f1b9fd1",
  "type": "APP_USER",
  "contract_id": "DE8ACC12E46L89",
  "issuer": "TheNewMotion",
  "valid": true,
  "whitelist": "ALLOWED",
  "last_updated": "2018-12-10T17:16:15Z"
}
```

##### Full RFID example

``` json
{
  "country_code": "DE",
  "party_id": "TNM",
  "uid": "12345678905880",
  "type": "RFID",
  "contract_id": "DE8ACC12E46L89",
  "visual_number": "DF000-2001-8999-1",
  "issuer": "TheNewMotion",
  "group_id": "DF000-2001-8999",
  "valid": true,
  "whitelist": "ALLOWED",
  "language": "it",
  "default_profile_type": "GREEN",
  "energy_contract": {
    "supplier_name": "Greenpeace Energy eG",
    "contract_id": "0123456789"
  },
  "last_updated": "2018-12-10T17:25:10Z"
}
```

## Data types

### AllowedType *enum*

| Value       | Description                                                                                     |
|-------------|-------------------------------------------------------------------------------------------------|
| ALLOWED     | This Token is allowed to charge (at this location).                                             |
| BLOCKED     | This Token is blocked.                                                                          |
| EXPIRED     | This Token has expired.                                                                         |
| NO_CREDIT   | This Token belongs to an account that has not enough credits to charge (at the given location). |
| NOT_ALLOWED | Token is valid, but is not allowed to charge at the given location.                             |

### EnergyContract *class*

Information about a energy contract that belongs to a Token so a driver could use his/her own energy contract when
charging at a Charge Point.

| Property      | Type                                   | Card. | Description                                                                  |
|---------------|----------------------------------------|-------|------------------------------------------------------------------------------|
| supplier_name | [string](/16-types.md#string-type)(64) | 1     | Name of the energy supplier for this token.                                  |
| contract_id   | [string](/16-types.md#string-type)(64) | ?     | Contract ID at the energy supplier, that belongs to the owner of this token. |

### LocationReferences *class*

References to location details.

| Property    | Type                                       | Card. | Description                                                                                    |
|-------------|--------------------------------------------|-------|------------------------------------------------------------------------------------------------|
| location_id | [CiString](/16-types.md#cistring-type)(36) | 1     | Unique identifier for the location.                                                            |
| evse_uids   | [CiString](/16-types.md#cistring-type)(36) | \*    | Unique identifiers for EVSEs within the CPO's platform for the EVSE within the given location. |

### TokenType *enum*

| Value       | Description                                                                                                                     |
|-------------|---------------------------------------------------------------------------------------------------------------------------------|
| AD_HOC_USER | One time use Token ID generated by a server (or App.) The eMSP uses this to bind a Session to a customer, probably an app user. |
| APP_USER    | Token ID generated by a server (or App.) to identify a user of an App. The same user uses the same Token for every Session.     |
| OTHER       | Other type of token                                                                                                             |
| RFID        | RFID Token                                                                                                                      |

:::note
The eMSP is RECOMMENDED to push Tokens with type: `AD_HOC_USER` or `APP_USER` with `whitelist` set to `NEVER`.
Whitelists are very useful for RFID type Tokens, but the `AD_HOC_USER`/`APP_USER` Tokens are used to start Sessions from
an App etc. so whitelisting them has no advantages.
:::

### WhitelistType *enum*

Defines when authorization of a Token by the CPO is allowed.

The validity of a Token has no influence on this. If a Token is: `valid = false`, when the `whitelist` field requires
real-time authorization, the CPO SHALL do a [real-time authorization](https://ocpi.dev), the state of
the Token might have changed.

| Value           | Description                                                                                                                                                                                                                     |
|-----------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ALWAYS          | Token always has to be whitelisted, [realtime authorization](https://ocpi.dev) is not possible/allowed. CPO shall always allow any use of this Token.                                                                           |
| ALLOWED         | It is allowed to whitelist the token, [realtime authorization](https://ocpi.dev) is also allowed. The CPO may choose which version of authorization to use.                                                                     |
| ALLOWED_OFFLINE | In normal situations [realtime authorization](https://ocpi.dev) shall be used. But when the CPO cannot get a response from the eMSP (communication between CPO and eMSP is offline), the CPO shall allow this Token to be used. |
| NEVER           | Whitelisting is forbidden, only [realtime authorization](https://ocpi.dev) is allowed. CPO shall always send a [realtime authorization](https://ocpi.dev) for any use of this Token to the eMSP.                                |
