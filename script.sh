#!/bin/bash

find . -type f -name "*.md" ! -path "./index.md" | while read -r file; do
  
  echo "Processing $file..."
  filename_no_ext=$(basename "$file" .md) 
  
  parent_dir_name=$(basename "$(dirname "$file")") 
  
  parent_title=$(echo "$parent_dir_name" | sed 's/^[0-9]*-//') 
  
  parent_dir_cleaned=$(echo "$parent_title" | tr '[:upper:]' '[:lower:]' | sed 's/ //g') 

  sed -i.bak '/\[Go back\]/d' "$file"

  if [ "$filename_no_ext" == "$parent_dir_cleaned" ]; then
    awk -v s1="parent_title: Home" -v s2="parent_url: /" '
      /---/ { count++ }
      { print }
      count == 1 && /^title:/ {
        print s1
        print s2
      }
    ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"

  else
    parent_url="./${parent_dir_cleaned}.md"

    awk -v s1="parent_title: $parent_title" -v s2="parent_url: $parent_url" '
      /---/ { count++ }
      { print }
      count == 1 && /^title:/ {
        print s1
        print s2
      }
    ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"

  fi

  rm -f "$file.bak"

done

echo "All markdown files have been updated!"
