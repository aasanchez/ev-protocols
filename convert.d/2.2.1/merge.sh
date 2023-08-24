#!/usr/bin/env bash

# Check if there are any changes in .md files
# if git diff --quiet --exit-code -- '*.md'; then
#   exit 0
# fi

ROOT=$(pwd)

function replace(){
  line_num=$(grep -n "\s$3" "$2" | head -n1 | cut -d: -f1)
  content=$(sed "${line_num}q;d" "$2" | tr -d '#' | tr -d '.' | xargs )
  slug=$(echo "$content" | tr '[:upper:]' '[:lower:]' | tr -cs '[:alnum:]' '-' | gsed 's/^-//' | gsed 's/-*$//')
  gsed -i "s/#$4/#$slug/g" "$2"
}

DIR="$ROOT/website/docs/ocpi"
markdown_files=$(find "$DIR" -name "*.md" | sort)

merged_file="website/static/ocpi.md"
rm -rf "$merged_file"
touch "$merged_file"

for file in $markdown_files; do
  echo "Merging $file..."
  tail -n +5 "$file" >> "$merged_file"
done

# H1=0
# H2=0
# H3=0
# H4=0
# H5=0
# number_line=0

# while read -r LINE; do
#   number_line=$((number_line + 1))
#   if [[ $LINE =~ ^# ]]; then
#     COUNT=$(echo "$LINE" | tr -cd '#' | wc -c)
#     if [ "$COUNT" -eq 1 ]; then
#       H1=$((H1 + 1))
#       H2=0
#       H3=0
#       H4=0
#       H5=0
#       TITLE=$(echo "$LINE" | gsed 's/\#//' | xargs)
#       TITLE="# $H1. $TITLE"
#       gsed -i "${number_line}s/.*/$TITLE/" "$OUTPUT_FILE"
#     fi
#     if [ "$COUNT" -eq 2 ]; then
#       H2=$((H2 + 1))
#       H3=0
#       H4=0
#       H5=0
#       TITLE=$(echo "$LINE" | gsed 's/\##//' | xargs)
#       TITLE="## $H1.$H2. $TITLE"
#       gsed -i "${number_line}s/.*/$TITLE/" "$OUTPUT_FILE"
#     fi
#     if [ "$COUNT" -eq 3 ]; then
#       H3=$((H3 + 1))
#       H4=0
#       H5=0
#       TITLE=$(echo "$LINE" | gsed 's/\###//' | xargs)
#       TITLE="### $H1.$H2.$H3. $TITLE"
#       gsed -i "${number_line}s/.*/$TITLE/" "$OUTPUT_FILE"
#     fi
#     if [ "$COUNT" -eq 4 ]; then
#       H4=$((H4 + 1))
#       H5=0
#       TITLE=$(echo "$LINE" | gsed 's/\####//' | xargs)
#       TITLE="#### $H1.$H2.$H3.$H4. $TITLE"
#       gsed -i "${number_line}s/.*/$TITLE/" "$OUTPUT_FILE"
#     fi
#     if [ "$COUNT" -eq 5 ]; then
#       H5=$((H5 + 1))
#       TITLE=$(echo $LINE | gsed 's/\#####//' | xargs)
#       TITLE="##### $H1.$H2.$H3.$H4.$H5. $TITLE"
#       gsed -i "${number_line}s/.*/$TITLE/" "$OUTPUT_FILE"
#     fi
#   fi
# done < "$OUTPUT_FILE"

# gsed -i 's/^#####\([^#]\)/######\1/g' "$OUTPUT_FILE"
# gsed -i 's/^#####\([^#]\)/######\1/g' "$OUTPUT_FILE"
# gsed -i 's/^####\([^#]\)/#####\1/g' "$OUTPUT_FILE"
# gsed -i 's/^###\([^#]\)/####\1/g' "$OUTPUT_FILE"
# gsed -i 's/^##\([^#]\)/###\1/g' "$OUTPUT_FILE"
# gsed -i 's/^#\([^#]\)/##\1/g' "$OUTPUT_FILE"

# gsed -i '1s/^/# FIEVA Documentation\n/' "$OUTPUT_FILE"

# ## Fix internal references
# gsed -i 's/types#/#/g' "$OUTPUT_FILE"

# echo "" >> "$OUTPUT_FILE"

# docker container run -i darkriszty/prettify-md < "$OUTPUT_FILE" > "$OUTPUT_FILE".tmp

# rm "$OUTPUT_FILE" 
# mv "$OUTPUT_FILE".tmp "$OUTPUT_FILE"

mdl $OUTPUT_FILE