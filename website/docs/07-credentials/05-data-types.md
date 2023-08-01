---
id: data-types
slug: /modules/credentials/data-types
---
# Data types

## CredentialsRole *class*

| Property         | Type                                      | Card. | Description                                                                    |
|------------------|-------------------------------------------|-------|--------------------------------------------------------------------------------|
| role             | [Role](/16-types.md#role-enum)            | 1     | Type of role.                                                                  |
| business_details | [BusinessDetails](https://ocpi.dev)       | 1     | Details of this party.                                                         |
| party_id         | [CiString](/16-types.md#cistring-type)(3) | 1     | CPO, eMSP (or other role) ID of this party (following the ISO-15118 standard). |
| country_code     | [CiString](/16-types.md#cistring-type)(2) | 1     | ISO-3166 alpha-2 country code of the country this party is operating in.       |