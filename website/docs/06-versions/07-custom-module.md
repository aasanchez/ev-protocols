---
id: custom-module
slug: /modules/version/custom-module
---
# Custom Modules

Parties are allowed to create custom modules or customized versions of the existing modules. To do so, the [ModuleID
enum](https://ocpi.dev) can be extended with additional custom moduleIDs. These custom
moduleIDs MAY only be sent to parties with which there is an agreement to use a custom module. Do NOT send custom
moduleIDs to parties you are not 100% sure will understand the custom moduleIDs. It is advised to use a prefix (e.g.
country-code + party-id) for any custom moduleID, this ensures that the moduleID will not be used for any future module
of OCPI.

For example: `nltnm-tokens`
