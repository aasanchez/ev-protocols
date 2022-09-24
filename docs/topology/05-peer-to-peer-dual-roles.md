---
sidebar_position: 5
---

# Peer-to-peer dual roles

Some parties have dual roles, most of the companies are CPO and eMSP.
This topology is a bilateral connection: peer-to-peer between two platforms,
and both platforms have the CPO and the eMSP roles.

```mermaid
flowchart LR
  subgraph platform-a
    direction LR
    eMSP1
    eMSP2
    CPO1
    CPO2
  end

  subgraph platform-b
    direction LR
    eMSP4
    CPO5
    CPO6
    CPO7
  end

  platform-a ---OCPI--- platform-b
```
