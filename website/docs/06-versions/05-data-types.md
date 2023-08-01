---
id: data-types
slug: /modules/version/data-types
---
# Data Types

## Version *class*

| Property | Type                              | Card. | Description                                                  |
|----------|-----------------------------------|-------|--------------------------------------------------------------|
| version  | [VersionNumber](https://ocpi.dev) | 1     | The version number.                                          |
| url      | [URL](/16-types.md#url-type)      | 1     | URL to the endpoint containing version specific information. |

## Endpoint *class*

| Property   | Type                              | Card. | Description                              |
|------------|-----------------------------------|-------|------------------------------------------|
| identifier | [ModuleID](https://ocpi.dev)      | 1     | Endpoint identifier.                     |
| role       | [InterfaceRole](https://ocpi.dev) | 1     | Interface role this endpoint implements. |
| url        | [URL](/16-types.md#url-type)      | 1     | URL to the endpoint.                     |

:::note
for the **credentials** module, the value of the role property is not relevant as this module is the same for all roles.
It is advised to send "SENDER" as the InterfaceRole for one's own credentials endpoint and to disregard the value of the
role property of the Endpoint object for other platforms' credentials modules.
:::

### Data

| Type                        | Card. | Description                        |
|-----------------------------|-------|------------------------------------|
| [Version](https://ocpi.dev) | \+    | A list of supported OCPI versions. |

### Data

| Property  | Type                              | Card. | Description                                     |
|-----------|-----------------------------------|-------|-------------------------------------------------|
| version   | [VersionNumber](https://ocpi.dev) | 1     | The version number.                             |
| endpoints | [Endpoint](https://ocpi.dev)      | \+    | A list of supported endpoints for this version. |
