---
id: interfaces-and-endpoints
slug: locations/interfaces-and-endpoints
---
# Interfaces and endpoints

There are both, a Sender and a Receiver interface for Locations. It is advised to use the Push direction from Sender to
Receiver during normal operation in order to keep the latency of updates low. The Sender interface is meant to be used
when the connection between two parties is established for the first time, to retrieve the current list of Location
objects with the current status, and when the Receiver is not 100% sure the Location cache is entirely up-to-date (i.e.
to perform a full sync). The Receiver can also use the Sender
\<\</docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#get-object-request-parameters,GET Object
interface\>to retrieve a specific Location, EVSE or Connector. This feature might be used by an Receiver that wants
information about a specific Location, but has not implemented the Receiver Locations interface (i.e. cannot receive
Push).

## Sender Interface

Typically implemented by market roles like: CPO.

| Method                                                                                 | Description |
|----------------------------------------------------------------------------------------|-------------|
| \<\</docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#get-method,GET\> |             |
| POST                                                                                   | n/a         |
| PUT                                                                                    | n/a         |
| PATCH                                                                                  | n/a         |
| DELETE                                                                                 | n/a         |

### **GET** Method

Depending on the URL Segments provided, the GET request can either be used to retrieve information about a list of
available Locations (with EVSEs and Connectors) at a CPO
(\<\</docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#get-list-request-parameters,GET List\>\>) or it
can be used to retrieve information about one specific Location, EVSE or Connector
(\<\</docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#get-object-request-parameters,GET Object\>\>).

#### GET List: Request Parameters

Endpoint structure definition:

`{locations_endpoint_url}?[date_from={date_from}]&amp;[date_to={date_to}]&amp;[offset={offset}]&amp;[limit={limit}]`

Examples:

* `https://www.server.com/ocpi/cpo/2.2.1/locations/?date_from=2019-01-28T12:00:00&date_to=2019-01-29T12:00:00`
* `https://ocpi.server.com/2.2.1/locations/?offset=50`
* `https://www.server.com/ocpi/2.2.1/locations/?date_from=2019-01-29T12:00:00&limit=100`
* `https://www.server.com/ocpi/cpo/2.2.1/locations/?offset=50&limit=100`

If the optional parameters `{date_from}` and/or `{date_to}` are provided, only Locations with (`last_updated`) between
the given `{date_from}` (including) and `{date_to}` (excluding) will be returned. In order for this to work properly,
the following logic MUST be implemented accordingly: If an EVSE is updated, also the *parent* Location's `last_updated`
field needs to be updated. Similarly, if a Connector is updated, the EVSE's `last_updated` and the Location's
`last_updated` fields need to be updated.

This request is \<\</docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#pagination,paginated\>\>, it
supports the
\<\</docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#paginated-request,pagination\>related URL
parameters.

| Parameter | Datatype                                                     | Required | Description                                                                                         |
|-----------|--------------------------------------------------------------|----------|-----------------------------------------------------------------------------------------------------|
| date_from | \<\</docs/ocpi/07-types/01-intro.md#datetime-type,DateTime\> | no       | Only return Locations that have `last_updated` after or equal to this Date/Time (inclusive).        |
| date_to   | \<\</docs/ocpi/07-types/01-intro.md#datetime-type,DateTime\> | no       | Only return Locations that have `last_updated` up to this Date/Time, but not including (exclusive). |
| offset    | int                                                          | no       | The offset of the first object returned. Default is 0.                                              |
| limit     | int                                                          | no       | Maximum number of objects to GET.                                                                   |

#### GET List: Response Data

This endpoint returns a list of Location objects. The header will contain the
\<\</docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#paginated-response,pagination\>related
headers.

Each object must contain all required fields. Fields that are not specified may be considered as null values. Any old
information that is not specified in the response is considered no longer valid. For requests that use pagination, the
response data provided by all the pages together is the new truth. Any old information not contained in any of the pages
needs to be considered no longer valid.

| Type                                                                                       | Card. | Description                             |
|--------------------------------------------------------------------------------------------|-------|-----------------------------------------|
| \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#location-object,Location\> | \*    | List of all Locations with valid EVSEs. |

#### GET Object: Request Parameters

Endpoint structure definition for retrieving a Location, EVSE or Connector:

`{locations_endpoint_url}/{location_id}[/{evse_uid}][/{connector_id}]`

Examples:

* `https://www.server.com/ocpi/cpo/2.2.1/locations/LOC1`
* `https://www.server.com/ocpi/cpo/2.2.1/locations/LOC1/3256`
* `https://www.server.com/ocpi/cpo/2.2.1/locations/LOC1/3256/1`

The following parameters can be provided as URL segments in the same order.

| Parameter    | Datatype                                                           | Required | Description                                                     |
|--------------|--------------------------------------------------------------------|----------|-----------------------------------------------------------------|
| location_id  | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(36) | yes      | Location.id of the Location object to retrieve.                 |
| evse_uid     | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(36) | no       | Evse.uid, required when requesting an EVSE or Connector object. |
| connector_id | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(36) | no       | Connector.id, required when requesting a Connector object.      |

#### GET Object: Response Data

The response contains the requested object.

Choice: one of three

| Type                                                                                         | Card. | Description                                                |
|----------------------------------------------------------------------------------------------|-------|------------------------------------------------------------|
| \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#location-object,Location\>   | 1     | If a Location object was requested: the Location object.   |
| \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#evse-object,EVSE\>           | 1     | If an EVSE object was requested: the EVSE object.          |
| \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#connector-object,Connector\> | 1     | If a Connector object was requested: the Connector object. |

## Receiver Interface

Typically implemented by market roles like: eMSP and NSP.

Locations are
\<\</docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md#client-owned-object-push,Client Owned
Objects\>\>, so the end-points need to contain the required extra fields:
{\<\</docs/ocpi/06-modules/02-credentials/06-object-description.md#credentials-object,party_id\>\>} and
{\<\</docs/ocpi/06-modules/02-credentials/06-object-description.md#credentials-object,country_code\>\>}.

Endpoint structure definition:

`{locations_endpoint_url}/{country_code}/{party_id}/{location_id}[/{evse_uid}][/{connector_id}]`

Examples:

* `https://www.server.com/ocpi/emsp/2.2.1/locations/BE/BEC/LOC1`
* `https://server.com/ocpi/2.2.1/locations/BE/BEC/LOC1/3256`
* `https://ocpi.server.com/2.2.1/locations/BE/BEC/LOC1/3256/1`

| Method                                                                                     | Description                                                                                                                                                                                                                                      |
|--------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| \<\</docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#get-method-1,GET\>   | Retrieve a Location as it is stored in the eMSP system.                                                                                                                                                                                          |
| POST                                                                                       | n/a *(use \<\</docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#put-method,PUT\>\>)*                                                                                                                                             |
| \<\</docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#put-method,PUT\>     | Push new/updated Location, EVSE and/or Connector to the eMSP.                                                                                                                                                                                    |
| \<\</docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#patch-method,PATCH\> | Notify the eMSP of partial updates to a Location, EVSE or Connector (such as the status).                                                                                                                                                        |
| DELETE                                                                                     | n/a *(use \<\</docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#patch-method,PATCH\>to update the `status` to `REMOVED` as described in \<\</docs/ocpi/06-modules/03-locations/04-flow-and-lifecycle.md,Flow and Lifecycle\>\>)* |

### **GET** Method

If the CPO wants to check the status of a Location, EVSE or Connector object in the eMSP system, it might GET the object
from the eMSP system for validation purposes. The CPO is the owner of the objects, so it would be illogical if the eMSP
system had a different status or was missing an object. If a discrepancy is found, the CPO might push an update to the
eMSP via a \<\</docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#put-method,PUT\>or
\<\</docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#patch-method,PATCH\>call.

#### Request Parameters

The following parameters can be provided as URL segments.

| Parameter    | Datatype                                                           | Required | Description                                                             |
|--------------|--------------------------------------------------------------------|----------|-------------------------------------------------------------------------|
| country_code | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(2)  | yes      | Country code of the CPO requesting data from the eMSP system.           |
| party_id     | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(3)  | yes      | Party ID (Provider ID) of the CPO requesting data from the eMSP system. |
| location_id  | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(36) | yes      | Location.id of the Location object to retrieve.                         |
| evse_uid     | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(36) | no       | Evse.uid, required when requesting an EVSE or Connector object.         |
| connector_id | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(36) | no       | Connector.id, required when requesting a Connector object.              |

#### Response Data

The response contains the requested object.

Choice: one of three

| Type                                                                                         | Card. | Description                                                |
|----------------------------------------------------------------------------------------------|-------|------------------------------------------------------------|
| \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#location-object,Location\>   | 1     | If a Location object was requested: the Location object.   |
| \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#evse-object,EVSE\>           | 1     | If an EVSE object was requested: the EVSE object.          |
| \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#connector-object,Connector\> | 1     | If a Connector object was requested: the Connector object. |

### **PUT** Method

The CPO pushes available Location, EVSE or Connector objects to the eMSP. PUT can be used to send new Location objects
to the eMSP but also to replace existing Locations.

When the PUT only contains a
\<\</docs/ocpi/06-modules/03-locations/06-object-description.md#connector-object,Connector\>Object, the Receiver
SHALL also set the new `last_updated` value on the parent
\<\</docs/ocpi/06-modules/03-locations/06-object-description.md#evse-object,EVSE\>and
\<\</docs/ocpi/06-modules/03-locations/06-object-description.md#location-object,Location\>Objects.

When the PUT only contains a \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#evse-object,EVSE\>\>
Object, the Receiver SHALL also set the new `last_updated` value on the parent
\<\</docs/ocpi/06-modules/03-locations/06-object-description.md#location-object,Location\>Object.

#### Request Parameters

This is an information Push message, the objects pushed will not be owned by the eMSP. To make distinctions between
objects being pushed to an eMSP from different CPOs, the
{\<\</docs/ocpi/06-modules/02-credentials/06-object-description.md#credentials-object,party_id\>\>} and
{\<\</docs/ocpi/06-modules/02-credentials/06-object-description.md#credentials-object,country_code\>\>} have to be
included in the URL (as URL segments, as described in the
\<\</docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#receiver-interface,Receiver Interface\>\>).

| Parameter    | Datatype                                                           | Required | Description                                                                                                                                                   |
|--------------|--------------------------------------------------------------------|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| country_code | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(2)  | yes      | Country code of the CPO requesting this PUT to the eMSP system. This SHALL be the same value as the `country_code` in the Location object being pushed.       |
| party_id     | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(3)  | yes      | Party ID (Provider ID) of the CPO requesting this PUT to the eMSP system. This SHALL be the same value as the `party_id` in the Location object being pushed. |
| location_id  | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(36) | yes      | Location.id of the new Location object, or the Location of which an EVSE or Connector object is pushed.                                                       |
| evse_uid     | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(36) | no       | Evse.uid, required when an EVSE or Connector object is pushed.                                                                                                |
| connector_id | \<\</docs/ocpi/07-types/01-intro.md#cistring-type,CiString\>\>(36) | no       | Connector.id, required when a Connector object is pushed.                                                                                                     |

#### Request Body

The request body contains the new/updated object.

When the PUT contains a \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#connector-object,Connector\>\>
Object, the Receiver SHALL also set the new `last_updated` value on the parent
\<\</docs/ocpi/06-modules/03-locations/06-object-description.md#evse-object,EVSE\>and
\<\</docs/ocpi/06-modules/03-locations/06-object-description.md#location-object,Location\>Objects.

When the PUT contains a \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#evse-object,EVSE\>Object, the
Receiver SHALL also set the new `last_updated` value on the parent
\<\</docs/ocpi/06-modules/03-locations/06-object-description.md#location-object,Location\>Object.

| Type                                                                                         | Card. | Description                                           |
|----------------------------------------------------------------------------------------------|-------|-------------------------------------------------------|
| \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#location-object,Location\>   | 1     | New Location object, or Location object to replace.   |
| \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#evse-object,EVSE\>           | 1     | New EVSE object, or EVSE object to replace.           |
| \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#connector-object,Connector\> | 1     | New Connector object, or Connector object to replace. |

#### Example: add an EVSE

To add an *EVSE*, simply put the full object in an update message, including all its required fields. Since the id will
be new to the eMSP's system, the receiving party will know that it is a new object. When not all required fields are
specified, the object may be discarded.

```json
PUT To URL: https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012/3256

{
  "uid": "3256",
  "evse_id": "BE*BEC*E041503003",
  "status": "AVAILABLE",
  "capabilities": [
    "RESERVABLE"
  ],
  "connectors": [
    {
      "id": "1",
      "standard": "IEC_62196_T2",
      "format": "SOCKET",
      "tariff_ids": [
        "14"
      ]
    }
  ],
  "floor": -1,
  "physical_reference": 3,
  "last_updated": "2019-06-24T12:39:09Z"
}
```

### **PATCH** Method

Same as the \<\</docs/ocpi/06-modules/03-locations/05-interfaces-and-endpoints.md#put-method,PUT\>method, but only
the fields/objects that have to be updated have to be present. Other fields/objects that are not specified as part of
the request are considered unchanged. Therefore, this method is not suitable to remove information shared earlier.

Any request to the PATCH method SHALL contain the `last_updated` field.

When the PATCH is on a \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#connector-object,Connector\>\>
Object, the Receiver SHALL also set the new `last_updated` value on the parent
\<\</docs/ocpi/06-modules/03-locations/06-object-description.md#evse-object,EVSE\>and
\<\</docs/ocpi/06-modules/03-locations/06-object-description.md#location-object,Location\>Objects.

When the PATCH is on a \<\</docs/ocpi/06-modules/03-locations/06-object-description.md#evse-object,EVSE\>Object, the
Receiver SHALL also set the new `last_updated` value on the parent
\<\</docs/ocpi/06-modules/03-locations/06-object-description.md#location-object,Location\>Object.

#### Example: a simple status update

This is the most common type of update message. It is used to notify eMSPs that the status of an EVSE changed. In this
case it is the EVSE with uid `3255` of the Location with id `1012`.

```json
PATCH To URL: https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012/3255

{
  "status": "CHARGING",
  "last_updated": "2019-06-24T12:39:09Z"
}
```

#### Example: change the location name

In this example the name of the Location with id `1012` is being updated.

```json
PATCH To URL: https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012


{
  "name": "Interparking Gent Zuid",
  "last_updated": "2019-06-24T12:39:09Z"
}
```

#### Example: set tariff update

In this example Connector `2` of EVSE `1` of Location `1012` receives a new pricing scheme.

```json
PATCH To URL: https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012/3255/2

{
  "tariff_ids": [
    "15"
  ],
  "last_updated": "2019-06-24T12:39:09Z"
}
```

#### Example: delete an EVSE

An EVSE can be deleted by updating its `status` property.

```json
PATCH To URL: https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012/3256

{
  "status": "REMOVED",
  "last_updated": "2019-06-24T12:39:09Z"
}
```

:::note
To inform eMSPs that an EVSE is scheduled for removal, the status_schedule field can be used.\_
:::
