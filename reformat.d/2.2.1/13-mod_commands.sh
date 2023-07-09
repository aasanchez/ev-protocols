#!/usr/bin/env bash

function pre_mod_commands(){
  file="$ROOT/ocpi/mod_commands.asciidoc"
  gsed -i 's|+$||gm' "$file"

  
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

  # gsed -i -z "s|\`\`\` json\nPUT To URL: https://www.server.com/ocpi/cpo/2.2.1/tokens/NL/TNM/012345678\n\n|Example Request:\n\n\`\`\`shell\ncurl --request PUT --header \"Authorization: Token <OCPI_TOKEN>\"\n     \"https://www.server.com/ocpi/cpo/2.2.1/tokens/NL/TNM/012345678\"\n\`\`\`\n\nExample Response:\n\n\`\`\`json\n|gm" "$file"
  # gsed -i -z "s|\`\`\` json\nPATCH To URL: https://www.server.com/ocpi/cpo/2.2.1/tokens/NL/TNM/012345678\n\n|Example Request:\n\n\`\`\`shell\ncurl --request PATCH --header \"Authorization: Token <OCPI_TOKEN>\"\n     \"https://www.server.com/ocpi/cpo/2.2.1/tokens/NL/TNM/012345678\"\n\`\`\`\n\nExample Response:\n\n\`\`\`json\n|gm" "$file"

  # gsed -i    "s|^======\s|##### |gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
