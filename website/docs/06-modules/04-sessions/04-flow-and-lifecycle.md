---
id: flow-and-lifecycle
slug: /modules/sessions/flow-and-lifecycle
---
# Flow and Lifecycle

## Push model

When the CPO creates a Session object they push it to the corresponding eMSP by calling
[PUT](https://ocpi.dev) on the eMSP's Sessions endpoint with the newly created Session object.

Any changes to a Session in the CPO system are sent to the eMSP system by calling [PATCH](https://ocpi.dev) on
the eMSP's Sessions endpoint with the updated Session object.

Sessions cannot be deleted, final status of a session is: `COMPLETED`.

When the CPO is not sure about the state or existence of a Session object in the eMSP's system, the CPO can call
[GET](https://ocpi.dev) on the eMSP's Sessions endpoint to validate the Session object in the eMSP's system.

## Pull model

eMSPs who do not support the Push model need to call [GET](https://ocpi.dev) on the CPO's Sessions endpoint
to receive a list of Sessions.

This [GET](https://ocpi.dev) method can also be used in combination with the Push model to retrieve Sessions
after the system (re-)connects to a CPO, to get a list Sessions *missed* during a downtime of the eMSP's system.

## Set: Charging Preferences

For a lot of smart charging use cases, input from the driver is needed. The smart charging algorithms need to be able to
give certain session priority over others. In other words they need to know how much energy an EV needs before what
time. Via a [PUT](https://ocpi.dev) request on the Sender Interface, during an ongoing session, the eMSP can
send [Charging Preferences](https://ocpi.dev) on behalf of the driver.

The eMSP can determine if an EVSE supports Charging Preferences by checking if the [EVSE
capabilities](https://ocpi.dev) contains:
[CHARGING_PREFERENCES_CAPABLE](https://ocpi.dev).

Via [Tariffs](https://ocpi.dev) the CPO can give different Charging Preferences different
prices. A [Connector](https://ocpi.dev) can have multiple
[Tariffs](https://ocpi.dev), one for each [ProfileType](https://ocpi.dev).

## Reservation

When a EV driver makes a Reservation for a Charge Point/EVSE, the Sender SHALL create a new Session object with `status`
= `RESERVED` When the Push model is used, the CPO SHALL push the new Session object to the Receiver.

When a reservation results in a charging session for the same `Token`, the Session object `status` to: `ACTIVE`

When a reservation does not result in a charging session, the Session object `status` SHALL be set to: `COMPLETED`.

A CDR might be created even if no energy was transferred to the EV, just for the costs of the reservation.
