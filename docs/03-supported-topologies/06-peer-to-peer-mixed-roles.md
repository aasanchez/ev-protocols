---
sidebar_position: 6
---

# Peer-to-peer mixed roles

Some parties have dual roles, or provide them to other parties and then connect to other companies that do the same.
This topology is a bilateral connection: peer-to-peer between two platforms,
and both platforms have multiple different and also the same roles.

```plantuml
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
  roundCorner 8
}


left to right direction

rectangle PLATFORM as CPOMSP1 {
  agent eMSP1
  agent eMSP2
  agent CPO1
  agent CPO2
}

rectangle PLATFORM as CPOMSP2 {
  agent eMSP4
  agent CPO5
  agent CPO6
  agent CPO7
}

CPOMSP1 -- CPOMSP2: OCPI


'following is only to fix layout
eMSP1 -[hidden]- eMSP4
CPO2 -[hidden]- CPO7

@enduml
```
