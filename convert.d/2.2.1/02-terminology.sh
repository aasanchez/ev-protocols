#!/usr/bin/env bash

function pre_terminology(){
  file="$ROOT/ocpi/terminology.asciidoc"
  $SED -i 's|+$||gm' "$file"
  $SED -i 's/\.Charging Topology schematic//gm' "$file"
  # $SED -i -z 's|3s,9|1,1|gm' "$file"

}

function fix_terminology(){
  file="$ROOT/docs/02-terminology.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 2\nslug: terminology-and-definitions\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"
  $SED -i 's|<https://www.ietf.org/rfc/rfc2119.txt>|[https://www.ietf.org/rfc/rfc2119.txt](https://www.ietf.org/rfc/rfc2119.txt)|g' "$file"
  $SED -i -z 's/\n\n- /\n\* /gm' "$file"
  $SED -i -z 's/Examples of platforms:/Examples of platforms:\n/gm' "$file"
  $SED -i 's/[[:blank:]]*$//' "$file"              # Delete Trailspace
  $SED -i "s/’/'/gm" "$file"
  $SED -i "s/“/\"/gm" "$file"
  $SED -i "s/”/\"/gm" "$file"
  $SED -i "s|Belgium and Luxembourg.$|Belgium and Luxembourg.\n|gm" "$file"
  $SED -i "s|codes.de/).|codes.de/).\n|gm" "$file"
  $SED -i "s|\* \*Connector|\n\* \*Connector|gm" "$file"

  $SED -i '/<figure>/d' "$file"
  $SED -i '/<\/figure>/d' "$file"
  $SED -i "s|<img src=\"images/topology.svg\" alt=\"Charging Topology schematic\" />|![Charging Topology schematic](images/topology.svg)|g" "$file"
  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}


