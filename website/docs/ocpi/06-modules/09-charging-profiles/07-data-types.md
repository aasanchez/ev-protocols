---
id: data-types
slug: data-types
---
# Data types

## ActiveChargingProfile *class*

| Property         | Type                                                                                            | Card. | Description                                                                                                                                                 |
|------------------|-------------------------------------------------------------------------------------------------|-------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| start_date_time  | [DateTime](/ocpi/07-types/01-intro.md#datetime-type)                                            | 1     | Date and time at which the Charge Point has calculated this ActiveChargingProfile. All time measurements within the profile are relative to this timestamp. |
| charging_profile | [ChargingProfile](/ocpi/06-modules/09-charging-profiles/07-data-types.md#chargingprofile-class) | 1     | Charging profile structure defines a list of charging periods.                                                                                              |

## ChargingRateUnit *enum*

Unit in which a charging profile is defined.

| Value | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
|-------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| W     | Watts (power) This is the TOTAL allowed charging power. If used for AC Charging, the phase current should be calculated via: Current per phase = Power / (Line Voltage \* Number of Phases). The "Line Voltage" used in the calculation is the Line to Neutral Voltage (VLN). In Europe and Asia VLN is typically 220V or 230V and the corresponding Line to Line Voltage (VLL) is 380V and 400V. The "Number of Phases" is the numberPhases from the ChargingProfilePeriod. It is usually more convenient to use this for DC charging. Note that if numberPhases in a ChargingProfilePeriod is absent, 3 SHALL be assumed. |
| A     | Amperes (current) The amount of Ampere per phase, not the sum of all phases. It is usually more convenient to use this for AC charging.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |

## ChargingProfile *class*

Charging profile class defines a list of charging periods.

| Property                | Type                                                                                                        | Card. | Description                                                                                                                                                                                                                                                                                                                            |
|-------------------------|-------------------------------------------------------------------------------------------------------------|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| start_date_time         | [DateTime](/ocpi/07-types/01-intro.md#datetime-type)                                                        | ?     | Starting point of an absolute profile. If absent the profile will be relative to start of charging.                                                                                                                                                                                                                                    |
| duration                | int                                                                                                         | ?     | Duration of the charging profile in seconds. If the duration is left empty, the last period will continue indefinitely or until end of the transaction in case start_date_time is absent.                                                                                                                                              |
| charging_rate_unit      | [ChargingRateUnit](/ocpi/06-modules/09-charging-profiles/07-data-types.md#chargingrateunit-enum)            | 1     | The unit of measure.                                                                                                                                                                                                                                                                                                                   |
| min_charging_rate       | [number](/ocpi/07-types/01-intro.md#number-type)                                                            | ?     | Minimum charging rate supported by the EV. The unit of measure is defined by the chargingRateUnit. This parameter is intended to be used by a local smart charging algorithm to optimize the power allocation for in the case a charging process is inefficient at lower charging rates. Accepts at most one digit fraction (e.g. 8.1) |
| charging_profile_period | [ChargingProfilePeriod](/ocpi/06-modules/09-charging-profiles/07-data-types.md#chargingprofileperiod-class) | \*    | List of ChargingProfilePeriod elements defining maximum power or current usage over time.                                                                                                                                                                                                                                              |

## ChargingProfilePeriod *class*

Charging profile period structure defines a time period in a charging profile, as used in:
[ChargingProfile](/ocpi/06-modules/09-charging-profiles/07-data-types.md#chargingprofile-class)

| Property     | Type                                             | Card. | Description                                                                                                                                                                |
|--------------|--------------------------------------------------|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| start_period | int                                              | 1     | Start of the period, in seconds from the start of profile. The value of StartPeriod also defines the stop time of the previous period.                                     |
| limit        | [number](/ocpi/07-types/01-intro.md#number-type) | 1     | Charging rate limit during the profile period, in the applicable chargingRateUnit, for example in Amperes (A) or Watts (W). Accepts at most one digit fraction (e.g. 8.1). |

## ChargingProfileResponseType *enum*

Response to the ChargingProfile request from the eMSP to the CPO.

| Value           | Description                                                                                                            |
|-----------------|------------------------------------------------------------------------------------------------------------------------|
| ACCEPTED        | ChargingProfile request accepted by the CPO, request will be forwarded to the EVSE.                                    |
| NOT_SUPPORTED   | The ChargingProfiles not supported by this CPO, Charge Point, EVSE etc.                                                |
| REJECTED        | ChargingProfile request rejected by the CPO. (Session might not be from a customer of the eMSP that send this request) |
| TOO_OFTEN       | ChargingProfile request rejected by the CPO, requests are send more often then allowed.                                |
| UNKNOWN_SESSION | The Session in the requested command is not known by this CPO.                                                         |

## ChargingProfileResultType *enum*

Result of a ChargingProfile request that the EVSE sends via the CPO to the eMSP.

| Value    | Description                                                         |
|----------|---------------------------------------------------------------------|
| ACCEPTED | ChargingProfile request accepted by the EVSE.                       |
| REJECTED | ChargingProfile request rejected by the EVSE.                       |
