#!/usr/bin/env bash

ROOT=$(pwd)

DIR="$ROOT/website/docs"
markdown_files=$(find "$DIR" -name "*.md" | sort)

merged_file="website/static/fieva.md"
rm -rf $merged_file
touch $merged_file

for file in $markdown_files; do
  echo "Merging $file..."
  cat "$file" >> $merged_file
done

mdl website/static/fieva.md

