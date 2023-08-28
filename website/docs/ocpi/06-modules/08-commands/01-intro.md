---
id: intro
slug: /ocpi/modules/commands
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

See [CommandType](/docs/ocpi/06-modules/08-commands/07-data-types.md#commandtype-enum) for a description of the
different commands. *Use the `UNLOCK_CONNECTOR` command with care, please read the note at
[CommandType](/docs/ocpi/06-modules/08-commands/07-data-types.md#commandtype-enum).*

**Module dependency:** [Locations module](/docs/ocpi/06-modules/03-locations/01-intro.md), [Sessions
module](/docs/ocpi/06-modules/04-sessions/01-intro.md)
