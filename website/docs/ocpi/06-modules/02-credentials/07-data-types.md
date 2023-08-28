---
id: data-types
slug: data-types
---
# Data types

## CredentialsRole *class*

| Property         | Type                                                                                    | Card. | Description                                                                    |
|------------------|-----------------------------------------------------------------------------------------|-------|--------------------------------------------------------------------------------|
| role             | [Role](/ocpi/07-types/01-intro.md#role-enum)                                            | 1     | Type of role.                                                                  |
| business_details | [BusinessDetails](/ocpi/06-modules/03-locations/07-data-types.md#businessdetails-class) | 1     | Details of this party.                                                         |
| party_id         | [CiString](/ocpi/07-types/01-intro.md#cistring-type)(3)                                 | 1     | CPO, eMSP (or other role) ID of this party (following the ISO-15118 standard). |
