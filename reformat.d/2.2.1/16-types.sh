#!/usr/bin/env bash

function pre_types(){
  file="$ROOT/ocpi/types.asciidoc"
  gsed -i "s|\[source\]|\[source, text\]|gm" "$file"
  # gsed -i "s|\[source\]|\[source, text\]|gm" "$file"
}

function fix_types() {
  file="$ROOT/docs/16-types.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 16\nslug: types\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -z "s/<div class=\"note\">\n/\:\:\:note/gm" "$file"
  gsed -i -z "s|\n</div>|\:\:\:|gm" "$file"
  
  gsed -i "s|^\`\`\`\stext|\`\`\`text|gm" "$file"
  gsed -i -z "s|\`\`\`text\n{|\`\`\`json\n{|gm" "$file"
  
  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
