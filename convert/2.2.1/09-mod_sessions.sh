#!/usr/bin/env bash

function pre_mod_sessions(){
  file="$ROOT/ocpi/mod_sessions.asciidoc"
  gsed -i 's|+$||gm' "$file"
}

function fix_mod_sessions() {
  file="$ROOT/website/docs/09-mod_sessions.md"
  tempfile="$file.tmp"

  echo -e "---\nid: sessions\nslug: modules/sessions\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -e "s|^\# \*Sessions\* module|# Sessions|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`sessions\`\*\*|\:\:\:tip Module Identifier\nsessions\n\:\:\:|gm" "$file"
  gsed -i    "s|^\*\*Data owner: \`CPO\`\*\*|\:\:\:caution Data owner\nCPO\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"
  gsed -i    "s/’/'/gm" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"

  gsed -i    "s|^======|#####|gm" "$file"
  gsed -i 's|^- |* |gm' "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
