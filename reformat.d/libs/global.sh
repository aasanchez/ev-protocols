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
