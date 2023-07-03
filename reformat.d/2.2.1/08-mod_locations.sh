#!/usr/bin/env bash

function pre_mod_locations(){
  file="$ROOT/ocpi/mod_locations.asciidoc"
  $SED -i 's|+$||gm' "$file"
}

function fix_mod_locations() {
  file="$ROOT/docs/08-mod_locations.md"
  tempfile="$file.tmp"

  $SED -i -e "s|^\# \*Locations\* module|# Locations module|gm" "$file"
  $SED -i "s|^\*\*Module Identifier: \`locations\`\*\*|\:\:\:tip Module Identifier\nlocations\n\:\:\:|gm" "$file"
  $SED -i "s|^\*\*Data owner: \`CPO\`\*\*|\:\:\:caution Data owner\nCPO\n\:\:\:|gm" "$file"
  $SED -i "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"
  $SED -i "s|^======|#####|gm" "$file"
  $SED -i -z 's|- |* |gm' "$file"

  $SED -i -z "s/<div class=\"note\">\n/\:\:\:note/gm" "$file"
  $SED -i -z "s|\n</div>|\:\:\:|gm" "$file"
  $SED -i "s/’/'/gm" "$file"
  $SED -i -z 's|\n\*\s|\* |gm' "$file"
  $SED -i -z 's|:\n\*\s|:\n\n\* |gm' "$file"



  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
