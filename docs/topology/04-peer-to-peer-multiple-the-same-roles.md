---
sidebar_position: 4
---

# Peer-to-peer multiple the same roles

Some parties provide for example CPO or eMSP services for other companies. So the platform hosts multiple parties with
the same role. This topology is a bilateral connection: peer-to-peer between two platforms, and both platforms can have
multiple roles.

```mermaid
flowchart LR
  subgraph platform-a
    direction LR
    eMSP1
    eMSP2
    eMSP3
  end

  subgraph platform-b
    direction LR
    CPO1
    CPO2
  end

  platform-a ---OCPI--- platform-b
```
