#!/usr/bin/env bash

function pre_mod_locations(){
  file="$ROOT/ocpi/mod_locations.asciidoc"
  gsed -i 's|+$||gm' "$file"

  gsed -i '/^.Location class diagram$/d' "$file"
  gsed -i '/^.Diagram showing a representation of the example 24\/7 open with exception closing.$/d' "$file"
  gsed -i '/^.Diagram showing a representation of the example Opening Hours with exceptional closing$/d' "$file"
  gsed -i '/^.Diagram showing a representation of the example Opening Hours with exceptional opening.$/d' "$file"
  gsed -i -z 's/schedule applies.\n\n/schedule applies.\n\n\[options="header"\]\n/' "$file"
}

function fix_mod_locations() {
  file="$ROOT/docs/08-mod_locations.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 8\nslug: locations\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"
  
  gsed -i -e "s|^\# \*Locations\* module|# Locations module|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`locations\`\*\*|\:\:\:tip Module Identifier\nlocations\n\:\:\:|gm" "$file"
  gsed -i    "s|^\*\*Data owner: \`CPO\`\*\*|\:\:\:caution Data owner\nCPO\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"
  gsed -i    "s|^======|#####|gm" "$file"
  gsed -i -z "s|- |* |gm" "$file"

  gsed -i -z "s/<div class=\"note\">\n/\:\:\:note\n/gm" "$file"
  gsed -i -z "s|\n</div>|\n\:\:\:|gm" "$file"
  gsed -i    "s/’/'/gm" "$file"
  gsed -i -z "s|\n\*\s|\* |gm" "$file"
  gsed -i -z "s|:\n\*\s|:\n\n\* |gm" "$file"

  gsed -i -z "s|<span class=\"line-through\">|~~|gm" "$file"
  gsed -i -z "s|</span>|~~|gm" "$file"

  gsed -i -z "s|\`-\`|-|gm" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"
  
  gsed -i -e "s|^\* \`publish\` =|\n\* \`publish\` =|gm" "$file"
  
  gsed -i    "/Choice: one of three/d" "$file"
  gsed -i    "s|\\\> ||gm" "$file"
  
  gsed -i    "s|The response contains the requested object.|The response contains the requested object.\n\nChoice: one of three|gm" "$file"

  gsed -i -z "s|\`\`\` json\nPUT To URL: https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012/3256\n\n|Example Request:\n\n\`\`\`shell\ncurl --request PUT --header \"Authorization: Token <OCPI_TOKEN>\" \"https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012/3256\"\n\`\`\`\n\nExample Response:\n\n\`\`\`json\n|gm" "$file"
  gsed -i -z "s|\`\`\` json\nPATCH To URL: https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012/3255\n\n|Example Request:\n\n\`\`\`shell\ncurl --request PATCH --header \"Authorization: Token <OCPI_TOKEN>\" \"https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012/3255\"\n\`\`\`\n\nExample Response:\n\n\`\`\`json\n|gm" "$file"
  gsed -i -z "s|\`\`\` json\nPATCH To URL: https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012\n\n|Example Request:\n\n\`\`\`shell\ncurl --request PATCH --header \"Authorization: Token <OCPI_TOKEN>\" \"https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012\"\n\`\`\`\n\nExample Response:\n\n\`\`\`json|gm" "$file"
  gsed -i -z "s|\`\`\` json\nPATCH To URL: https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012/3255/2\n\n|Example Request:\n\n\`\`\`shell\ncurl --request PATCH --header \"Authorization: Token <OCPI_TOKEN>\" \"https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012/3255/2\"\n\`\`\`\n\nExample Response:\n\n\`\`\`json\n|gm" "$file"
  gsed -i -z "s|\`\`\` json\nPATCH To URL: https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012/3256\n\n|Example Request:\n\n\`\`\`shell\ncurl --request PATCH --header \"Authorization: Token <OCPI_TOKEN>\" \"https://www.server.com/ocpi/emsp/2.2.1/locations/NL/TNM/1012/3256\"\n\`\`\`\n\nExample Response:\n\n\`\`\`json\n|gm" "$file"

  gsed -i    "/<figure>/d" "$file"
  gsed -i    "/<\/figure>/d" "$file"

  gsed -i    "s|<img src=\"images/locations-class-diagram.svg\" alt=\"Location class diagram\" />|![Location class diagram](./images/locations-class-diagram.svg)|g" "$file"
  gsed -i    "s|<img src=\"images/location_hours_247_open_exception_closing.svg\" alt=\"24/7 open with exception closing.\" />|![24/7 open with exception closing.](./images/location_hours_247_open_exception_closing.svg)|g" "$file"
  gsed -i -z "s|<img src=\"images/location_hours_opening_hours_with_exceptional_closing.svg\"\nalt=\"Opening Hours with exceptional closing.\" />|![Opening Hours with exceptional closing.](./images/location_hours_opening_hours_with_exceptional_closing.svg)|g" "$file"
  gsed -i -z "s|<img src=\"images/location_hours_opening_hours_with_exceptional_opening.svg\"\nalt=\"Opening Hours with exceptional opening.\" />|![Opening Hours with exceptional opening.](./images/location_hours_opening_hours_with_exceptional_opening.svg)|g" "$file"

  gsed -i    "s|^##### Simple:$|##### Simple|gm" "$file"
  gsed -i    "s|^##### Tariff energy provider name:$|##### Tariff energy provider name|gm" "$file"
  gsed -i    "s|^##### Complete:$|##### Complete|gm" "$file"
  gsed -i    "s|^#### Example: 24/7 open with exceptional closing.$|#### Example: 24/7 open with exceptional closing|gm" "$file"
  gsed -i    "s|^#### Example: Opening Hours with exceptional closing.$|#### Example: Opening Hours with exceptional closing|gm" "$file"
  gsed -i    "s|^#### Example: Opening Hours with exceptional opening.$|#### Example: Opening Hours with exceptional opening|gm" "$file"

  gsed -i -e 's|":" Regex:.*|":" Regex: [Regex Test](https://regex101.com/r/xaMwu6/1) \||gm' "$file" ## Change because for some bizzare reason, I cant render properly code inside of a Markdown Table, I have to find a solution for this

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"

}
