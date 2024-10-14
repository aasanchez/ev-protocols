---
sidebar_position: 3
---
# Conventions

The key words *must*, *must not*, *required*, *shall*, *shall not*, *should*, *should not*, *recommended*, *may* and
*optional* in this document are to be interpreted as described in [RFC 2119](https://tools.ietf.org/html/rfc2119).

The cardinality is defined by the indicators _*_, *+*, *?* and *1*, where the last one is the default. The meaning and
mapping to XML syntax is as follows:

|   Meaning    |              XML Schema               | DTD |
| :----------- | :------------------------------------ | --- |
| At most one  | `minOccurs="0" maxOccurs="1"`         | ?   |
| one or more  | `minOccurs="1" maxOccurs="unbounded"` | +   |
| zero or more | `minOccurs="0" maxOccurs="unbounded"` | *   |
| exactly one  | *(default)*                           | 1   |

For some data fields a [Regular Expression](http://en.wikipedia.org/wiki/Regular_expression) is provided as an
additional and very precise definition of the data format.

The character *>* in front of any data field indicates a choice of  multiple possibilities.

The character *~* appended to any data field indicates the  implementation as an XML attribute instead of an element.
