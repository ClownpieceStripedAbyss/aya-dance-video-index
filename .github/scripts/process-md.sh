#!/usr/bin/env bash

MD="$1"

if [[ -z "$MD" ]]; then
  echo "Usage: $0 <markdown-file>"
  exit 1
fi

if [[ ! -f "$MD" ]]; then
  echo "File not found: $MD"
  exit 1
fi

# Parse the frontmatter between the first and second '---'
frontmatter=$(sed -n '/^---$/,/^---$/p' "$MD" | sed '1d;$d')

# Parse to KV pairs
declare -A fields
while IFS= read -r line; do
    key=$(echo "$line" | cut -d':' -f1)
    value=$(echo "$line" | cut -d':' -f2- | sed 's/^ //')
    fields[$key]="$value"
done <<< "$frontmatter"

URL="${fields[URL]}"
CAT_ID="${fields[CategoryID]}"
CAT_NAME="${fields[CategoryName]}"

if [[ -z "$URL" ]]; then
  echo "URL not found in frontmatter"
  exit 1
fi

if [[ -z "$CAT_ID" ]]; then
  echo "Category ID not found in frontmatter"
  exit 1
fi

if [[ -z "$CAT_NAME" ]]; then
  echo "Category Name not found in frontmatter"
  exit 1
fi

# Set the github actions output, for debugging
echo "URL=$URL" >> "$GITHUB_OUTPUT"
echo "CategoryID=$CAT_ID" >> "$GITHUB_OUTPUT"
echo "CategoryName=$CAT_NAME" >> "$GITHUB_OUTPUT"

# OK, just give the data to the next step
bash "$(dirname "$(readlink -f "$0")")"/process-url.sh "$URL" "$CAT_ID" "$CAT_NAME"
