---
id: data-types
slug: /modules/commands/data-types
---
# Data types

## CommandResponseType *enum*

Response to the command request from the eMSP to the CPO.

| Value           | Description                                                                                                    |
|-----------------|----------------------------------------------------------------------------------------------------------------|
| NOT_SUPPORTED   | The requested command is not supported by this CPO, Charge Point, EVSE etc.                                    |
| REJECTED        | Command request rejected by the CPO. (Session might not be from a customer of the eMSP that send this request) |
| ACCEPTED        | Command request accepted by the CPO.                                                                           |
| UNKNOWN_SESSION | The Session in the requested command is not known by this CPO.                                                 |

## CommandResultType *enum*

Result of the command that was sent to the Charge Point.

| Value                | Description                                                                               |
|----------------------|-------------------------------------------------------------------------------------------|
| ACCEPTED             | Command request accepted by the Charge Point.                                             |
| CANCELED_RESERVATION | The Reservation has been canceled by the CPO.                                             |
| EVSE_OCCUPIED        | EVSE is currently occupied, another session is ongoing. Cannot start a new session        |
| EVSE_INOPERATIVE     | EVSE is currently inoperative or faulted.                                                 |
| FAILED               | Execution of the command failed at the Charge Point.                                      |
| NOT_SUPPORTED        | The requested command is not supported by this Charge Point, EVSE etc.                    |
| REJECTED             | Command request rejected by the Charge Point.                                             |
| TIMEOUT              | Command request timeout, no response received from the Charge Point in a reasonable time. |
| UNKNOWN_RESERVATION  | The Reservation in the requested command is not known by this Charge Point.               |

## CommandType *enum*

The command requested.

| Value              | Description                                                                                                           |
|--------------------|-----------------------------------------------------------------------------------------------------------------------|
| CANCEL_RESERVATION | Request the Charge Point to cancel a specific reservation.                                                            |
| RESERVE_NOW        | Request the Charge Point to reserve a (specific) EVSE for a Token for a certain time, starting now.                   |
| START_SESSION      | Request the Charge Point to start a transaction on the given EVSE/Connector.                                          |
| STOP_SESSION       | Request the Charge Point to stop an ongoing session.                                                                  |
| UNLOCK_CONNECTOR   | Request the Charge Point to unlock the connector (if applicable). This functionality is for help desk operators only! |

**The command `UNLOCK_CONNECTOR` may only be used by an operator or the eMSP. This command SHALL never be allowed to be
sent directly by the EV-Driver. The `UNLOCK_CONNECTOR` is intended to be used in the rare situation that the connector
is not unlocked successfully after a transaction is stopped. The mechanical unlock of the lock mechanism might get
stuck, for example: fail when there is tension on the charging cable when the Charge Point tries to unlock the
