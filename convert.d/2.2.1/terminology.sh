#!/usr/bin/env bash

function pre_terminology(){
  file="$ROOT/ocpi/terminology.asciidoc"
  # $SED -i -z 's|2s,10|1,1|gm' "$file"
  # $SED -i -z 's|3s,9|1,1|gm' "$file"

}

function fix_terminology(){
  file="$ROOT/docs/02-terminology.md"

  # docker container run -i darkriszty/prettify-md < "$OUTPUT_FILE" > "$OUTPUT_FILE".tmp
  $SED -i 's/[[:blank:]]*$//' "$file"              # Delete Trailspace
}


