---
id: flow-and-lifecycle
slug: flow-and-lifecycle
---
# Flow and Lifecycle

## Push model

When the CPO creates a Session object they push it to the corresponding eMSP by calling
[PUT](/docs/ocpi/06-modules/04-sessions/05-interfaces-and-endpoints.md#put-method-1) on the eMSP's Sessions endpoint
with the newly created Session object.

Any changes to a Session in the CPO system are sent to the eMSP system by calling
[PATCH](/docs/ocpi/06-modules/04-sessions/05-interfaces-and-endpoints.md#patch-method) on the eMSP's Sessions endpoint
with the updated Session object.

Sessions cannot be deleted, final status of a session is: `COMPLETED`.

When the CPO is not sure about the state or existence of a Session object in the eMSP's system, the CPO can call
[GET](/docs/ocpi/06-modules/04-sessions/05-interfaces-and-endpoints.md#get-method-1) on the eMSP's Sessions endpoint to
validate the Session object in the eMSP's system.

## Pull model

eMSPs who do not support the Push model need to call
[GET](/docs/ocpi/06-modules/04-sessions/05-interfaces-and-endpoints.md#get-method) on the CPO's Sessions endpoint to
receive a list of Sessions.

This [GET](/docs/ocpi/06-modules/04-sessions/05-interfaces-and-endpoints.md#get-method) method can also be used in
combination with the Push model to retrieve Sessions after the system (re-)connects to a CPO, to get a list Sessions
*missed* during a downtime of the eMSP's system.

## Set: Charging Preferences

For a lot of smart charging use cases, input from the driver is needed. The smart charging algorithms need to be able to
give certain session priority over others. In other words they need to know how much energy an EV needs before what
time. Via a [PUT](/docs/ocpi/06-modules/04-sessions/05-interfaces-and-endpoints.md#put-method) request on the Sender
Interface, during an ongoing session, the eMSP can send [Charging
Preferences](/docs/ocpi/06-modules/04-sessions/06-object-description.md#chargingpreferences-object) on behalf of the
driver.

The eMSP can determine if an EVSE supports Charging Preferences by checking if the [EVSE
capabilities](/docs/ocpi/06-modules/03-locations/06-object-description.md#) contains:
[CHARGING_PREFERENCES_CAPABLE](/docs/ocpi/06-modules/03-locations/07-data-types.md#capability-enum).

Via [Tariffs](/docs/ocpi/06-modules/06-tariffs/06-object-description.md#tariff-object) the CPO can give different
Charging Preferences different prices. A
[Connector](/docs/ocpi/06-modules/03-locations/06-object-description.md#connector-object) can have multiple
[Tariffs](/docs/ocpi/06-modules/06-tariffs/06-object-description.md#tariff-object), one for each
[ProfileType](/docs/ocpi/06-modules/04-sessions/07-data-types.md#profiletype-enum).

## Reservation

When a EV driver makes a Reservation for a Charge Point/EVSE, the Sender SHALL create a new Session object with `status`
= `RESERVED` When the Push model is used, the CPO SHALL push the new Session object to the Receiver.

When a reservation results in a charging session for the same `Token`, the Session object `status` to: `ACTIVE`

When a reservation does not result in a charging session, the Session object `status` SHALL be set to: `COMPLETED`.

A CDR might be created even if no energy was transferred to the EV, just for the costs of the reservation.
