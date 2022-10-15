---
sidebar_position: 7
---

# Multiple peer-to-peer

More a real-world topology when OCPI is used between market parties without a hub, all parties are platforms with
multiple roles.

Disadvantage of this: requires a lot of connections between platforms to be setup, tested and maintained.

```plantuml
@startuml

skinparam agentRoundCorner 8
skinparam rectangleRoundCorner 8
skinparam rectangleRoundCorner 8

left to right direction

  rectangle PLATFORM as MSPP1 {
    agent eMSP1
    agent eMSP2
  }

  rectangle PLATFORM as CPOP1 {
    agent CPO1
    agent CPO2
  }


  rectangle PLATFORM as CPOMSP1 {
    agent eMSP3
    agent CPO3
  }

  rectangle PLATFORM as CPOMSP2 {
    agent eMSP4
    agent CPO4
  }


MSPP1 -- CPOP1
MSPP1 -- CPOMSP1
MSPP1 -- CPOMSP2
CPOP1 -- CPOMSP1
CPOP1 -- CPOMSP2
CPOMSP1 -- CPOMSP2

@enduml
```
