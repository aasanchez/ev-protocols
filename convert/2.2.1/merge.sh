#!/usr/bin/env bash

ROOT=$(pwd)

OUTPUT_FILE="$ROOT/static/fieva.md"
rm -rf "$OUTPUT_FILE"

for file in $(find "$ROOT"/docs/*.md | sort); do
  echo "Merging $file..."
  tail -n +5 "$file" >> "$OUTPUT_FILE"
  echo "" >> "$OUTPUT_FILE"
done

gsed -i '/^$/{N;/^\n$/D;}' "$OUTPUT_FILE"

mdl static/fieva.md
