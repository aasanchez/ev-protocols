---
id: terminology-and-definitions-cardinality
slug: terminology-and-definitions/cardinality
---
# Cardinality

When defining the cardinality of a field, the following symbols are used throughout this document:

| Symbol | Description                                                                                                                                                                             | Type       |
|--------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------|
| ?      | An optional object. If not set, it might be `null`, or the field might be omitted. When the field is set to null or omitted and it has a default value, the value is the default value. | Object     |
| 1      | Required object.                                                                                                                                                                        | Object     |
| \*     | A list of zero or more objects. If empty, it might be `null`, `[]` or the field might be omitted.                                                                                       | \[Object\] |
| \+     | A list of at least one object.                                                                                                                                                          | \[Object\] |
