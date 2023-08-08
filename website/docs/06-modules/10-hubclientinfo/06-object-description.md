---
id: object-description
slug: /modules/hubclientinfo/object-description
---
# Object description

## *ClientInfo* Object

| Property     | Type                                                                                    | Card. | Description                                                                                           |
|--------------|-----------------------------------------------------------------------------------------|-------|-------------------------------------------------------------------------------------------------------|
| party_id     | [CiString](/07-types/01-intro.md#cistring-type)(3)                                      | 1     | CPO or eMSP ID of this party (following the 15118 ISO standard), as used in the credentials exchange. |
| country_code | [CiString](/07-types/01-intro.md#cistring-type)(2)                                      | 1     | Country code of the country this party is operating in, as used in the credentials exchange.          |
| role         | [Role](/07-types/01-intro.md#role-enum)                                                 | 1     | The role of the connected party.                                                                      |
| status       | [ConnectionStatus](/06-modules/10-hubclientinfo/07-data-types.md#connectionstatus-enum) | 1     | Status of the connection to the party.                                                                |
| last_updated | [DateTime](/07-types/01-intro.md#datetime-type)                                         | 1     | Timestamp when this ClientInfo object was last updated.                                               |
