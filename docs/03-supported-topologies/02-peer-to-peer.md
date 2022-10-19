---
sidebar_position: 2
---

# Peer-to-peer

The simplest topology is a bilateral connection: peer-to-peer between two platforms,
and in the most simple version each platform only has 1 role.

```plantuml Figure 1. peer-to-peer topology example
@startuml

skinparam backgroundColor transparent
skinparam ArrowColor      #c13830
skinparam ArrowThickness  2

skinparam agent {
  BackgroundColor   #fefdca
  BorderColor       #c13830
  BorderThickness   2
  roundCorner       8
}

skinparam rectangle {
  BackgroundColor #fff
  roundCorner     8
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
