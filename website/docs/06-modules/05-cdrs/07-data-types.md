---
id: data-types
slug: /modules/cdrs/data-types
---
# Data types

## AuthMethod *enum*

| Value        | Description                                                                                                                                                             |
|--------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| AUTH_REQUEST | Authentication request has been sent to the eMSP.                                                                                                                       |
| COMMAND      | Command like [StartSession](https://ocpi.dev) or [ReserveNow](https://ocpi.dev) used to start the Session, the Token provided in the Command was used as authorization. |
| WHITELIST    | Whitelist used for authentication, no request to the eMSP has been performed.                                                                                           |

## CdrDimension *class*

| Property | Type                                        | Card. | Description                                                                 |
|----------|---------------------------------------------|-------|-----------------------------------------------------------------------------|
| type     | [CdrDimensionType](https://ocpi.dev)        | 1     | Type of CDR dimension.                                                      |
| volume   | [number](/07-types/01-intro.md#number-type) | 1     | Volume of the dimension consumed, measured according to the dimension type. |

## CdrDimensionType *enum*

This enumeration contains allowed values for CdrDimensions, which are used to define dimensions of ChargingPeriods in
both `CDRs` and `Sessions`. Some of these values are not useful for `CDRs`, and SHALL therefor only be used in
`Sessions`, these are marked in the column: Session Only

| Value            | Session Only | Description                                                                                                                                                                                              |
|------------------|--------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| CURRENT          | Y            | Average charging current during this [ChargingPeriod](https://ocpi.dev): defined in A (Ampere). When negative, the current is flowing from the EV to the grid.                                           |
| ENERGY           |              | Total amount of energy (dis-)charged during this [ChargingPeriod](https://ocpi.dev): defined in kWh. When negative, more energy was feed into the grid then charged into the EV. Default step_size is 1. |
| ENERGY_EXPORT    | Y            | Total amount of energy feed back into the grid: defined in kWh.                                                                                                                                          |
| ENERGY_IMPORT    | Y            | Total amount of energy charged, defined in kWh.                                                                                                                                                          |
| MAX_CURRENT      |              | Sum of the maximum current over all phases, reached during this [ChargingPeriod](https://ocpi.dev): defined in A (Ampere).                                                                               |
| MIN_CURRENT      |              | Sum of the minimum current over all phases, reached during this [ChargingPeriod](https://ocpi.dev), when negative, current has flowed from the EV to the grid. Defined in A (Ampere).                    |
| MAX_POWER        |              | Maximum power reached during this [ChargingPeriod](https://ocpi.dev): defined in kW (Kilowatt).                                                                                                          |
| MIN_POWER        |              | Minimum power reached during this [ChargingPeriod](https://ocpi.dev): defined in kW (Kilowatt), when negative, the power has flowed from the EV to the grid.                                             |
| PARKING_TIME     |              | Time during this [ChargingPeriod](https://ocpi.dev) not charging: defined in hours, default step_size multiplier is 1 second.                                                                            |
| POWER            | Y            | Average power during this [ChargingPeriod](https://ocpi.dev): defined in kW (Kilowatt). When negative, the power is flowing from the EV to the grid.                                                     |
| RESERVATION_TIME |              | Time during this [ChargingPeriod](https://ocpi.dev) Charge Point has been reserved and not yet been in use for this customer: defined in hours, default step_size multiplier is 1 second.                |
| STATE_OF_CHARGE  | Y            | Current state of charge of the EV, in percentage, values allowed: 0 to 100. See note below.                                                                                                              |
| TIME             |              | Time charging during this [ChargingPeriod](https://ocpi.dev): defined in hours, default step_size multiplier is 1 second.                                                                                |

:::note
OCPI makes it possible to provide SoC in the Session object. This information can be useful to show the current State of
Charge to an EV driver during charging. Implementers should be aware that SoC is only available at some DC Chargers.
Which is currently a small amount of the total amount of Charge Points. Of these DC Chargers, only a small percentage
currently provides SoC via OCPP to the CPO. Then there is also the question if SoC is allowed to be provided to
third-parties as it can be seen as privacy-sensitive information. So if an implementer wants to show SoC in, for example
an App, care should be taken, to make the App work without SoC, as this will probably not always be available.
:::

## CdrLocation *class*

The *CdrLocation* class contains only the relevant information from the
[Location](https://ocpi.dev) object that is needed in a CDR.

| Property             | Type                                                | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|----------------------|-----------------------------------------------------|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| id                   | [CiString](/07-types/01-intro.md#cistring-type)(36) | 1     | Uniquely identifies the location within the CPO's platform (and suboperator platforms). This field can never be changed, modified or renamed.                                                                                                                                                                                                                                                                                                                                                                                                      |
| name                 | [string](/07-types/01-intro.md#string-type)(255)    | ?     | Display name of the location.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| address              | [string](/07-types/01-intro.md#string-type)(45)     | 1     | Street/block name and house number if available.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| city                 | [string](/07-types/01-intro.md#string-type)(45)     | 1     | City or town.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| postal_code          | [string](/07-types/01-intro.md#string-type)(10)     | ?     | Postal code of the location, may only be omitted when the location has no postal code: in some countries charging locations at highways don't have postal codes.                                                                                                                                                                                                                                                                                                                                                                                   |
| state                | [string](/07-types/01-intro.md#string-type)(20)     | ?     | State only to be used when relevant.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| country              | [string](/07-types/01-intro.md#string-type)(3)      | 1     | ISO 3166-1 alpha-3 code for the country of this location.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| coordinates          | [GeoLocation](https://ocpi.dev)                     | 1     | Coordinates of the location.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| evse_uid             | [CiString](/07-types/01-intro.md#cistring-type)(36) | 1     | Uniquely identifies the EVSE within the CPO's platform (and suboperator platforms). For example a database unique ID or the actual *EVSE ID*. This field can never be changed, modified or renamed. This is the *technical* identification of the EVSE, not to be used as *human readable* identification, use the field: `evse_id` for that. Allowed to be set to: [`#NA`](/04-transport-and-format/01-json-http-implementation-guide.md#no-data-available) when this CDR is created for a reservation that never resulted in a charging session. |
| evse_id              | [CiString](/07-types/01-intro.md#cistring-type)(48) | 1     | Compliant with the following specification for EVSE ID from "eMI3 standard version V1.0" (<http://emi3group.com/documents-links/>) "Part 2: business objects.". Allowed to be set to: [`#NA`](/04-transport-and-format/01-json-http-implementation-guide.md#no-data-available) when this CDR is created for a reservation that never resulted in a charging session.                                                                                                                                                                               |
| connector_id         | [CiString](/07-types/01-intro.md#cistring-type)(36) | 1     | Identifier of the connector within the EVSE. Allowed to be set to: [`#NA`](/04-transport-and-format/01-json-http-implementation-guide.md#no-data-available) when this CDR is created for a reservation that never resulted in a charging session.                                                                                                                                                                                                                                                                                                  |
| connector_standard   | [ConnectorType](https://ocpi.dev)                   | 1     | The standard of the installed connector. When this CDR is created for a reservation that never resulted in a charging session, this field can be set to any value and should be ignored by the Receiver.                                                                                                                                                                                                                                                                                                                                           |
| connector_format     | [ConnectorFormat](https://ocpi.dev)                 | 1     | The format (socket/cable) of the installed connector. When this CDR is created for a reservation that never resulted in a charging session, this field can be set to any value and should be ignored by the Receiver.                                                                                                                                                                                                                                                                                                                              |
| connector_power_type | [PowerType](https://ocpi.dev)                       | 1     | When this CDR is created for a reservation that never resulted in a charging session, this field can be set to any value and should be ignored by the Receiver.                                                                                                                                                                                                                                                                                                                                                                                    |

## CdrToken *class*

| Property     | Type                                                | Card. | Description                                                                                                                                                                                                                                                                                                                                                            |
|--------------|-----------------------------------------------------|-------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code | [CiString](/07-types/01-intro.md#cistring-type)(2)  | 1     | ISO-3166 alpha-2 country code of the MSP that *owns* this Token.                                                                                                                                                                                                                                                                                                       |
| party_id     | [CiString](/07-types/01-intro.md#cistring-type)(3)  | 1     | ID of the eMSP that *owns* this Token (following the ISO-15118 standard).                                                                                                                                                                                                                                                                                              |
| uid          | [CiString](/07-types/01-intro.md#cistring-type)(36) | 1     | Unique ID by which this Token can be identified. This is the field used by the CPO's system (RFID reader on the Charge Point) to identify this token. Currently, in most cases: `type=RFID`, this is the RFID hidden ID as read by the RFID reader, but that is not a requirement. If this is a `type=APP_USER` Token, it will be a unique, by the eMSP, generated ID. |
| type         | [TokenType](https://ocpi.dev)                       | 1     | Type of the token                                                                                                                                                                                                                                                                                                                                                      |
| contract_id  | [CiString](/07-types/01-intro.md#cistring-type)(36) | 1     | Uniquely identifies the EV driver contract token within the eMSP's platform (and suboperator platforms). Recommended to follow the specification for eMA ID from "eMI3 standard version V1.0" (<http://emi3group.com/documents-links/>) "Part 2: business objects."                                                                                                    |

## ChargingPeriod *class*

A Charging Period consists of a start timestamp and a list of possible values that influence this period, for example:
amount of energy charged this period, maximum current during this period etc.

| Property        | Type                                                | Card. | Description                                                                                                                           |
|-----------------|-----------------------------------------------------|-------|---------------------------------------------------------------------------------------------------------------------------------------|
| start_date_time | [DateTime](/07-types/01-intro.md#datetime-type)     | 1     | Start timestamp of the charging period. A period ends when the next period starts. The last period ends when the session ends.        |
| dimensions      | [CdrDimension](https://ocpi.dev)                    | \+    | List of relevant values for this charging period.                                                                                     |
| tariff_id       | [CiString](/07-types/01-intro.md#cistring-type)(36) | ?     | Unique identifier of the Tariff that is relevant for this Charging Period. If not provided, no Tariff is relevant during this period. |

## SignedData *class*

This class contains all the information of the signed data. Which encoding method is used, if needed, the public key and
a list of signed values.

| Property                | Type                                                | Card. | Description                                                                                                                                       |
|-------------------------|-----------------------------------------------------|-------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| encoding_method         | [CiString](/07-types/01-intro.md#cistring-type)(36) | 1     | The name of the encoding used in the SignedData field. This is the name given to the encoding by a company or group of companies. See note below. |
| encoding_method_version | int                                                 | ?     | Version of the EncodingMethod (when applicable)                                                                                                   |
| public_key              | [string](/07-types/01-intro.md#string-type)(512)    | ?     | Public key used to sign the data, base64 encoded.                                                                                                 |
| signed_values           | [SignedValue](https://ocpi.dev)                     | \+    | One or more signed values.                                                                                                                        |
| url                     | [string](/07-types/01-intro.md#cistring-type)(512)  | ?     | URL that can be shown to an EV driver. This URL gives the EV driver the possibility to check the signed data from a charging session.             |

:::note
For the German Eichrecht, different solutions are used, all have (somewhat) different encodings. Below the table with
known implementations and the contact information for more information.
:::

| Name                       | Description                                | Contact                          |
|----------------------------|--------------------------------------------|----------------------------------|
| OCMF                       | Proposed by SAFE                           | <https://has-to-be.com>          |
| Alfen Eichrecht            | Alfen Eichrecht encoding / implementation. | <https://alfen.com/de/downloads> |
| EDL40 E-Mobility Extension | eBee smart technologies implementation     | <https://www.ebee.berlin>        |
| EDL40 Mennekes             | Mennekes implementation                    |                                  |

## SignedValue *class*

This class contains the signed and the plain/unsigned data. By decoding the data, the receiver can check if the content
has not been altered.

| Property    | Type                                                | Card. | Description                                                                                                                                                                                                                                                                                                         |
|-------------|-----------------------------------------------------|-------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| nature      | [CiString](/07-types/01-intro.md#cistring-type)(32) | 1     | Nature of the value, in other words, the event this value belongs to. Possible values at moment of writing: - Start (value at the start of the Session) - End (signed value at the end of the Session) - Intermediate (signed values take during the Session, after Start, before End) Others might be added later. |
| plain_data  | [string](/07-types/01-intro.md#string-type)(512)    | 1     | The un-encoded string of data. The format of the content depends on the EncodingMethod field.                                                                                                                                                                                                                       |