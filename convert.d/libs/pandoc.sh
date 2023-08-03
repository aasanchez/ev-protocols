#!/usr/bin/env bash

function pandoc2markdown(){
  number=$(echo "$1" | cut -d'-' -f1)
  file=$(echo "$1" | cut -d'-' -f2)

  format="gfm"
  echo "Processing $file to $format"
  cp "$ROOT/ocpi/$file.asciidoc" "$ROOT/website/docs/$file.asciidoc"
  asciidoc -b docbook "$ROOT/website/docs/$file.asciidoc"
  pandoc -f docbook -t $format --wrap=auto --columns=120 "$ROOT/website/docs/$file.xml" -o "$ROOT/website/docs/$number-$file.md"
  rm "$ROOT/website/docs/$file.asciidoc" "$ROOT/website/docs/$file.xml"
}
