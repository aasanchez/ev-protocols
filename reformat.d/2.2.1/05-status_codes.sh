#!/usr/bin/env bash

function fix_status_codes() {
  file="$ROOT/docs/05-status_codes.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 5\nslug: status-codes\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  $SED -i "s|–|-|gm" "$file"
  $SED -i "s/’/'/gm" "$file"
  $SED -i 's|^- |* |gm' "$file"
}
