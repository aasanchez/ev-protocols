---
id: data-types
slug: /modules/credentials/data-types
---
## Data types

### CredentialsRole *class*

| Property         | Type                                               | Card. | Description                                                                    |
|------------------|----------------------------------------------------|-------|--------------------------------------------------------------------------------|
| role             | [Role](/07-types/01-intro.md#role-enum)            | 1     | Type of role.                                                                  |
| business_details | [BusinessDetails](https://ocpi.dev)                | 1     | Details of this party.                                                         |
| party_id         | [CiString](/07-types/01-intro.md#cistring-type)(3) | 1     | CPO, eMSP (or other role) ID of this party (following the ISO-15118 standard). |
