find . -type f -name "*.md" ! -path "./README.md" | while read -r file; do
  title=$(grep '^# ' "$file" | sed 's/# //')

  front_matter="---
layout: default
title: ${title}
---"

  original_content=$(tail -n +2 "$file")

  echo "${front_matter}\n${original_content}" > "$file"
done
