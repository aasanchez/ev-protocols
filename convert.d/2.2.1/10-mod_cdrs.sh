#!/usr/bin/env bash

function pre_mod_cdrs(){
  file="$ROOT/ocpi/mod_cdrs.asciidoc"
  gsed -i 's|+$||gm' "$file"
}

function fix_mod_cdrs() {
  file="$ROOT/website/docs/10-mod_cdrs.md"
  tempfile="$file.tmp"

  echo -e "---\nid: cdrs\nslug: modules/cdrs\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -e "s|^\# \*CDRs\* module|# CDRs|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`cdrs\`\*\*|\:\:\:tip Module Identifier\ncdrs\n\:\:\:|gm" "$file"
  gsed -i    "s|^\*\*Data owner: \`CPO\`\*\*|\:\:\:caution Data owner\nCPO\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"
  
  gsed -i 's|^- |* |gm' "$file"
  
  gsed -i    "s/’/'/gm" "$file"
  gsed -i    "s|^======|#####|gm" "$file"

  gsed -i -z "s|\*\*step_size\:\*\* |#### Step_size\n\n|gm" "$file"
  gsed -i -z "s|\*\*ChargingPeriod\:\*\* |#### ChargingPeriod\n\n|gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"

  mv "$tempfile" "$file"
  echo "" >> "$file"
}

function flavored_mod_cdrs() {
  file="$ROOT/website/docs/10-mod_cdrs.md"
  tempfile="$file.tmp"
  echo "$file EV-protocols flavored"
  MODULE="05-cdrs"
  splitInH2 "$file"

  rm -rf "$ROOT/website/docs/06-modules/05-cdrs"
  mkdir -p "$ROOT/website/docs/06-modules/05-cdrs"

  # reserved
  # mv "$ROOT/tmp/usecases.md"                "$ROOT/website/docs/06-modules/$MODULE/03-use-cases.md"
  mv "$ROOT/tmp/flowandlifecycle.md"        "$ROOT/website/docs/06-modules/$MODULE/04-flow-and-lifecycle.md"
  mv "$ROOT/tmp/interfacesandendpoints.md"  "$ROOT/website/docs/06-modules/$MODULE/05-interfaces-and-endpoints.md"
  mv "$ROOT/tmp/objectdescription.md"       "$ROOT/website/docs/06-modules/$MODULE/06-object-description.md"
  mv "$ROOT/tmp/datatypes.md"               "$ROOT/website/docs/06-modules/$MODULE/07-data-types.md"

  < "$file" gsed -n '1,/## Flow and Lifecycle/p' > "$ROOT/website/docs/06-modules/$MODULE/01-intro.md"

  file="$ROOT/website/docs/06-modules/$MODULE/01-intro.md"
  echo "flavoring $file"
  gsed -i '1,4d' "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: intro
slug: /modules/cdrs
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i '/## Flow and Lifecycle/d' "$file"
  gsed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' -e 'P;D' "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/04-flow-and-lifecycle.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: flow-and-lifecycle
slug: /modules/cdrs/flow-and-lifecycle
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/05-interfaces-and-endpoints.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: interfaces-and-endpoints
slug: /modules/cdrs/interfaces-and-endpoints
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i "s/^##### /#### /gm" "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/06-object-description.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: object-description
slug: /modules/cdrs/object-description
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
slug: /modules/cdrs/data-types
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"

  rm -rf "$ROOT/website/docs/10-mod_cdrs.md"
}