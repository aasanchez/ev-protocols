#!/usr/bin/env bash

function pre_mod_versions(){
  file="$ROOT/ocpi/mod_versions.asciidoc"
  $SED -i 's|+$||gm' "$file"
}

function fix_mod_versions() {
  file="$ROOT/docs/06-mod_versions.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 6\nslug: module-versions\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  $SED -i -e "s|\`+|\`|gm" "$file"
  $SED -i -e "s|+\`|\`|gm" "$file"
  $SED -i -z "s/<div class=\"note\">\n/\:\:\:note/gm" "$file"
  $SED -i -z "s|\n</div>|\:\:\:|gm" "$file"
  $SED -i "s/’/'/gm" "$file"
  $SED -i "s|‘credentials|\*\*credentials|gm" "$file"
  $SED -i "s|\` mo| mo|gm" "$file"
  gsed -i 's/\*\*credentials\\ module,/**credentials** module,/g' "$file"

  $SED -i -e "s|^\# \*Versions\* module|# Versions module|gm" "$file"

  $SED -i "s/\*\*Type:\*\* Configuration Module/\:\:\:info\n\*\*Type:\*\* Configuration Module\n\:\:\:/gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
