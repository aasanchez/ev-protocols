---
sidebar_position: 6
---

# Peer-to-peer mixed roles

Some parties have dual roles, or provide them to other parties and then connect to other companies that do the same.
This topology is a bilateral connection: peer-to-peer between two platforms,
and both platforms have multiple different and also the same roles.

```mermaid
flowchart TB
  subgraph platform-a
    direction LR
    eMSP1
    eMSP2
  end

  subgraph platform-b
    direction LR
    eMSP3
    CPO3
  end

  subgraph platform-c
    direction LR
    CPO1
    CPO2
  end

  subgraph platform-d
    direction LR
    eMSP4
    CPO4
  end

  platform-a --- |OCPI|platform-b
  platform-a --- |OCPI|platform-c
  platform-a --- |OCPI|platform-d
  platform-b --- |OCPI|platform-c
  platform-b --- |OCPI|platform-d
  platform-c --- |OCPI|platform-d
```
