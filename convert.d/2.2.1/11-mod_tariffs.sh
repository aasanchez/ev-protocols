#!/usr/bin/env bash

function pre_mod_tariffs(){
  file="$ROOT/ocpi/mod_tariffs.asciidoc"
  gsed -i 's|+$||gm' "$file"
  gsed -i    "s|^====== Free of Charge Tariff example|====== Free of Charge Tariff example\n|gm" "$file"
}

function fix_mod_tariffs() {
  file="$ROOT/website/docs/11-mod_tariffs.md"
  tempfile="$file.tmp"

  echo -e "---\nid: tariffs\nslug: modules/tariffs\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -e "s|^\# \*Tariffs\* module|# Tariffs|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`tariffs\`\*\*|\:\:\:tip Module Identifier\ntariffs\n\:\:\:|gm" "$file"
  gsed -i    "s|^\*\*Data owner: \`CPO\`\*\*|\:\:\:caution Data owner\nCPO\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"

  gsed -i -z "s|\`\`\` json|\`\`\`json|gm" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"
  
  gsed -i 's|^- |* |gm' "$file"
  
  gsed -i    "s/’/'/gm" "$file"
  gsed -i    "s|^======\s|##### |gm" "$file"

  gsed -i -z "s|\n\n\*\s|\n\* |gm" "$file"
  gsed -i -z "s|\n\n  - |\n  * |gm" "$file"
  gsed -i -z "s|\n    - |    * |gm" "$file"

  gsed -i -z "s|Examples:\n\*|Examples:\n\n\*|gm" "$file"
  gsed -i -z "s|Example:\n\*|Example:\n\n\*|gm" "$file"
  gsed -i -z "s|\:\n\*|\:\n\n\*|gm" "$file"

  gsed -i -e "s|^\#\#\#\#\# Simple Tariff example € 0.25 per kWh$|##### Simple Tariff example € 0.25 per kWh$\n|gm" "$file"
  gsed -i -e "s|^##### Tariff example € 0.25 per kWh + start fee$|##### Tariff example € 0.25 per kWh + start fee\n|gm" "$file"
  gsed -i -e "s|^##### Tariff example € 0.25 per kWh + minimum price$|##### Tariff example € 0.25 per kWh + minimum price\n|gm" "$file"
  gsed -i -e "s|^##### Tariff example € 0.25 per kWh + parking fee + start fee$|##### Tariff example € 0.25 per kWh + parking fee + start fee\n|gm" "$file"
  gsed -i -e "s|^##### Tariff example € 0.25 per kWh + start fee + max price + tariff end date$|##### Tariff example € 0.25 per kWh + start fee + max price + tariff end date\n|gm" "$file"
  gsed -i -e "s|^##### Complex Tariff example$|##### Complex Tariff example\n|gm" "$file"
  gsed -i -e "s|^##### Tariff example with reservation price$|##### Tariff example with reservation price\n|gm" "$file"
  gsed -i -e "s|^##### Tariff example with reservation price and fee$|##### Tariff example with reservation price and fee\n|gm" "$file"
  gsed -i -e "s|^##### Tariff example with reservation price and expire fee$|##### Tariff example with reservation price and expire fee\n|gm" "$file"
  gsed -i -e "s|^##### Tariff example with reservation time and expire time$|##### Tariff example with reservation time and expire time\n|gm" "$file"
  gsed -i -e "s|^##### Tariff example € 025 per kWh + start fee$|##### Tariff example € 025 per kWh + start fee\n|gm" "$file"
  gsed -i -e "s|^##### Example: New Tariff € 2 per hour charging time (not parking)\.$|##### Example: New Tariff € 2 per hour charging time (not parking)|gm" "$file"
  gsed -i -e "s|    A \`TariffRestrictions\` |A \`TariffRestrictions\` |gm" "$file"
  gsed -i -z "s|Charge Point\.\n\* Charging Time|Charge Point\.\n\n\* Charging Time|gm" "$file"
  gsed -i -z "s|already full\.\n\* Charging Time|already full\.\n\n\* Charging Time|gm" "$file"
  gsed -i -z "s|more useful\.\n\* Charging Time|more useful\.\n\n\* Charging Time|gm" "$file"
  gsed -i -z "s|more detail\.\n\* Start or transaction fee|more detail\.\n\n\* Start or transaction fee|gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}

function flavored_mod_tariffs() {
  file="$ROOT/website/docs/11-mod_tariffs.md"
  tempfile="$file.tmp"
  echo "$file EV-protocols flavored"
  MODULE="06-tariffs"
  splitInH2 "$file"

  rm -rf "$ROOT/website/docs/06-modules/06-tariffs"
  mkdir -p "$ROOT/website/docs/06-modules/06-tariffs"

  # reserved
  # mv "$ROOT/tmp/usecases.md"                "$ROOT/website/docs/06-modules/$MODULE/03-use-cases.md"
  mv "$ROOT/tmp/flowandlifecycle.md"        "$ROOT/website/docs/06-modules/$MODULE/04-flow-and-lifecycle.md"
  mv "$ROOT/tmp/interfacesandendpoints.md"  "$ROOT/website/docs/06-modules/$MODULE/05-interfaces-and-endpoints.md"
  mv "$ROOT/tmp/objectdescription.md"       "$ROOT/website/docs/06-modules/$MODULE/06-object-description.md"
  mv "$ROOT/tmp/datatypes.md"               "$ROOT/website/docs/06-modules/$MODULE/07-data-types.md"

  < "$file" gsed -n '1,/## Flow and Lifecycle/p' > "$ROOT/website/docs/06-modules/$MODULE/01-intro.md"

  file="$ROOT/website/docs/06-modules/$MODULE/01-intro.md"
  echo "flavoring $file"
  gsed -i '1,4d' "$file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: intro
slug: /modules/tariffs
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i '/## Flow and Lifecycle/d' "$file"
  gsed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' -e 'P;D' "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/04-flow-and-lifecycle.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: flow-and-lifecycle
slug: /modules/tariffs/flow-and-lifecycle
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/05-interfaces-and-endpoints.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: interfaces-and-endpoints
slug: /modules/tariffs/interfaces-and-endpoints
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i "s/^##### /#### /gm" "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/06-object-description.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: object-description
slug: /modules/tariffs/object-description
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i "s/^##### /#### /gm" "$file"

  file="$ROOT/website/docs/06-modules/$MODULE/07-data-types.md"
  echo "flavoring $file"
  cat <<E_O_HEADERS > "$file.tmp"
---
id: data-types
slug: /modules/tariffs/data-types
---
E_O_HEADERS
  cat "$file" >> "$file.tmp" && mv "$file.tmp" "$file"
  gsed -i "s/^## /# /gm" "$file"
  gsed -i "s/^### /## /gm" "$file"
  gsed -i "s/^#### /### /gm" "$file"
  gsed -i "s/^##### /#### /gm" "$file"

  rm -rf "$ROOT/website/docs/11-mod_tariffs.md"
}