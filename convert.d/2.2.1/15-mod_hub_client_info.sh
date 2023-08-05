#!/usr/bin/env bash

function pre_mod_hub_client_info(){
  file="$ROOT/ocpi/mod_hub_client_info.asciidoc"
  gsed -i 's|+$||gm' "$file"
}

function fix_mod_hub_client_info() {
  file="$ROOT/website/docs/15-mod_hub_client_info.md"
  tempfile="$file.tmp"

  echo -e "---\nid: hub_client_info\nslug: modules/hub-client-info\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -e "s|^\# \*HubClientInfo\* module|# HubClientInfo|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`hubclientinfo\`\*\*|\:\:\:tip Module Identifier\nhubclientinfo\n\:\:\:|gm" "$file"
  gsed -i    "s|^\*\*Data owner: \`Hub\`\*\*|\:\:\:caution Data owner\nHub\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Configuration Module|\:\:\:info Type\nConfiguration Module\n\:\:\:|gm" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"
  gsed -i 's|^- |* |gm' "$file"
  gsed -i -z "s|\`\n\n\*|\`\n\*|gm" "$file"
  gsed -i -z "s|\n\n\*\s|\n\* |gm" "$file"
  gsed -i -z "s|Examples:\n\*|Examples:\n\n\*|gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}