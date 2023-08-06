---
id: intro
slug: /modules/commands
---
# Commands

:::tip Module Identifier
commands
:::

:::info Type
Functional Module
:::

The Commands module enables remote commands to be sent to a Location/EVSE. The following commands are supported:

* `CANCEL_RESERVATION`
* `RESERVE_NOW`
* `START_SESSION`
* `STOP_SESSION`
* `UNLOCK_CONNECTOR`

See [CommandType](https://ocpi.dev) for a description of the different commands. *Use the
`UNLOCK_CONNECTOR` command with care, please read the note at [CommandType](https://ocpi.dev).*

**Module dependency:** [Locations module](https://ocpi.dev), [Sessions
module](https://ocpi.dev)

