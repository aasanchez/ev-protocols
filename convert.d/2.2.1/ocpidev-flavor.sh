#!/usr/bin/env bash
# shellcheck source=/dev/null

. ./convert.d/libs/global.sh

. ./convert.d/2.2.1/01-introduction.sh
flavored_introduction

. ./convert.d/2.2.1/02-terminology.sh
flavored_terminology

. ./convert.d/2.2.1/03-topology.sh

. ./convert.d/2.2.1/04-transport_and_format.sh
flavored_transport_and_format

. ./convert.d/2.2.1/05-status_codes.sh

. ./convert.d/2.2.1/06-mod_versions.sh
flavored_mod_versions

. ./convert.d/2.2.1/07-mod_credentials.sh
flavored_mod_credentials

. ./convert.d/2.2.1/08-mod_locations.sh
flavored_mod_locations

. ./convert.d/2.2.1/09-mod_sessions.sh

. ./convert.d/2.2.1/10-mod_cdrs.sh

. ./convert.d/2.2.1/11-mod_tariffs.sh

. ./convert.d/2.2.1/12-mod_tokens.sh

. ./convert.d/2.2.1/13-mod_commands.sh

. ./convert.d/2.2.1/14-mod_charging_profiles.sh

. ./convert.d/2.2.1/15-mod_hub_client_info.sh

. ./convert.d/2.2.1/16-types.sh

