---
id: intro
slug: /modules/tokens
---
# Tokens

:::tip Module Identifier
tokens
:::

:::caution Data owner
MSP
:::

:::info Type
Functional Module
:::

The tokens module gives CPOs knowledge of the token information of an eMSP. eMSPs can push Token information to CPOs,
CPOs can build a cache of known Tokens. When a request to authorize comes from a Charge Point, the CPO can check against
this cache. With this cached information they know to which eMSP they can later send a CDR.

