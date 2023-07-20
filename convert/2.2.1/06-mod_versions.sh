#!/usr/bin/env bash

function pre_mod_versions(){
  file="$ROOT/ocpi/mod_versions.asciidoc"
  gsed -i 's|+$||gm' "$file"
}

function fix_mod_versions() {
  file="$ROOT/website/docs/06-mod_versions.md"
  tempfile="$file.tmp"

  echo -e "---\nid: versions\nslug: modules/versions\n---" | cat - "$file" > "$tempfile"
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
  echo "$file ocpi.dev flavored"

  splitInH2 "$file"

  rm -rf "$ROOT/website/docs/05-versions"
  mkdir -p "$ROOT/website/docs/05-versions"

  mv "$ROOT/tmp/versioninformationendpoint.md" "$ROOT/website/docs/05-versions/02-version-information-endpoint.md"
  mv "$ROOT/tmp/versiondetailsendpoint.md"     "$ROOT/website/docs/05-versions/03-version-details-endpoint.md"

  < "$file" gsed -n '1,/## Version information endpoint/p' > "$ROOT/website/docs/05-versions/01-version-intro.md"



}
