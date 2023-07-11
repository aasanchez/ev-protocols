#!/usr/bin/env bash

# shellcheck source=/dev/null
# shellcheck disable=SC2016

ROOT=$(pwd)

command -v asciidoc >/dev/null 2>&1 ||  { echo >&2 "Please install asciidoc"; exit 1; };
command -v pandoc >/dev/null 2>&1 ||    { echo >&2 "Please install pandoc"; exit 1; };

if [[ ! -d $ROOT/ocpi ]]; then
  git clone https://github.com/ocpi/ocpi.git "$ROOT"/ocpi

fi

cd "$ROOT" || exit 0

splitInH2(){
  file="$1"

  rm -rf "$ROOT/tmp/"
  mkdir -p "$ROOT/tmp/"

  content=$(<"$file")
  sections=($(echo "$content" | awk '/^## / { print NR }'))
  for ((i = 0; i < ${#sections[@]}; i++)); do
    start=${sections[i]}
    end=${sections[i+1]:-$(echo "$content" | wc -l)}
    section_content=$(echo "$content" | sed -n "${start},${end}p")
    section_heading=$(echo "$section_content" | head -n 1 | sed 's/^## //')
    filename=$(echo "$section_heading" | tr '[:upper:]' '[:lower:]' | tr -cd '[:alnum:]\n')
    filename="${filename}.md"
    section_content=$(echo "$section_content" | sed '$d')
    echo "$section_content" > "$ROOT/tmp/$filename"
    echo "Created file: $filename"
  done
}
