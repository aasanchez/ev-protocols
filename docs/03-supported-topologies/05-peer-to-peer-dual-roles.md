---
sidebar_position: 5
---

# Peer-to-peer dual roles

Some parties have dual roles, most of the companies are CPO and eMSP.
This topology is a bilateral connection: peer-to-peer between two platforms,
and both platforms have the CPO and the eMSP roles.

```plantuml
@startuml

skinparam agent {
  roundCorner 8
}

skinparam rectangle {
  roundCorner 8
}


left to right direction

rectangle PLATFORM as CPOMSP1 {
  agent eMSP1
  agent CPO1
}

rectangle PLATFORM as CPOMSP2 {
  agent eMSP2
  agent CPO2
}

CPOMSP1 -- CPOMSP2: OCPI


'following is only to fix layout
CPO1 -[hidden]- CPO1
eMSP1 -[hidden]- eMSP2

@enduml
```
