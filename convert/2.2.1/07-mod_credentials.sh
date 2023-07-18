#!/usr/bin/env bash

function pre_mod_credentials(){
  file="$ROOT/ocpi/mod_credentials.asciidoc"

  gsed -i '/^.The OCPI registration process$/d' "$file"
  gsed -i '/^.The OCPI update process$/d' "$file"

}

function fix_mod_credentials() {
  file="$ROOT/website/docs/07-mod_credentials.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 7\nslug: credentials\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i "s|^\`\`\`\sjson|\`\`\`json|gm" "$file"
  gsed -i "s/’/'/gm" "$file"
  gsed -i -e "s|^\# \*Credentials\* module|# Credentials|gm" "$file"

  gsed -i "s|^\*\*Module Identifier: \`credentials\`\*\*|\:\:\:tip Module Identifier\ncredentials\n\:\:\:|gm" "$file"
  gsed -i "s/\*\*Type:\*\* Configuration Module/\:\:\:info Type\nConfiguration Module\n\:\:\:/gm" "$file"

  gsed -i '/<figure>/d' "$file"
  gsed -i '/<\/figure>/d' "$file"

  gsed -i "s|<img src=\"images/registration-sequence.svg\" alt=\"The OCPI registration process\" />|![The OCPI registration process](./images/registration-sequence.svg)|g" "$file"
  gsed -i "s|<img src=\"images/update-sequence.svg\" alt=\"The OCPI update process\" />|![The OCPI update process](./images/update-sequence.svg)|g" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"

}
