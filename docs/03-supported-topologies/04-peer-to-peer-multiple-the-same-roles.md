---
sidebar_position: 4
---

# Peer-to-peer multiple the same roles

Some parties provide for example CPO or eMSP services for other companies. So the platform hosts multiple parties with
the same role. This topology is a bilateral connection: peer-to-peer between two platforms, and both platforms can have
multiple roles.

```plantuml Figure 4. peer-to-peer with multiple roles topology example
@startuml

skinparam agent {
  roundCorner 8
}

skinparam rectangle {
  roundCorner 8
}

left to right direction

rectangle PLATFORM as MSPPP {
  agent eMSP1
  agent eMSP2
  agent eMSP3
}

rectangle PLATFORM as CPOPP {
  agent CPO1
  agent CPO2
}

MSPPP -- CPOPP: OCPI

eMSP1 -[hidden]- CPO1
eMSP3 -[hidden]- CPO2

@enduml
```
