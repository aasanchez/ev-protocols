# Definitions

This section contains the terminology that is used throughout this document.

|                                 |                                                                                                                                                                                                                           |
|---------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Central System**              | Charge Point Management System: the central system that manages Charge Points and has the information for authorizing users for using its Charge Points.                                                                  |
| **CiString**                    | Case Insensitive String. Only printable ASCII allowed.                                                                                                                                                                    |
| **Charge Point**                | The Charge Point is the physical system where an electric vehicle can be charged. A Charge Point has one or more connectors.                                                                                              |
| **Charging Profile**            | Generic Charging Profile, used for different types of Profiles. Contains information about the Profile and holds the (Charging Schedule)[#]. In future versions of OCPP it might hold more than 1 [Charging Schedule](#). |
| **Charging Schedule**           | Part of a Charging Profile. Defines a block of charging Power or Current limits. Can contain a start time and length.                                                                                                     |
| **Charging Session**            | A Charging Session is started when first interaction with user or EV occurs. This can be a card swipe, remote start of transaction, connection of cable and/or EV, parking bay occupancy detector, etc.                   |
| **Composite Charging Schedule** | The charging schedule as calculated by the Charge Point. It is the result of the calculation of all active schedules and possible local limits present in the Charge Point. Local Limits might be taken into account.     |
|                                 |                                                                                                                                                                                                                           |
|                                 |                                                                                                                                                                                                                           |
|                                 |                                                                                                                                                                                                                           |
|                                 |                                                                                                                                                                                                                           |


|  |  |
|  |  |
|  |  |
|  |  |
|  |  |