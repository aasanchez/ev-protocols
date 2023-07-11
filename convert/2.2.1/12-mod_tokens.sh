#!/usr/bin/env bash

function pre_mod_tokens(){
  file="$ROOT/ocpi/mod_tokens.asciidoc"
  gsed -i 's|+$||gm' "$file"
}

function fix_mod_tokens() {
  file="$ROOT/website/docs/12-mod_tokens.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 12\nslug: tokens\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i -e "s|^\# \*Tokens\* module|# Tokens module|gm" "$file"
  gsed -i    "s|^\*\*Module Identifier: \`tokens\`\*\*|\:\:\:tip Module Identifier\ntokens\n\:\:\:|gm" "$file"
  gsed -i    "s|^\*\*Data owner: \`MSP\`\*\*|\:\:\:caution Data owner\nMSP\n\:\:\:|gm" "$file"
  gsed -i    "s|\*\*Type:\*\* Functional Module|\:\:\:info Type\nFunctional Module\n\:\:\:|gm" "$file"

  gsed -i -z "s/<div class=\"note\">\n/\:\:\:note\n/gm" "$file"
  gsed -i -z "s|\n</div>|\n\:\:\:|gm" "$file"

  gsed -i -z "s|\`\n\n\`+|\`\n* \`|gm" "$file"
  gsed -i -e "s|+\`|\`|gm" "$file"
  gsed -i -z "s|\`+|* \`|gm" "$file"
  
  gsed -i 's|^- |* |gm' "$file"
  
  gsed -i    "s/’/'/gm" "$file"

  gsed -i -z "s|\`\`\` json\nPUT To URL: https://www.server.com/ocpi/cpo/2.2.1/tokens/NL/TNM/012345678\n\n|Example Request:\n\n\`\`\`shell\ncurl --request PUT --header \"Authorization: Token <OCPI_TOKEN>\" \"https://www.server.com/ocpi/cpo/2.2.1/tokens/NL/TNM/012345678\"\n\`\`\`\n\nExample Response:\n\n\`\`\`json\n|gm" "$file"
  gsed -i -z "s|\`\`\` json\nPATCH To URL: https://www.server.com/ocpi/cpo/2.2.1/tokens/NL/TNM/012345678\n\n|Example Request:\n\n\`\`\`shell\ncurl --request PATCH --header \"Authorization: Token <OCPI_TOKEN>\" \"https://www.server.com/ocpi/cpo/2.2.1/tokens/NL/TNM/012345678\"\n\`\`\`\n\nExample Response:\n\n\`\`\`json\n|gm" "$file"

  gsed -i    "s|^======\s|##### |gm" "$file"

  docker container run -i darkriszty/prettify-md < "$file" > "$tempfile"
  mv "$tempfile" "$file"
  echo "" >> "$file"
}
