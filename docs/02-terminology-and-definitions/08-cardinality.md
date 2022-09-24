---
sidebar_position: 8
---

# Cardinality

When defining the cardinality of a field, the following symbols are used throughout this document:

| Symbol | Type     | Description                                                                                                                                                                            |
|--------|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ?      | Object   | An optional object. If not set, it might be `null`, or the field might be omitted. When the field is set to null or omitted and it has a default value, the value is the default value |
| 1      | Object   | Required object.                                                                                                                                                                       |
| *      | [Object] | A list of zero or more objects. If empty, it might be `null`, `[]` or the field might be omitted                                                                                       |
| *      | [Object] | A list of at least one object                                                                                                                                                          |
