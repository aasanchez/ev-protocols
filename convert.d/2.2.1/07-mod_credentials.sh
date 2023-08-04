#!/usr/bin/env bash

function pre_mod_credentials(){
  file="$ROOT/ocpi/mod_credentials.asciidoc"

  gsed -i '/^.The OCPI registration process$/d' "$file"
  gsed -i '/^.The OCPI update process$/d' "$file"

}

function fix_mod_credentials() {
  file="$ROOT/website/docs/07-mod_credentials.md"
  tempfile="$file.tmp"

  echo -e "---\nid: credentials\nslug: modules/credentials\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i "s|^\`\`\`\sjson|\`\`\`json|gm" "$file"
  gsed -i "s/’/'/gm" "$file"
  gsed -i -e "s|^\# \*Credentials\* module|# Credentials|gm" "$file"

  gsed -i "s|^\*\*Module Identifier: \`credentials\`\*\*|\:\:\:tip Module Identifier\ncredentials\n\:\:\:|gm" "$file"
  gsed -i "s/\*\*Type:\*\* Configuration Module/\:\:\:info Type\nConfiguration Module\n\:\:\:/gm" "$file"

  gsed -i "s|<img src=\"images/registration-sequence.svg\" alt=\"The OCPI registration process\" />|![The OCPI registration process](../../images/registration-sequence.svg)|g" "$file"
  gsed -i "s|<img src=\"images/update-sequence.svg\" alt=\"The OCPI update process\" />|![The OCPI update process](../../images/update-sequence.svg)|g" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  gsed -i '/^$/N;/^\n$/D'  "$file"

}

function flavored_mod_credentials() {
  file="$ROOT/website/docs/07-mod_credentials.md"
  tempfile="$file.tmp"
  echo "$file ocpi.dev flavored"
  MODULE="02-credentials"
  splitInH2 "$file"

  rm -rf "$ROOT/website/docs/06-modules/02-credentials"
  mkdir -p "$ROOT/website/docs/06-modules/02-credentials"

  # reserved
  mv "$ROOT/tmp/usecases.md"                "$ROOT/website/docs/06-modules/$MODULE/03-use-cases.md"
  # Flow
  mv "$ROOT/tmp/interfacesandendpoints.md"  "$ROOT/website/docs/06-modules/$MODULE/05-interfaces-and-endpoints.md"
  mv "$ROOT/tmp/objectdescription.md"       "$ROOT/website/docs/06-modules/$MODULE/06-object-description.md"
  mv "$ROOT/tmp/datatypes.md"               "$ROOT/website/docs/06-modules/$MODULE/07-data-types.md"

  < "$file" gsed -n '1,/## Use cases/p' > "$ROOT/website/docs/06-modules/$MODULE/01-intro.md"

  file="$ROOT/website/docs/06-modules/$MODULE/01-intro.md"
  echo "flavoring $file"
  gsed -i '1,4d' "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: intro
slug: /modules/credentials
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i '/## Use cases/d' "$file"
  gsed -i '/^[[:space:]]*$/{N; /^\n\n$/d}' "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/03-use-cases.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: use-cases
slug: /modules/credentials/use-cases
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/05-interfaces-and-endpoints.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: interfaces-and-endpoints
slug: /modules/credentials/interfaces-and-endpoints
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/06-object-description.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: object-description
slug: /modules/credentials/object-description
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
slug: /modules/credentials/data-types
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"

  rm -rf "$ROOT/website/docs/07-mod_credentials.md"
}