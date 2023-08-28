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
  file="$ROOT/website/docs/ocpi/13-mod_commands.md"
  tempfile="$file.tmp"

  echo -e "---\nid: commands\nslug: modules/commands\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -e "s|^\# \*Commands\* module|# Commands|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`commands\`\*\*|\:\:\:tip Module Identifier\ncommands\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"
  
  gsed -i 's|^- |* |gm' "$file"
  
  gsed -i -z "s|\`\n\n\*|\`\n\*|gm" "$file"
  
  gsed -i    "s/’/'/gm" "$file"

  gsed -i "s|<img src=\"images/command_start_session_timeout.svg\" alt=\"START_SESSION failed\" />|![START_SESSION failed](../../images/command_start_session_timeout.svg)|g" "$file"
  gsed -i "s|<img src=\"images/command_start_session_no_cable.svg\" alt=\"START_SESSION failed\" />|![START_SESSION failed](../../images/command_start_session_no_cable.svg)|g" "$file"
  gsed -i "s|<img src=\"images/command_start_session_succesful.svg\" alt=\"START_SESSION successful\" />|![START_SESSION successful](../../images/command_start_session_succesful.svg)|g" "$file"
  gsed -i "s|<img src=\"images/command_start_session_whitelist_never.svg\" alt=\"START_SESSION whitelist NEVER\" />|![START_SESSION whitelist NEVER](../../images/command_start_session_whitelist_never.svg)|g" "$file"
  gsed -i "s|<img src=\"images/command_unlock_unknow_location.svg\" alt=\"UNLOCK_CONNECTOR Unknown Location\" />|![UNLOCK_CONNECTOR Unknown Location](../../images/command_unlock_unknow_location.svg)|g" "$file"
  gsed -i "s|<img src=\"images/command_reservenow_rejected.svg\" alt=\"RESERVE_NEW rejected by Charge Point\" />|![RESERVE_NEW rejected by Charge Point](../../images/command_reservenow_rejected.svg)|g" "$file"
  gsed -i "s|<img src=\"images/command_reservenow_successful.svg\" alt=\"Successful RESERVE_NOW\" />|![Successful RESERVE_NOW](../../images/command_reservenow_successful.svg)|g" "$file"
  gsed -i "s|<img src=\"images/command_reservenow_canceled_by_cpo.svg\" alt=\"Reservation canceled by the CPO\" />|![Reservation canceled by the CPO](../../images/command_reservenow_canceled_by_cpo.svg)|g" "$file"

  gsed -i    "s|^======\s|##### |gm" "$file"

  gsed -i    "/Choice: one of five/d" "$file"
  gsed -i    "s|\\\> ||gm" "$file"
  
  gsed -i    "s|Depending on the \`command\` parameter the body SHALL contain the applicable object for that command\.|Depending on the \`command\` parameter the body SHALL contain the applicable object for that command\.\n\n> Choice: one of five|gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}

function flavored_mod_commands() {
  file="$ROOT/website/docs/ocpi/13-mod_commands.md"
  tempfile="$file.tmp"
  echo "$file EV-protocols flavored"
  MODULE="08-commands"
  splitInH2 "$file"

  rm -rf "$ROOT/website/docs/ocpi/06-modules/08-commands"
  mkdir -p "$ROOT/website/docs/ocpi/06-modules/08-commands"

  # reserved
  # mv "$ROOT/tmp/usecases.md"                "$ROOT/website/docs/ocpi/06-modules/$MODULE/03-use-cases.md"
  mv "$ROOT/tmp/flow.md"                    "$ROOT/website/docs/ocpi/06-modules/$MODULE/04-flow.md"
  mv "$ROOT/tmp/interfacesandendpoints.md"  "$ROOT/website/docs/ocpi/06-modules/$MODULE/05-interfaces-and-endpoints.md"
  mv "$ROOT/tmp/objectdescription.md"       "$ROOT/website/docs/ocpi/06-modules/$MODULE/06-object-description.md"
  mv "$ROOT/tmp/datatypes.md"               "$ROOT/website/docs/ocpi/06-modules/$MODULE/07-data-types.md"

  < "$file" gsed -n '1,/## Flow/p' > "$ROOT/website/docs/ocpi/06-modules/$MODULE/01-intro.md"

  file="$ROOT/website/docs/ocpi/06-modules/$MODULE/01-intro.md"
  echo "flavoring $file"
  gsed -i '1,4d' "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: intro
slug: /ocpi/modules/commands
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i '/## Flow/d' "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"
  gsed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' -e 'P;D' "$file"

  file="$ROOT/website/docs/ocpi/06-modules/$MODULE/04-flow.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: flow
slug: flow
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  file="$ROOT/website/docs/ocpi/06-modules/$MODULE/05-interfaces-and-endpoints.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: interfaces-and-endpoints
slug: interfaces-and-endpoints
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i "s/^##### /#### /gm" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  file="$ROOT/website/docs/ocpi/06-modules/$MODULE/06-object-description.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: object-description
slug: object-description
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  file="$ROOT/website/docs/ocpi/06-modules/$MODULE/07-data-types.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: data-types
slug: data-types
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i '/^$/N;/^\n$/D' "$file"

  rm -rf "$ROOT/website/docs/ocpi/13-mod_commands.md"
}
