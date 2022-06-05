#!/usr/bin/env bash
# shellcheck source=/dev/null
# shellcheck disable=SC2016

ROOT=$(pwd)
SED="$(which sed)"
unamestr=$(uname) 

if [[ "$unamestr" == 'Linux' ]]; then
  SED="$(which sed)"
elif [[ "$unamestr" == 'Darwin' ]]; then
  SED="$(which gsed)"
fi

. ./update/libs/global.sh
. ./update/libs/pre_markdown.sh

cd "$ROOT"/ocpi || exit 0

git reset --hard --quiet
git clean -xfd --quiet
git checkout release-2.2-bugfixes
git pull origin release-2.2-bugfixes --quiet
git clean -xfd --quiet

rsync -av --update --delete --quiet "$ROOT"/ocpi/releases/2.0/*.png "$ROOT"/versioned_docs/version-2.0/images

## Introduction
file="$ROOT/ocpi/releases/2.0/introduction.md"
mdCompanies "$ROOT"/ocpi/releases/2.0/introduction.md
clean_markdown "$file"
$SED -i 's|https://github.com/ocpi/ocpi|[OCPI Github](https://github.com/ocpi/ocpi)|g' "$file"
$SED -i 's|•	|* |g' "$file"
$SED -i -z 's|\:\n\*|\:\n\n\*|g' "$file"

pandoc -t "gfm" --wrap=auto --columns=120 -o "$ROOT/versioned_docs/version-2.0/01-introduction.md" "$file"

file="$ROOT/versioned_docs/version-2.0/01-introduction.md"
clean_markdown "$file"
Head_metadata "1" "$file" "/"
###

## Terminology
file="$ROOT/ocpi/releases/2.0/terminology.md"
clean_markdown "$file"
$SED -i 's/See https:\/\/bdew-codes.*$//' "$file"
pandoc -t "gfm" --wrap=auto --columns=120 -o "$ROOT/versioned_docs/version-2.0/02-terminology.md" "$file"
file="$ROOT/versioned_docs/version-2.0/02-terminology.md"
clean_markdown "$file"
Head_metadata "2" "$file"
$SED -i 's|<img src=\"data/topology.png\" alt=\"Topology\" />|![Topology](images/topology.png)|g' "$ROOT/versioned_docs/version-2.0/02-terminology.md"
$SED -i 's/\*Connector\*/\_Connector\_/g' "$file"
$SED -i 's/\*EVSE\*/\_EVSE\_/g' "$file"
$SED -i 's/\*Location\*/\_Location\_/g' "$file"
###

## Transport
file="$ROOT/ocpi/releases/2.0/transport_and_format.md"
$SED -i -z 's|Authorization|Authorizatiooooon|g' "$file"
clean_markdown "$file"
$SED -i -z 's|```\nAuthorization|```plaintext\nAuthorization|g' "$file"
$SED -i -z 's|```\nLink|```plaintext\nLink|g' "$file"
$SED -i -z 's|```\nhttps|```plaintext\nhttps|g' "$file"



# $SED -i -z 's|https://example.com/ocpi/cpo/2.0/credentials|<https://example.com/ocpi/cpo/2.0/credentials>|g' "$file"
# $SED -i -z 's|https://example.com/ocpi/cpo/2.0/locations|<https://example.com/ocpi/cpo/2.0/locations>|g' "$file"
# $SED -i -z 's|https://example.com/ocpi/emsp/2.0/credentials|<https://example.com/ocpi/emsp/2.0/credentials>|g' "$file"
# $SED -i -z 's|https://example.com/ocpi/emsp/2.0/locations|<https://example.com/ocpi/emsp/2.0/locations>|g' "$file"

# original_json='{"data": [{'

# formatted_json='{"data":['

# original_escaped=$(printf '%s\n' "$original_json" | sed -e 's/[]\/$*.^[]/\\&/g')
# formatted_escaped=$(printf '%s\n' "$formatted_json" | sed -e 's/[]\/$*.^[]/\\&/g')

# $SED -i "s|$original_escaped|$formatted_escaped|g" "$file"




# # $SED -i 's/[[:blank:]]*$//' "$file"
# # $SED -i -z 's|\n```\n\s\s\sLink|\n\n```plaintext\nLink|g' "$file"
# # $SED -i -z 's|\n```\n\s\s\shttps|\n\n```plaintext\nhttps|g' "$file"
# # $SED -i 's|https://example.com/ocpi/cpo/2.0/credentials|`https://example.com/ocpi/cpo/2.0/credentials`|g' "$file"
# # $SED -i 's|https://example.com/ocpi/cpo/2.0/locations|`https://example.com/ocpi/cpo/2.0/locations`|g' "$file"
# # $SED -i 's|https://example.com/ocpi/emsp/2.0/credentials|`https://example.com/ocpi/emsp/2.0/credentials`|g' "$file"
# # $SED -i 's|https://example.com/ocpi/emsp/2.0/locations|`https://example.com/ocpi/emsp/2.0/locations`|g' "$file"
# # $SED -i 's|credentials.md#credentials-object|http://ocpi.dev|g' "$file"
# # $SED -i 's|status_codes.md#status-codes|http://ocpi.dev|g' "$file"
# # $SED -i 's|types.md#12_datetime_type|http://ocpi.dev|g' "$file"

# pandoc -t "gfm" --wrap=auto --columns=120 -o "$ROOT"/versioned_docs/version-2.0/03-transport-and-format.md "$file"
# clean_markdown "$file"
# # $SED -i 's/[[:blank:]]*$//' "$ROOT/versioned_docs/version-2.0/03-transport-and-format.md"              # Delete Trailspace
# # $SED -i '/^$/N;/\n$/D' "$ROOT/versioned_docs/version-2.0/03-transport-and-format.md"

# ## Status
# file="$ROOT/ocpi/releases/2.0/status_codes.md"
# clean_markdown "$file"
# pandoc -t "gfm" --wrap=auto --columns=120 -o "$ROOT"/versioned_docs/version-2.0/04-status-codes.md "$file"

# ## Versions
# file="$ROOT/ocpi/releases/2.0/version_information_endpoint.md"
# clean_markdown "$file"
# # $SED -i 's|types.md#14_url_type|http://ocpi.dev|g' "$file"
# # $SED -i 's|types.md#13_decimal_type|http://ocpi.dev|g' "$file"
# # $SED -i 's|types.md#14_url|http://ocpi.dev|g' "$file"
# # $SED -i 's|mod_cdrs.md|http://ocpi.dev|g' "$file"
# # $SED -i 's|credentials.md|http://ocpi.dev|g' "$file"
# # $SED -i 's|mod_locations.md|http://ocpi.dev|g' "$file"
# # $SED -i 's|mod_sessions.md|http://ocpi.dev|g' "$file"
# # $SED -i 's|mod_tariffs.md|http://ocpi.dev|g' "$file"
# # $SED -i 's|mod_tokens.md|http://ocpi.dev|g' "$file"

# pandoc -t "gfm" --wrap=auto --columns=120 -o "$ROOT/versioned_docs/version-2.0/05-version-details.md" "$file"

# # file="$ROOT/versioned_docs/version-2.0/05-version-details.md"
# # output_directory="$ROOT/versioned_docs/version-2.0/"
# # IFS=$'\n'
# # while read -r line; do
# #   if [[ $line =~ ^#\  ]]; then
# #     heading="${line:2}"
# #     filename=$(echo "$heading" | tr '[:upper:]' '[:lower:]' | tr '[:space:]' '-' | tr -cd '[:alnum:]-')
# #     current_file="$output_directory/$filename.md"
# #     echo -e "# $heading\n" > "$current_file"
# #   else
# #     echo "$line" >> "$current_file"
# #   fi
# # done < "$file"
# # $SED -i 's/[[:blank:]]*$//' "$ROOT/versioned_docs/version-2.0/version-information-endpoint-.md"              # Delete Trailspace
# # $SED '/^$/{N;/^\n$/D;}'         "$ROOT/versioned_docs/version-2.0/version-information-endpoint-.md" > "$ROOT/versioned_docs/version-2.0/version-information-endpoint.md.tmp"
# # mv "$ROOT/versioned_docs/version-2.0/version-information-endpoint.md.tmp"                        "$ROOT/versioned_docs/version-2.0/05-version-information-endpoint.md"
# # rm "$ROOT/versioned_docs/version-2.0/version-information-endpoint-.md"
# # $SED -i 's|\*\([^*]*\)\*|_\1_|g'  "$ROOT/versioned_docs/version-2.0/05-version-information-endpoint.md"
# # $SED -i "$ d" "$ROOT/versioned_docs/version-2.0/05-version-information-endpoint.md"

# # $SED -i 's/[[:blank:]]*$//' "$ROOT/versioned_docs/version-2.0/version-details-endpoint-.md"              # Delete Trailspace
# # $SED '/^$/{N;/^\n$/D;}'         "$ROOT/versioned_docs/version-2.0/version-details-endpoint-.md" > "$ROOT/versioned_docs/version-2.0/version-details-endpoint.md.tmp"
# # mv "$ROOT/versioned_docs/version-2.0/version-details-endpoint.md.tmp"                         "$ROOT/versioned_docs/version-2.0/06-version-details-endpoint.md"
# # rm "$ROOT/versioned_docs/version-2.0/version-details-endpoint-.md"
# # $SED -i 's|\*\([^*]*\)\*|_\1_|g' "$ROOT/versioned_docs/version-2.0/06-version-details-endpoint.md"

# # rm "$ROOT/versioned_docs/version-2.0/05-version-details.md"

# ## Credentials
# file="$ROOT/ocpi/releases/2.0/credentials.md"
# clean_markdown "$file"
# # $SED -i 's|#11-get-method|http://ocpi.dev|g' "$file"
# # $SED -i 's|#12-post-method|http://ocpi.dev|g' "$file"
# # $SED -i 's|#13-put-method|http://ocpi.dev|g' "$file"
# # $SED -i 's|#14-delete-method|http://ocpi.dev|g' "$file"
# # $SED -i 's|types.md#14_url_type|http://ocpi.dev|g' "$file"
# # $SED -i 's|mod_locations.md#41-businessdetails-class|http://ocpi.dev|g' "$file"
# # $SED -i 's|types.md#16-string-type|http://ocpi.dev|g' "$file"
# # $SED -i 's|status_codes.md#3xxx-server-errors|http://ocpi.dev|g' "$file"

# pandoc -t "gfm" --wrap=auto --columns=120 -o "$ROOT/versioned_docs/version-2.0/07-credentials.md" "$file"

# # file="$ROOT/versioned_docs/version-2.0/07-credentials.md"
# # $SED -i 's/<figure>//gm' "$file"
# # $SED -i 's/<\/figure>//gm' "$file"
# # $SED -i '/figcaption/d' "$file"
# # $SED -i 's|<img src=\"data/registration-sequence.png\" alt=\"the OCPI registration process\" \/>|![the OCPI registration process](images/registration-sequence.png)|g' "$file"
# # $SED -i 's|<img src=\"data/update-sequence.png\" alt=\"the OCPI update process\" />|![the OCPI update process](images/update-sequence.png)|g' "$file"

# # $SED '/^$/{N;/^\n$/D;}' "$file" > "$file.tmp"
# # mv "$file.tmp" "$file"

# # touch "$file.tmp"
# # while read -r line; do
# #   if [[ $line =~ ^#  ]]; then
# #     new="$(echo "$line" | $SED 's/[0-9.*]//g' | $SED 's/ \{2,\}/ /g')"
# #     echo "$new"  >> "$file.tmp"
# #   else
# #     echo "$line" >> "$file.tmp"
# #   fi
# # done < "$file"
# # mv "$file.tmp" "$file"

# # $SED -i 's|\*\*Module Identifier: `credentials`\*\*|\:\:\:info\nModule Identifier: `credentials`\n\:\:\:|g' "$file"

# ## Locations
# file="$ROOT/ocpi/releases/2.0/mod_locations.md"
# clean_markdown "$file"
# pandoc -t "gfm" --wrap=auto --columns=120 -o "$ROOT/versioned_docs/version-2.0/08-locations.md" "$file"
# # file="$ROOT/versioned_docs/version-2.0/08-locations.md"
