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

. ./conv                       d

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
