#!/usr/bin/env bash

function pre_topology(){
  file="$ROOT/ocpi/topology.asciidoc"

  $SED -i '/^.peer-to-peer\stopology\sexample$/d' "$file"
  $SED -i '/^.Multiple peer-to-peer topology example$/d' "$file"
  $SED -i '/^.peer-to-peer with multiple roles topology example$/d' "$file"
  $SED -i '/^.peer-to-peer with both CPO and eMSP roles topology example$/d' "$file"
  $SED -i '/^.peer-to-peer with mixed roles topology example$/d' "$file"
  $SED -i '/^.Platforms connected via a Hub topology example$/d' "$file"
  $SED -i '/^.Platforms connected via a Hub and directly topology example$/d' "$file"

}

function fix_topology() {
  file="$ROOT/docs/03-topology.md"
  tempfile="$file.tmp"

  echo -e "---\nsidebar_position: 3\nslug: supported-topologies/\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  $SED -i '/<figure>/d' "$file"
  $SED -i '/<\/figure>/d' "$file"
  $SED -i -z "s/svg\"\nalt/svg\" alt/gm" "$file"

  $SED -i "s|<img src=\"images/architecture_direct.svg\" alt=\"peer-to-peer topology example\" />|![peer-to-peer topology example](./images/architecture_direct.svg)|g" "$file"
  $SED -i "s|<img src=\"images/architecture_multiple_direct_modified.svg\" alt=\"Multiple peer-to-peer topology example\" />|![Multiple peer-to-peer topology example](./images/architecture_multiple_direct_modified.svg)|g" "$file"
  $SED -i "s|<img src=\"images/architecture_platform_same_direct.svg\" alt=\"peer-to-peer with multiple roles topology example\" />|![peer-to-peer with multiple roles topology example](./images/architecture_platform_same_direct.svg)|g" "$file"
  $SED -i "s|<img src=\"images/architecture_platform_dual_direct.svg\" alt=\"peer-to-peer with both CPO and eMSP roles topology example\" />|![peer-to-peer with both CPO and eMSP roles topology example](./images/architecture_platform_dual_direct.svg)|g" "$file"
  $SED -i "s|<img src=\"images/architecture_platform_mixed_direct.svg\" alt=\"peer-to-peer with mixed roles topology example\" />|![peer-to-peer with mixed roles topology example](./images/architecture_platform_mixed_direct.svg)|g" "$file"
  $SED -i "s|<img src=\"images/architecture_mutiple_platform_direct_modified.svg\" alt=\"peer-to-peer with mixed roles topology example\" />|![Multiple peer-to-peer](./images/architecture_mutiple_platform_direct_modified.svg)|g" "$file"
  $SED -i "s|<img src=\"images/architecture_hub_simple_modified.svg\" alt=\"Platforms connected via a Hub topology example\" />|![Platforms connected via a Hub topology example](./images/architecture_hub_simple_modified.svg)|g" "$file"
  $SED -i "s|<img src=\"images/architecture_hub_and_direct_modified.svg\" alt=\"Platforms connected via a Hub and directly topology example\" />|![Platforms connected via a Hub and directly topology example](./images/architecture_hub_and_direct_modified.svg)|g" "$file"
}
