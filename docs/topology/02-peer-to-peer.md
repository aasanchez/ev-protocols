---
sidebar_position: 2
---

# Peer-to-peer

The simplest topology is a bilateral connection: peer-to-peer between two platforms,
and in the most simple version each platform only has 1 role.

.peer-to-peer topology example
image::images/architecture_direct.svg[peer-to-peer topology example]

![ECISS logo](http://www.plantuml.com/plantuml/svg/TS-n2i9030RWsJn5Ng2xE5KAWc3feRv0iB4UNdEIIoVfktjj1ple-9ClVqYPZDI6Fa1wUdcHKe_KiHY-OQDnaBQAAgouXH5MHlbc95tWdoxmtT0YgkyUXgsVj8y2y5rpf_trq9nhf8HSNvpBHRYSdZEC_tJbcXMUOhPBHL7CqnqsbJj2oTBcppu0)

```uml
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
asfasd
```mermaid
graph LR
    A[eMSP] -->|CPO| B(OCPI)
```

```mermaid
gantt
dateFormat  YYYY-MM-DD
title Adding GANTT diagram to mermaid
excludes weekdays 2014-01-10

section A section
Completed task            :done,    des1, 2014-01-06,2014-01-08
Active task               :active,  des2, 2014-01-09, 3d
Future task               :         des3, after des2, 5d
Future task2               :         des4, after des3, 5d
```

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```
