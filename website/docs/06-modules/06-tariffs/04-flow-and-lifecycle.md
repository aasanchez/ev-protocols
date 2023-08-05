---
id: flow-and-lifecycle
slug: /modules/tariffs/flow-and-lifecycle
---
# Flow and Lifecycle

## Push model

When the CPO creates a new Tariff they push them to the eMSPs by calling the [PUT](https://ocpi.dev) method on
the eMSPs Tariffs endpoint with the newly created Tariff object.

Any changes to the Tariff(s) in the CPO's system can be sent to the eMSPs systems by calling the
[PUT](https://ocpi.dev) method on the eMSPs Tariffs endpoint with the updated Tariff object.

When the CPO deletes a Tariff, they will update the eMSPs systems by calling [DELETE](https://ocpi.dev) on the
eMSPs Tariffs endpoint with the ID of the Tariff that was deleted.

When the CPO is not sure about the state or existence of a Tariff object in the system of an eMSP, the CPO can use a
[GET](https://ocpi.dev) request to validate the Tariff object in the eMSP's system.

## Pull model

eMSPs who do not support the Push model need to call [GET](https://ocpi.dev) on the CPO's Tariff endpoint to
receive all Tariffs, replacing the current list of known Tariffs with the newly received list.
