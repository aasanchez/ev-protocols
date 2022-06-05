#!/usr/bin/env bash

function clean_markdown(){
  local file=$1
  $SED -i 's|<div><!-- ---------------------------------------------------------------------------- --></div>||g' "$file"
  $SED -i 's|^- |* |g' "$file"
  $SED -i '/figure\>/d'   "$file"
  $SED -i '/figcaption/d' "$file"
  $SED -i 's|(credentials.md#credentials-object)|(https://ocpi.dev)|g' "$file"
  $SED -i 's|(credentials.md)|(https://ocpi.dev)|g' "$file"
  $SED -i 's|(mod_cdrs.md)|(https://ocpi.dev)|g' "$file"
  $SED -i 's|(mod_locations.md)|(https://ocpi.dev)|g' "$file"
  $SED -i 's|(mod_sessions.md)|(https://ocpi.dev)|g' "$file"
  $SED -i 's|(mod_tariffs.md)|(https://ocpi.dev)|g' "$file"
  $SED -i 's|(mod_tokens.md)|(https://ocpi.dev)|g' "$file"
  $SED -i 's|(status_codes.md#status-codes)|(https://ocpi.dev)|g' "$file"
  $SED -i 's|(types.md#12_datetime_type)|(https://ocpi.dev)|g' "$file"
  $SED -i 's|(types.md#13_decimal_type)|(https://ocpi.dev)|g' "$file"
  $SED -i 's|(types.md#14_url_type)|(https://ocpi.dev)|g' "$file"
  $SED -i 's|(types.md#14_url)|(https://ocpi.dev)|g' "$file"
  echo "" > "$file.tmp"
  while read -r line; do
    if [[ $line =~ ^#  ]]; then
      # echo $line
      new="$(echo "$line" | $SED 's/[0-9.\*_]//g' | $SED 's/ \{2,\}/ /g')"
      echo "$new"  >> "$file.tmp"
      # echo $new
    else
      echo "$line" >> "$file.tmp"
    fi
  done < "$file"
  mv "$file.tmp" "$file"
  sed '/^$/N;/^\n$/D' "$file" > "$file.tmp"
  mv "$file.tmp" "$file"
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
