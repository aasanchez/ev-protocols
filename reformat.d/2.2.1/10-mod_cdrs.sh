#!/usr/bin/env bash

function pre_mod_cdrs(){
  file="$ROOT/ocpi/mod_cdrs.asciidoc"
  gsed -i 's|+$||gm' "$file"
}

function fix_mod_cdrs() {
  file="$ROOT/docs/10-mod_cdrs.md"
  tempfile="$file.tmp"

  gsed -i -e "s|^\# \*CDRs\* module|# CDRs module|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`cdrs\`\*\*|\:\:\:tip Module Identifier\ncdrs\n\:\:\:|gm" "$file"
  gsed -i    "s|^\*\*Data owner: \`CPO\`\*\*|\:\:\:caution Data owner\nCPO\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"

  gsed -i -z "s/<div class=\"note\">\n/\:\:\:note/gm" "$file"
  gsed -i -z "s|\n</div>|\:\:\:|gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
