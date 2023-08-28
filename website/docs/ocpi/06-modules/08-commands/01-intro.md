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

See \<\</docs/ocpi/06-modules/08-commands/07-data-types.md#commandtype-enum,CommandType\>for a description of the
different commands. *Use the `UNLOCK_CONNECTOR` command with care, please read the note at
\<\</docs/ocpi/06-modules/08-commands/07-data-types.md#commandtype-enum,CommandType\>\>.*

**Module dependency:** \<\</docs/ocpi/06-modules/03-locations/01-intro.md,Locations module\>\>,
\<\</docs/ocpi/06-modules/04-sessions/01-intro.md,Sessions module\>\>
