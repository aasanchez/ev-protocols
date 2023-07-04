#!/usr/bin/env bash

function clean_asciidoc(){
  local file=$1
  tempfile="$file.tmp"
  
}

function clean_markdown(){
  local file=$1
  tempfile="$file.tmp"

}

function Head_metadata (){
  local position=$1
  local file=$2
  local slug=$3
  echo "---" > "$file.tmp"
  echo "sidebar_position: $position" >> "$file.tmp"
  if [[ -n $slug ]]; then
    echo "slug: $3" >> "$file.tmp"
  fi
  echo "---" >> "$file.tmp"
  cat "$file" >> "$file.tmp"
  mv "$file.tmp" "$file"
}
