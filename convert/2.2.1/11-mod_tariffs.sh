#!/usr/bin/env bash

function pre_mod_tariffs(){
  file="$ROOT/ocpi/mod_tariffs.asciidoc"
  gsed -i 's|+$||gm' "$file"
  gsed -i    "s|^====== Free of Charge Tariff example|====== Free of Charge Tariff example\n|gm" "$file"
}

function fix_mod_tariffs() {
  file="$ROOT/website/docs/11-mod_tariffs.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 11\nslug: tariffs\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -e "s|^\# \*Tariffs\* module|# Tariffs module|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`tariffs\`\*\*|\:\:\:tip Module Identifier\ntariffs\n\:\:\:|gm" "$file"
  gsed -i    "s|^\*\*Data owner: \`CPO\`\*\*|\:\:\:caution Data owner\nCPO\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"

  gsed -i -z "s/<div class=\"note\">\n/\:\:\:note\n/gm" "$file"
  gsed -i -z "s|\n</div>|\n\:\:\:|gm" "$file"
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

  gsed -i -z "s|\`\`\`json\nPUT To URL: https://www.server.com/ocpi/emsp/2.2.1/tariffs/NL/TNM/12\n\n|Example Request:\n\n\`\`\`shell\ncurl --request PUT --header \"Authorization: Token <OCPI_TOKEN>\" \"https://www.server.com/ocpi/emsp/2.2.1/tariffs/NL/TNM/12\"\n\`\`\`\n\nExample Response:\n\n\`\`\`json\n|gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
