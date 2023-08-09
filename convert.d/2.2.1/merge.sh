#!/usr/bin/env bash

ROOT=$(pwd)
echo $ROOT
DIR="$ROOT/website/docs"
markdown_files=$(find "$DIR" -name "*.md" | sort)

merged_file="website/static/fieva.md"
rm -rf $merged_file
tail -n +5 "website/docs/01-introduction/01-introduction.md" >> "$merged_file"
# cp website/docs/01-introduction/01-introduction.md $merged_file

for file in $markdown_files; do
  if [[ $(basename "$file") == "$ROOT/website/docs/01-introduction/introduction.md" ]]; then
    echo "/Users/aasanchez/Development/ocpi.dev/website/docs/01-introduction/01-introduction.md"
    continue
  fi
  echo "Merging $file..."
  tail -n +5 "$file" >> "$merged_file"
  echo "" >> "$merged_file"
done

gsed -i -E 's|^#|##|g' "$merged_file"
gsed -i '/^$/N;/^\n$/D' "$merged_file"

# gsed -i 's|## ⚡ OCPI|# ⚡ OCPI|gm' "$merged_file"


# mdl website/static/fieva.md