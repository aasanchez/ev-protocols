#!/usr/bin/env bash

function pre_terminology(){
  file="$ROOT/ocpi/terminology.asciidoc"
  gsed -i 's|+$||gm' "$file"
  gsed -i 's/\.Charging Topology schematic//gm' "$file"

}

function fix_terminology(){
  file="$ROOT/docs/02-terminology.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 2\nslug: terminology-and-definitions\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"
  gsed -i 's|<https://www.ietf.org/rfc/rfc2119.txt>|[https://www.ietf.org/rfc/rfc2119.txt](https://www.ietf.org/rfc/rfc2119.txt)|g' "$file"
  gsed -i -z 's/\n\n- /\n\* /gm' "$file"
  gsed -i -z 's/Examples of platforms:/Examples of platforms:\n/gm' "$file"
  gsed -i 's/[[:blank:]]*$//' "$file"              # Delete Trailspace
  gsed -i "s/’/'/gm" "$file"
  gsed -i "s/“/\"/gm" "$file"
  gsed -i "s/”/\"/gm" "$file"
  gsed -i "s|Belgium and Luxembourg.$|Belgium and Luxembourg.\n|gm" "$file"
  gsed -i "s|codes.de/).|codes.de/).\n|gm" "$file"
  gsed -i "s|\* \*Connector|\n\* \*Connector|gm" "$file"

  gsed -i '/<figure>/d' "$file"
  gsed -i '/<\/figure>/d' "$file"
  gsed -i "s|<img src=\"images/topology.svg\" alt=\"Charging Topology schematic\" />|![Charging Topology schematic](./images/topology.svg)|g" "$file"
  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}


split_terminology() {
  file="$ROOT/docs/02-terminology.md"
  content=$(<"$file")

  # Create the output directory
  output_dir="$ROOT/docs/02-terminology"
  mkdir -p "$output_dir"

  # Split the content based on H2 (##) headers
  IFS=$'\n'
  sections=($(echo "$content" | awk '/^##/ {print NR}'))
  sections+=($(echo "${#content}"))  # Add the end position as the last section
  
  echo ${#sections[@]}
  # Extract and save each section into a separate file
  for ((i = 0; i < ${#sections[@]} - 1; i++)); do
      start=$((sections[i] + 1))
      end=$((sections[i + 1] - 1))
      title=$(echo "${content:${sections[i]}:$((sections[i + 1] - sections[i]))}" | grep -oP '^## \K(.+)')
      slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr -cs '[:alnum:]-' '-')
      output_file="$output_dir/$slug.md"
      echo "${content:$start:$((end - start + 1))}" > "$output_file"
      echo "Saved section '$title' to '$output_file'"
  done
}
