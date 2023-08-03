#!/usr/bin/env bash

function pre_mod_tokens(){
  file="$ROOT/ocpi/mod_tokens.asciidoc"
  gsed -i 's|+$||gm' "$file"
}

function fix_mod_tokens() {
  file="$ROOT/website/docs/12-mod_tokens.md"
  tempfile="$file.tmp"

  echo -e "---\nid: tokens\nslug: modules/tokens\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -e "s|^\# \*Tokens\* module|# Tokens|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`tokens\`\*\*|\:\:\:tip Module Identifier\ntokens\n\:\:\:|gm" "$file"
  gsed -i    "s|^\*\*Data owner: \`MSP\`\*\*|\:\:\:caution Data owner\nMSP\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"
  
  gsed -i 's|^- |* |gm' "$file"
  
  gsed -i    "s/’/'/gm" "$file"

  gsed -i    "s|^======\s|##### |gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
