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

function flavored_mod_hubclientinfo() {
  file="$ROOT/website/docs/15-mod_hub_client_info.md"
  tempfile="$file.tmp"
  echo "$file ocpi.dev flavored"
  MODULE="10-hubclientinfo"
  splitInH2 "$file"

  rm -rf "$ROOT/website/docs/06-modules/10-hubclientinfo"
  mkdir -p "$ROOT/website/docs/06-modules/10-hubclientinfo"

  mv "$ROOT/tmp/scenarios.md"           "$ROOT/website/docs/06-modules/$MODULE/03-scenarios.md"
  mv "$ROOT/tmp/flowandlifecycle.md"    "$ROOT/website/docs/06-modules/$MODULE/04-flow-and-lifecycle.md"
  mv "$ROOT/tmp/interfaces.md"          "$ROOT/website/docs/06-modules/$MODULE/05-interfaces.md"
  mv "$ROOT/tmp/objectdescription.md"   "$ROOT/website/docs/06-modules/$MODULE/06-object-description.md"
  mv "$ROOT/tmp/datatypes.md"           "$ROOT/website/docs/06-modules/$MODULE/07-data-types.md"

  < "$file" gsed -n '1,/## Scenarios/p' > "$ROOT/website/docs/06-modules/$MODULE/01-intro.md"

  file="$ROOT/website/docs/06-modules/$MODULE/01-intro.md"
  echo "flavoring $file"
  gsed -i '1,4d' "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: intro
slug: /modules/hubclientinfo
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i '/## Scenarios/d' "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"
  gsed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' -e 'P;D' "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/03-scenarios.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: scenarios
slug: /modules/hubclientinfo/scenarios
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/04-flow-and-lifecycle.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: flow-and-lifecycle
slug: /modules/hubclientinfo/flow-and-lifecycle
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^## Still alive check./## Still alive check/gm" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/05-interfaces.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: interfaces
slug: /modules/hubclientinfo/interfaces
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/06-object-description.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: object-description
slug: /modules/hubclientinfo/object-description
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/07-data-types.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: data-types
slug: /modules/hubclientinfo/data-types
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"

  rm -rf "$ROOT/website/docs/15-mod_hub_client_info.md"
}
