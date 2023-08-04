---
id: object-description
slug: /modules/credentials/object-description
---
## Object description

### Credentials object

| Property | Type                                            | Card. | Description                                                                                                                                                                                                                                   |
|----------|-------------------------------------------------|-------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| token    | [string](/07-types/01-intro.md#string-type)(64) | 1     | The credentials token for the other party to authenticate in your system. It should only contain printable non-whitespace ASCII characters, that is, characters with Unicode code points from the range of U+0021 up to and including U+007E. |
| url      | [URL](/07-types/01-intro.md#url-type)           | 1     | The URL to your API versions endpoint.                                                                                                                                                                                                        |
| roles    | [CredentialsRole](https://ocpi.dev)             | \+    | List of the roles this party provides.                                                                                                                                                                                                        |

Every role needs a unique combination of: `role`, `party_id` and `country_code`.

A platform can have the same role more than once, each with its own unique `party_id` and `country_code`, for example
when a CPO provides *white-label* services for *virtual* CPOs.

One or more roles and thus `party_id` and `country_code` sets are provided here to inform a server about the `party_id`
and `country_code` sets a client will use when pushing [Client Owned
Objects](/04-transport-and-format/01-json-http-implementation-guide.md#client-owned-object-push). This helps a server to determine
the URLs a client will use when pushing a [Client Owned
Object](/04-transport-and-format/01-json-http-implementation-guide.md#client-owned-object-push). The `country_code` is added to
make certain the URL used when pushing a [Client Owned
Object](/04-transport-and-format/01-json-http-implementation-guide.md#client-owned-object-push) is unique as there might be
multiple parties in the world with the same `party_id`. The combination of `country_code` and `party_id` should always
be unique though. A party operating in multiple countries can always use the home country of the company for all
connections.

For example: EVSE IDs can be pushed under the country and provider identification of a company, even if the EVSEs are
actually located in a different country. This way it is not necessary to establish one OCPI connection per country a
company operates in.

The `party_id` and `country_code` given here have no direct link with the eMI3 EVSE IDs and Contract IDs that might be
used in the different OCPI modules. A party implementing OCPI MAY push EVSE IDs with an eMI3 `spot operator` different
from the OCPI `party_id` and/or the `country_code`.

A Hub SHALL only reports itself as role: Hub. A Hub SHALL NOT report all the other connected parties as a role on the
platform. A Hub SHALL report connected parties via the [HubClientInfo
module](https://ocpi.dev).

### Examples

Example of a minimal CPO credentials object:

```json
{
  "token": "ebf3b399-779f-4497-9b9d-ac6ad3cc44d2",
  "url": "https://example.com/ocpi/versions",
  "roles": [
    {
      "role": "CPO",
      "party_id": "EXA",
      "country_code": "NL",
      "business_details": {
        "name": "Example Operator"
      }
    }
  ]
}
```

Example of a combined CPO/eMSP credentials object:

```json
{
  "token": "9e80a9c4-28be-11e9-b210-d663bd873d93",
  "url": "https://ocpi.example.com/versions",
  "roles": [
    {
      "role": "CPO",
      "party_id": "EXA",
      "country_code": "NL",
      "business_details": {
        "name": "Example Operator"
      }
    },
    {
      "role": "EMSP",
      "party_id": "EXA",
      "country_code": "NL",
      "business_details": {
        "name": "Example Provider"
      }
    }
  ]
}
```

Example of a CPO credentials object with full business details:

```json
{
  "token": "9e80ae10-28be-11e9-b210-d663bd873d93",
  "url": "https://example.com/ocpi/versions",
  "roles": [
    {
      "role": "CPO",
      "party_id": "EXA",
      "country_code": "NL",
      "business_details": {
        "name": "Example Operator",
        "logo": {
          "url": "https://example.com/img/logo.jpg",
          "thumbnail": "https://example.com/img/logo_thumb.jpg",
          "category": "OPERATOR",
          "type": "jpeg",
          "width": 512,
          "height": 512
        },
        "website": "http://example.com"
      }
    }
  ]
}
```

Example of a CPO credentials object for a platform that provides services for 3 CPOs:

```json
{
  "token": "9e80aca8-28be-11e9-b210-d663bd873d93",
  "url": "https://ocpi.example.com/versions",
  "roles": [
    {
      "role": "CPO",
      "party_id": "EXO",
      "country_code": "NL",
      "business_details": {
        "name": "Excellent Operator"
      }
    },
    {
      "role": "CPO",
      "party_id": "PFC",
      "country_code": "NL",
      "business_details": {
        "name": "Plug Flex Charging"
      }
    },
    {
      "role": "CPO",
      "party_id": "CGP",
      "country_code": "NL",
      "business_details": {
        "name": "Charging Green Power"
      }
    }
  ]
}
```
