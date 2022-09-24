---
sidebar_position: 3
---

# Multiple peer-to-peer connections

A more real-world topology where multiple parties connect their platforms
and each platform only has 1 role.
(Not every party necessarily connects with all the other parties with the other role).

```mermaid
graph TB
    eMSP1 --- CPO1
    eMSP2 --- CPO1
    eMSP3 --- CPO1
    eMSP1 --- CPO2
    eMSP2 --- CPO2
    eMSP3 --- CPO2
    eMSP4 --- CPO2
    eMSP2 --- CPO3
    eMSP3 --- CPO3
    eMSP4 --- CPO3
```
