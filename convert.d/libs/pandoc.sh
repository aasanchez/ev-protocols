#!/usr/bin/env bash

function pandoc2markdown(){
  number=$(echo "$1" | cut -d'-' -f1)
  file=$(echo "$1" | cut -d'-' -f2)

  format="gfm"
  echo "Processing $file to $format"
  cp "$ROOT/ocpi/$file.asciidoc" "$ROOT/docs/$file.asciidoc"
  asciidoc -b docbook "$ROOT/docs/$file.asciidoc"
  pandoc -f docbook -t $format --wrap=auto --columns=120 "$ROOT/docs/$file.xml" -o "$ROOT/docs/$number-$file.md"
  rm "$ROOT/docs/$file.asciidoc" "$ROOT/docs/$file.xml"
}
