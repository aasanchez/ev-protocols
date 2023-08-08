---
id: data-types
slug: /modules/sessions/data-types
---
# Data types

## ChargingPreferencesResponse *enum*

An enum with possible responses to a [PUT Charging Preferences](/06-modules/04-sessions/05-interfaces-and-endpoints.md#put-method) request.

If a PUT with `ChargingPreferences` is received for an EVSE that does not have the capability
`CHARGING_PREFERENCES_CAPABLE`, the receiver should respond with an HTTP status of 404 and an OCPI status code of 2001
in the [OCPI response object](/04-transport-and-format/01-json-http-implementation-guide.md#response-format).

| Value                      | Description                                                                                                                 |
|----------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| ACCEPTED                   | Charging Preferences accepted, EVSE will try to accomplish them, although this is no guarantee that they will be fulfilled. |
| DEPARTURE_REQUIRED         | CPO requires `departure_time` to be able to perform Charging Preference based Smart Charging.                               |
| ENERGY_NEED_REQUIRED       | CPO requires `energy_need` to be able to perform Charging Preference based Smart Charging.                                  |
| NOT_POSSIBLE               | Charging Preferences contain a demand that the EVSE knows it cannot fulfill.                                                |
| PROFILE_TYPE_NOT_SUPPORTED | `profile_type` contains a value that is not supported by the EVSE.                                                          |

## ProfileType *enum*

Different smart charging profile types.

| Value   | Description                                                                                             |
|---------|---------------------------------------------------------------------------------------------------------|
| CHEAP   | Driver wants to use the cheapest charging profile possible.                                             |
| FAST    | Driver wants his EV charged as quickly as possible and is willing to pay a premium for this, if needed. |
| GREEN   | Driver wants his EV charged with as much regenerative (green) energy as possible.                       |
| REGULAR | Driver does not have special preferences.                                                               |

## SessionStatus *enum*

Defines the state of a session.

| Value       | Description                                                                                                                                                                                                                                                        |
|-------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ACTIVE      | The session has been accepted and is active. All pre-conditions were met: Communication between EV and EVSE (for example: cable plugged in correctly), EV or driver is authorized. EV is being charged, or can be charged. Energy is, or is not, being transfered. |
| COMPLETED   | The session has been finished successfully. No more modifications will be made to the Session object using this state.                                                                                                                                             |
| INVALID     | The Session object using this state is declared invalid and will not be billed.                                                                                                                                                                                    |
| PENDING     | The session is pending, it has not yet started. Not all pre-conditions are met. This is the initial state. The session might never become an *active* session.                                                                                                     |
