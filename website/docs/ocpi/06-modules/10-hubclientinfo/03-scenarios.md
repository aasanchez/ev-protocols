---
id: scenarios
slug: scenarios
---
# Scenarios

This section will describe what the expected behavior is when a party receives information of a ConnectionState change.

## Another Party becomes CONNECTED

Party is (back) online. Request can be sent again. Every party receiving Client Owned Objects from this party should be
prepared to receive Client Owned Objects with URLs that contain the party_id and country_code of this party.

## Another Party goes OFFLINE

Connection to party is not available: No requests can be sent. Do not queue Push messages. When the other party comes
back online, it is their responsibility to do a GET to get back in sync.

## Another Party becomes PLANNED

No requests can be sent to this new party yet. It can be a good idea to sent some notification to an operator to get
into contact with the new party so contracts can be setup. This state may also be used when a Hub has some configuration
indicating which parties have contracts which each other. When a company does not have a connection configured, this
state may also be sent to parties.

## Another Party becomes SUSPENDED

Like with OFFLINE, no requests should be sent to this party, they cannot be delivered.

When, for example, CDRs still have to be delivered (there is some unfinished business) parties are advised to get into
contact with the other party in some other way: call them, or send an e-mail.
