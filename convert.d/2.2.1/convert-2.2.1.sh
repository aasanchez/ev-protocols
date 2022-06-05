#!/usr/bin/env bash
# shellcheck source=/dev/null

. ./convert.d/libs/global.sh
. ./convert.d/libs/pandoc.sh

echo "$ROOT"

cd "$ROOT"/ocpi || exit 0

git reset --hard --quiet
git clean -xfd --quiet
git checkout release-2.2.1-bugfixes
git pull origin release-2.2.1-bugfixes --quiet
git clean -xfd --quiet

