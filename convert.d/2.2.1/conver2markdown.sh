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

cp -a ocpi/images/. website/docs/images/
cp -a ocpi/examples/. website/docs/examples/

directory="website/docs/images"
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
pandoc2markdown "01-introduction"
links "website/docs/01-introduction.md"
common_cleaning "website/docs/01-introduction.md"
fix_introduction

echo ""

. ./convert.d/2.2.1/02-terminology.sh
pre_terminology
pandoc2markdown "02-terminology"
links "website/docs/02-terminology.md"
common_cleaning "website/docs/02-terminology.md"
fix_terminology

echo ""

. ./convert.d/2.2.1/03-topology.sh
pre_topology
pandoc2markdown "03-topology"
links "website/docs/03-topology.md"
common_cleaning "website/docs/03-topology.md"
fix_topology

echo ""

. ./convert.d/2.2.1/04-transport_and_format.sh
pre_transport_and_format
pandoc2markdown "04-transport_and_format"
links "website/docs/04-transport_and_format.md"
common_cleaning "website/docs/04-transport_and_format.md"
fix_transport_and_format

echo ""

. ./convert.d/2.2.1/05-status_codes.sh
pandoc2markdown "05-status_codes"
common_cleaning "website/docs/05-status_codes.md"
fix_status_codes

echo ""

mv ocpi/version_information_endpoint.asciidoc ocpi/mod_versions.asciidoc
. ./convert.d/2.2.1/06-mod_versions.sh
pre_mod_versions
pandoc2markdown "06-mod_versions"
links "website/docs/06-mod_versions.md"
common_cleaning "website/docs/06-mod_versions.md"
fix_mod_versions

echo ""

mv ocpi/credentials.asciidoc ocpi/mod_credentials.asciidoc
. ./convert.d/2.2.1/07-mod_credentials.sh
pre_mod_credentials
pandoc2markdown "07-mod_credentials"
links "website/docs/07-mod_credentials.md"
common_cleaning "website/docs/07-mod_credentials.md"
fix_mod_credentials

echo ""

. ./convert.d/2.2.1/08-mod_locations.sh
pre_mod_locations
pandoc2markdown "08-mod_locations"
links "website/docs/08-mod_locations.md"
common_cleaning "website/docs/08-mod_locations.md"
fix_mod_locations

echo ""

. ./convert.d/2.2.1/09-mod_sessions.sh
pre_mod_sessions
pandoc2markdown "09-mod_sessions"
links "website/docs/09-mod_sessions.md"
common_cleaning "website/docs/09-mod_sessions.md"
fix_mod_sessions

echo ""

. ./convert.d/2.2.1/10-mod_cdrs.sh
pre_mod_cdrs
pandoc2markdown "10-mod_cdrs"
links "website/docs/10-mod_cdrs.md"
common_cleaning "website/docs/10-mod_cdrs.md"
fix_mod_cdrs

echo ""

. ./convert.d/2.2.1/11-mod_tariffs.sh
pre_mod_tariffs
pandoc2markdown "11-mod_tariffs"
links "website/docs/11-mod_tariffs.md"
common_cleaning "website/docs/11-mod_tariffs.md"
fix_mod_tariffs

echo ""

. ./convert.d/2.2.1/12-mod_tokens.sh
pre_mod_tokens
pandoc2markdown "12-mod_tokens"
links "website/docs/12-mod_tokens.md"
common_cleaning "website/docs/12-mod_tokens.md"
fix_mod_tokens

echo ""

. ./convert.d/2.2.1/13-mod_commands.sh
pre_mod_commands
pandoc2markdown "13-mod_commands"
links "website/docs/13-mod_commands.md"
common_cleaning "website/docs/13-mod_commands.md"
fix_mod_commands

echo ""

. ./convert.d/2.2.1/14-mod_charging_profiles.sh
pre_mod_charging_profiles
pandoc2markdown "14-mod_charging_profiles"
links "website/docs/14-mod_charging_profiles.md"
common_cleaning "website/docs/14-mod_charging_profiles.md"
fix_mod_charging_profiles

echo ""

. ./convert.d/2.2.1/15-mod_hub_client_info.sh
pre_mod_hub_client_info
pandoc2markdown "15-mod_hub_client_info"
links "website/docs/15-mod_hub_client_info.md"
common_cleaning "website/docs/15-mod_hub_client_info.md"
fix_mod_hub_client_info

echo ""

. ./convert.d/2.2.1/16-types.sh
pre_types
pandoc2markdown "16-types"
links "website/docs/16-types.md"
common_cleaning "website/docs/15-mod_hub_client_info.md"
fix_types

cd "$ROOT"/ocpi || exit 0

git reset --hard --quiet
git clean -xfd --quiet
