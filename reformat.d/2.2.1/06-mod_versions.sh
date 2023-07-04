#!/usr/bin/env bash

function pre_mod_versions(){
  file="$ROOT/ocpi/mod_versions.asciidoc"
  gsed -i 's|+$||gm' "$file"
}

function fix_mod_versions() {
  file="$ROOT/docs/06-mod_versions.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 7\nslug: module-versions\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s/<div class=\"note\">\n/\:\:\:note/gm" "$file"
  gsed -i -z "s|\n</div>|\:\:\:|gm" "$file"
  gsed -i "s/’/'/gm" "$file"
  gsed -i "s|‘credentials|\*\*credentials|gm" "$file"
  gsed -i "s|\` mo| mo|gm" "$file"
  gsed -i 's/\*\*credentials\\ module,/**credentials** module,/g' "$file"

  gsed -i -e "s|^\# \*Versions\* module|# Versions module|gm" "$file"

  gsed -i "s/\*\*Type:\*\* Configuration Module/\:\:\:info Type\nConfiguration Module\n\:\:\:/gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
