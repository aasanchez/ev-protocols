---
id: object-description
slug: /modules/commands/object-description
---
# Object description

## *CancelReservation* Object

With CancelReservation the Sender can request the Cancel of an existing Reservation. The CancelReservation needs to
contain the `reservation_id` that was given by the Sender to the `ReserveNow`.

As there might be cost involved for a Reservation, canceling a reservation might still result in a CDR being send for
the reservation.

| Property       | Type                                                | Card. | Description                                                                                                                                                               |
|----------------|-----------------------------------------------------|-------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| response_url   | [URL](/07-types/01-intro.md#url-type)               | 1     | URL that the CommandResult POST should be sent to. This URL might contain a unique ID to be able to distinguish between CancelReservation requests.                       |
| reservation_id | [CiString](/07-types/01-intro.md#cistring-type)(36) | 1     | Reservation id, unique for this reservation. If the Charge Point already has a reservation that matches this reservationId the Charge Point will replace the reservation. |

## *CommandResponse* Object

The CommandResponse object is send in the HTTP response body.

Because OCPI does not allow/require retries, it could happen that the asynchronous result url given by the eMSP is never
successfully called. The eMSP might have had a glitch, HTTP 500 returned, was offline for a moment etc. For the eMSP to
be able to give a quick as possible response to another system or driver app. It is important for the eMSP to know the
timeout on a certain command.

| Property | Type                                                                                     | Card. | Description                                                                                                                                         |
|----------|------------------------------------------------------------------------------------------|-------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| result   | [CommandResponseType](/06-modules/08-commands/07-data-types.md#commandresponsetype-enum) | 1     | Response from the CPO on the command request.                                                                                                       |
| timeout  | int                                                                                      | 1     | Timeout for this command in seconds. When the Result is not received within this timeout, the eMSP can assume that the message might never be send. |
| message  | [DisplayText](/07-types/01-intro.md#displaytext-class)                                   | \*    | Human-readable description of the result (if one can be provided), multiple languages can be provided.                                              |

## *CommandResult* Object

| Property | Type                                                                                 | Card. | Description                                                                                            |
|----------|--------------------------------------------------------------------------------------|-------|--------------------------------------------------------------------------------------------------------|
| result   | [CommandResultType](/06-modules/08-commands/07-data-types.md#commandresulttype-enum) | 1     | Result of the command request as sent by the Charge Point to the CPO.                                  |
| message  | [DisplayText](/07-types/01-intro.md#displaytext-class)                               | \*    | Human-readable description of the reason (if one can be provided), multiple languages can be provided. |

## *ReserveNow* Object

The `evse_uid` is optional. If no EVSE is specified, the Charge Point should keep one EVSE available for the EV Driver
identified by the given Token. (This might not be supported by all Charge Points). A reservation can be replaced/updated
by sending a `RESERVE_NOW` request with the same Location (Charge Point) and the same `reservation_id`.

A successful reservation will result in a new `Session` object being created by the CPO.

An unused Reservation of a Charge Point/EVSE MAY result in cost being made, thus also a CDR.

The eMSP provides a Token that has to be used by the Charge Point. The Token provided by the eMSP for the `ReserveNow`
SHALL be authorized by the eMSP before sending it to the CPO. Therefor the CPO SHALL NOT check the validity of the Token
provided before sending the request to the Charge Point.

If this is an OCPP Charge Point, the Charge Point decides if it needs to validate the given Token, in such case:

* If this Token is of type `AD_HOC_USER` or `APP_USER` the CPO SHALL NOT do a [realtime
  authorization](/06-modules/07-tokens/04-flow-and-lifecycle.md#real-time-authorization) at the eMSP for this.

* If this Token is of type `RFID`, the CPO SHALL NOT do a [realtime
  authorization](/06-modules/07-tokens/04-flow-and-lifecycle.md#real-time-authorization) at the eMSP for this Token at
  the given EVSE/Charge Point within 15 minutes after having received this `ReserveNow`.

The eMSP MAY use Tokens that have not been pushed via the [Token](/06-modules/07-tokens/01-intro.md) module. This is
especially likely with tokens fof types `AD_HOC_USER` or `APP_USER`. Such Tokens are only used in commands sent by an
eMSP and never presented locally at the Charge Point by a Driver like `RFID` Tokens.

Unknown Tokens received by the CPO in the `ReserveNow` Object don't need to be stored in the
[Token](/06-modules/07-tokens/01-intro.md) module. In other words, when a Token has been received via `ReserveNow`, the
same `Token` does not have to be returned in a Token GET request from the eMSP.

An eMSP sending a `ReserveNow` SHALL only use Tokens that are owned by this eMSP. Using Tokens of other eMSPs is not
allowed.

The `reservation_id` sent by the Sender (eMSP) to the Receiver (CPO) SHALL NOT be sent directly to a Charge Point. The
CPO SHALL make sure the Reservation ID sent to the Charge Point is unique and is not used by another Sender (eMSP). We
don't want a Sender (eMSP) to replace or cancel a reservation of another Sender (eMSP).

| Property                | Type                                                                 | Card. | Description                                                                                                                                                                                                                                                     |
|-------------------------|----------------------------------------------------------------------|-------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| response_url            | [URL](/07-types/01-intro.md#url-type)                                | 1     | URL that the CommandResult POST should be sent to. This URL might contain a unique ID to be able to distinguish between ReserveNow requests.                                                                                                                    |
| token                   | [Token](/06-modules/07-tokens/06-object-description.md#token-object) | 1     | Token object for how to reserve this Charge Point (and specific EVSE).                                                                                                                                                                                          |
| expiry_date             | [DateTime](/07-types/01-intro.md#datetime-type)                      | 1     | The Date/Time when this reservation ends, in UTC.                                                                                                                                                                                                               |
| reservation_id          | [CiString](/07-types/01-intro.md#cistring-type)(36)                  | 1     | Reservation id, unique for this reservation. If the Receiver (typically CPO) Point already has a reservation that matches this reservationId for that Location it will replace the reservation.                                                                 |
| location_id             | [CiString](/07-types/01-intro.md#cistring-type)(36)                  | 1     | Location.id of the Location (belonging to the CPO this request is sent to) for which to reserve an EVSE.                                                                                                                                                        |
| evse_uid                | [CiString](/07-types/01-intro.md#cistring-type)(36)                  | ?     | Optional EVSE.uid of the EVSE of this Location if a specific EVSE has to be reserved.                                                                                                                                                                           |
| authorization_reference | [CiString](/07-types/01-intro.md#cistring-type)(36)                  | ?     | Reference to the authorization given by the eMSP, when given, this reference will be provided in the relevant [Session](/06-modules/04-sessions/06-object-description.md#session-object) and/or [CDR](/06-modules/05-cdrs/06-object-description.md#cdr-object). |

## *StartSession* Object

The `evse_uid` is optional. If no EVSE is specified, the Charge Point can itself decide on which EVSE to start a new
session. (this might not be supported by all Charge Points).

The eMSP provides a Token that has to be used by the Charge Point. The Token provided by the eMSP for the `StartSession`
SHALL be authorized by the eMSP before sending it to the CPO. Therefor the CPO SHALL NOT check the validity of the Token
provided before sending the request to the Charge Point.

If this is an OCPP Charge Point, the Charge Point decides if it needs to validate the given Token, in such case:

* If this Token is of type: `AD_HOC_USER` or `APP_USER` the CPO SHALL NOT do a [realtime
  authorization](/06-modules/07-tokens/04-flow-and-lifecycle.md#real-time-authorization) at the eMSP for this .

* If this Token is of type: `RFID`, the CPO SHALL NOT do a [realtime
  authorization](/06-modules/07-tokens/04-flow-and-lifecycle.md#real-time-authorization) at the eMSP for this Token at
  the given EVSE/Charge Point within 15 minutes after having received this `StartSession`. (This means that if the
  driver decided to use his RFID within 15 minutes at the same Charge Point, because the app is not working somehow, the
  RFID is already authorized)

The eMSP MAY use Tokens that have not been pushed via the [Token](/06-modules/07-tokens/01-intro.md) module, especially
`AD_HOC_USER` or `APP_USER` Tokens are only used by commands send by an eMSP. As these are never used locally at the
Charge Point like `RFID`.

Unknown Tokens received by the CPO in the `StartSession` Object don't need to be stored in the
[Token](/06-modules/07-tokens/01-intro.md) module. In other words, when a Token has been received via `StartSession`,
the same `Token` does not have to be returned in a Token GET request from the eMSP. However, the information of the
Token SHALL be put in the `Session` and `CDR`.

An eMSP sending a `StartSession` SHALL only use Token that are owned by this eMSP in `StartSession`, using Tokens of
other eMSPs is not allowed.

| Property                | Type                                                                 | Card. | Description                                                                                                                                                                                                                                                     |
|-------------------------|----------------------------------------------------------------------|-------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| response_url            | [URL](/07-types/01-intro.md#url-type)                                | 1     | URL that the CommandResult POST should be sent to. This URL might contain a unique ID to be able to distinguish between StartSession requests.                                                                                                                  |
| token                   | [Token](/06-modules/07-tokens/06-object-description.md#token-object) | 1     | Token object the Charge Point has to use to start a new session. The Token provided in this request is authorized by the eMSP.                                                                                                                                  |
| location_id             | [CiString](/07-types/01-intro.md#cistring-type)(36)                  | 1     | Location.id of the Location (belonging to the CPO this request is sent to) on which a session is to be started.                                                                                                                                                 |
| evse_uid                | [CiString](/07-types/01-intro.md#cistring-type)(36)                  | ?     | Optional EVSE.uid of the EVSE of this Location on which a session is to be started. Required when `connector_id` is set.                                                                                                                                        |
| connector_id            | [CiString](/07-types/01-intro.md#cistring-type)(36)                  | ?     | Optional Connector.id of the Connector of the EVSE on which a session is to be started. This field is required when the capability: [START_SESSION_CONNECTOR_REQUIRED](/06-modules/03-locations/07-data-types.md#capability-enum) is set on the EVSE.           |
| authorization_reference | [CiString](/07-types/01-intro.md#cistring-type)(36)                  | ?     | Reference to the authorization given by the eMSP, when given, this reference will be provided in the relevant [Session](/06-modules/04-sessions/06-object-description.md#session-object) and/or [CDR](/06-modules/05-cdrs/06-object-description.md#cdr-object). |

:::note
In case of an OCPP 1.x Charge Point, the EVSE ID should be mapped to the connector ID of a Charge Point. OCPP 1.x does
not have good support for Charge Points that have multiple connectors per EVSE. To make StartSession over OCPI work, the
CPO SHOULD present the different connectors of an EVSE as separate EVSE, as is also written by the OCA in the
application note: "Multiple Connectors per EVSE in a OCPP 1.x implementation".
:::

## *StopSession* Object

| Property     | Type                                                | Card. | Description                                                                                                                                   |
|--------------|-----------------------------------------------------|-------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| response_url | [URL](/07-types/01-intro.md#url-type)               | 1     | URL that the CommandResult POST should be sent to. This URL might contain a unique ID to be able to distinguish between StopSession requests. |
| session_id   | [CiString](/07-types/01-intro.md#cistring-type)(36) | 1     | Session.id of the Session that is requested to be stopped.                                                                                    |

## *UnlockConnector* Object

| Property     | Type                                                | Card. | Description                                                                                                                                       |
|--------------|-----------------------------------------------------|-------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| response_url | [URL](/07-types/01-intro.md#url-type)               | 1     | URL that the CommandResult POST should be sent to. This URL might contain a unique ID to be able to distinguish between UnlockConnector requests. |
| location_id  | [CiString](/07-types/01-intro.md#cistring-type)(36) | 1     | Location.id of the Location (belonging to the CPO this request is sent to) of which it is requested to unlock the connector.                      |
| evse_uid     | [CiString](/07-types/01-intro.md#cistring-type)(36) | 1     | EVSE.uid of the EVSE of this Location of which it is requested to unlock the connector.                                                           |
| connector_id | [CiString](/07-types/01-intro.md#cistring-type)(36) | 1     | Connector.id of the Connector of this Location of which it is requested to unlock.                                                                |
