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
  file="$ROOT/docs/14-mod_charging_profiles.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 14\nslug: charging-profiles\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -e "s|^\# \*ChargingProfiles\* module|# ChargingProfiles module|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`chargingprofiles\`\*\*|\:\:\:tip Module Identifier\nchargingprofiles\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"

  gsed -i -z "s/<div class=\"note\">\n/\:\:\:note\n/gm" "$file"
  gsed -i -z "s|\n</div>|\n\:\:\:|gm" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"
  gsed -i 's|^- |* |gm' "$file"
  gsed -i -z "s|\`\n\n\*|\`\n\*|gm" "$file"
  gsed -i -z "s|\n\n\*\s|\n\* |gm" "$file"
  
  gsed -i    "s/’/'/gm" "$file"

  gsed -i    "/<figure>/d" "$file"
  gsed -i    "/<\/figure>/d" "$file"

  gsed -i -z "s|Example:\n\*|Example:\n\n\*|gm" "$file"
  gsed -i -z "s|mentioned topologies\.\n\*|mentioned topologies\.\n\n\*|gm" "$file"

  gsed -i -z "s|ChargingProfiles\.|ChargingProfiles|gm" "$file"
  gsed -i -z "s|to SCSP\.|to SCSP|gm" "$file"
  gsed -i -z "s|.svg\"\nalt=|.svg\" alt=|gm" "$file"
  gsed -i -z "s|Examples\:|Examples\:\n|gm" "$file"

  gsed -i "s|<img src=\"images/sd_charging_profile_clear.svg\" alt=\"Example of a ClearChargingProfile\" />|![Example of a ClearChargingProfile](./images/sd_charging_profile_clear.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_charging_profile_clear_via_msp.svg\" alt=\"Example of a ClearChargingProfile via the MSP\" />|![Example of a ClearChargingProfile via the MSP](./images/sd_charging_profile_clear_via_msp.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_charging_profile_get.svg\" alt=\"Example of a GET ActiveChargingProfile\" />|![Example of a GET ActiveChargingProfile](./images/sd_charging_profile_get.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_charging_profile_get_via_msp.svg\" alt=\"Example of a GET ActiveChargingProfile via the MSP\" />|![Example of a GET ActiveChargingProfile via the MSP](./images/sd_charging_profile_get_via_msp.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_charging_profile_set.svg\" alt=\"Example of a SetChargingProfile\" />|![Example of a SetChargingProfile](./images/sd_charging_profile_set.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_charging_profile_set_via_msp.svg\" alt=\"Example of a SetChargingProfile via the MSP\" />|![Example of a SetChargingProfile via the MSP](./images/sd_charging_profile_set_via_msp.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_charging_profile_updated.svg\" alt=\"Example of an ActiveChargingProfile being send by the CPO\" />|![Example of an ActiveChargingProfile being send by the CPO](./images/sd_charging_profile_updated.svg)|g" "$file"
  gsed -i "s|<img src=\"images/topology_sc_emsp.svg\" alt=\"Smart Charging Topology: The eMSP generates ChargingProfiles\" />|![Smart Charging Topology: The eMSP generates ChargingProfiles](./images/topology_sc_emsp.svg)|g" "$file"
  gsed -i "s|<img src=\"images/topology_scsp_cpo.svg\" alt=\"Smart Charging Topology: The eMSP generates ChargingProfiles\" />|![Smart Charging Topology: The eMSP generates ChargingProfiles](./images/topology_scsp_cpo.svg)|g" "$file"
  gsed -i "s|<img src=\"images/topology_scsp_emsp.svg\" alt=\"Smart Charging Topology: The eMSP generates ChargingProfiles\" />|![Smart Charging Topology: The eMSP generates ChargingProfiles](./images/topology_scsp_emsp.svg)|g" "$file"
  gsed -i "s|<img src=\"images/sd_charging_profile_updated_via_msp.svg\" alt=\"Example of an ActiveChargingProfile being sent by the CPO to the SCSP via the eMSP\" />|![Example of an ActiveChargingProfile being sent by the CPO to the SCSP via the eMSP](./images/sd_charging_profile_updated_via_msp.svg)|g" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
