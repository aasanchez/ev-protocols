---
sidebar_position: 8
---

# Platforms via Hub

This topology has all Platforms only connect via a Hub, all communication goes via the Hub.

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

rectangle PLATFORM as MSP1 {
  agent CPO2
  agent eMSP2
}

rectangle PLATFORM as MSP2 {
  agent eMSP3
  agent eMSP4
}

rectangle PLATFORM as MSP3 {
  agent eMSP5
}

rectangle PLATFORM as CPOP1 {
  agent CPO1
  agent eMSP1
}

rectangle PLATFORM as CPOP2 {
  agent CPO3
  agent CPO4
}

rectangle PLATFORM as CPOP3 {
  agent CPO5
}

rectangle PLATFORM as HUBPL {
  agent Hub
}

MSP1--HUBPL: OCPI
MSP2--HUBPL: OCPI
MSP3--HUBPL: OCPI
HUBPL--CPOP1: OCPI
HUBPL--CPOP2: OCPI
HUBPL--CPOP3: OCPI
@enduml
```
