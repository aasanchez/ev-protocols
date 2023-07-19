---
id: interface-endpoints
slug: interface-endpoints
---
# Interface endpoints

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
