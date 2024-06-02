#!/usr/bin/env bash

AYA_ID="$1"
MD="$2"
UPLOAD="${3:-false}"

if [[ -z "$MD" || -z "$AYA_ID" ]]; then
  echo "Usage: $0 <id> <markdown-file> [upload]"
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
if [[ -f "$GITHUB_OUTPUT" ]]; then
  echo "URL=$URL" >> "$GITHUB_OUTPUT"
  echo "CategoryID=$CAT_ID" >> "$GITHUB_OUTPUT"
  echo "CategoryName=$CAT_NAME" >> "$GITHUB_OUTPUT"
fi

echo "ID: $AYA_ID"
echo "URL: $URL"
echo "Category ID: $CAT_ID"
echo "Category Name: $CAT_NAME"

# OK, just give the data to the next step
bash "$(dirname "$(readlink -f "$0")")"/process-url.sh "$AYA_ID" "$URL" "$CAT_ID" "$CAT_NAME" "$UPLOAD"
