#!/usr/bin/env bash

function fix_status_codes() {
  rm -rf "$ROOT/website/docs/ocpi/05-status-codes"
  mkdir -p "$ROOT/website/docs/ocpi/05-status-codes"

  mv "$ROOT/website/docs/ocpi/05-status_codes.md" "$ROOT/website/docs/ocpi/05-status-codes/01-status-codes.md"

  file="$ROOT/website/docs/ocpi/05-status-codes/01-status-codes.md"
  tempfile="$file.tmp"

  gsed -i "s|^# Status codes$|# 🚦 Status codes|gm" "$file"

  echo -e "---\nsidebar_position: 5\nslug: /ocpi/status-codes\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i "s|–|-|gm" "$file"
  gsed -i "s/’/'/gm" "$file"
  gsed -i 's|^- |* |gm' "$file"
  gsed -i -z 's|\n\*\s|\* |gm' "$file"
  gsed -i -z 's|:\n\*\s|:\n\n\* |gm' "$file"

}
