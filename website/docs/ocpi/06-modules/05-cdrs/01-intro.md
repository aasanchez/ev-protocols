---
id: intro
slug: /ocpi/modules/cdrs
---
# CDRs

:::tip Module Identifier
cdrs
:::

:::caution Data owner
CPO
:::

:::info Type
Functional Module
:::

A **Charge Detail Record** is the description of a concluded charging session. The CDR is the only billing-relevant
object. CDRs are sent from the CPO to the eMSP after the charging session has ended. Although there is no requirement to
send CDRs in (semi-) realtime, it is seen as good practice to send them as soon as possible. But if there is an
agreement between parties to send them, for example, once a month, that is also allowed by OCPI.
