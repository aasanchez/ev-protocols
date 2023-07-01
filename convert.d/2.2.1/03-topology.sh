#!/usr/bin/env bash

function pre_topology(){
  file="$ROOT/ocpi/topology.asciidoc"
}

function fix_topology() {
  file="$ROOT/docs/01-topology.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 3\nslug: /\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  $SED -i -z 's/\n\n  - /\n  \* /gm' "$file"
  $SED -i -z 's/\n\n- /\n* /gm' "$file"
  $SED -i 's/^#\([^:]*\):$/#\1/' "$file"
  $SED -i 's/[[:blank:]]*$//' "$file"              # Delete Trailspace

  $SED -i 's/### Changes\/New functionality/### Changes\/New functionality\n/' "$file"
  $SED -i 's/\* A good/\n\* A good /' "$file"
    
  $SED -i 's/\*\*OCPI is developed with support of:\*\*/### OCPI is developed with support of/g' "$file"

  $SED -i 's/<figure>//gm' "$file"
  $SED -i 's/<\/figure>//gm' "$file"
  
  $SED -i "s|<img src=\"images/evroamingeu_logo.png\" alt=\"evRoaming4EU logo\" />|![evRoaming4EU logo](images/evroamingeu_logo.png)|g" "$file"
  $SED -i "s|<img src=\"images/eciss_logo.png\" alt=\"ECISS logo\" />|![ECISS logo](images/eciss_logo.png)|g" "$file"
  
  $SED -i 's|<https://github.com/ocpi/ocpi>|[OCPI Github Repository](https://github.com/ocpi/ocpi)|g' "$file"
  $SED -i '/^$/N;/\n$/D' "$file"
  $SED -i "s/’/'/gm" "$file"

}
