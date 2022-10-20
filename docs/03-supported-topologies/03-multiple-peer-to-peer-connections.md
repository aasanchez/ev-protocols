---
sidebar_position: 3
---

# Multiple peer-to-peer connections

A more real-world topology where multiple parties connect their platforms
and each platform only has 1 role.
(Not every party necessarily connects with all the other parties with the other role).

```plantuml Figure 2. Multiple peer-to-peer topology example
@startuml

skinparam backgroundColor transparent
skinparam ArrowColor      #c13830
skinparam ArrowThickness  2
skinparam ranksep 250

skinparam agent {
  BackgroundColor   #fefdca
  BorderColor       #c13830
  BorderThickness   2
  roundCorner       8
  roundCorner 8
}

skinparam rectangle {
  BackgroundColor #fff
  roundCorner 8
}

rectangle PLATFORM as eMSPP1 {
  agent eMSP1
}

rectangle PLATFORM as eMSPP2 {
  agent eMSP2
}

rectangle PLATFORM as eMSPP3 {
  agent eMSP3
}

rectangle PLATFORM as eMSPP4 {
  agent eMSP4
}

rectangle PLATFORM as CPOP1 {
  agent CPO1
}

rectangle PLATFORM as CPOP2 {
  agent CPO2
}

rectangle PLATFORM as CPOP3 {
  agent CPO3
}

eMSPP1 -- CPOP1 : OCPI
eMSPP2 -- CPOP2
eMSPP1 -- CPOP2 : OCPI
eMSPP2 -- CPOP1
eMSPP2 -- CPOP3
eMSPP3 -- CPOP1
eMSPP3 -- CPOP2
eMSPP3 -- CPOP3 : OCPI
eMSPP4 -- CPOP1
eMSPP4 -- CPOP2
eMSPP4 -- CPOP3 : OCPI

@enduml
```