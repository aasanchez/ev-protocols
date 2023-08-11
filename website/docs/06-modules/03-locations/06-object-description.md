---
id: object-description
slug: /modules/locations/object-description
---
# Object description

Location, EVSE and Connector have the following relation.

![Location class diagram](../../images/locations-class-diagram.svg)

## *Location* Object

The *Location* object describes the location and its properties where a group of EVSEs that belong together are
installed. Typically, the *Location* object is the exact location of the group of EVSEs, but it can also be the entrance
of a parking garage which contains these EVSEs. The exact way to reach each EVSE can be further specified by its own
properties.

Locations may be shown in apps or on websites etc. when the flag: `publish` is set to `true`. Locations that have this
flag set to `false` SHALL not be shown in an app or on a website etc. unless it is to the owner of a
[Token](/06-modules/07-tokens/06-object-description.md#token-object) in the `publish_allowed_to` list. Even parties like
NSP or eMSP that do not *own* this Token MAY show this location on an app or website, but only to the owner of that
Token. If the user of their app/website has provided information about his/her
[Token](/06-modules/07-tokens/06-object-description.md#token-object), And that information matches all the fields of one
of the [PublishToken](/06-modules/03-locations/07-data-types.md#publishtokentype-class) tokens in the list, then they
are allowed to show this location to their user. It is not allowed in OCPI to use a Token that is not *owned* by the
eMSP itself to start a charging session.

| Property             | Type                                                                                           | Card. | Description                                                                                                                                                                                                                                                                                                        |
|----------------------|------------------------------------------------------------------------------------------------|-------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code         | [CiString](/07-types/01-intro.md#cistring-type)(2)                                             | 1     | ISO-3166 alpha-2 country code of the CPO that *owns* this Location.                                                                                                                                                                                                                                                |
| party_id             | [CiString](/07-types/01-intro.md#cistring-type)(3)                                             | 1     | ID of the CPO that *owns* this Location (following the ISO-15118 standard).                                                                                                                                                                                                                                        |
| id                   | [CiString](/07-types/01-intro.md#cistring-type)(36)                                            | 1     | Uniquely identifies the location within the CPOs platform (and suboperator platforms). This field can never be changed, modified or renamed.                                                                                                                                                                       |
| publish              | boolean                                                                                        | 1     | Defines if a Location may be published on an website or app etc. When this is set to `false`, only tokens identified in the field: `publish_allowed_to` are allowed to be shown this Location. When the same location has EVSEs that may be published and may not be published, two *Locations* should be created. |
| publish_allowed_to   | [PublishTokenType](/06-modules/03-locations/07-data-types.md#publishtokentype-class)           | \*    | This field may only be used when the `publish` field is set to `false`. Only owners of Tokens that match all the set fields of one PublishToken in the list are allowed to be shown this location.                                                                                                                 |
| name                 | [string](/07-types/01-intro.md#string-type)(255)                                               | ?     | Display name of the location.                                                                                                                                                                                                                                                                                      |
| address              | [string](/07-types/01-intro.md#string-type)(45)                                                | 1     | Street/block name and house number if available.                                                                                                                                                                                                                                                                   |
| city                 | [string](/07-types/01-intro.md#string-type)(45)                                                | 1     | City or town.                                                                                                                                                                                                                                                                                                      |
| postal_code          | [string](/07-types/01-intro.md#string-type)(10)                                                | ?     | Postal code of the location, may only be omitted when the location has no postal code: in some countries charging locations at highways don't have postal codes.                                                                                                                                                   |
| state                | [string](/07-types/01-intro.md#string-type)(20)                                                | ?     | State or province of the location, only to be used when relevant.                                                                                                                                                                                                                                                  |
| country              | [string](/07-types/01-intro.md#string-type)(3)                                                 | 1     | ISO 3166-1 alpha-3 code for the country of this location.                                                                                                                                                                                                                                                          |
| coordinates          | [GeoLocation](/06-modules/03-locations/07-data-types.md#geolocation-class)                     | 1     | Coordinates of the location.                                                                                                                                                                                                                                                                                       |
| related_locations    | [AdditionalGeoLocation](/06-modules/03-locations/07-data-types.md#additionalgeolocation-class) | \*    | Geographical location of related points relevant to the user.                                                                                                                                                                                                                                                      |
| parking_type         | [ParkingType](/06-modules/03-locations/07-data-types.md#parkingtype-enum)                      | ?     | The general type of parking at the charge point location.                                                                                                                                                                                                                                                          |
| evses                | [EVSE](/06-modules/03-locations/06-object-description.md#evse-object)                          | \*    | List of EVSEs that belong to this Location.                                                                                                                                                                                                                                                                        |
| directions           | [DisplayText](/07-types/01-intro.md#displaytext-class)                                         | \*    | Human-readable directions on how to reach the location.                                                                                                                                                                                                                                                            |
| operator             | [BusinessDetails](/06-modules/03-locations/07-data-types.md#businessdetails-class)             | ?     | Information of the operator. When not specified, the information retrieved from the [Credentials](/06-modules/02-credentials/01-intro.md) module, selected by the `country_code` and `party_id` of this Location, should be used instead.                                                                          |
| suboperator          | [BusinessDetails](/06-modules/03-locations/07-data-types.md#businessdetails-class)             | ?     | Information of the suboperator if available.                                                                                                                                                                                                                                                                       |
| owner                | [BusinessDetails](/06-modules/03-locations/07-data-types.md#businessdetails-class)             | ?     | Information of the owner if available.                                                                                                                                                                                                                                                                             |
| facilities           | [Facility](/06-modules/03-locations/07-data-types.md#facility-enum)                            | \*    | Optional list of facilities this charging location directly belongs to.                                                                                                                                                                                                                                            |
| time_zone            | [string](/07-types/01-intro.md#string-type)(255)                                               | 1     | One of IANA tzdata's TZ-values representing the time zone of the location. Examples: "Europe/Oslo", "Europe/Zurich". (<http://www.iana.org/time-zones>)                                                                                                                                                            |
| opening_times        | [Hours](/06-modules/03-locations/07-data-types.md#hours-class)                                 | ?     | The times when the EVSEs at the location can be accessed for charging.                                                                                                                                                                                                                                             |
| charging_when_closed | boolean                                                                                        | ?     | Indicates if the EVSEs are still charging outside the opening hours of the location. E.g. when the parking garage closes its barriers over night, is it allowed to charge till the next morning? Default: **true**                                                                                                 |
| images               | [Image](/06-modules/03-locations/07-data-types.md#image-class)                                 | \*    | Links to images related to the location such as photos or logos.                                                                                                                                                                                                                                                   |
| energy_mix           | [EnergyMix](/06-modules/03-locations/07-data-types.md#energymix-class)                         | ?     | Details on the energy supplied at this location.                                                                                                                                                                                                                                                                   |
| last_updated         | [DateTime](/07-types/01-intro.md#datetime-type)                                                | 1     | Timestamp when this Location or one of its EVSEs or Connectors were last updated (or created).                                                                                                                                                                                                                     |

Private Charge Points, home or business that do not need to be published on apps, and do not require remote control via
OCPI, SHOULD not be PUT via the OCPI Locations module.

### Example public charging location

This is an example of a public charging location. Can be used by any EV Driver as long as his eMSP has a roaming
agreement with the CPO. Or the Charge Point has an ad-hoc payment possibility

* `publish` = `true`
* `parking_type` = `ON_STREET` but could also be another value.
* `EVSE.parking_restrictions` not used.

```json
{
  "country_code": "BE",
  "party_id": "BEC",
  "id": "LOC1",
  "publish": true,
  "name": "Gent Zuid",
  "address": "F.Rooseveltlaan 3A",
  "city": "Gent",
  "postal_code": "9000",
  "country": "BEL",
  "coordinates": {
    "latitude": "51.047599",
    "longitude": "3.729944"
  },
  "parking_type": "ON_STREET",
  "evses": [
    {
      "uid": "3256",
      "evse_id": "BE*BEC*E041503001",
      "status": "AVAILABLE",
      "capabilities": [
        "RESERVABLE"
      ],
      "connectors": [
        {
          "id": "1",
          "standard": "IEC_62196_T2",
          "format": "CABLE",
          "power_type": "AC_3_PHASE",
          "max_voltage": 220,
          "max_amperage": 16,
          "tariff_ids": [
            "11"
          ],
          "last_updated": "2015-03-16T10:10:02Z"
        },
        {
          "id": "2",
          "standard": "IEC_62196_T2",
          "format": "SOCKET",
          "power_type": "AC_3_PHASE",
          "max_voltage": 220,
          "max_amperage": 16,
          "tariff_ids": [
            "13"
          ],
          "last_updated": "2015-03-18T08:12:01Z"
        }
      ],
      "physical_reference": "1",
      "floor_level": "-1",
      "last_updated": "2015-06-28T08:12:01Z"
    },
    {
      "uid": "3257",
      "evse_id": "BE*BEC*E041503002",
      "status": "RESERVED",
      "capabilities": [
        "RESERVABLE"
      ],
      "connectors": [
        {
          "id": "1",
          "standard": "IEC_62196_T2",
          "format": "SOCKET",
          "power_type": "AC_3_PHASE",
          "max_voltage": 220,
          "max_amperage": 16,
          "tariff_ids": [
            "12"
          ],
          "last_updated": "2015-06-29T20:39:09Z"
        }
      ],
      "physical_reference": "2",
      "floor_level": "-2",
      "last_updated": "2015-06-29T20:39:09Z"
    }
  ],
  "operator": {
    "name": "BeCharged"
  },
  "time_zone": "Europe/Brussels",
  "last_updated": "2015-06-29T20:39:09Z"
}
```

### Example destination charging location

This is an example of a destination charging location. This is a Location where only guests, employees or customers can
charge. For an EV driver, it can be useful to know if he/she can charge at his destination.

For example at a restaurant, only customers of the restaurant can charge their EV. Or at an office building where
employees and guest of the office can charge their EV.

Locations you can think of where this is useful: restaurants, bars, clubs, theme parks, stores, supermarkets, company
building, office buildings, etc.

* `publish` = `true`
* `parking_type` = `PARKING_LOT` (but could also be `PARKING_GARAGE`, `ON_DRIVEWAY` or `UNDERGROUND_GARAGE`)
* `EVSE.parking_restrictions` = `CUSTOMERS`

```json
{
  "country_code": "NL",
  "party_id": "ALF",
  "id": "3e7b39c2-10d0-4138-a8b3-8509a25f9920",
  "publish": true,
  "name": "ihomer",
  "address": "Tamboerijn 7",
  "city": "Etten-Leur",
  "postal_code": "4876 BS",
  "country": "NLD",
  "coordinates": {
    "latitude": "51.562787",
    "longitude": "4.638975"
  },
  "parking_type": "PARKING_LOT",
  "evses": [
    {
      "uid": "fd855359-bc81-47bb-bb89-849ae3dac89e",
      "evse_id": "NL*ALF*E000000001",
      "status": "AVAILABLE",
      "connectors": [
        {
          "id": "1",
          "standard": "IEC_62196_T2",
          "format": "SOCKET",
          "power_type": "AC_3_PHASE",
          "max_voltage": 220,
          "max_amperage": 16,
          "last_updated": "2019-07-01T12:12:11Z"
        }
      ],
      "parking_restrictions": [
        "CUSTOMERS"
      ],
      "last_updated": "2019-07-01T12:12:11Z"
    }
  ],
  "time_zone": "Europe/Amsterdam",
  "last_updated": "2019-07-01T12:12:11Z"
}
```

### Example destination charging location not published, but paid guest usage possible

This is an example of a destination charging location. But the owner of the location has requested not to publish the
location in Apps or on websites.

Charging is still possible: EV drivers of an eMSP with a roaming agreement can still charge their EV. The eMSP helpdesk
can use the information from the Location module to help the driver, maybe even start a session for a driver. Starting a
session from an App is not possible, because the driver will not be able to select the Charge Point on a map.

In case the EV driver is not billed for charging, there is, in such a case, no reason to publish the location via OCPI.

* `publish` = `false`
* `publish_allowed_to` not used
* `parking_type` = not used\`
* `EVSE.parking_restrictions` = `CUSTOMERS` May still be useful so a support desk can also tell this to a customer.

```json
{
  "country_code": "NL",
  "party_id": "ALF",
  "id": "3e7b39c2-10d0-4138-a8b3-8509a25f9920",
  "publish": false,
  "name": "ihomer",
  "address": "Tamboerijn 7",
  "city": "Etten-Leur",
  "postal_code": "4876 BS",
  "country": "NLD",
  "coordinates": {
    "latitude": "51.562787",
    "longitude": "4.638975"
  },
  "evses": [
    {
      "uid": "fd855359-bc81-47bb-bb89-849ae3dac89e",
      "evse_id": "NL*ALF*E000000001",
      "status": "AVAILABLE",
      "connectors": [
        {
          "id": "1",
          "standard": "IEC_62196_T2",
          "format": "SOCKET",
          "power_type": "AC_3_PHASE",
          "max_voltage": 220,
          "max_amperage": 16,
          "last_updated": "2019-07-01T12:12:11Z"
        }
      ],
      "parking_restrictions": [
        "CUSTOMERS"
      ],
      "last_updated": "2019-07-01T12:12:11Z"
    }
  ],
  "time_zone": "Europe/Amsterdam",
  "last_updated": "2019-07-01T12:12:11Z"
}
```

### Example charging location with limited visibility

This is an example of a charging location that only a limited group can see (and use) via an App or website.

Typical examples where this is useful:

* Charge Points in the parking garage of an apartment building. Only owners can see/control the Charge Points.
* Charge Points at an office, for employees only. Only employees can see/control the Charge Points.
* Charge Points at vehicle depot. Any employee can see/control an charge point, even transaction they did not start. Use
  `group_id` for this.

The locations SHALL NOT be published to the general public. Only selected
[Tokens](/06-modules/07-tokens/06-object-description.md#token-object) can see (and control) the Charge Points via eMSP
app.

* `publish` = `false`
* `publish_allowed_to` contains list with information of
  [Tokens](/06-modules/07-tokens/06-object-description.md#token-object) that are allowed to be shown the `Location`.
* `parking_type` = `UNDERGROUND_GARAGE` (but could also be `PARKING_GARAGE`, `ON_DRIVEWAY` or `PARKING_LOT`)

```json
{
  "country_code": "NL",
  "party_id": "ALL",
  "id": "f76c2e0c-a6ef-4f67-bf23-6a187e5ca0e0",
  "publish": false,
  "publish_allowed_to": [
    {
      "visual_number": "12345-67",
      "issuer": "NewMotion"
    },
    {
      "visual_number": "0055375624",
      "issuer": "ANWB"
    },
    {
      "uid": "12345678905880",
      "type": "RFID"
    }
  ],
  "name": "Water State",
  "address": "Taco van der Veenplein 12",
  "city": "Leeuwarden",
  "postal_code": "8923 EM",
  "country": "NLD",
  "coordinates": {
    "latitude": "53.213763",
    "longitude": "5.804638"
  },
  "parking_type": "UNDERGROUND_GARAGE",
  "evses": [
    {
      "uid": "8c1b3487-61ac-40a7-a367-21eee99dbd90",
      "evse_id": "NL*ALL*EGO0000013",
      "status": "AVAILABLE",
      "connectors": [
        {
          "id": "1",
          "standard": "IEC_62196_T2",
          "format": "SOCKET",
          "power_type": "AC_3_PHASE",
          "max_voltage": 230,
          "max_amperage": 16,
          "last_updated": "2019-09-27T00:19:45Z"
        }
      ],
      "last_updated": "2019-09-27T00:19:45Z"
    }
  ],
  "time_zone": "Europe/Amsterdam",
  "last_updated": "2019-09-27T00:19:45Z"
}
```

### Example private charge point with eMSP app control

This is an example of a private/home charge point that needs to be controlled via an eMSP App.

The locations SHALL NOT be published to the general public. Only the owner, identified by his/her
[Token](/06-modules/07-tokens/06-object-description.md#token-object) can see (and control) the Charge Points via an eMSP
app.

* `publish` = `false`
* `publish_allowed_to` contains the information of the
  [Tokens](/06-modules/07-tokens/06-object-description.md#token-object) of the owner.
* `parking_type` = not used, not relevant, owner knows where his Charge Point is.

```json
{
  "country_code": "DE",
  "party_id": "ALL",
  "id": "a5295927-09b9-4a71-b4b9-a5fffdfa0b77",
  "publish": false,
  "publish_allowed_to": [
    {
      "visual_number": "0123456-99",
      "issuer": "MoveMove"
    }
  ],
  "address": "Krautwigstraße 283A",
  "city": "Köln",
  "postal_code": "50931",
  "country": "DEU",
  "coordinates": {
    "latitude": "50.931826",
    "longitude": "6.964043"
  },
  "parking_type": "ON_DRIVEWAY",
  "evses": [
    {
      "uid": "4534ad5f-45be-428b-bfd0-fa489dda932d",
      "evse_id": "DE*ALL*EGO0000001",
      "status": "AVAILABLE",
      "connectors": [
        {
          "id": "1",
          "standard": "IEC_62196_T2",
          "format": "SOCKET",
          "power_type": "AC_1_PHASE",
          "max_voltage": 230,
          "max_amperage": 8,
          "last_updated": "2019-04-05T17:17:56Z"
        }
      ],
      "last_updated": "2019-04-05T17:17:56Z"
    }
  ],
  "time_zone": "Europe/Berlin",
  "last_updated": "2019-04-05T17:17:56Z"
}
```

### Example charge point in a parking garage with opening hours

This is an example of a charge point, located in a parking garage with limited opening hours: 7:00 * 18:00.

If the EV is left in the parking garage overnight, the car will still be charged.

* `publish` = `true`
* `parking_type` = `PARKING_GARAGE` but could also be another value.
* `EVSE.parking_restrictions` not used.
* `opening_times` is used.
* `charging_when_closed` = `true`

```json
{
  "country_code": "SE",
  "party_id": "EVC",
  "id": "cbb0df21-d17d-40ba-a4aa-dc588c8f98cb",
  "publish": true,
  "name": "P-Huset Leonard",
  "address": "Claesgatan 6",
  "city": "Malmö",
  "postal_code": "214 26",
  "country": "SWE",
  "coordinates": {
    "latitude": "55.590325",
    "longitude": "13.008307"
  },
  "parking_type": "PARKING_GARAGE",
  "evses": [
    {
      "uid": "eccb8dd9-4189-433e-b100-cc0945dd17dc",
      "evse_id": "SE*EVC*E000000123",
      "status": "AVAILABLE",
      "connectors": [
        {
          "id": "1",
          "standard": "IEC_62196_T2",
          "format": "SOCKET",
          "power_type": "AC_3_PHASE",
          "max_voltage": 230,
          "max_amperage": 32,
          "last_updated": "2017-03-07T02:21:22Z"
        }
      ],
      "last_updated": "2017-03-07T02:21:22Z"
    }
  ],
  "time_zone": "Europe/Stockholm",
  "opening_times": {
    "twentyfourseven": false,
    "regular_hours": [
      {
        "weekday": 1,
        "period_begin": "07:00",
        "period_end": "18:00"
      },
      {
        "weekday": 2,
        "period_begin": "07:00",
        "period_end": "18:00"
      },
      {
        "weekday": 3,
        "period_begin": "07:00",
        "period_end": "18:00"
      },
      {
        "weekday": 4,
        "period_begin": "07:00",
        "period_end": "18:00"
      },
      {
        "weekday": 5,
        "period_begin": "07:00",
        "period_end": "18:00"
      },
      {
        "weekday": 6,
        "period_begin": "07:00",
        "period_end": "18:00"
      },
      {
        "weekday": 7,
        "period_begin": "07:00",
        "period_end": "18:00"
      }
    ]
  },
  "charging_when_closed": true,
  "last_updated": "2017-03-07T02:21:22Z"
}
```

## *EVSE* Object

The *EVSE* object describes the part that controls the power supply to a single EV in a single session. It always
belongs to a [Location](/06-modules/03-locations/06-object-description.md#location-object) object. The object only
contains directions to get from the location itself to the EVSE (i.e. *floor*, *physical_reference* or *directions*).

When the directional properties of an EVSE are insufficient to reach the EVSE from the *Location* point, then it
typically indicates that the EVSE should be put in a different *Location* object (sometimes with the same address but
with different coordinates/directions).

An *EVSE* object has a list of Connectors which can not be used simultaneously: only one connector per EVSE can be used
at the time.

| Property             | Type                                                                                    | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|----------------------|-----------------------------------------------------------------------------------------|-------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| uid                  | [CiString](/07-types/01-intro.md#cistring-type)(36)                                     | 1     | Uniquely identifies the EVSE within the CPOs platform (and suboperator platforms). This field can never be changed, modified or renamed. This is the *technical* identification of the EVSE, not to be used as *human readable* identification, use the field `evse_id` for that. This field is named `uid` instead of `id`, because `id` could be confused with `evse_id` which is an eMI3 defined field. Note that in order to fulfill both the requirement that an EVSE's `uid` be unique within a CPO's platform and the [requirement that EVSEs are never deleted](/06-modules/03-locations/04-flow-and-lifecycle.md#delete-with-status-update), a CPO will typically want to avoid using identifiers of the physical hardware for this `uid` property. If they do use such a physical identifier, they will find themselves breaking the uniqueness requirement for `uid` when the same physical EVSE is redeployed at another Location. |
| evse_id              | [CiString](/07-types/01-intro.md#cistring-type)(48)                                     | ?     | Compliant with the following specification for EVSE ID from "eMI3 standard version V1.0" (<http://emi3group.com/documents-links/>) "Part 2: business objects." Optional because: if an `evse_id` is to be re-used in the real world, the `evse_id` can be removed from an EVSE object if the `status` is set to `REMOVED`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| status               | [Status](/06-modules/03-locations/07-data-types.md#status-enum)                         | 1     | Indicates the current status of the EVSE.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| status_schedule      | [StatusSchedule](/06-modules/03-locations/07-data-types.md#statusschedule-class)        | \*    | Indicates a planned status update of the EVSE.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| capabilities         | [Capability](/06-modules/03-locations/07-data-types.md#capability-enum)                 | \*    | List of functionalities that the EVSE is capable of.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| connectors           | [Connector](/06-modules/03-locations/06-object-description.md#connector-object)         | \+    | List of available connectors on the EVSE.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| floor_level          | [string](/07-types/01-intro.md#string-type)(4)                                          | ?     | Level on which the Charge Point is located (in garage buildings) in the locally displayed numbering scheme.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| coordinates          | [GeoLocation](/06-modules/03-locations/07-data-types.md#geolocation-class)              | ?     | Coordinates of the EVSE.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| physical_reference   | [string](/07-types/01-intro.md#string-type)(16)                                         | ?     | A number/string printed on the outside of the EVSE for visual identification.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| directions           | [DisplayText](/07-types/01-intro.md#displaytext-class)                                  | \*    | Multi-language human-readable directions when more detailed information on how to reach the EVSE from the *Location* is required.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| parking_restrictions | [ParkingRestriction](/06-modules/03-locations/07-data-types.md#parkingrestriction-enum) | \*    | The restrictions that apply to the parking spot.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| images               | [Image](/06-modules/03-locations/07-data-types.md#image-class)                          | \*    | Links to images related to the EVSE such as photos or logos.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| last_updated         | [DateTime](/07-types/01-intro.md#datetime-type)                                         | 1     | Timestamp when this EVSE or one of its Connectors was last updated (or created).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

:::note
OCPP 1.x does not have good support for Charge Points that have multiple connectors per EVSE. To make `StartSession`
over OCPI work, the CPO SHOULD present the different connectors of an EVSE as separate EVSE, as is also written by the
OCA in the application note: "Multiple Connectors per EVSE in a OCPP 1.x implementation".
:::

## *Connector* Object

A *Connector* is the *socket* or *cable and plug* available for the EV to use. A single EVSE may provide multiple
Connectors but only one of them can be in use at the same time. A Connector always belongs to an
[EVSE](/06-modules/03-locations/06-object-description.md#evse-object) object.

| Property             | Type                                                                              | Card. | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|----------------------|-----------------------------------------------------------------------------------|-------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| id                   | [CiString](/07-types/01-intro.md#cistring-type)(36)                               | 1     | Identifier of the Connector within the EVSE. Two Connectors may have the same id as long as they do not belong to the same *EVSE* object.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| standard             | [ConnectorType](/06-modules/03-locations/07-data-types.md#connectortype-enum)     | 1     | The standard of the installed connector.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| format               | [ConnectorFormat](/06-modules/03-locations/07-data-types.md#connectorformat-enum) | 1     | The format (socket/cable) of the installed connector.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| power_type           | [PowerType](/06-modules/03-locations/07-data-types.md#powertype-enum)             | 1     |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| max_voltage          | int                                                                               | 1     | Maximum voltage of the connector (line to neutral for AC_3_PHASE), in volt \[V\]. For example: DC Chargers might vary the voltage during charging when battery almost full.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| max_amperage         | int                                                                               | 1     | Maximum amperage of the connector, in ampere \[A\].                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| max_electric_power   | int                                                                               | ?     | Maximum electric power that can be delivered by this connector, in Watts (W). When the maximum electric power is lower than the calculated value from `voltage` and `amperage`, this value should be set. For example: A DC Charge Point which can delivers up to 920V and up to 400A can be limited to a maximum of 150kW (max_electric_power = 150000). Depending on the car, it may supply max voltage or current, but not both at the same time. For AC Charge Points, the amount of phases used can also have influence on the maximum power.                                                                                                                                                                                                                                                                                                                                                       |
| tariff_ids           | [CiString](/07-types/01-intro.md#cistring-type)(36)                               | \*    | Identifiers of the currently valid charging tariffs. Multiple tariffs are possible, but only one of each [Tariff.type](/06-modules/06-tariffs/06-object-description.md#tariff-object) can be active at the same time. Tariffs with the same type are only allowed if they are not active at the same time: [start_date_time](/06-modules/06-tariffs/06-object-description.md#tariff-object) and [end_date_time](/06-modules/06-tariffs/06-object-description.md#tariff-object) period not overlapping. When preference-based smart charging is supported, one tariff for every possible [ProfileType](/06-modules/04-sessions/07-data-types.md#profiletype-enum) should be provided. These tell the user about the options they have at this Connector, and what the tariff is for every option. For a "free of charge" tariff, this field should be set and point to a defined "free of charge" tariff. |
| terms_and_conditions | [URL](/07-types/01-intro.md#url-type)                                             | ?     | URL to the operator's terms and conditions.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| last_updated         | [DateTime](/07-types/01-intro.md#datetime-type)                                   | 1     | Timestamp when this Connector was last updated (or created).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
