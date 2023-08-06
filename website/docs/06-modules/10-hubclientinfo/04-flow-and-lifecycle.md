---
id: flow-and-lifecycle
slug: /modules/hubclientinfo/flow-and-lifecycle
---
# Flow and Life-cycle

## Push model

When the Hub creates a new ClientInfo object they push it to the connected parties by calling
[PUT](https://ocpi.dev) on the connected party ClientInfo endpoint with the newly created ClientInfo
object.

Any changes to ClientInfo in the Hub system are sent to the connected party system by calling the
[PUT](https://ocpi.dev) method on the connected party ClientInfo endpoint with the updated ClientInfo.

When the Hub invalidates a ClientInfo object (deleting is not possible), the Hub will send the updated ClientInfo object
(with the field: status set to SUSPENDED, by calling the [PUT](https://ocpi.dev) method on the connected
party ClientInfo endpoint with the updated ClientInfo object.

When the connected party is not sure about the state or existence of a ClientInfo object in the Hub system, the
connected party can call the [GET](https://ocpi.dev) to request to ClientInfo object from the Hub system.

## Pull model

When a connected party is not sure about the state of the list of known connected parties of a Hub, or wants to request
the full list at the start-up of their system, the connected party can call the [GET](https://ocpi.dev) on
the Hubs ClientInfo endpoint to receive all ClientInfo objects. This method is not for operational flow.

## Still alive check.

The hubs needs to determine if a connection is still "alive".

To do this, the Hub should keep track of the time that has passed since the last message was received from a connected
party. When this is longer then X minutes (when unsure, start with 5 minutes) the Hub should send a: GET to the Version
information endpoint. As the Version information endpoint is always required in OCPI, and this endpoint is provided by
all parties, and a GET to the versions endpoint does not have any side effects, this is seen as the best way to do an
"still-alive"check.
