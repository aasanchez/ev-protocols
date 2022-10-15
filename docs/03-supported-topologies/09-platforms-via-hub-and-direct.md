---
sidebar_position: 9
---

# Platforms via Hub and direct

Not all Platforms will only communicate via a Hub.
There might be different reasons for Platforms to still have peer-to-peer connections.
The Hub might not yet support new functionality.
The Platforms use a custom module for some new project, which is not supported by the Hub.
etc.

```plantuml
@startuml

skinparam agent {
  roundCorner 8
}

skinparam rectangle {
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

rectangle PLATFORM as HUB_PLATFORM {
  agent Hub
}

MSP1--HUB_PLATFORM: OCPI
MSP2--HUB_PLATFORM: OCPI
MSP3--HUB_PLATFORM: OCPI
HUB_PLATFORM--CPOP1: OCPI
HUB_PLATFORM--CPOP2: OCPI
HUB_PLATFORM--CPOP3: OCPI

MSP1--CPOP1
MSP3--CPOP3

@enduml
```
