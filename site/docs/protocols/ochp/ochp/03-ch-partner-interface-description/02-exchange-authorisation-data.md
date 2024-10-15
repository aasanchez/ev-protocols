---
sidebar_position: 2
id: exchange-authorisation-data
---
# Exchange Authorisation Data

## Upload own authorisation data (roaming list) to the CHS

The MDM of each EVSP has to exchange the own authorisation data with the
Clearing House to share that data with EVSE Operators. The upload of the
own roaming list is done in the following way:

* MDM sends the SetRoamingAuthorisationList.req PDU.
* CHS responds with a SetRoamingAuthorisationList.conf PDU.

## Update own authorisation data (roaming list) in the CHS

For later updates of authorization data from the MDM to the Clearing
House and the EVSE Operators, only the changed entries (delta) have to
be transferred. The updated roaming list entries have to be sent the
following way:

* MDM sends the UpdateRoamingAuthorisationList.req PDU.
* CHS responds with a UpdateRoamingAuthorisationList.conf PDU.

## Download global roaming authorisation data from CHS

A CMS downloads the global authorisation data repository from the CHS.
The download of the global roaming list is done in the following way:

* CMS sends the GetRoamingAuthorisationList.req PDU.
* CHS responds with GetRoamingAuthorisationList.conf PDU.

## Download updates in global roaming authorisation data from CHS

A CMS downloads the changes to the global authorisation data repository
since the last synchronization from the CHS. The updates in the global
roaming list can be done in the following way:

* CMS sends the GetRoamingAuthorisationListUpdates.req PDU.
* CHS responds with GetRoamingAuthorisationListUpdates.conf PDU.
