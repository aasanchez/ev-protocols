---
id: information-endpoint
slug: information-endpoint
---
# Version information endpoint

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

## Data

| Type                                                                                  | Card. | Description                        |
|---------------------------------------------------------------------------------------|-------|------------------------------------|
| [Version](/docs/ocpi/06-modules/01-versions/02-information-endpoint.md#version-class) | \+    | A list of supported OCPI versions. |

### Version *class*

| Property | Type                                                                                         | Card. | Description                                                  |
|----------|----------------------------------------------------------------------------------------------|-------|--------------------------------------------------------------|
| version  | [VersionNumber](/docs/ocpi/06-modules/01-versions/03-details-endpoint.md#versionnumber-enum) | 1     | The version number.                                          |
| url      | [URL](/docs/ocpi/07-types/01-intro.md#url-type)                                              | 1     | URL to the endpoint containing version specific information. |

## GET

Fetch all supported OCPI versions of this CPO or eMSP.

### Example

```json
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
