---
id: object-description
slug: object-description
---
# Object Description

## InterfaceRole *enum*

| Value    | Description                                                                                                                                   |
|----------|-----------------------------------------------------------------------------------------------------------------------------------------------|
| SENDER   | Sender Interface implementation. Interface implemented by the owner of data, so the Receiver can Pull information from the data Sender/owner. |
| RECEIVER | Receiver Interface implementation. Interface implemented by the receiver of data, so the Sender/owner can Push information to the Receiver.   |

## ModuleID *enum*

The Module identifiers for each endpoint are described in the beginning of each *Module* chapter. The following table
contains the list of modules in this version of OCPI. Most modules (except [Credentials &
Registration](https://ocpi.dev)) are optional, but there might be dependencies
between modules. If there are dependencies between modules, it will be mentioned in the affected module description.

| Module                                         | ModuleID         | Remark                                                                              |
|------------------------------------------------|------------------|-------------------------------------------------------------------------------------|
| [CDRs](https://ocpi.dev)                       | cdrs             |                                                                                     |
| [Charging Profiles](https://ocpi.dev)          | chargingprofiles |                                                                                     |
| [Commands](https://ocpi.dev)                   | commands         |                                                                                     |
| [Credentials & Registration](https://ocpi.dev) | credentials      | Required for all implementations. The `role` field has no function for this module. |
| [Hub Client Info](https://ocpi.dev)            | hubclientinfo    |                                                                                     |
| [Locations](https://ocpi.dev)                  | locations        |                                                                                     |
| [Sessions](https://ocpi.dev)                   | sessions         |                                                                                     |
| [Tariffs](https://ocpi.dev)                    | tariffs          |                                                                                     |
| [Tokens](https://ocpi.dev)                     | tokens           |                                                                                     |

## VersionNumber *enum*

List of known versions.

| Value | Description                                                  |
|-------|--------------------------------------------------------------|
| 2.0   | OCPI version 2.0                                             |
| 2.1   | OCPI version 2.1 (DEPRECATED, do not use, use 2.1.1 instead) |
| 2.1.1 | OCPI version 2.1.1                                           |
| 2.2   | OCPI version 2.2 (DEPRECATED, do not use, use 2.2.1 instead) |
| 2.2.1 | OCPI version 2.2.1 (this version)                            |
