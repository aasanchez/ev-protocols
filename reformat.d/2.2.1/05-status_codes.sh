#!/usr/bin/env bash

function fix_status_codes() {
  file="$ROOT/docs/05-status_codes.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 5\nslug: status-codes\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i "s|–|-|gm" "$file"
  gsed -i "s/’/'/gm" "$file"
  gsed -i 's|^- |* |gm' "$file"
  gsed -i -z 's|\n\*\s|\* |gm' "$file"
  gsed -i -z 's|:\n\*\s|:\n\n\* |gm' "$file"

}
