#!/usr/bin/env bash
# shellcheck source=/dev/null

. ./convert.d/libs/global.sh
. ./convert.d/libs/links.sh
. ./convert.d/libs/pandoc.sh

echo "$ROOT"

cd "$ROOT"/ocpi || exit 0

git reset --hard --quiet
git clean -xfd --quiet
git checkout release-2.2.1-bugfixes
git pull origin release-2.2.1-bugfixes --quiet
git clean -xfd --quiet

cd "$ROOT" || exit 0

directory="ocpi/examples"
json_files=$(find "$directory" -type f -name "*.json")
for file in $json_files; do
  echo "Formatting $file..."
  jq '.' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
done

cp -a ocpi/images/. website/docs/ocpi/images/
cp -a ocpi/examples/. website/docs/ocpi/examples/

directory="website/docs/ocpi/images"
json_files=$(find "$directory" -type f -name "*.svg")
for file in $json_files; do
  echo "Adding white background to $file..."
  gsed -i -e 's|zoomAndPan="magnify">|zoomAndPan="magnify"><rect width="100%" height="100%" fill="white" />|gm' "$file"
  gsed -i -e 's|"http://www.drawsvg.org"><defs|"http://www.drawsvg.org"><rect width="100%" height="100%" fill="white" /><defs|gm' "$file"
  gsed -i -e 's|preserveAspectRatio="none">|preserveAspectRatio="none"><rect width="100%" height="100%" fill="white" />|gm' "$file"
  gsed -i -e 's|ydpi="53.060001">|ydpi="53.060001"><rect width="100%" height="100%" fill="white" />|gm' "$file"
done

. ./convert.d/2.2.1/01-introduction.sh
pre_introduction
links "ocpi/introduction.asciidoc"
pandoc2markdown "01-introduction"
common_cleaning "website/docs/ocpi/01-introduction.md"
fix_introduction
flavored_introduction

echo ""

. ./convert.d/2.2.1/02-terminology.sh
pre_terminology
links "ocpi/terminology.asciidoc"
pandoc2markdown "02-terminology"
common_cleaning "website/docs/ocpi/02-terminology.md"
fix_terminology
flavored_terminology

echo ""

. ./convert.d/2.2.1/03-topology.sh
pre_topology
links "ocpi/topology.asciidoc"
pandoc2markdown "03-topology"
common_cleaning "website/docs/ocpi/03-topology.md"
fix_topology

echo ""

. ./convert.d/2.2.1/04-transport_and_format.sh
pre_transport_and_format
links "ocpi/transport_and_format.asciidoc"
pandoc2markdown "04-transport_and_format"
common_cleaning "website/docs/ocpi/04-transport_and_format.md"
fix_transport_and_format
flavored_transport_and_format

echo ""

. ./convert.d/2.2.1/05-status_codes.sh
pandoc2markdown "05-status_codes"
common_cleaning "website/docs/ocpi/05-status_codes.md"
fix_status_codes

echo ""

# mv ocpi/version_information_endpoint.asciidoc ocpi/mod_versions.asciidoc
# . ./convert.d/2.2.1/06-mod_versions.sh
# pre_mod_versions
# links "ocpi/mod_versions.asciidoc"
# pandoc2markdown "06-mod_versions"
# common_cleaning "website/docs/ocpi/06-mod_versions.md"
# fix_mod_versions
# flavored_mod_versions

# echo ""

# mv ocpi/credentials.asciidoc ocpi/mod_credentials.asciidoc
# . ./convert.d/2.2.1/07-mod_credentials.sh
# pre_mod_credentials
# links "ocpi/mod_credentials.asciidoc"
# pandoc2markdown "07-mod_credentials"
# common_cleaning "website/docs/ocpi/07-mod_credentials.md"
# fix_mod_credentials
# flavored_mod_credentials

# echo ""

# . ./convert.d/2.2.1/08-mod_locations.sh
# pre_mod_locations
# links "ocpi/mod_locations.asciidoc"
# pandoc2markdown "08-mod_locations"
# common_cleaning "website/docs/ocpi/08-mod_locations.md"
# fix_mod_locations
# flavored_mod_locations

# echo ""

# . ./convert.d/2.2.1/09-mod_sessions.sh
# pre_mod_sessions
# links "ocpi/mod_sessions.asciidoc"
# pandoc2markdown "09-mod_sessions"
# common_cleaning "website/docs/ocpi/09-mod_sessions.md"
# fix_mod_sessions
# flavored_mod_sessions

# echo ""

# . ./convert.d/2.2.1/10-mod_cdrs.sh
# pre_mod_cdrs
# links "ocpi/mod_cdrs.asciidoc"
# pandoc2markdown "10-mod_cdrs"
# common_cleaning "website/docs/ocpi/10-mod_cdrs.md"
# fix_mod_cdrs
# flavored_mod_cdrs

# echo ""

# . ./convert.d/2.2.1/11-mod_tariffs.sh
# pre_mod_tariffs
# links "ocpi/mod_tariffs.asciidoc"
# pandoc2markdown "11-mod_tariffs"
# common_cleaning "website/docs/ocpi/11-mod_tariffs.md"
# fix_mod_tariffs
# flavored_mod_tariffs

# echo ""

# . ./convert.d/2.2.1/12-mod_tokens.sh
# pre_mod_tokens
# links "ocpi/mod_tokens.asciidoc"
# pandoc2markdown "12-mod_tokens"
# common_cleaning "website/docs/ocpi/12-mod_tokens.md"
# fix_mod_tokens
# flavored_mod_tokens

# echo ""

# . ./convert.d/2.2.1/13-mod_commands.sh
# pre_mod_commands
# links "ocpi/mod_commands.asciidoc"
# pandoc2markdown "13-mod_commands"
# common_cleaning "website/docs/ocpi/13-mod_commands.md"
# fix_mod_commands
# flavored_mod_commands

# echo ""

# . ./convert.d/2.2.1/14-mod_charging_profiles.sh
# pre_mod_charging_profiles
# links "ocpi/mod_charging_profiles.asciidoc"
# pandoc2markdown "14-mod_charging_profiles"
# common_cleaning "website/docs/ocpi/14-mod_charging_profiles.md"
# fix_mod_charging_profiles
# flavored_mod_charging-profiles

# echo ""

# . ./convert.d/2.2.1/15-mod_hub_client_info.sh
# pre_mod_hub_client_info
# links "ocpi/mod_hub_client_info.asciidoc"
# pandoc2markdown "15-mod_hub_client_info"
# common_cleaning "website/docs/ocpi/15-mod_hub_client_info.md"
# fix_mod_hub_client_info
# flavored_mod_hubclientinfo

# echo ""

# . ./convert.d/2.2.1/16-types.sh
# pre_types
# links "ocpi/types.asciidoc"
# pandoc2markdown "16-types"
# common_cleaning "website/docs/ocpi/16-types.md"
# fix_types

cd "$ROOT"/ocpi || exit 0

git reset --hard --quiet
git clean -xfd --quiet
