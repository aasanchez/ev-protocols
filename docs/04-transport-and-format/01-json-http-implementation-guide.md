---
sidebar_position: 1
---

# JSON / HTTP implementation guide

The OCPI protocol is based on HTTP and uses the JSON format. It follows a RESTful architecture for web services where
possible.

## Security and authentication

The interfaces are protected on the HTTP transport level, with SSL and token-based authentication. Please note that this
mechanism does *not* require client-side certificates for authentication, only server-side certificates to set up a
secure SSL connection.

## Authorization header

Every OCPI HTTP request MUST add an 'Authorization' header. The header looks as follows:

```text
Authorization: Token IpbJOXxkxOAuKR92z0nEcmVF3Qw09VG7I7d/WCg0koM=
```

