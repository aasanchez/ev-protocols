#!/usr/bin/env bash
# shellcheck source=/dev/null

. ./convert.d/libs/global.sh
. ./convert.d/libs/links.sh
. ./convert.d/libs/pandoc.sh

# FORCE=false

echo "$ROOT"

cd "$ROOT"/ocpi || exit 0

git reset --hard --quiet
git clean -xfd --quiet
git checkout release-2.2.1-bugfixes
git pull origin release-2.2.1-bugfixes --quiet
git clean -xfd --quiet

cd "$ROOT" || exit 0

cp -r ocpi/images docs/images/
cp -r ocpi/examples docs/examples/

. ./convert.d/2.2.1/01-introduction.sh
pre_introduction
pandoc2markdown "01-introduction"
links "docs/01-introduction.md"
fix_introduction

. ./convert.d/2.2.1/02-terminology.sh
pre_terminology
pandoc2markdown "02-terminology"
links "docs/02-terminology.md"
fix_terminology

. ./convert.d/2.2.1/03-topology.sh
pre_topology
pandoc2markdown "03-topology"
links "docs/03-topology.md"
fix_topology
