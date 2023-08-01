#!/usr/bin/env bash

function pre_types(){
  file="$ROOT/ocpi/types.asciidoc"
  gsed -i "s|\[source\]|\[source, text\]|gm" "$file"
}

function fix_types() {
  rm -rf "$ROOT/website/docs/16-types"
  mkdir -p "$ROOT/website/docs/16-types"

  mv "$ROOT/website/docs/16-types.md" "$ROOT/website/docs/16-types/16-types.md"

  file="$ROOT/website/docs/16-types/16-types.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 16\nslug: /types\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i 's|^# Types$|# 🔧 Types|g' "$file"

  gsed -i -z "s/<div class=\"note\">\n/\:\:\:note\n/gm" "$file"
  gsed -i -z "s|\n</div>|\n\:\:\:|gm" "$file"
  
  gsed -i "s|^\`\`\`\stext|\`\`\`text|gm" "$file"
  gsed -i -z "s|\`\`\`text\n{|\`\`\`json\n{|gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
