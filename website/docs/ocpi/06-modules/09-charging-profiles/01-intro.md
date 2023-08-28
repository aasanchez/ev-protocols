---
id: intro
slug: /ocpi/modules/charging-profiles
---
# ChargingProfiles

:::tip Module Identifier
chargingprofiles
:::

:::info Type
Functional Module
:::

With the ChargingProfiles module, parties (SCSP but also MSPs) can send (Smart) Charging Profiles to a Location/EVSE. It
is also possible to request the *ActiveChargingProfile* from a Location/EVSE.

The ActiveChargingProfile is the charging profile as calculated by the EVSE. It is the result of the calculation of all
smart charging inputs present in the EVSE, also Local Limits might be taken into account.

The ChargingProfile is similar to the concept of Charging Profiles in OCPP, but exposes this functionality to third
parties. These objects and the accompanying interfaces make certain abstractions that make them more suitable for energy
parties to signal their intent. The data structures are base on OCPP 1.6 and 2.0 to make conversion of messages between
OCPI and OCPP easy.

:::note
Charging Profiles set via this module are no guarantee that the EV will charge with the exact given limit, it is a
maximum limit, not a target. A lot of factors influence the charging speed. The EV might not take the amount of energy
that the EVSE is willing to provide to it, the battery might be too warm or almost full. A single phase cable might be
used on a three phase Charge Point. There can be local energy limits (load balancing between EVSEs on a relative small
energy connection to a group of EVSEs) that might limit the energy offered by the EVSE to the EV even further.
:::

ChargingProfile can be created by the owner of a Token on Sessions that belong to that token. If another party sends a
ChargingProfile and the CPO has no contract that allows that party to set profiles on sessions, the CPO is allowed to
reject such profiles.

This module can be used by the eMSP, but can also be used by another party that provide "Smart Charging Services" (Smart
Charging Service Provider (SCSP) / Aggregator / Energy Service Broker etc.) These SCSPs then depend on the CPO sending
session information to them. They need to know which session is ongoing to be able to influence it. If a SCSP uses this
module, read eMSP as SCSP.

:::note
OCPI provides the means for SCSPs to do this. Parties doing this have to adhere to local privacy laws, have to have
setup contracts etc. Local laws might oblige explicit consent from the driver etc.
:::

**Module dependency:** [Sessions module](/docs/ocpi/06-modules/04-sessions/01-intro.md)

## Smart Charging Topologies

There are different Smart Charging Topologies possible. Which topology can be used depends on the contracts between
different parties.

:::note
Care has to be taken to prevent mixing the different topologies. When multiple parties start sending Charging Profiles,
the resulting charging speed might be unpredictable. In case of OCPP Charge Points, the result will be the minimum of
all the Charging Profiles, resulting in a slower than needed charging speed.
:::

### The eMSP generates ChargingProfiles

The most straight forward topology, the eMSP generates ChargingProfiles for its own customers, no SCSP is involved. The
eMSP *owns* the customer, so if the eMSP knows that its customer agrees with the eMSP manipulating the charging speed,
the eMSP is free to do this.

![Smart Charging Topology: The eMSP generates ChargingProfiles](../../images/topology_sc_emsp.svg)

| Interface | Role |
|-----------|------|
| Sender    | eMSP |
| Receiver  | CPO  |

### The eMSP delegated Smart Charging to SCSP

In the topology, the eMSP has delegated the generation of ChargingProfiles to a SCSP. For this, the eMSP and SCSP have
agreed to use OCPI as the interface.

The eMSP *owns* the customer, so if the eMSP knows that its customer agrees with the eMSP manipulating the charging
speed, the eMSP is free to do this. The eMSP can forward OCPI
[Session](/docs/ocpi/06-modules/04-sessions/06-object-description.md#session-object) Objects to the SCSP. the SCSP can
act on the received/updated [Session](/docs/ocpi/06-modules/04-sessions/06-object-description.md#session-object)
Objects, by sending Charging Profile commands via the eMSP to the CPO.

The eMSP and SCSP have to take into account that they have to oblige to local privacy laws when exchanging information
about eMSPs customers.

From the CPO point of view, this topology is similar to the one above, the CPO will not know the difference.

![Smart Charging Topology: The eMSP generates ChargingProfiles](../../images/topology_scsp_emsp.svg)

| Connection  | Interface | Role |
|-------------|-----------|------|
| SCSP - eMSP | Sender    | SCSP |
| SCSP - eMSP | Receiver  | eMSP |
| eMSP - CPO  | Sender    | eMSP |
| eMSP - CPO  | Receiver  | CPO  |

### The CPO delegated Smart Charging to SCSP

In this topology, the CPO has delegated the generation of ChargingProfiles to a SCSP. For this, the CPO and SCSP have
agreed to use OCPI as the interface.

The CPO *owns* the EVSE on which charging happens. As the CPO does not *own* the customers, the CPO needs to make sure
the EV driver knows that the charging speed might not be the maximum the driver has expected, this could be something as
simple as a sticker on the Charge Point, or might even be part of the tariff text.

The CPO might generate ChargingProfiles themselves, but as OCPI is then not used this is not part of this document.

The CPO can forward OCPI [Session](/docs/ocpi/06-modules/04-sessions/06-object-description.md#session-object) Objects to
the SCSP. the SCSP can act on the received/updated
[Session](/docs/ocpi/06-modules/04-sessions/06-object-description.md#session-object) Objects, by sending Charging
Profile commands to the CPO.

The CPO and SCSP have to take into account that they have to oblige to local privacy laws when exchanging information
about eMSPs customers.

In this topology, the eMSP is not aware that the CPO is using OCPI to receive Charging Profiles from the SCSP.

![Smart Charging Topology: The eMSP generates ChargingProfiles](../../images/topology_scsp_cpo.svg)

| Interface | Role |
|-----------|------|
| Sender    | SCSP |
| Receiver  | CPO  |

## Use Cases

This module is designed to support the following use cases, for all the above mentioned topologies.

* The eMSP/SCSP sends/updates a ChargingProfile to manipulate an ongoing charging session.
* The eMSP/SCSP request to remove the set ChargingProfile from an ongoing charging session.
* The eMSP/SCSP request the ActiveChargingProfile for an ongoing charging session.
* The CPO updates the eMSP/SCSP of changes to an ActiveChargingProfile.
