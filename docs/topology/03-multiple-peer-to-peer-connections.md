---
sidebar_position: 3
---

# Multiple peer-to-peer connections

A more real-world topology where multiple parties connect their platforms
and each platform only has 1 role.
(Not every party necessarily connects with all the other parties with the other role).

```mermaid
graph TB
    A[eMSP1] --- CPO1
    B[eMSP2] --- CPO1
    C[eMSP3] --- CPO1
    D[eMSP4] --- CPO1
    A[eMSP1] --- CPO2
    B[eMSP2] --- CPO2
    C[eMSP3] --- CPO2
    D[eMSP4] --- CPO2
    A[eMSP1] --- CPO3
    B[eMSP2] --- CPO3
    C[eMSP3] --- CPO3
    D[eMSP4] --- CPO3
```
