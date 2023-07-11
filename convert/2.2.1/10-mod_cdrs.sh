#!/usr/bin/env bash

function pre_mod_cdrs(){
  file="$ROOT/ocpi/mod_cdrs.asciidoc"
  gsed -i 's|+$||gm' "$file"
}

function fix_mod_cdrs() {
  file="$ROOT/website/docs/10-mod_cdrs.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 10\nslug: cdrs\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -e "s|^\# \*CDRs\* module|# CDRs module|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`cdrs\`\*\*|\:\:\:tip Module Identifier\ncdrs\n\:\:\:|gm" "$file"
  gsed -i    "s|^\*\*Data owner: \`CPO\`\*\*|\:\:\:caution Data owner\nCPO\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"

  gsed -i -z "s/<div class=\"note\">\n/\:\:\:note\n/gm" "$file"
  gsed -i -z "s|\n</div>|\n\:\:\:|gm" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"
  
  gsed -i 's|^- |* |gm' "$file"
  
  gsed -i    "s/’/'/gm" "$file"
  gsed -i    "s|^======|#####|gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
