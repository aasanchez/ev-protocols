#!/usr/bin/env bash

function pre_mod_charging_profiles(){
  file="$ROOT/ocpi/mod_charging_profiles.asciidoc"
  gsed -i 's|+$||gm' "$file"

  gsed -i '/^.Smart Charging Topology: The eMSP generates ChargingProfiles.$/d' "$file"
  gsed -i '/^.Example of a SetChargingProfile.$/d' "$file"
  gsed -i '/^.Example of a SetChargingProfile via the MSP.$/d' "$file"
  gsed -i '/^.Example of a ClearChargingProfile.$/d' "$file"
  gsed -i '/^.Example of a ClearChargingProfile via the MSP.$/d' "$file"
  gsed -i '/^.Example of a GET ActiveChargingProfile.$/d' "$file"
  gsed -i '/^.Example of a GET ActiveChargingProfile via the MSP.$/d' "$file"
  gsed -i '/^.Example of an ActiveChargingProfile being send by the CPO$/d' "$file"
  gsed -i '/^.Example of an ActiveChargingProfile being sent by the CPO via the eMSP$/d' "$file"
}

function fix_mod_charging_profiles() {
  file="$ROOT/website/docs/14-mod_charging_profiles.md"
  tempfile="$file.tmp"

  echo -e "---\nid: charging_profiles\nslug: modules/charging-profiles\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -e "s|^\# \*ChargingProfiles\* module|# ChargingProfiles|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`chargingprofiles\`\*\*|\:\:\:tip Module Identifier\nchargingprofiles\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"
  gsed -i 's|^- |* |gm' "$file"
  gsed -i -z "s|\`\n\n\*|\`\n\*|gm" "$file"
  gsed -i -z "s|\n\n\*\s|\n\* |gm" "$file"
  
  gsed -i    "s/’/'/gm" "$file"

  gsed -i -z "s|Example:\n\*|Example:\n\n\*|gm" "$file"
  gsed -i -z "s|mentioned topologies\.\n\*|mentioned topologies\.\n\n\*|gm" "$file"

  gsed -i -z "s|ChargingProfiles\.|ChargingProfiles|gm" "$file"
  gsed -i -z "s|to SCSP\.|to SCSP|gm" "$file"
  gsed -i -z "s|.svg\"\nalt=|.svg\" alt=|gm" "$file"
  gsed -i -z "s|Examples\:|Examples\:\n|gm" "$file"

  gsed -i "s|<img src=\"images/sd_charging_profile_clear.svg\" alt=\"Example of a ClearChargingProfile\" />|![Example of a ClearChargingProfile](../../images/sd_charging_profile_clear.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_charging_profile_clear_via_msp.svg\" alt=\"Example of a ClearChargingProfile via the MSP\" />|![Example of a ClearChargingProfile via the MSP](../../images/sd_charging_profile_clear_via_msp.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_charging_profile_get.svg\" alt=\"Example of a GET ActiveChargingProfile\" />|![Example of a GET ActiveChargingProfile](../../images/sd_charging_profile_get.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_charging_profile_get_via_msp.svg\" alt=\"Example of a GET ActiveChargingProfile via the MSP\" />|![Example of a GET ActiveChargingProfile via the MSP](../../images/sd_charging_profile_get_via_msp.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_charging_profile_set.svg\" alt=\"Example of a SetChargingProfile\" />|![Example of a SetChargingProfile](../../images/sd_charging_profile_set.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_charging_profile_set_via_msp.svg\" alt=\"Example of a SetChargingProfile via the MSP\" />|![Example of a SetChargingProfile via the MSP](../../images/sd_charging_profile_set_via_msp.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_charging_profile_updated.svg\" alt=\"Example of an ActiveChargingProfile being send by the CPO\" />|![Example of an ActiveChargingProfile being send by the CPO](../../images/sd_charging_profile_updated.svg)|g" "$file"
  gsed -i "s|<img src=\"images/topology_sc_emsp.svg\" alt=\"Smart Charging Topology: The eMSP generates ChargingProfiles\" />|![Smart Charging Topology: The eMSP generates ChargingProfiles](../../images/topology_sc_emsp.svg)|g" "$file"
  gsed -i "s|<img src=\"images/topology_scsp_cpo.svg\" alt=\"Smart Charging Topology: The eMSP generates ChargingProfiles\" />|![Smart Charging Topology: The eMSP generates ChargingProfiles](../../images/topology_scsp_cpo.svg)|g" "$file"
  gsed -i "s|<img src=\"images/topology_scsp_emsp.svg\" alt=\"Smart Charging Topology: The eMSP generates ChargingProfiles\" />|![Smart Charging Topology: The eMSP generates ChargingProfiles](../../images/topology_scsp_emsp.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_charging_profile_updated_via_msp.svg\" alt=\"Example of an ActiveChargingProfile being sent by the CPO to the SCSP via the eMSP\" />|![Example of an ActiveChargingProfile being sent by the CPO to the SCSP via the eMSP](../../images/sd_charging_profile_updated_via_msp.svg)|g" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}

function flavored_mod_charging-profiles() {
  file="$ROOT/website/docs/14-mod_charging_profiles.md"
  tempfile="$file.tmp"
  echo "$file ocpi.dev flavored"
  MODULE="09-charging-profiles"
  splitInH2 "$file"

  rm -rf "$ROOT/website/docs/06-modules/09-charging-profiles"
  mkdir -p "$ROOT/website/docs/06-modules/09-charging-profiles"

  mv "$ROOT/tmp/smartchargingtopologies.md" "$ROOT/website/docs/06-modules/$MODULE/02-smart-charging-topologies.md"
  mv "$ROOT/tmp/usecases.md"                "$ROOT/website/docs/06-modules/$MODULE/03-use-cases.md"
  mv "$ROOT/tmp/flow.md"                    "$ROOT/website/docs/06-modules/$MODULE/04-flow.md"
  mv "$ROOT/tmp/interfacesandendpoints.md"  "$ROOT/website/docs/06-modules/$MODULE/05-interfaces-and-endpoints.md"
  mv "$ROOT/tmp/objectdescription.md"       "$ROOT/website/docs/06-modules/$MODULE/06-object-description.md"
  mv "$ROOT/tmp/datatypes.md"               "$ROOT/website/docs/06-modules/$MODULE/07-data-types.md"

  < "$file" gsed -n '1,/## Flow/p' > "$ROOT/website/docs/06-modules/$MODULE/01-intro.md"

  file="$ROOT/website/docs/06-modules/$MODULE/01-intro.md"
  echo "flavoring $file"
  gsed -i '1,4d' "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: intro
slug: /modules/charging-profiles
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i '/## Flow/d' "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"
  gsed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' -e 'P;D' "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/02-smart-charging-topologies.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: smart-charging-topologies
slug: /modules/charging-profiles/smart-charging-topologies
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/03-use-cases.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: use-cases
slug: /modules/charging-profiles/use-cases
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/04-flow.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: flow
slug: /modules/charging-profiles/flow
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/05-interfaces-and-endpoints.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: interfaces-and-endpoints
slug: /modules/charging-profiles/interfaces-and-endpoints
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i "s/^##### /#### /gm" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/06-object-description.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: object-description
slug: /modules/charging-profiles/object-description
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/07-data-types.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: data-types
slug: /modules/charging-profiles/data-types
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  rm -rf "$ROOT/website/docs/14-mod_charging_profiles.md"
}
