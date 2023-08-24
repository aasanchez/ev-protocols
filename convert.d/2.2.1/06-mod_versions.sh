#!/usr/bin/env bash

function pre_mod_versions(){
  file="$ROOT/ocpi/mod_versions.asciidoc"
  gsed -i 's|+$||gm' "$file"
}

function fix_mod_versions() {
  file="$ROOT/website/docs/06-mod_versions.md"
  tempfile="$file.tmp"

  echo -e "---\nid: versions\nslug: modules/versiones\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s/<div class=\"note\">\n/\:\:\:note\n/gm" "$file"
  gsed -i -z "s|\n</div>|\n\:\:\:|gm" "$file"
  gsed -i "s/’/'/gm" "$file"
  gsed -i "s|‘credentials|\*\*credentials|gm" "$file"
  gsed -i "s|\` mo| mo|gm" "$file"
  gsed -i 's/\*\*credentials\\ module,/**credentials** module,/g' "$file"

  gsed -i -e "s|^\# \*Versions\* module|# Versions|gm" "$file"

  gsed -i "s/\*\*Type:\*\* Configuration Module/\:\:\:info Type\nConfiguration Module\n\:\:\:/gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}

function flavored_mod_versions() {
  file="$ROOT/website/docs/06-mod_versions.md"
  tempfile="$file.tmp"
  echo "$file EV-protocols flavored"

  splitInH2 "$file"

  rm -rf "$ROOT/website/docs/06-modules/01-versions"
  mkdir -p "$ROOT/website/docs/06-modules/01-versions"

  mv "$ROOT/tmp/versioninformationendpoint.md" "$ROOT/website/docs/06-modules/01-versions/02-information-endpoint.md"
  mv "$ROOT/tmp/versiondetailsendpoint.md"     "$ROOT/website/docs/06-modules/01-versions/03-details-endpoint.md"

  < "$file" gsed -n '1,/## Version information endpoint/p' > "$ROOT/website/docs/06-modules/01-versions/01-intro.md"

  file="$ROOT/website/docs/06-modules/01-versions/01-intro.md"
  echo "flavoring $file"
  gsed -i '1,4d' "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: intro
slug: /modules/versions
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i -z "s|# Versions|# Versions\n\n\:\:\:tip Module Identifier\nversions\n\:\:\:|gm" "$file"
  gsed -i '/# Version information endpoint/d' "$file"
  gsed -i '/^[[:space:]]*$/{N; /^\n\n$/d}' "$file"
  gsed -i -z 's/versions.\n\n/versions.\n/gm' "$file"

  file="$ROOT/website/docs/06-modules/01-versions/02-information-endpoint.md"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: information-endpoint
slug: /modules/versions/information-endpoint
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  echo "flavoring $file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i "s/^## Version/### Version/gm" "$file"

  file="$ROOT/website/docs/06-modules/01-versions/03-details-endpoint.md"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: details-endpoint
slug: /modules/versions/details-endpoint
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  echo "flavoring $file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"

  gsed -i "s/^### Data/## Data/gm" "$file"
  gsed -i "s/^### GET/## GET/gm" "$file"

  rm -rf "$ROOT/website/docs/06-mod_versions.md"

}
