#!/usr/bin/env bash

function pre_introduction(){
  file="$ROOT/ocpi/introduction.asciidoc"

  $SED -i 's|EV Box|https://evbox.com[EV Box]|g' "$file"
  $SED -i 's|New Motion|https://newmotion.com[New Motion]|g' "$file"
  $SED -i 's|ElaadNL|https://elaad.nl[ElaadNL]|g' "$file"
  $SED -i 's|GreenFlux|https://greenflux.com[GreenFlux]|g' "$file"
  $SED -i 's|Last Mile Solutions|https://lastmilesolutions.com[Last Mile Solutions]|g' "$file"
  $SED -i 's|Plugsurfing|https://plugsurfing.com[Plugsurfing]|g' "$file"
  $SED -i 's|Next Charge|https://nextcharge.app[Next Charge]|g' "$file"
  $SED -i 's|Freshmile|https://freshmile.com[Freshmile]|g' "$file"
  $SED -i 's|E55C|https://e55c.com[E55C]|g' "$file"
  $SED -i 's|GIREVE|https://gireve.com[GIREVE]|g' "$file"
  $SED -i 's|ihomer|https://ihomer.nl[ihomer]|g' "$file"
  $SED -i 's|Rexel,|https://www.rexel.com[Rexel]\,|g' "$file"
  $SED -i 's|Stromnetz Hamburg|https://www.stromnetz-hamburg.de[Stromnetz Hamburg]|g' "$file"
  $SED -i 's|Enervalis|https://enervalis.com[Enervalis]|g' "$file"
  $SED -i 's|Place to plug|https://placetoplug.com[Place to plug]|g' "$file"
  $SED -i 's|Ecomovement|https://www.eco-movement.com[Ecomovement]|g' "$file"
  $SED -i 's|Allego|https://www.allego.eu[Allego]|g' "$file"
  $SED -i 's|ENIO|https://www.enio-management.com[ENIO]|g' "$file"

}

function fix_introduction() {
  file="$ROOT/docs/01-introduction.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 1\nslug: /\n---" | cat - "$file" > "$tempfile"
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
  
  $SED -i "s|<img src=\"images/evroamingeu_logo.png\" alt=\"evRoaming4EU logo\" />|![evRoaming4EU logo](./images/evroamingeu_logo.png)|g" "$file"
  $SED -i "s|<img src=\"images/eciss_logo.png\" alt=\"ECISS logo\" />|![ECISS logo](./images/eciss_logo.png)|g" "$file"
  
  $SED -i 's|<https://github.com/ocpi/ocpi>|[OCPI Github Repository](https://github.com/ocpi/ocpi)|g' "$file"
  $SED -i '/^$/N;/\n$/D' "$file"
  $SED -i "s/’/'/gm" "$file"

}
