---
id: flow-and-lifecycle
slug: /modules/cdrs/flow-and-lifecycle
---
# Flow and Lifecycle

CDRs are created by the CPO. They most likely will be sent only to the eMSP that needs to pay the bill of the underlying
charging session. Because a CDR is for billing purposes, it cannot be changed or replaced once sent to the eMSP. Changes
are simply not allowed. Instead, a [Credit CDR](/06-modules/05-cdrs/04-flow-and-lifecycle.md#credit-cdrs) can be sent.

CDRs may be sent for charging locations that have not been published via the
[Location](https://ocpi.dev) module. This is typically for home chargers.

## Credit CDRs

As CDRs are used for billing and can be seen as a kind of invoice, they cannot be deleted. Instead, they have to be
credited.

When a CPO wants to make changes to a CDR that was already sent to the eMSP, the CPO has to send a Credit CDR for the
first CDR. This credit CDR SHALL have a different CDR.id which can be a completely different number, or it can be the id
of the original CDR with something appended like for example: `-C` to make it unique again. To indicate that a CDR is a
Credit CDR, the [`credit`](/06-modules/05-cdrs/06-object-description.md#cdr-object) field has to be set to `true`. The Credit CDR references the old CDR
via the [`credit_reference_id`](/06-modules/05-cdrs/06-object-description.md#cdr-object) field, which SHALL contain the [`id`](/06-modules/05-cdrs/06-object-description.md#cdr-object) of the
original CDR. The Credit CDR will contain all the data of the original CDR. Only the values in the
[`total_cost`](/06-modules/05-cdrs/06-object-description.md#cdr-object) field SHALL contain the negative amounts of the original CDR.

After having sent the Credit CDR, the CPO can send a new CDR with a new unique ID and the fields:
[`credit`](/06-modules/05-cdrs/06-object-description.md#cdr-object) and [`credit_reference_id`](/06-modules/05-cdrs/06-object-description.md#cdr-object) omitted.

:::note
How far back in time a CPO can send a Credit CDR is not defined by OCPI. It is up the business contracts between the
different parties involved, as there might be local laws involved etc.
:::

## Push model

When the CPO creates CDR(s) they push them to the relevant eMSP by calling [POST](/06-modules/05-cdrs/05-interfaces-and-endpoints.md#post-method) on the eMSPs
CDRs endpoint with the newly created CDR(s). A CPO is not required to send *all* CDRs to *all* eMSPs, it is allowed to
only send CDRs to the eMSP that a CDR is relevant to.

CDRs should contain enough information (dimensions) to allow the eMSP to validate the total cost. It is advised to send
enough information to the eMSP so that they can calculate their own costs for billing their customers. An eMSP might
have a very different contract/pricing model with their EV drivers than the tariff structure of the CPO.

If the CPO, for any reason, wants to view a CDR it has posted to an eMSP's system, the CPO can retrieve the CDR by
performing a [GET](/06-modules/05-cdrs/05-interfaces-and-endpoints.md#get-method-1) request on the eMSP's CDRs endpoint at the URL returned in the response to
the [POST](/06-modules/05-cdrs/05-interfaces-and-endpoints.md#post-method).

## Pull model

eMSPs who do not support the Push model need to call [GET](/06-modules/05-cdrs/05-interfaces-and-endpoints.md#get-method) on the CPO's CDRs endpoint to
receive a list of CDRs.

This [GET](/06-modules/05-cdrs/05-interfaces-and-endpoints.md#get-method) can also be used in combination with the Push model to retrieve CDRs after the
system (re-)connects to a CPO, to get a list of CDRs *missed* during a downtime of the eMSP's system.

A CPO is not required to return all known CDRs, the CPO is allowed to return only the CDRs that are relevant for the
requesting eMSP.
