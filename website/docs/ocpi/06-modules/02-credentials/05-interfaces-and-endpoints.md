---
id: interfaces-and-endpoints
slug: interfaces-and-endpoints
---
# Interfaces and endpoints

The Credentials module is different from all other OCPI modules. This module is symmetric, it has to be implemented by
all OCPI implementations, and all implementations need to be able call this module on any other platform, and have to be
able the handle receiving the request from another party.

Example: `/ocpi/2.2.1/credentials` and `/ocpi/emsp/2.2.1/credentials`

| Method                                                                                      | Description                                                                                       |
|---------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------|
| [GET](/docs/ocpi/06-modules/02-credentials/05-interfaces-and-endpoints.md#get-method)       | Retrieves the credentials object to access the server's platform.                                 |
| [POST](/docs/ocpi/06-modules/02-credentials/05-interfaces-and-endpoints.md#post-method)     | Provides the server with a credentials object to access the client's system (i.e. register).      |
| [PUT](/docs/ocpi/06-modules/02-credentials/05-interfaces-and-endpoints.md#put-method)       | Provides the server with an updated credentials object to access the client's system.             |
| PATCH                                                                                       | n/a                                                                                               |
| [DELETE](/docs/ocpi/06-modules/02-credentials/05-interfaces-and-endpoints.md#delete-method) | Informs the server that its credentials to the client's system are now invalid (i.e. unregister). |

## **GET** Method

Retrieves the credentials object to access the server's platform. The request body is empty, the response contains the
credentials object to access the server's platform. This credentials object also contains extra information about the
server such as its business details.

## **POST** Method

Provides the server with credentials to access the client's system. This credentials object also contains extra
information about the client such as its business details.

A `POST` initiates the registration process for this endpoint's version. The server must also fetch the client's
endpoints for this version.

If successful, the server must generate a new credentials token and respond with the client's new credentials to access
the server's system. The credentials object in the response also contains extra information about the server such as its
business details.

This method MUST return a `HTTP status code 405: method not allowed` if the client has already been registered before.

## **PUT** Method

Provides the server with updated credentials to access the client's system. This credentials object also contains extra
information about the client such as its business details.

A `PUT` will switch to the version that contains this credentials endpoint if it's different from the current version.
The server must fetch the client's endpoints again, even if the version has not changed.

If successful, the server must generate a new credentials token for the client and respond with the client's updated
credentials to access the server's system. The credentials object in the response also contains extra information about
the server such as its business details.

This method MUST return a `HTTP status code 405: method not allowed` if the client has not been registered yet.

## **DELETE** Method

Informs the server that its credentials to access the client's system are now invalid and can no longer be used. Both
parties must end any automated communication. This is the unregistration process.

This method MUST return a `HTTP status code 405: method not allowed` if the client has not been registered before.
