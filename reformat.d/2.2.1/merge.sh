#!/usr/bin/env bash

ROOT=$(pwd)

OUTPUT_FILE="$ROOT/docs/fieva.md"
rm -rf "$OUTPUT_FILE"

for file in $(find "$ROOT"/docs/*.md | sort); do
  cat "$file" >> "$OUTPUT_FILE"
done


