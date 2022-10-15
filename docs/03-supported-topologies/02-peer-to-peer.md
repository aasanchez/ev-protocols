---
sidebar_position: 2
---

# Peer-to-peer

The simplest topology is a bilateral connection: peer-to-peer between two platforms,
and in the most simple version each platform only has 1 role.

```plantuml Figure 1. peer-to-peer topology example
@startuml

skinparam agent {
  roundCorner 8
}

skinparam rectangle {
  roundCorner 8
}

left to right direction

rectangle PLATFORM as eMSPP {
  agent eMSP
}

rectangle PLATFORM as CPOP {
  agent CPO
}
eMSPP -- CPOP: OCPI

@enduml
```
