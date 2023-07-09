#!/usr/bin/env bash

function pre_mod_commands(){
  file="$ROOT/ocpi/mod_commands.asciidoc"
  gsed -i 's|+$||gm' "$file"

  gsed -i '/^.START_SESSION failed$/d' "$file"
  gsed -i '/^.START_SESSION successful$/d' "$file"
  gsed -i '/^.START_SESSION whitelist NEVER$/d' "$file"
  gsed -i '/^.UNLOCK_CONNECTOR Unknown Location$/d' "$file"
  gsed -i '/^.RESERVE_NOW rejected by Charge Point$/d' "$file"
  gsed -i '/^.Successful RESERVE_NOW$/d' "$file"
  gsed -i '/^.Reservation canceled by the CPO$/d' "$file"
}

function fix_mod_commands() {
  file="$ROOT/docs/13-mod_commands.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 13\nslug: module-commands\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -e "s|^\# \*Commands\* module|# Commands module|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`commands\`\*\*|\:\:\:tip Module Identifier\ncommands\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"

  gsed -i -z "s/<div class=\"note\">\n/\:\:\:note/gm" "$file"
  gsed -i -z "s|\n</div>|\:\:\:|gm" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"
  
  gsed -i 's|^- |* |gm' "$file"
  
  gsed -i -z "s|\`\n\n\*|\`\n\*|gm" "$file"
  
  gsed -i    "s/’/'/gm" "$file"

  gsed -i    "/<figure>/d" "$file"
  gsed -i    "/<\/figure>/d" "$file"

  gsed -i "s|<img src=\"images/command_start_session_timeout.svg\" alt=\"START_SESSION failed\" />|![START_SESSION failed](./images/command_start_session_timeout.svg)|g" "$file"
  gsed -i "s|<img src=\"images/command_start_session_no_cable.svg\" alt=\"START_SESSION failed\" />|![START_SESSION failed](./images/command_start_session_no_cable.svg)|g" "$file"
  gsed -i "s|<img src=\"images/command_start_session_succesful.svg\" alt=\"START_SESSION successful\" />|![START_SESSION successful](./images/command_start_session_succesful.svg)|g" "$file"
  gsed -i "s|<img src=\"images/command_start_session_whitelist_never.svg\" alt=\"START_SESSION whitelist NEVER\" />|![START_SESSION whitelist NEVER](./images/command_start_session_whitelist_never.svg)|g" "$file"
  gsed -i "s|<img src=\"images/command_unlock_unknow_location.svg\" alt=\"UNLOCK_CONNECTOR Unknown Location\" />|![UNLOCK_CONNECTOR Unknown Location](./images/command_unlock_unknow_location.svg)|g" "$file"
  gsed -i "s|<img src=\"images/command_reservenow_rejected.svg\" alt=\"RESERVE_NEW rejected by Charge Point\" />|![RESERVE_NEW rejected by Charge Point](./images/command_reservenow_rejected.svg)|g" "$file"
  gsed -i "s|<img src=\"images/command_reservenow_successful.svg\" alt=\"Successful RESERVE_NOW\" />|![Successful RESERVE_NOW](./images/command_reservenow_successful.svg)|g" "$file"
  gsed -i "s|<img src=\"images/command_reservenow_canceled_by_cpo.svg\" alt=\"Reservation canceled by the CPO\" />|![Reservation canceled by the CPO](./images/command_reservenow_canceled_by_cpo.svg)|g" "$file"

  gsed -i    "s|^======\s|##### |gm" "$file"

  gsed -i    "/Choice: one of five/d" "$file"
  gsed -i    "s|\\\> ||gm" "$file"
  
  gsed -i    "s|Depending on the \`command\` parameter the body SHALL contain the applicable object for that command\.|Depending on the \`command\` parameter the body SHALL contain the applicable object for that command\.\n\n> Choice: one of five|gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
