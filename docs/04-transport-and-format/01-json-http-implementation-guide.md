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

> HTTP header names are case-insensitive

The literal 'Token' indicates that the token-based authentication mechanism is used, in OCPI this is called the
'credentials token'. 'Credentials tokens' are exchanged via the credentials module. These are different 'tokens' than
the Tokens exchanged via the Token Module: Tokens used by drivers to authorize charging. To prevent confusion, when
talking about the token used here in the HTTP Authorization header, call them: 'Credentials Tokens'.

After the literal 'Token', there SHALL be one space, followed by the 'encoded token'. The encoded token is obtained by
encoding the credentials token to an octet sequence with UTF-8 and then encoding that octet sequence with Base64
according to RFC 4648.

So for example, to use the credentials token 'example-token' in an OCPI request, one should include this header:

```text
Authorization: Token ZXhhbXBsZS10b2tlbgo=
```

> Many OCPI 2.1.1 and 2.2 implementations do not Base64 encode the credentials token when including it in the
> 'Authorization' header. Since OCPI 2.2-d2 the OCPI specification documents clearly require Base64 encoding the
> credentials token in the header value. Implementations that wish to be compatible with non-encoding 2.1.1 and
> 2.2 implementations have to choose the right way to parse and write authorization headers by either trial and
> error or configuration flags.

The credentials token must uniquely identify the requesting party. This way, the server can use the information in the
Authorization header to link the request to the correct requesting party’s account.

If the header is missing or the credentials token doesn’t match any known party then the server SHALL respond with an
`HTTP 401 - Unauthorized` status code.

When a server receives a request with a valid `CREDENTIALS_TOKEN_A`, on another module than: `credentials` or `versions`,
the server SHALL respond with an `HTTP 401 - Unauthorized` status code.

## Pull and Push

OCPI supports both Pull and Push models.

* **Push**: Changes in objects and new objects are sent (semi) real-time to the receiver.
* **Pull**: Receiver request a (full) list of objects every X times.

OCPI doesn’t require parties to implement Push. Pull is required, a receiver needs to be able to get in-sync after a
period of connection loss.

It is possible to implement a Pull only OCPI implementation, it might be a good starting point for an OCPI implementation.
However, it is strongly advised to implement Push for production systems that have to handle some load, especially when
several clients are requesting long lists frequently. Push implementations tend to use fewer resources. It is therefore
advised to clients pulling lists from a server to do this on a relative low polling interval: think in hours, not minutes,
and to introduce some splay (randomize the length of the poll interface a bit).
