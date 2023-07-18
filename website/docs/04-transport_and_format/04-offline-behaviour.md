---
id: offline-behaviour
slug: transport_and_format/offline-behaviour
---
# Offline behaviour

During communication over OCPI, one of the communicating parties might be unreachable for an undefined amount of time.
OCPI works event-based, new messages and status are pushed from one party to another. When communication is lost,
updates cannot be delivered.

OCPI messages SHOULD NOT be queued. When a client does a POST, PUT or PATCH request and that request fails or times out,
the client should not queue the message and retry the same message again later.

When the connection is re-established, it is up to the target-server of a connection to GET the current status from to
source-server to get back to a synchronized state.

For example:

* CDRs of the period of communication loss can be retrieved with a GET command on the CDRs module, with filters to
  retrieve only CDRs of the period since the last CDR has been received.
