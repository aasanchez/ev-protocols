#!/usr/bin/env bash
# shellcheck source=/dev/null

. ./reformat.d/libs/global.sh
. ./reformat.d/libs/links.sh
. ./reformat.d/libs/pandoc.sh

# FORCE=false

echo "$ROOT"

cd "$ROOT"/ocpi || exit 0

git reset --hard --quiet
git clean -xfd --quiet
git checkout release-2.2.1-bugfixes
git pull origin release-2.2.1-bugfixes --quiet
git clean -xfd --quiet

cd "$ROOT" || exit 0

directory="ocpi/examples/"
json_files=$(find "$directory" -type f -name "*.json")
for file in $json_files; do
  echo "Formatting $file..."
  jq '.' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
done

cp -a ocpi/images/. docs/images/
cp -a ocpi/examples/. docs/examples/

. ./reformat.d/2.2.1/01-introduction.sh
pre_introduction
pandoc2markdown "01-introduction"
links "docs/01-introduction.md"
fix_introduction

. ./reformat.d/2.2.1/02-terminology.sh
pre_terminology
pandoc2markdown "02-terminology"
links "docs/02-terminology.md"
fix_terminology

. ./reformat.d/2.2.1/03-topology.sh
pre_topology
pandoc2markdown "03-topology"
links "docs/03-topology.md"
fix_topology

. ./reformat.d/2.2.1/04-transport_and_format.sh
pre_transport_and_format
pandoc2markdown "04-transport_and_format"
links "docs/04-transport_and_format.md"
fix_transport_and_format

. ./reformat.d/2.2.1/05-status_codes.sh
pandoc2markdown "05-status_codes"
fix_status_codes
