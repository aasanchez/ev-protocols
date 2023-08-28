---
id: flow-and-lifecycle
slug: locations/flow-and-lifecycle
---
# Flow and Lifecycle

The Locations module has the [Location](/ocpi/06-modules/03-locations/06-object-description.md#location-object) as base
object. Each Location can have multiple EVSEs (1:n) and each EVSE can have multiple Connectors (1:n). With the methods
in the [Receiver interface](/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#receiver-interface), Location
data and status information can be shared with for example an eMSP and NSP. Updates can be made to a whole Location, but
also only to an EVSE or a single Connector.

When a CPO creates Location objects, it pushes them to connected eMSP by calling
[PUT](/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#put-method) on the Receivers Locations endpoint.
eMSPs who do not support Push mode need to call
[GET](/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#get-method) on the CPOs Locations endpoint to receive
the new object. This should be done regularly to stay up to date with the CPOs data, but not too often in order to keep
the load low.

If the CPO wants to replace a Location related object, they again push it to the eMSP systems by calling
[PUT](/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#put-method) on their Locations endpoint.

Any changes to a Location related object can also be pushed to connected eMSPs by calling the
[PATCH](/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#patch-method) method on the eMSPs Locations
endpoint, but using PATCH mode, only actual changes should be pushed. Providers who do not support Push mode need to
call [GET](/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#get-method) on the CPOs Locations endpoint to
receive the updates.

## Delete with status update

When the CPO wants to delete an EVSE from the list of active EVSEs, they MUST update the EVSE's `status` field to
`REMOVED` and call the [PUT](/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#put-method) or
[PATCH](/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#patch-method) on the eMSP system. A Location
without any valid EVSE object can be considered expired and should no longer be displayed. There is no way to entirely
delete Locations, EVSEs and Connectors as there are other modules like
[`sessions`](/ocpi/06-modules/04-sessions/01-intro.md) that depend on them. If it was possible to remove these objects,
those links would no longer work.

When the CPO is not sure about the state or existence of a Location, EVSE or Connector object in the eMSP's system, the
CPO can perform a [GET](/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#get-method-1) request to validate
the object in the eMSP's system.

Private charging Locations, that are not to be used for public charging, SHALL NOT be published via OCPI.

## No public charging or roaming

When a Location is not available for either Public Charging or Roaming, it is RECOMMENDED to NOT send that Location via
OCPI to receiving parties.

## Group of Charge Points

OCPP 2.0 supports a 3-tier model:

* Highest level is a Charge Point
* A Charge Point can have one or more EVSEs.
* Every EVSE can have one or more Connectors.

OCPI does not have this model:

* OCPI has Location at the highest level.
* Each location can have multiple EVSE
* Every EVSE can have one or more Connectors.

When mapping OCPP Charge Points to OCPI, there are 2 options:

* One Location for a group of Charge Points at the same location. (preferred)
* One Location per Charge Point at the same location.

OCPI prefers the first method. An EV driver does not care if a Location consists of one Charge Point with a very large
amount of EVSEs, or a large amount of Charge Points with only one EVSE. The EV driver wants to know how many EVSEs are
available. Grouping Charge Points in the same location into one OCPI Location will show better on a map that shows
Charging Locations.

:::note
By definition, an EVSE can only charge one EV at a time.
:::

## OCPP 1.x Charge Points with multiple connectors per EVSE

OCPP 1.x was not designed to support the 3-tier model. It had no notion of EVSEs. The Open Charge Alliance has written
an Application Note: "Multiple Connectors per EVSE in a OCPP 1.x implementation"

The workaround:

* Define one *virtual* EVSE per Connector.
* When a connector of an hardware EVSE becomes unavailable, set all *virtual* EVSEs for all the connectors of the
  hardware EVSE to unavailable. etc.
