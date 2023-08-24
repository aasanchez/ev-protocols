#!/usr/bin/env bash

function pre_transport_and_format(){
  file="$ROOT/ocpi/transport_and_format.asciidoc"
  gsed -i "s|\[source\]|\[source, http\]|gm" "$file"
  gsed -i -e "s| {object-id} | \`object-id\` |gm" "$file"
  gsed -i -e "s|{base-ocpi-url}/{end-point}/{country-code}/{party-id}/{object-id}|\`{base-ocpi-url}/{end-point}/{country-code}/{party-id}/{object-id}\`|gm" "$file"
  
  gsed -i '/^.Example sequence diagram of a GET for 1 Object from a CPO to an eMSP.$/d' "$file"
  gsed -i '/^.Example sequence diagram of a PUT via 2 Hubs.$/d' "$file"
  gsed -i '/^.Example sequence diagram of a Broadcast Push from a CPO to multiple eMSPs.$/d' "$file"
  gsed -i '/^.Example sequence diagram of a open routing GET from a CPO via the Hub.$/d' "$file"
  gsed -i '/^.Example sequence diagram of a GET All via the Hub, .$/d' "$file"
  gsed -i '/^.Example sequence diagram of a GET for 1 Object from a CPO on one platform to an MSP on another platform directly (without a Hub)$/d' "$file"
  gsed -i '/^.Example sequence diagram of a GET for 1 Object from one Platform to another Platform via a Hub$/d' "$file"
  gsed -i '/^.Example sequence diagram of Broadcast Push from one Platform to another Platform via a Hub$/d' "$file"
  gsed -i '/^.Example sequence diagram of a open routing between platforms  GET from a CPO via the Hub$/d' "$file"
  gsed -i '/^.Example sequence diagram of the uses of X-Request-ID and X-Correlation-ID in a peer-to-peer topology.$/d' "$file"
  gsed -i '/^.Example sequence diagram of the uses of X-Request-ID and X-Correlation-ID in a topology with a Hub.$/d' "$file"

}

function fix_transport_and_format() {
  file="$ROOT/website/docs/ocpi/04-transport_and_format.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 4\nslug: /ocpi/transport-and-format\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -z "s|======|######|gm" "$file"
  gsed -i "s|^\s\sAuthorization|Authorization|gm" "$file"
  gsed -i "s/’/'/gm" "$file"
  gsed -i "s|\#\#\#\#\# |\#\#\#\# |gm" "$file"
  gsed -i "s|^  Link|Link|gm" "$file"
  gsed -i -z "s|=100\n|=100|gm" "$file"
  gsed -i -z "s|100                 |100|gm" "$file"
  gsed -i -z 's|- |* |gm' "$file"
  gsed -i -e 's|^  https|https|gm' "$file"
  gsed -i 's|^#### Example\:|\* \*\*Example:\*\*|gm' "$file"
  gsed -i "s|^\`\`\`\sjson|\`\`\`json|gm" "$file"
  gsed -i "s|^\`\`\`\shttp|\`\`\`http|gm" "$file"
  gsed -i 's|^        "status_code"|  "status_code"|gm' "$file"
  gsed -i 's|^        "status_message"|  "status_message"|gm' "$file"
  gsed -i 's|^        "timestamp"|  "timestamp"|gm' "$file"

  gsed -i -z 's|.svg"\nalt="|.svg" alt="|gm' "$file"

  gsed -i "s|<img src=\"images/sd_get_simple.svg\" alt=\"OCPI Sequence Diagram Hub GET\" />|![OCPI Sequence Diagram Hub GET](./images/sd_get_simple.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_put_2_hubs.svg\" alt=\"OCPI Sequence Diagram Hub PUT with 2 Hubs\" />|![OCPI Sequence Diagram Hub PUT with 2 Hubs](./images/sd_put_2_hubs.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_put_boardcast.svg\" alt=\"OCPI Sequence Diagram of a Broadcast Push from a CPO to multiple eMSPs\" />|![OCPI Sequence Diagram of a Broadcast Push from a CPO to multiple eMSPs](./images/sd_put_boardcast.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_get_openrouting.svg\" alt=\"Example sequence diagram of a open routing GET from a CPO via the Hub\" />|![Example sequence diagram of a open routing GET from a CPO via the Hub](./images/sd_get_openrouting.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_get_all.svg\" alt=\"OCPI Sequence Diagram of a GET All via the Hub.\" />|![OCPI Sequence Diagram of a GET All via the Hub.](./images/sd_get_all.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_platform_to_platform_direct.svg\" alt=\"Example sequence diagram of a GET for 1 Object from a CPO on one platform to an MSP on another platform directly (without a Hub)\" />|![Example sequence diagram of a GET for 1 Object from a CPO on one platform to an MSP on another platform directly (without a Hub)](./images/sd_platform_to_platform_direct.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_platform_hub_platform.svg\" alt=\"Example sequence diagram of a GET for 1 Object from one Platform to another Platform via a Hub\" />|![Example sequence diagram of a GET for 1 Object from one Platform to another Platform via a Hub](./images/sd_platform_hub_platform.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_platform_hub_platform_broadcast.svg\" alt=\"Example sequence diagram of Broadcast Push from one Platform to another Platform via a Hub\" />|![Example sequence diagram of Broadcast Push from one Platform to another Platform via a Hub](./images/sd_platform_hub_platform_broadcast.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_get_openrouting_platform.svg\" alt=\"Example sequence diagram of a open routing between platforms GET from a CPO via the Hub\" />|![Example sequence diagram of a open routing between platforms GET from a CPO via the Hub](./images/sd_get_openrouting_platform.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_get_all_platform.svg\" alt=\"OCPI Sequence Diagram of a GET All via the Hub.\" />|![OCPI Sequence Diagram of a GET All via the Hub](./images/sd_get_all_platform.svg)|g" "$file"
  gsed -i "s|<img src=\"images/unqiue_ids_pair2pair.svg\" alt=\"Example sequence diagram of the uses of X-Request-ID and X-Correlation-ID in a peer-to-peer topology.\" />|![Example sequence diagram of the uses of X-Request-ID and X-Correlation-ID in a peer-to-peer topology.](./images/unqiue_ids_pair2pair.svg)|g" "$file"
  gsed -i "s|<img src=\"images/unqiue_ids_via_hub.svg\" alt=\"Example sequence diagram of the uses of X-Request-ID and X-Correlation-ID in a topology with a Hub.\" />|![Example sequence diagram of the uses of X-Request-ID and X-Correlation-ID in a topology with a Hub.](./images/unqiue_ids_via_hub.svg)|g" "$file"

  gsed -i -e "s|\`+|\`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}

flavored_transport_and_format() {
  file="$ROOT/website/docs/ocpi/04-transport_and_format.md"
  tempfile="$file.tmp"
  echo "$file EV-protocols flavored"

  splitInH2 "$file"

  rm -rf "$ROOT/website/docs/ocpi/04-transport-and-format"
  mkdir -p "$ROOT/website/docs/ocpi/04-transport-and-format"

  mv "$ROOT/tmp/jsonhttpimplementationguide.md" "$ROOT/website/docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md"
  mv "$ROOT/tmp/uniquemessageids.md"            "$ROOT/website/docs/ocpi/04-transport-and-format/02-unique-message-ids.md"
  mv "$ROOT/tmp/interfaceendpoints.md"          "$ROOT/website/docs/ocpi/04-transport-and-format/03-interface-endpoints.md"
  mv "$ROOT/tmp/offlinebehaviour.md"            "$ROOT/website/docs/ocpi/04-transport-and-format/04-offline-behaviour.md"

  file="$ROOT/website/docs/ocpi/04-transport-and-format/01-json-http-implementation-guide.md"
  echo "flavoring $file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i "s/^##### /#### /gm" "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: json-http-implementation-guide
slug: json-http-implementation-guide
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i 's/](\.\/\([^)]*\))/](..\/\1)/g' "$file"
  gsed -i -z 's|### GET All via Hubs\n\nThis|\#\#\# GET All via Hubs \(headers description\)\n\nThis|gm' "$file"

  gsed -i -z "s|\[2001\](/05\-status_codes.md)|\[2001\](/05\-status_codes.md\#2xxx-client-errors)|gm" "$file"

  search_text="http\nAuthorization: Token ZWJmM2IzOTktNzc5Zi00NDk3LTliOWQtYWM2YWQzY2M0NGQyCg=="
  replace_text="shell {2} title=\"Note: HTTP header names are case-insensitive\"\ncurl --request GET \"https://www.server.com/ocpi/cpo/2.2.1/versions\" \\\ \n--header \"Authorization: Token ZWJmM2IzOTktNzc5Zi00NDk3LTliOWQtYWM2YWQzY2M0NGQyCg==\""
  gsed -i -z "s|$search_text|$replace_text|g" "$file"

  gsed -i -z "s|\n\:\:\:note\n\nHTTP header names are case-insensitive\n\n\:\:\:\n||g" "$file"

  search_text="http\nAuthorization: Token ZXhhbXBsZS10b2tlbgo="
  replace_text="shell {2}\ncurl --request GET \"https://www.server.com/ocpi/cpo/2.2.1/versions\" \\\ \n--header \"Authorization: Token ZXhhbXBsZS10b2tlbgo=\""
  gsed -i -z "s|$search_text|$replace_text|g" "$file"

  gsed -i 's/[ \t]*$//' "$file"
  gsed -i 's|Example sequence diagram of a GET for 1 Object from a CPO on one platform to an MSP on another platform directly|Party to Party|gm' "$file"

  gsed -i "s/^### GET$/### GET Method/gm" "$file"
  gsed -i "s/^### PUT/### PUT Method/gm" "$file"
  gsed -i "s/^### PATCH/### PATCH Method/gm" "$file"

  gsed -i -z "s|\:\:\:\n\n\*|\:\:\:\n\n\#\#\# Examples\n\n\*|gm" "$file"
  gsed -i -z "s|\*\*Example\:\*\*\s||gm" "$file"

  gsed -i "/^\`\`\`json$/,/^\`\`\`$/ s/^/    /" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  file="$ROOT/website/docs/ocpi/04-transport-and-format/02-unique-message-ids.md"
  echo "flavoring $file"
  gsed -i "s/^## /# /gm" "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: unique-message-ids
slug: unique-message-ids
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i 's/](\.\/\([^)]*\))/](..\/\1)/g' "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  file="$ROOT/website/docs/ocpi/04-transport-and-format/03-interface-endpoints.md"
  echo "flavoring $file"
  gsed -i "s/^## /# /gm" "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: interface-endpoints
slug: interface-endpoints
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i 's/](\.\/\([^)]*\))/](..\/\1)/g' "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  file="$ROOT/website/docs/ocpi/04-transport-and-format/04-offline-behaviour.md"
  echo "flavoring $file"
  gsed -i "s/^## /# /gm" "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: offline-behaviour
slug: offline-behaviour
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i 's/](\.\/\([^)]*\))/](..\/\1)/g' "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  rm "$ROOT/website/docs/ocpi/04-transport_and_format.md"
}
