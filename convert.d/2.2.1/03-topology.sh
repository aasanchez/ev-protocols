#!/usr/bin/env bash

function pre_topology(){
  file="$ROOT/ocpi/topology.asciidoc"

  gsed -i '/^.peer-to-peer\stopology\sexample$/d' "$file"
  gsed -i '/^.Multiple peer-to-peer topology example$/d' "$file"
  gsed -i '/^.peer-to-peer with multiple roles topology example$/d' "$file"
  gsed -i '/^.peer-to-peer with both CPO and eMSP roles topology example$/d' "$file"
  gsed -i '/^.peer-to-peer with mixed roles topology example$/d' "$file"
  gsed -i '/^.Platforms connected via a Hub topology example$/d' "$file"
  gsed -i '/^.Platforms connected via a Hub and directly topology example$/d' "$file"

}

function fix_topology() {
  rm -rf "$ROOT/website/docs/ocpi/03-supported-topologies"
  mkdir -p "$ROOT/website/docs/ocpi/03-supported-topologies"

  mv "$ROOT/website/docs/ocpi/03-topology.md" "$ROOT/website/docs/ocpi/03-supported-topologies/01-topology.md"

  file="$ROOT/website/docs/ocpi/03-supported-topologies/01-topology.md"
  tempfile="$file.tmp"

  echo -e "---\nid: supported-topologies\nslug: /ocpi/supported-topologies\n---" | cat - "$file" > "$tempfile"
  mv "$tempfile" "$file"

  gsed -i 's|^# Supported Topologies$|# 🕸️ Supported Topologies|g' "$file"

  gsed -i -z "s/svg\"\nalt/svg\" alt/gm" "$file"

  gsed -i "s|<img src=\"images/architecture_direct.svg\" alt=\"peer-to-peer topology example\" />|![peer-to-peer topology example](../images/architecture_direct.svg)|g" "$file"
  gsed -i "s|<img src=\"images/architecture_multiple_direct_modified.svg\" alt=\"Multiple peer-to-peer topology example\" />|![Multiple peer-to-peer topology example](../images/architecture_multiple_direct_modified.svg)|g" "$file"
  gsed -i "s|<img src=\"images/architecture_platform_same_direct.svg\" alt=\"peer-to-peer with multiple roles topology example\" />|![peer-to-peer with multiple roles topology example](../images/architecture_platform_same_direct.svg)|g" "$file"
  gsed -i "s|<img src=\"images/architecture_platform_dual_direct.svg\" alt=\"peer-to-peer with both CPO and eMSP roles topology example\" />|![peer-to-peer with both CPO and eMSP roles topology example](../images/architecture_platform_dual_direct.svg)|g" "$file"
  gsed -i "s|<img src=\"images/architecture_platform_mixed_direct.svg\" alt=\"peer-to-peer with mixed roles topology example\" />|![peer-to-peer with mixed roles topology example](../images/architecture_platform_mixed_direct.svg)|g" "$file"
  gsed -i "s|<img src=\"images/architecture_mutiple_platform_direct_modified.svg\" alt=\"peer-to-peer with mixed roles topology example\" />|![Multiple peer-to-peer](../images/architecture_mutiple_platform_direct_modified.svg)|g" "$file"
  gsed -i "s|<img src=\"images/architecture_hub_simple_modified.svg\" alt=\"Platforms connected via a Hub topology example\" />|![Platforms connected via a Hub topology example](../images/architecture_hub_simple_modified.svg)|g" "$file"
  gsed -i "s|<img src=\"images/architecture_hub_and_direct_modified.svg\" alt=\"Platforms connected via a Hub and directly topology example\" />|![Platforms connected via a Hub and directly topology example](../images/architecture_hub_and_direct_modified.svg)|g" "$file"

  gsed -i '/^$/N;/^\n$/D' "$file"
  gsed -i '${/^$/d}' "$file"
}
