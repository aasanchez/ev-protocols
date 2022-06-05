---
sidebar_position: 1
---
# OCPI

## OCPI 2.2.1

During implementation of OCPI 2.2 some issues where found that required updating the protocol to fix them. These are all
minor changes, so most OCPI 2.2 implementations would need no, or only minor changes, to upgrade to OCPI 2.2.1.

For more information on detailed changes see [changelog](http://www.google.com).

## OCPI 2.2

OCPI 2.2 includes new functionality and improvements, compared to OCPI 2.1.1.

### Changes/New functionality

* Support for Hubs
  * [Message routing headers](http://www.google.com)
  * [Hub Client Info](http://www.google.com)
* [Support Platforms with multiple/different roles, additional roles](http://www.google.com)
* [Charging Profiles](http://www.google.com)
* [Preference based Smart Charging](http://www.google.com)
* [Improvements](http://www.google.com)
  * [CRRs](http://www.google.com): Credit CDRs, VAT, Calibration law/Eichrecht support, Session_id, 
    AuthorizationReference, CdrLocation, CdrToken
  * [Sessions](http://www.google.com): VAT, CdrToken, How to add a Charging Period
  * [Tariffs](http://www.google.com): Tariff types, Min/Max price, reservation tariff, Much more examples
  * [Locations](http://www.google.com): Multiple Tariffs, Lots of small improvements
  * [Tokens](http://www.google.com): Group_id, energy contract
  * [Commands](http://www.google.com): Cancel Reservation added

For more information on detailed changes see [changelog](http://www.google.com).

## Introduction and background

The Open Charge Point Interface (OCPI) enables a scalable, automated EV roaming setup between Charge Point Operators and e-
Mobility Service Providers. It supports authorization, charge point information exchange (including live status updates and
transaction events), charge detail record exchange, remote charge point commands and the exchange of smart-charging related
information between parties.

It offers market participants in EV an attractive and scalable solution for (international) roaming between networks, avoiding the
costs and innovation-limiting complexities involved with today's non-automated solutions or with central roaming hubs. As such it
helps to enable EV drivers to charge everywhere in a fully-informed way, helps the market to develop quickly and helps market
players to execute their business models in the best way.

What does it offer (main functionality):

* A good roaming system (for bilateral usage and/or via a hub).
* Real-time information about location, availability and price.
* A uniform way of exchanging data (Notification Data Records and Charge Data Records), before during and after the
transaction.
* Remote mobile support to access any Charge Point without pre-registration.

An international group of over 400 companies from all over the world already supports OCPI. Initiators are EV Box,
New Motion, ElaadNL, BeCharged, GreenFlux and Last Mile Solutions. Other participants include: Next Charge, Freshmile,
Plugsurfing, E55C, GIREVE, OCN, ihomer, Rexel, Stromnetz Hamburg, Enervalis, Place to plug, Plugsurfing, Ecomovement,
Allego, Gronn Kontakt Norway, ENIO, Fastned, AvantIT, Chargemap, Involtum, Capitol Region Denmark, Vattenfall, EON,
ECY Conseil Emeric Chardiny, Eneco Mobility, Google, Jedlix, MTC, Smartlab, Sodetrel, XXIMO, Mnemonics, Share & Charge,
Service House, Alfen / ICU, PI2 Consultancy, Pitpoint, Blue Corner, Building Energy, Chargestorm, Chargepoint, ESARJ,
Chargelab.co, MUVEXT, Next Green Car / Zap Map, Be Mo Tech, Parking Eagle, GraphDefined, Chargecloud,
Rutgerplantengaconsulting, Everon, Tanqyou, Electric Vehicle Association Scotland (EVA NCS), EV-Tech, Plugin Power,
Last Mile Solutions, BIA Power, IBIL, Gridscape, Maxem, Virta, EasyCharger, Total EV Charge, Gowithflow, EKAROS,
Rexel US, Stekker App, Travelcard, Emobility Consulting. The EVRoaming foundation supported by the Netherlands
Knowledge Platform for Charging Infrastructure (NKL) facilitates and coordinates this protocol to guarantee progress and
ensure development and results.

This document describes a combined set of standards based on the work done in the past. Next to that, the evolution of
these standards and their use are taken into account and some elements have been updated to match nowadays use.

### OCPI is developed with support of

evRoaming4EU project and its partners:

![evRoaming4EU](img/evroamingeu_logo.png)

ECISS project and its partners:

![ECISS](img/eciss_logo.png)

The latest version of this specification can be found here: [https://github.com/ocpi/ocpi](https://github.com/ocpi/ocpi)
