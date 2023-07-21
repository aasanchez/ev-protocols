#!/usr/bin/env bash

function pre_introduction(){
  file="$ROOT/ocpi/introduction.asciidoc"

  gsed -i 's|EV Box|https://evbox.com[EV Box]|g' "$file"
  gsed -i 's|New Motion|https://newmotion.com[New Motion]|g' "$file"
  gsed -i 's|ElaadNL|https://elaad.nl[ElaadNL]|g' "$file"
  gsed -i 's|GreenFlux|https://greenflux.com[GreenFlux]|g' "$file"
  gsed -i 's|Last Mile Solutions|https://lastmilesolutions.com[Last Mile Solutions]|g' "$file"
  gsed -i 's|Plugsurfing|https://plugsurfing.com[Plugsurfing]|g' "$file"
  gsed -i 's|Next Charge|https://nextcharge.app[Next Charge]|g' "$file"
  gsed -i 's|Freshmile|https://freshmile.com[Freshmile]|g' "$file"
  gsed -i 's|E55C|https://e55c.com[E55C]|g' "$file"
  gsed -i 's|GIREVE|https://gireve.com[GIREVE]|g' "$file"
  gsed -i 's|ihomer|https://ihomer.nl[ihomer]|g' "$file"
  gsed -i 's|Rexel,|https://www.rexel.com[Rexel]\,|g' "$file"
  gsed -i 's|Stromnetz Hamburg|https://www.stromnetz-hamburg.de[Stromnetz Hamburg]|g' "$file"
  gsed -i 's|Enervalis|https://enervalis.com[Enervalis]|g' "$file"
  gsed -i 's|Place to plug|https://placetoplug.com[Place to plug]|g' "$file"
  gsed -i 's|Ecomovement|https://www.eco-movement.com[Ecomovement]|g' "$file"
  gsed -i 's|Allego|https://www.allego.eu[Allego]|g' "$file"
  gsed -i 's|ENIO|https://www.enio-management.com[ENIO]|g' "$file"
  gsed -i 's|Fastned|https://fastnedcharging.com[Fastned]|g' "$file"
  gsed -i 's|AvantIT|https://www.avantit.no[AvantIT]|g' "$file"
  gsed -i 's|Chargemap|https://chargemap.com[Chargemap]|g' "$file"
  gsed -i 's|Vattenfall|https://vattenfall.com[Vattenfall]|g' "$file"
  gsed -i 's|Involtum|https://www.involtum.com[Involtum]|g' "$file"
  gsed -i 's|EON|https://www.eon.com[EON]|g' "$file"

}

function fix_introduction() {
  file="$ROOT/website/docs/01-introduction.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 1\nslug: /\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"
  gsed -i -z 's/\n\n  - /\n  \* /gm' "$file"
  gsed -i -z 's/\n\n- /\n* /gm' "$file"
  gsed -i 's/^#\([^:]*\):$/#\1/' "$file"
  gsed -i 's/[[:blank:]]*$//' "$file"              # Delete Trailspace

  gsed -i 's/### Changes\/New functionality/### Changes\/New functionality\n/' "$file"
  gsed -i 's/\* A good/\n\* A good /' "$file"
    
  gsed -i 's/\*\*OCPI is developed with support of:\*\*/### OCPI is developed with support of/g' "$file"
  
  gsed -i "s|<img src=\"images/evroamingeu_logo.png\" alt=\"evRoaming4EU logo\" />|![evRoaming4EU logo](./images/evroamingeu_logo.png)|g" "$file"
  gsed -i "s|<img src=\"images/eciss_logo.png\" alt=\"ECISS logo\" />|![ECISS logo](./images/eciss_logo.png)|g" "$file"
  
  gsed -i 's|<https://github.com/ocpi/ocpi>|[OCPI Github Repository](https://github.com/ocpi/ocpi)|g' "$file"
  gsed -i '/^$/N;/\n$/D' "$file"
  gsed -i "s/’/'/gm" "$file"

}

# Transforms the structure of the original documentation
# maybe change to headings, titles, and order of presentation of the information in order 
# to optimize accessibility and usability for web-based formats.
# This function preserves the content and definitions without modification.
function flavored_introduction(){
  file="$ROOT/website/docs/01-introduction.md"
  tempfile="$file.tmp"
  echo "$file ocpi.dev flavored"
  gsed -i -z "s/For more information on detailed changes see \[changelog\](https:\/\/ocpi\.dev)\.\n\n//gm" "$file"

  splitInH2 "$file"
  
  line_number=$(grep -n "### OCPI is developed with support of" "$ROOT/tmp/introductionandbackground.md" | cut -d: -f1)
  gsed -n "${line_number},\$p" "$ROOT/tmp/introductionandbackground.md" > "$ROOT/tmp/newfile.md"

  gsed -i "${line_number},\$d" "$ROOT/tmp/introductionandbackground.md"
  gsed -i '/^$/N;/\n$/D' "$ROOT/tmp/introductionandbackground.md"

  cat "$ROOT/tmp/introductionandbackground.md" \
      "$ROOT/tmp/ocpi221d2.md" \
      "$ROOT/tmp/ocpi221.md" \
      "$ROOT/tmp/ocpi22.md" \
      "$ROOT/tmp/newfile.md" \
      > "$ROOT/website/docs/01-introduction.md"

  echo -e "---\nid: introduction\nslug: /\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i 's|^### OCPI|\n## OCPI|g' "$file"
  gsed -i 's|^## OCPI 2.2.1$|\n## OCPI 2.2.1|g' "$file"
  gsed -i 's|^## OCPI 2.2$|\n## OCPI 2.2|g' "$file"
  gsed -i 's|^## OCPI 2.2.1-d2$|## OCPI 2.2.1-d2|g' "$file"

  gsed -i 's|^## Introduction and background$|# OCPI|g' "$file"

}
