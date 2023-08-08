---
id: flow-and-lifecycle
slug: /modules/tariffs/flow-and-lifecycle
---
# Flow and Lifecycle

## Push model

When the CPO creates a new Tariff they push them to the eMSPs by calling the [PUT](/06-modules/06-tariffs/05-interfaces-and-endpoints.md#put-method) method on
the eMSPs Tariffs endpoint with the newly created Tariff object.

Any changes to the Tariff(s) in the CPO's system can be sent to the eMSPs systems by calling the
[PUT](/06-modules/06-tariffs/05-interfaces-and-endpoints.md#put-method) method on the eMSPs Tariffs endpoint with the updated Tariff object.

When the CPO deletes a Tariff, they will update the eMSPs systems by calling [DELETE](/06-modules/06-tariffs/05-interfaces-and-endpoints.md#delete-method) on the
eMSPs Tariffs endpoint with the ID of the Tariff that was deleted.

When the CPO is not sure about the state or existence of a Tariff object in the system of an eMSP, the CPO can use a
[GET](/06-modules/06-tariffs/05-interfaces-and-endpoints.md#get-method) request to validate the Tariff object in the eMSP's system.

## Pull model

eMSPs who do not support the Push model need to call [GET](/06-modules/06-tariffs/05-interfaces-and-endpoints.md#get-method) on the CPO's Tariff endpoint to
receive all Tariffs, replacing the current list of known Tariffs with the newly received list.
