#!/usr/bin/env bash

function pre_terminology(){
  file="$ROOT/ocpi/terminology.asciidoc"
  gsed -i 's|+$||gm' "$file"
  gsed -i 's/\.Charging Topology schematic//gm' "$file"

}

function fix_terminology(){
  file="$ROOT/website/docs/02-terminology.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 2\nslug: terminology-and-definitions\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"
  gsed -i 's|<https://www.ietf.org/rfc/rfc2119.txt>|[https://www.ietf.org/rfc/rfc2119.txt](https://www.ietf.org/rfc/rfc2119.txt)|g' "$file"
  gsed -i -z 's/\n\n- /\n\* /gm' "$file"
  gsed -i -z 's/Examples of platforms:/Examples of platforms:\n/gm' "$file"
  gsed -i 's/[[:blank:]]*$//' "$file"              # Delete Trailspace
  gsed -i "s/’/'/gm" "$file"
  gsed -i "s/“/\"/gm" "$file"
  gsed -i "s/”/\"/gm" "$file"
  gsed -i "s|Belgium and Luxembourg.$|Belgium and Luxembourg.\n|gm" "$file"
  gsed -i "s|codes.de/).|codes.de/).\n|gm" "$file"
  gsed -i "s|\* \*Connector|\n\* \*Connector|gm" "$file"

  gsed -i '/<figure>/d' "$file"
  gsed -i '/<\/figure>/d' "$file"
  gsed -i "s|<img src=\"images/topology.svg\" alt=\"Charging Topology schematic\" />|![Charging Topology schematic](./images/topology.svg)|g" "$file"
  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}


flavored_terminology() {
  file="$ROOT/website/docs/02-terminology.md"
  tempfile="$file.tmp"
  echo "$file ocpi.dev flavored"

  splitInH2 "$file"

  rm -rf "$ROOT/website/docs/02-terminology-and-definitions"
  mkdir -p "$ROOT/website/docs/02-terminology-and-definitions"

  mv "$ROOT/tmp/requirementkeywords.md"             "$ROOT/website/docs/02-terminology-and-definitions/01-requirement-keywords.md"
  mv "$ROOT/tmp/abbreviations.md"                   "$ROOT/website/docs/02-terminology-and-definitions/02-abbreviations.md"
  mv "$ROOT/tmp/evchargingmarketroles.md"           "$ROOT/website/docs/02-terminology-and-definitions/03-ev-charging-market-roles.md"
  mv "$ROOT/tmp/terminology.md"                     "$ROOT/website/docs/02-terminology-and-definitions/04-terminology.md"
  mv "$ROOT/tmp/providerandoperatorabbreviation.md" "$ROOT/website/docs/02-terminology-and-definitions/05-provider-and-operator-abbreviation.md"
  mv "$ROOT/tmp/chargingtopology.md"                "$ROOT/website/docs/02-terminology-and-definitions/06-charging-topology.md"
  mv "$ROOT/tmp/variablenames.md"                   "$ROOT/website/docs/02-terminology-and-definitions/07-variable-names.md"
  mv "$ROOT/tmp/cardinality.md"                     "$ROOT/website/docs/02-terminology-and-definitions/08-cardinality.md"
  mv "$ROOT/tmp/dataretention.md"                   "$ROOT/website/docs/02-terminology-and-definitions/09-data-retention.md"

  file="$ROOT/website/docs/02-terminology-and-definitions/01-requirement-keywords.md"
  gsed -i "s/^## /# /gm" "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: requirement-keywords
slug: terminology-and-definitions/requirement-keywords
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"

  file="$ROOT/website/docs/02-terminology-and-definitions/02-abbreviations.md"
  gsed -i "s/^## /# /gm" "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: abbreviations
slug: terminology-and-definitions/abbreviations
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"

  file="$ROOT/website/docs/02-terminology-and-definitions/03-ev-charging-market-roles.md"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: ev-charging-market-roles
slug: terminology-and-definitions/ev-charging-market-roles
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"

  file="$ROOT/website/docs/02-terminology-and-definitions/04-terminology.md"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: terminology
slug: terminology-and-definitions/terminology
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"

  file="$ROOT/website/docs/02-terminology-and-definitions/05-provider-and-operator-abbreviation.md"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: provider-and-operator-abbreviation
slug: terminology-and-definitions/provider-and-operator-abbreviation
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"

  file="$ROOT/website/docs/02-terminology-and-definitions/06-charging-topology.md"
  gsed -i "s/^## /# /gm" "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: charging-topology
slug: terminology-and-definitions/charging-topology
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i 's/](\.\/\([^)]*\))/](..\/\1)/g' "$file"

  file="$ROOT/website/docs/02-terminology-and-definitions/07-variable-names.md"
  gsed -i "s/^## /# /gm" "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: variable-names
slug: terminology-and-definitions/variable-names
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"

  file="$ROOT/website/docs/02-terminology-and-definitions/08-cardinality.md"
  gsed -i "s/^## /# /gm" "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: cardinality
slug: terminology-and-definitions/cardinality
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"

  file="$ROOT/website/docs/02-terminology-and-definitions/09-data-retention.md"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: data-retention
slug: terminology-and-definitions/data-retention
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"

  rm -rf "$ROOT/website/docs/02-terminology.md"
}
