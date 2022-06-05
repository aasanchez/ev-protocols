#!/usr/bin/env bash
# shellcheck source=/dev/null
# shellcheck disable=SC2016

./convert.d/2.2.1/convert-2.2.1.sh

# cd "$ROOT" || exit 0

# ./update/2.0/init2.0.sh

# cd "$ROOT"/ocpi || exit 0
# git reset --hard
# git clean -xfd


# pre_introduction
# pandoc2markdown "01-introduction"
# fix_introduction

# pre_terminology
# pandoc2markdown "02-terminology"
# fix_terminology

# pandoc2markdown "03-topology"
# pandoc2markdown "04-transport_and_format"
# pandoc2markdown "05-status_codes"
# pandoc2markdown "06-version_information_endpoint"
# pandoc2markdown "07-credentials"
# pandoc2markdown "08-mod_locations"
# pandoc2markdown "09-mod_sessions"
# pandoc2markdown "10-mod_cdrs"
# pandoc2markdown "11-mod_tariffs"
# pandoc2markdown "12-mod_tokens"
# pandoc2markdown "13-mod_commands"
# pandoc2markdown "14-mod_charging_profiles"
# pandoc2markdown "15-mod_hub_client_info"
# pandoc2markdown "16-types"
# pandoc2markdown "17-changelog"


