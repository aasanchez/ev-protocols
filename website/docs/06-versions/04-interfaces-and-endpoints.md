---
id: interfaces-and-endpoints
slug: /modules/version/interfaces-and-endpoints
---
# Interfaces and Endpoint


## Version information endpoint

This endpoint lists all the available OCPI versions and the corresponding URLs to where version specific details such as
the supported endpoints can be found.

Endpoint structure definition:

No structure defined. This is open for every party to define themselves.

Examples:

* `https://www.server.com/ocpi/cpo/versions`
* `https://www.server.com/ocpi/emsp/versions`
* `https://ocpi.server.com/versions`

The exact URL to the implemented version endpoint should be given (offline) to parties that want to communicate with
your OCPI implementation.

Both, CPOs and eMSPs MUST implement such a version endpoint.

| Method | Description                                     |
|--------|-------------------------------------------------|
| GET    | Fetch information about the supported versions. |

### GET

Fetch all supported OCPI versions of this CPO or eMSP.

#### Example

``` json
[
  {
    "version": "2.1.1",
    "url": "https://www.server.com/ocpi/2.1.1"
  },
  {
    "version": "2.2.1",
    "url": "https://www.server.com/ocpi/2.2.1"
  }
]
```

## Version details endpoint

Via the version details, the parties can exchange which modules are implemented for a specific version of OCPI, which
interface role is implemented, and what the endpoint URL is for this interface.

Parties that are both CPO and eMSP (or a Hub) can implement one version endpoint that covers both roles. With the
information that is available in the version details, parties don't need to implement a separate endpoint per role (CPO
or eMSP) anymore. In practice this means that when a company is both a CPO and an eMSP and it connects to another party
that implements both interfaces, only one OCPI connection is needed.

:::note
OCPI 2.2 introduced the role field in the version details. Older versions of OCPI do not support this.
:::

Endpoint structure definition:

No structure defined. This is open for every party to define themselves.

Examples:

* `https://www.server.com/ocpi/cpo/2.2.1`
* `https://www.server.com/ocpi/emsp/2.2.1`
* `https://ocpi.server.com/2.2.1/details`

This endpoint lists the supported endpoints and their URLs for a specific OCPI version. To notify the other party that
the list of endpoints of your current version has changed, you can send a PUT request to the corresponding credentials
endpoint (see the credentials chapter).

Both the CPO and the eMSP MUST implement this endpoint.

| Method | Description                                                       |
|--------|-------------------------------------------------------------------|
| GET    | Fetch information about the supported endpoints for this version. |

### GET

Fetch information about the supported endpoints and their URLs for this OCPI version.

#### Examples

Simple version details example: CPO with only 2 modules.

``` json
{
  "version": "2.2",
  "endpoints": [
    {
      "identifier": "credentials",
      "role": "SENDER",
      "url": "https://example.com/ocpi/2.2/credentials"
    },
    {
      "identifier": "locations",
      "role": "SENDER",
      "url": "https://example.com/ocpi/cpo/2.2/locations"
    }
  ]
}
```

Simple version details example: party with both CPO and eMSP with only 2 modules.

In this case the `credentials module is not defined twice as this module is the same for all roles.

``` json
{
  "version": "2.2",
  "endpoints": [
    {
      "identifier": "credentials",
      "role": "RECEIVER",
      "url": "https://example.com/ocpi/2.2/credentials"
    },
    {
      "identifier": "locations",
      "role": "SENDER",
      "url": "https://example.com/ocpi/cpo/2.2/locations"
    },
    {
      "identifier": "tokens",
      "role": "RECEIVER",
      "url": "https://example.com/ocpi/cpo/2.2/tokens"
    },
    {
      "identifier": "locations",
      "role": "RECEIVER",
      "url": "https://example.com/ocpi/msp/2.2/locations"
    },
    {
      "identifier": "tokens",
      "role": "SENDER",
      "url": "https://example.com/ocpi/msp/2.2/tokens"
    }
  ]
}
```
