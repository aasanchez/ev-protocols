# *Credentials* module

**Module Identifier: `credentials`**

**Type:** Configuration Module

The credentials module is used to exchange the credentials token that
has to be used by parties for authorization of requests.

Every OCPI request is required to contain a credentials token in the
[HTTP Authorizationheader](#transport_and_format.asciidoc#transport_and_format_authorization_header).

## Use cases

### Registration

To start using OCPI, the Platforms will need to exchange credentials
tokens.

To start the exchange of credentials tokens, one platform has to be
selected as Sender for the Credentials module. This has to be decided
between the Platforms (outside of OCPI) before they first connect.

To start the credentials exchange, the Receiver Platform must create a
unique credentials token: `CREDENTIALS_TOKEN_A` that has to be used to
authorize the Sender until the credentials exchange is finished. This
credentials token along with the versions endpoint SHOULD be sent to the
Sender in a secure way that is outside the scope of this protocol.

The Sender starts the registration process, retrieves the version
information and details (using `CREDENTIALS_TOKEN_A` in the HTTP
Authorization header). The Sender generates a unique credentials token:
`CREDENTIALS_TOKEN_B`, sends it to the Receiver in a POST request to the
`credentials` module of the Receiver. The Receiver stores
`CREDENTIALS_TOKEN_B` and uses it for any requests to the Sender
Platform, including the version information and details.

The Receiver generates a unique credentials token: `CREDENTIALS_TOKEN_C`
and returns it to the Sender in the response to the POST request from
the Sender.

After the credentials exchange has finished, the Sender SHALL use
`CREDENTIALS_TOKEN_C` in future OCPI request to the Receiver Platform.
The `CREDENTIALS_TOKEN_A` can then be thrown away, it MAY no longer be
used.

(In the sequence diagrams below we use relative paths as short resource
identifiers to illustrate API endpoints; please note that they should be
absolute URLs in any working implementation of OCPI.)

<figure>
<img src="images/registration-sequence.svg"
alt="The OCPI registration process" />
<figcaption aria-hidden="true">The OCPI registration
process</figcaption>
</figure>

Due to its symmetric nature of the credentials module, any platform can
be Sender and or the Receiver for this module.

### Updating to a newer version

At some point, both platforms will have implemented a newer OCPI
version. To start using the newer version, one platform has to send a
PUT request to the credentials endpoint of the other platform.

<figure>
<img src="images/update-sequence.svg" alt="The OCPI update process" />
<figcaption aria-hidden="true">The OCPI update process</figcaption>
</figure>

### Changing endpoints for the current version

This can be done by following the update procedure for the same version.

By sending a PUT request to the credentials endpoint of this version,
the other platform will fetch and store the corresponding set of
endpoints.

### Updating the credentials and resetting the credentials token

The credentials (or parts thereof, such as the credentials token) can be
updated by sending the new credentials via a PUT request to the
credentials endpoint of the current version, similar to the update
procedure described above.

Security advices: When one of the connecting platforms suspects that a
credentials token is compromised, that platform SHALL initiate a
credentials token update as soon as possible. It is advisable to renew
the credentials tokens at least once a month, in case it was not
detected that the credentials where compromised.

### Errors during registration

When the server connects back to the client during the credentials
registration, it might encounter problems. When this happens, the server
should add the status code
[3001](#status_codes.asciidoc#status_codes_3xxx_server_errors) in the
response to the POST from the client.

### Required endpoints not available

When two platforms connect, it might happen that one of the platforms
expects a certain endpoint to be available at the other platform.

For example: a Platform with a CPO role could only want to connect when
the CDRs endpoint is available in an platform with an eMSP role.

In case the Sender (starting the credentials exchange process) cannot
find the endpoints it expects, it is expected NOT to send the POST
request with credentials to the Receiver. Log a message/notify the
administrator to contact the administrator of the Receiver platform.

In case the Receiver platform that cannot find the endpoints it expects,
then it is expected to respond to the request with the status code
[3003](#status_codes.asciidoc#status_codes_3xxx_server_errors).

## Interfaces and endpoints

The Credentials module is different from all other OCPI modules. This
module is symmetric, it has to be implemented by all OCPI
implementations, and all implementations need to be able call this
module on any other platform, and have to be able the handle receiving
the request from another party.

Example: `/ocpi/2.2.1/credentials` and `/ocpi/emsp/2.2.1/credentials`

<table>
<colgroup>
<col style="width: 14%" />
<col style="width: 85%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Method</th>
<th style="text-align: left;">Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p><a
href="#credentials_get_method">GET</a></p></td>
<td style="text-align: left;"><p>Retrieves the credentials object to
access the server’s platform.</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><a
href="#credentials_post_method">POST</a></p></td>
<td style="text-align: left;"><p>Provides the server with a credentials
object to access the client’s system (i.e. register).</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a
href="#credentials_put_method">PUT</a></p></td>
<td style="text-align: left;"><p>Provides the server with an updated
credentials object to access the client’s system.</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>PATCH</p></td>
<td style="text-align: left;"><p>n/a</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a
href="#credentials_delete_method">DELETE</a></p></td>
<td style="text-align: left;"><p>Informs the server that its credentials
to the client’s system are now invalid (i.e. unregister).</p></td>
</tr>
</tbody>
</table>

### **GET** Method

Retrieves the credentials object to access the server’s platform. The
request body is empty, the response contains the credentials object to
access the server’s platform. This credentials object also contains
extra information about the server such as its business details.

### **POST** Method

Provides the server with credentials to access the client’s system. This
credentials object also contains extra information about the client such
as its business details.

A `POST` initiates the registration process for this endpoint’s version.
The server must also fetch the client’s endpoints for this version.

If successful, the server must generate a new credentials token and
respond with the client’s new credentials to access the server’s system.
The credentials object in the response also contains extra information
about the server such as its business details.

This method MUST return a `HTTP status code 405: method not allowed` if
the client has already been registered before.

### **PUT** Method

Provides the server with updated credentials to access the client’s
system. This credentials object also contains extra information about
the client such as its business details.

A `PUT` will switch to the version that contains this credentials
endpoint if it’s different from the current version. The server must
fetch the client’s endpoints again, even if the version has not changed.

If successful, the server must generate a new credentials token for the
client and respond with the client’s updated credentials to access the
server’s system. The credentials object in the response also contains
extra information about the server such as its business details.

This method MUST return a `HTTP status code 405: method not allowed` if
the client has not been registered yet.

### **DELETE** Method

Informs the server that its credentials to access the client’s system
are now invalid and can no longer be used. Both parties must end any
automated communication. This is the unregistration process.

This method MUST return a `HTTP status code 405: method not allowed` if
the client has not been registered before.

## Object description

### Credentials object

<table>
<colgroup>
<col style="width: 18%" />
<col style="width: 18%" />
<col style="width: 6%" />
<col style="width: 57%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Property</th>
<th style="text-align: left;">Type</th>
<th style="text-align: left;">Card.</th>
<th style="text-align: left;">Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p>token</p></td>
<td style="text-align: left;"><p><a
href="#types.asciidoc#types_string_type">string</a>(64)</p></td>
<td style="text-align: left;"><p>1</p></td>
<td style="text-align: left;"><p>The credentials token for the other
party to authenticate in your system. It should only contain printable
non-whitespace ASCII characters, that is, characters with Unicode code
points from the range of U+0021 up to and including U+007E.</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>url</p></td>
<td style="text-align: left;"><p><a
href="#types.asciidoc#types_url_type">URL</a></p></td>
<td style="text-align: left;"><p>1</p></td>
<td style="text-align: left;"><p>The URL to your API versions
endpoint.</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>roles</p></td>
<td style="text-align: left;"><p><a
href="#credentials_credentials_role_class">CredentialsRole</a></p></td>
<td style="text-align: left;"><p>+</p></td>
<td style="text-align: left;"><p>List of the roles this party
provides.</p></td>
</tr>
</tbody>
</table>

Every role needs a unique combination of: `role`, `party_id` and
`country_code`.

A platform can have the same role more than once, each with its own
unique `party_id` and `country_code`, for example when a CPO provides
*white-label* services for *virtual* CPOs.

One or more roles and thus `party_id` and `country_code` sets are
provided here to inform a server about the `party_id` and `country_code`
sets a client will use when pushing [Client Owned
Objects](#transport_and_format.asciidoc#transport_and_format_client_owned_object_push).
This helps a server to determine the URLs a client will use when pushing
a [Client Owned
Object](#transport_and_format.asciidoc#transport_and_format_client_owned_object_push).
The `country_code` is added to make certain the URL used when pushing a
[Client Owned
Object](#transport_and_format.asciidoc#transport_and_format_client_owned_object_push)
is unique as there might be multiple parties in the world with the same
`party_id`. The combination of `country_code` and `party_id` should
always be unique though. A party operating in multiple countries can
always use the home country of the company for all connections.

For example: EVSE IDs can be pushed under the country and provider
identification of a company, even if the EVSEs are actually located in a
different country. This way it is not necessary to establish one OCPI
connection per country a company operates in.

The `party_id` and `country_code` given here have no direct link with
the eMI3 EVSE IDs and Contract IDs that might be used in the different
OCPI modules. A party implementing OCPI MAY push EVSE IDs with an eMI3
`spot operator` different from the OCPI `party_id` and/or the
`country_code`.

A Hub SHALL only reports itself as role: Hub. A Hub SHALL NOT report all
the other connected parties as a role on the platform. A Hub SHALL
report connected parties via the [HubClientInfo
module](#mod_hub_client_info.asciidoc#mod_hub_client_info_module).

### Examples

Example of a minimal CPO credentials object:

    {
        "token": "ebf3b399-779f-4497-9b9d-ac6ad3cc44d2",
        "url": "https://example.com/ocpi/versions",
        "roles": [{
            "role": "CPO",
            "party_id": "EXA",
            "country_code": "NL",
            "business_details": {
                "name": "Example Operator"
            }
        }]
    }

Example of a combined CPO/eMSP credentials object:

    {
        "token": "9e80a9c4-28be-11e9-b210-d663bd873d93",
        "url": "https://ocpi.example.com/versions",
        "roles": [{
            "role": "CPO",
            "party_id": "EXA",
            "country_code": "NL",
            "business_details": {
                "name": "Example Operator"
            }
        }, {
            "role": "EMSP",
            "party_id": "EXA",
            "country_code": "NL",
            "business_details": {
                "name": "Example Provider"
            }
        }]
    }

Example of a CPO credentials object with full business details:

    {
        "token": "9e80ae10-28be-11e9-b210-d663bd873d93",
        "url": "https://example.com/ocpi/versions",
        "roles": [{
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
        }]
    }

Example of a CPO credentials object for a platform that provides
services for 3 CPOs:

    {
        "token": "9e80aca8-28be-11e9-b210-d663bd873d93",
        "url": "https://ocpi.example.com/versions",
        "roles": [{
            "role": "CPO",
            "party_id": "EXO",
            "country_code": "NL",
            "business_details": {
                "name": "Excellent Operator"
            }
        }, {
            "role": "CPO",
            "party_id": "PFC",
            "country_code": "NL",
            "business_details": {
                "name": "Plug Flex Charging"
            }
        }, {
            "role": "CPO",
            "party_id": "CGP",
            "country_code": "NL",
            "business_details": {
                "name": "Charging Green Power"
            }
        }]
    }

## Data types

### CredentialsRole *class*

<table>
<colgroup>
<col style="width: 18%" />
<col style="width: 18%" />
<col style="width: 6%" />
<col style="width: 57%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Property</th>
<th style="text-align: left;">Type</th>
<th style="text-align: left;">Card.</th>
<th style="text-align: left;">Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p>role</p></td>
<td style="text-align: left;"><p><a
href="#types.asciidoc#types_role_enum">Role</a></p></td>
<td style="text-align: left;"><p>1</p></td>
<td style="text-align: left;"><p>Type of role.</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>business_details</p></td>
<td style="text-align: left;"><p><a
href="#mod_locations.asciidoc#mod_locations_businessdetails_class">BusinessDetails</a></p></td>
<td style="text-align: left;"><p>1</p></td>
<td style="text-align: left;"><p>Details of this party.</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>party_id</p></td>
<td style="text-align: left;"><p><a
href="#types.asciidoc#types_cistring_type">CiString</a>(3)</p></td>
<td style="text-align: left;"><p>1</p></td>
<td style="text-align: left;"><p>CPO, eMSP (or other role) ID of this
party (following the ISO-15118 standard).</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>country_code</p></td>
<td style="text-align: left;"><p><a
href="#types.asciidoc#types_cistring_type">CiString</a>(2)</p></td>
<td style="text-align: left;"><p>1</p></td>
<td style="text-align: left;"><p>ISO-3166 alpha-2 country code of the
country this party is operating in.</p></td>
</tr>
</tbody>
</table>
