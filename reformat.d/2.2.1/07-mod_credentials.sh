#!/usr/bin/env bash

function pre_mod_credentials(){
  file="$ROOT/ocpi/mod_credentials.asciidoc"

  $SED -i '/^.The OCPI registration process$/d' "$file"
  $SED -i '/^.The OCPI update process$/d' "$file"

}

function fix_mod_credentials() {
  file="$ROOT/docs/07-mod_credentials.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 7\nslug: module-credentials\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  $SED -i "s|^\`\`\`\sjson|\`\`\`json|gm" "$file"
  $SED -i "s/’/'/gm" "$file"
  $SED -i -e "s|^\# \*Credentials\* module|# Credentials module|gm" "$file"

  $SED -i "s|^\*\*Module Identifier: \`credentials\`\*\*|\:\:\:tip Module Identifier\ncredentials\n\:\:\:|gm" "$file"
  $SED -i "s/\*\*Type:\*\* Configuration Module/\:\:\:info Type\nConfiguration Module\n\:\:\:/gm" "$file"

  $SED -i '/<figure>/d' "$file"
  $SED -i '/<\/figure>/d' "$file"

  $SED -i "s|<img src=\"images/registration-sequence.svg\" alt=\"The OCPI registration process\" />|![The OCPI registration process](./images/registration-sequence.svg)|g" "$file"
  $SED -i "s|<img src=\"images/update-sequence.svg\" alt=\"The OCPI update process\" />|![The OCPI update process](./images/update-sequence.svg)|g" "$file"
  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"

}
