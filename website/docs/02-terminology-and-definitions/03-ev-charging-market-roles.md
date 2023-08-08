---
id: ev-charging-market-roles
slug: ev-charging-market-roles
---
# EV Charging Market Roles

In the EV Charging landscape, different market roles can be identified.

| Role            | Description                                                                                                                                                                               |
|-----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **CPO**         | Charging Point Operator. Operates a network of Charge Points.                                                                                                                             |
| **eMSP**        | e-Mobility Service Provider. Gives EV drivers access to charging services.                                                                                                                |
| **Hub**         | Can connect one or more CPOs to one or more eMSPs.                                                                                                                                        |
| **NAP**         | National Access Point. Provides a national database with all (public) charging locations. Information can be sent and retrieved from the NAP. This makes it different from a typical NSP. |
| **NSP**         | Navigation Service Provider. Provides EV drivers with location information of Charge Points. Usually only interested in Location information.                                             |
| **Roaming Hub** | See: Hub.                                                                                                                                                                                 |
| **SCSP**        | Smart Charging Service Provider. Provides Smart Charging service to other parties. Might use a lot of different inputs to calculate Smart Charging Profiles.                              |

Some of these roles can be combined in one company. A Platform can provide service for multiple CPOs or eMSPs, but also
for both eMSPs and CPOs.

OCPI 2.0 and OCPI 2.1.1 had a very strict definition of roles: only CPO and eMSP. But this is rare in the real world,
there are almost no parties that are strictly CPO or eMSP and have their own platform. In the real world, lots of
parties provide service to CPOs that are not running their own platform. A lot of CPOs are also eMSP. With OCPI 2.1.1
and earlier that meant having to set up an OCPI connection per role.

OCPI 2.2 introduced more roles and abstracts the role from the OCPI connection itself. OCPI 2.2 and OCPI 2.2.1 are
described in terms of about Platforms connecting to Platforms, or Platforms connecting via Hubs to other Platforms. The
Platform itself is not a role. The Platform provides services for 1 or more roles.

Examples of platforms:

* A pure CPO: Not providing services to other CPOs. Not being an eMSP. Running its own software that connects via OCPI.
  Is defined in OCPI as a Platform has 1 CPO role, the CPO role of that company.
* A Company that has a cloud-based eMSP software solution, it offers to companies that want to be eMSP, but don't want
  to host/run their own software. Is a Platform that has a number of eMSP roles, one for each eMSP the company is
  providing services for. Not for this company itself because the company itself is not an eMSP.
* A Company that operates public Charge Points and also provides eMSP service to EV drivers, running their own software
  platform. Is seen in OCPI as a Platform that has 2 roles: CPO and eMSP for this company.
* If one the companies above starts to offer their service to other CPOs and eMSP, it is in OCPI still seen as 1
  platform. This platform then provides multiple CPO and eMSP roles.
* A Roaming Hub is in OCPI terms also a Platform, antoher OCPI Platform can connect to it. Most Roamings Hubs only have
  one role: Hub.

## Typical OCPI implementations per Role

The following table shows the typical modules implemented by the different roles. These are not required. The table
shows the typical communication role: Receiver, Sender or Both.

| Modules                                                           | [CPO](/07-types/01-intro.md#role-enum) | [eMSP](/07-types/01-intro.md#role-enum) | [Hub](/07-types/01-intro.md#role-enum) | [NSP](/07-types/01-intro.md#role-enum) | [NAP](/07-types/01-intro.md#role-enum) | [SCSP](/07-types/01-intro.md#role-enum) |
|-------------------------------------------------------------------|----------------------------------------|-----------------------------------------|----------------------------------------|----------------------------------------|----------------------------------------|-----------------------------------------|
| [CDRs](/06-modules/05-cdrs/01-intro.md)                           | Sender                                 | Receiver                                | Both                                   |                                        |                                        |                                         |
| [Charging Profiles](/06-modules/09-charging-profiles/01-intro.md) | Receiver                               |                                         | Both                                   |                                        |                                        | Sender                                  |
| [Commands](/06-modules/08-commands/01-intro.md)                   | Receiver                               | Sender                                  | Both                                   |                                        |                                        |                                         |
| [Credentials](/06-modules/02-credentials/01-intro.md)             | Both                                   | Both                                    | Both                                   | Both                                   | Both                                   | Both                                    |
| [Hub Client Info](/06-modules/10-hubclientinfo/01-intro.md)       | Receiver                               | Receiver                                | Sender                                 | Receiver                               | Receiver                               | Receiver                                |
| [Locations](https://ocpi.dev)                                     | Sender                                 | Receiver                                | Both                                   | Receiver                               | Both                                   |                                         |
| [Sessions](https://ocpi.dev)                                      | Sender                                 | Receiver                                | Both                                   |                                        |                                        | Receiver                                |
| [Tariffs](https://ocpi.dev)                                       | Sender                                 | Receiver                                | Both                                   | Receiver                               | Both                                   |                                         |
| [Tokens](https://ocpi.dev)                                        | Receiver                               | Sender                                  | Both                                   |                                        |                                        |                                         |
| [Versions](/06-modules/01-versions/01-intro.md)                   | Both                                   | Both                                    | Both                                   | Both                                   | Both                                   | Both                                    |
