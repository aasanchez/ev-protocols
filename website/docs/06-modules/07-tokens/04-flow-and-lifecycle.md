---
id: flow-and-lifecycle
slug: /modules/tokens/flow-and-lifecycle
---
# Flow and Lifecycle

## Push model

When the eMSP creates a new Token object they push it to the CPO by calling [PUT](https://ocpi.dev) on the CPO's
Tokens endpoint with the newly created Token object.

Any changes to Token in the eMSP system are sent to the CPO system by calling either the [PUT](https://ocpi.dev)
or the [PATCH](https://ocpi.dev) on the CPO's Tokens endpoint with the updated Token(s).

When the eMSP invalidates a Token (deleting is not possible), the eMSP will send the updated Token (with the field:
valid set to `false`, by calling, either the [PUT](https://ocpi.dev) or the [PATCH](https://ocpi.dev) on
the CPO's Tokens endpoint with the updated Token.

When the eMSP is not sure about the state or existence of a Token object in the CPO system, the eMSP can call the
[GET](https://ocpi.dev) to validate the Token object in the CPO system.

## Pull model

When a CPO is not sure about the state of the list of known Tokens, or wants to request the full list as a start-up of
their system, the CPO can call the [GET](https://ocpi.dev) on the eMSP's Token endpoint to receive all Tokens,
updating already known Tokens and adding new received Tokens to it own list of Tokens. This is not intended for
real-time operation, requesting the full list of tokens for every authorization will put to much strain on systems. It
is intended for getting in-sync with the server, or to get a list of all tokens (from a server without Push mode) every
X hours.

## Real-time authorization

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
[Location](/06-modules/03-locations/01-intro.md) module, typically a private charger. In most cases this is expected to
result in: `ALLOWED`.
:::

:::note
If real-time authorization is asked for a location, the eMSP SHALL NOT validate that charging is possible based on
information like opening hours or EVSE status etc. as this information might not be up to date.
:::
