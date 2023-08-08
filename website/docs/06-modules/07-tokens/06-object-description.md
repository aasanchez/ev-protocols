---
id: object-description
slug: /modules/tokens/object-description
---
# Object description

## *AuthorizationInfo* Object

| Property                | Type                                                                                  | Card. | Description                                                                                                                                                                                                                                                     |
|-------------------------|---------------------------------------------------------------------------------------|-------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| allowed                 | [AllowedType](/06-modules/07-tokens/07-data-types.md#allowedtype-enum)                | 1     | Status of the Token, and whether charging is allowed at the optionally given location.                                                                                                                                                                          |
| token                   | [Token](/06-modules/07-tokens/06-object-description.md#token-object)                  | 1     | The complete Token object for which this authorization was requested.                                                                                                                                                                                           |
| location                | [LocationReferences](/06-modules/07-tokens/07-data-types.md#locationreferences-class) | ?     | Optional reference to the location if it was included in the request, and if the EV driver is allowed to charge at that location. Only the EVSEs the EV driver is allowed to charge at are returned.                                                            |
| authorization_reference | [CiString](/07-types/01-intro.md#cistring-type)(36)                                   | ?     | Reference to the authorization given by the eMSP, when given, this reference will be provided in the relevant [Session](/06-modules/04-sessions/06-object-description.md#session-object) and/or [CDR](/06-modules/05-cdrs/06-object-description.md#cdr-object). |
| info                    | [DisplayText](/07-types/01-intro.md#displaytext-class)                                | ?     | Optional display text, additional information to the EV driver.                                                                                                                                                                                                 |

## *Token* Object

| Property             | Type                                                                          | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|----------------------|-------------------------------------------------------------------------------|-------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code         | [CiString](/07-types/01-intro.md#cistring-type)(2)                            | 1     | ISO-3166 alpha-2 country code of the MSP that *owns* this Token.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| party_id             | [CiString](/07-types/01-intro.md#cistring-type)(3)                            | 1     | ID of the eMSP that *owns* this Token (following the ISO-15118 standard).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| uid                  | [CiString](/07-types/01-intro.md#cistring-type)(36)                           | 1     | Unique ID by which this Token, combined with the Token type, can be identified. This is the field used by CPO system (RFID reader on the Charge Point) to identify this token. Currently, in most cases: type=RFID, this is the RFID hidden ID as read by the RFID reader, but that is not a requirement. If this is a `APP_USER` or `AD_HOC_USER` Token, it will be a uniquely, by the eMSP, generated ID. This field is named `uid` instead of `id` to prevent confusion with: `contract_id`.                                                                                            |
| type                 | [TokenType](/06-modules/07-tokens/07-data-types.md#tokentype-enum)            | 1     | Type of the token                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| contract_id          | [CiString](/07-types/01-intro.md#cistring-type)(36)                           | 1     | Uniquely identifies the EV Driver contract token within the eMSP's platform (and suboperator platforms). Recommended to follow the specification for eMA ID from "eMI3 standard version V1.0" (<http://emi3group.com/documents-links/>) "Part 2: business objects."                                                                                                                                                                                                                                                                                                                        |
| visual_number        | [string](/07-types/01-intro.md#string-type)(64)                               | ?     | Visual readable number/identification as printed on the Token (RFID card), might be equal to the contract_id.                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| issuer               | [string](/07-types/01-intro.md#string-type)(64)                               | 1     | Issuing company, most of the times the name of the company printed on the token (RFID card), not necessarily the eMSP.                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| group_id             | [CiString](/07-types/01-intro.md#cistring-type)(36)                           | ?     | This ID groups a couple of tokens. This can be used to make two or more tokens work as one, so that a session can be started with one token and stopped with another, handy when a card and key-fob are given to the EV-driver. Beware that OCPP 1.5/1.6 only support group_ids (it is called parentId in OCPP 1.5/1.6) with a maximum length of 20.                                                                                                                                                                                                                                       |
| valid                | boolean                                                                       | 1     | Is this Token valid                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| whitelist            | [WhitelistType](/06-modules/07-tokens/07-data-types.md#whitelisttype-enum)    | 1     | Indicates what type of white-listing is allowed.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| language             | [string](/07-types/01-intro.md#string-type)(2)                                | ?     | Language Code ISO 639-1. This optional field indicates the Token owner's preferred interface language. If the language is not provided or not supported then the CPO is free to choose its own language.                                                                                                                                                                                                                                                                                                                                                                                   |
| default_profile_type | [ProfileType](/06-modules/04-sessions/07-data-types.md#profiletype-enum)      | ?     | The default [Charging Preference](/06-modules/04-sessions/06-object-description.md#set-charging-preferences). When this is provided, and a charging session is started on an Charge Point that support Preference base Smart Charging and support this [ProfileType](/06-modules/04-sessions/07-data-types.md#profiletype-enum), the Charge Point can start using this [ProfileType](/06-modules/04-sessions/07-data-types.md#profiletype-enum), without this having to be set via: [Set Charging Preferences](/06-modules/04-sessions/06-object-description.md#set-charging-preferences). |
| energy_contract      | [EnergyContract](/06-modules/07-tokens/07-data-types.md#energycontract-class) | ?     | When the Charge Point supports using your own energy supplier/contract at a Charge Point, information about the energy supplier/contract is needed so the CPO knows which energy supplier to use. NOTE: In a lot of countries it is currently not allowed/possible to use a drivers own energy supplier/contract at a Charge Point.                                                                                                                                                                                                                                                        |
| last_updated         | [DateTime](/07-types/01-intro.md#datetime-type)                               | 1     | Timestamp when this Token was last updated (or created).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |

The combination of *uid* and *type* should be unique for every token within the eMSP's system.

:::note
OCPP supports group_id (or ParentID as it is called in OCPP 1.5/1.6) OCPP 1.5/1.6 only support group ID's with maximum
length of string(20), case insensitive. As long as EV-driver can be expected to charge at an OCPP 1.5/1.6 Charge Point,
it is adviced to not used a group_id longer then 20.
:::

### Examples

##### Simple APP_USER example

``` json
{
  "country_code": "DE",
  "party_id": "TNM",
  "uid": "bdf21bce-fc97-11e8-8eb2-f2801f1b9fd1",
  "type": "APP_USER",
  "contract_id": "DE8ACC12E46L89",
  "issuer": "TheNewMotion",
  "valid": true,
  "whitelist": "ALLOWED",
  "last_updated": "2018-12-10T17:16:15Z"
}
```

##### Full RFID example

``` json
{
  "country_code": "DE",
  "party_id": "TNM",
  "uid": "12345678905880",
  "type": "RFID",
  "contract_id": "DE8ACC12E46L89",
  "visual_number": "DF000-2001-8999-1",
  "issuer": "TheNewMotion",
  "group_id": "DF000-2001-8999",
  "valid": true,
  "whitelist": "ALLOWED",
  "language": "it",
  "default_profile_type": "GREEN",
  "energy_contract": {
    "supplier_name": "Greenpeace Energy eG",
    "contract_id": "0123456789"
  },
  "last_updated": "2018-12-10T17:25:10Z"
}
```
