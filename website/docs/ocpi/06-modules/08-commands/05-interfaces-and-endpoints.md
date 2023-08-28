---
id: interfaces-and-endpoints
slug: interfaces-and-endpoints
---
# Interfaces and endpoints

The commands module consists of two interfaces: a Receiver interface that enables a Sender (typically eMSP) (and its
clients) to send commands to a Location/EVSE and an Sender interface to receive the response from the Location/EVSE
asynchronously.

## Receiver Interface

Typically implemented by market roles like: CPO.

Endpoint structure definition:

`{commands_endpoint_url}{command}`

Examples:

* `https://www.server.com/ocpi/cpo/2.2.1/commands/START_SESSION`
* `https://ocpi.server.com/commands/STOP_SESSION`
* `https://server.com/ocpi/cpo/2.2.1/commands/RESERVE_NOW`

| Method                                                                               | Description                                                                           |
|--------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------|
| GET                                                                                  | n/a                                                                                   |
| [POST](/docs/ocpi/06-modules/08-commands/05-interfaces-and-endpoints.md#post-method) | Send a command to the CPO, requesting the CPO to send the command to the Charge Point |
| PUT                                                                                  | n/a                                                                                   |
| PATCH                                                                                | n/a                                                                                   |
| DELETE                                                                               | n/a                                                                                   |

### **POST** Method

#### Request Parameters

The following parameter shall be provided as URL segments.

| Parameter | Datatype                                                                           | Required | Description                        |
|-----------|------------------------------------------------------------------------------------|----------|------------------------------------|
| command   | [CommandType](/docs/ocpi/06-modules/08-commands/07-data-types.md#commandtype-enum) | yes      | Type of command that is requested. |

### Request Body

Depending on the `command` parameter the body SHALL contain the applicable object for that command.

> Choice: one of five

| Type                                                                                                     | Card. | Description                                                                                                                                      |
|----------------------------------------------------------------------------------------------------------|-------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| [CancelReservation](/docs/ocpi/06-modules/08-commands/06-object-description.md#cancelreservation-object) | 1     | CancelReservation object, for the `CANCEL_RESERVATION` command, with information needed to cancel an existing reservation.                       |
| [ReserveNow](/docs/ocpi/06-modules/08-commands/06-object-description.md#reservenow-object)               | 1     | ReserveNow object, for the `RESERVE_NOW` command, with information needed to reserve a (specific) connector of a Charge Point for a given Token. |
| [StartSession](/docs/ocpi/06-modules/08-commands/06-object-description.md#startsession-object)           | 1     | StartSession object, for the `START_SESSION` command, with information needed to start a sessions.                                               |
| [StopSession](/docs/ocpi/06-modules/08-commands/06-object-description.md#stopsession-object)             | 1     | StopSession object, for the `STOP_SESSION` command, with information needed to stop a sessions.                                                  |
| [UnlockConnector](/docs/ocpi/06-modules/08-commands/06-object-description.md#unlockconnector-object)     | 1     | UnlockConnector object, for the `UNLOCK_CONNECTOR` command, with information needed to unlock a connector of a Charge Point.                     |

#### Response Data

The response contains the direct response from the Receiver, not the response from the Charge Point itself, that will be
sent via an asynchronous POST on the Sender interface if this response is `ACCEPTED`.

| Datatype                                                                                             | Card. | Description                                                                                                                                                                                                             |
|------------------------------------------------------------------------------------------------------|-------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [CommandResponse](/docs/ocpi/06-modules/08-commands/06-object-description.md#commandresponse-object) | 1     | Result of the command request, by the CPO (not the Charge Point). So this indicates if the CPO understood the command request and was able to send it to the Charge Point. This is not the response by the Charge Point |

## Sender Interface

Typically implemented by market roles like: eMSP.

The Sender interface receives the asynchronous responses.

Endpoint structure definition:

No structure defined. This is open to the Sender to define, the URL is provided to the Receiver by the Sender in the
POST to the Receiver interface. Therefor OCPI does not define variables.

Example:

* `https://www.server.com/ocpi/emsp/2.2.1/commands/{command}`
* `https://ocpi.server.com/commands/{command}/{uid}`

| Method                                                                                 | Description                                              |
|----------------------------------------------------------------------------------------|----------------------------------------------------------|
| GET                                                                                    | n/a                                                      |
| [POST](/docs/ocpi/06-modules/08-commands/05-interfaces-and-endpoints.md#post-method-1) | Receive the asynchronous response from the Charge Point. |
| PUT                                                                                    | n/a                                                      |
| PATCH                                                                                  | n/a                                                      |
| DELETE                                                                                 | n/a                                                      |

### **POST** Method

Endpoint structure definition:

It is up to the implementation of the eMSP to determine what parameters are put in the URL. The eMSP sends a URL in the
POST method body to the CPO. The CPO is required to use this URL for the asynchronous response by the Charge Point. It
is advised to make this URL unique for every request to differentiate simultaneous commands, for example by adding a
unique id as a URL segment.

Examples:

* `https://www.server.com/ocpi/emsp/2.2.1/commands/RESERVE_NOW/1234`
* `https://www.server.com/ocpi/emsp/2.2.1/commands/UNLOCK_CONNECTOR/2`

### Request Body

| Datatype                                                                                         | Card. | Description                                           |
|--------------------------------------------------------------------------------------------------|-------|-------------------------------------------------------|
| [CommandResult](/docs/ocpi/06-modules/08-commands/06-object-description.md#commandresult-object) | 1     | Result of the command request, from the Charge Point. |
