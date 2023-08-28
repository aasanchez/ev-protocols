---
id: object-description
slug: object-description
---
# Object description

## *ClientInfo* Object

| Property     | Type                                                                                                   | Card. | Description                                                                                           |
|--------------|--------------------------------------------------------------------------------------------------------|-------|-------------------------------------------------------------------------------------------------------|
| party_id     | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(3)                                      | 1     | CPO or eMSP ID of this party (following the 15118 ISO standard), as used in the credentials exchange. |
| country_code | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(2)                                      | 1     | Country code of the country this party is operating in, as used in the credentials exchange.          |
| role         | \<\</docs/ocpi/07-types/01-intro.md#role-enum,Role\>\>                                                 | 1     | The role of the connected party.                                                                      |
| status       | \<\</docs/ocpi/06-modules/10-hubclientinfo/07-data-types.md#connectionstatus-enum,ConnectionStatus\>\> | 1     | Status of the connection to the party.                                                                |
| last_updated | \<\</docs/ocpi/07-types/01-intro.md#datetime-type,DateTime\>\>                                         | 1     | Timestamp when this ClientInfo object was last updated.                                               |
