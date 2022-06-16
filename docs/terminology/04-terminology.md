---
sidebar_position: 4
---

# Terminology

## Broadcast Push

When communicating via a Hub, a data owner can do a single call to the Hub, the Hub then calls all receiving systems.
See: Broadcast push

## Charge Point

The physical system where an EV can be charged. A Charge Point has one or more EVSEs. Sometimes called Charging Station

## Client Owned Objects

In a normal REST interface the server is the owner of data, when a new resource is created by calling POST, the server
creates the URL where the resource can be found by a client.

OCPI is different, in most modules the owner is the party pushing data to a server, to inform them of updates. For
example Locations, the CPO owns a Location (Charge Point), when a new Charge Point is added, the CPO calls PUT on the
eMSP systems to inform them about new locations. See: Client Owned Objects

## Configuration Module

OCPI Module needed to setup and maintain OCPI connections, but does not provide information for the EV driver: Credentials,
Versions and Hub Client Info. Configuration Modules do NOT use message routing.

## Functional Module

OCPI Module that provides functionality/information for the EV Driver, such as: Tokens, Locations, CDRs etc.  Functional
Modules use message routing.

## Open Routing Request

This is for Platforms that are connected via a Hub. When a system sends a pull request to the Hub, and does not know, or
care about, the owner of information, but asks the Hub to route the GET to the correct Platform. The Hub finds the
correct Platform and routes the request to that Platform. See: Open Routing Request

## Platform

Software that provides services via OCPI. A platform can provide service for a single eMSP or CPO, or for multiple CPOs
or eMSPs. It can even provide services for both eMSPs and CPOs at the same time. A Hub is also an OCPI Platform, most
only have one role: Hub.

## Pull

A system calls GET request to retrieve information from the system that owns the data.

## Push

The system (owning the data) actively calls POST/PUT/PATCH to update other systems with new/updated information.
