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

## Essential fields
URL="${fields[URL]}"
CAT_ID="${fields[CategoryID]}"
CAT_NAME="${fields[CategoryName]}"
FLIP="${fields[Flip]}"

if [[ -z "$URL" ]]; then
  echo "URL not found in frontmatter"
  exit 1
fi

if [[ -z "$CAT_NAME" ]]; then
  echo "Category Name not found in frontmatter"
  exit 1
fi

if [[ -z "$CAT_ID" ]]; then
  # read it from categories.json with jq
  CAT_ID=$(jq -r --arg name "$CAT_NAME" '.[] | select(.name == $name) | .id' "$(dirname "$(readlink -f "$0")")"/../../categories.json)
  if [[ -z "$CAT_ID" ]]; then
    echo "No mapping found for Category Name: $CAT_NAME in categories.json, please add it or provide Category ID in frontmatter"
    exit 1
  fi
else
  # Check if the category ID exists
  # remember the id is an integer, so we need to compare it as an integer
  if ! jq -e --arg id "$CAT_ID" '.[] | select(.id == ($id | tonumber))' "$(dirname "$(readlink -f "$0")")"/../../categories.json > /dev/null; then
    echo "Category ID: $CAT_ID not found in categories.json"
    exit 1
  fi
  # Check if the category name matches the ID
  CAT_NAME_IN_JSON="$(jq -r --arg id "$CAT_ID" '.[] | select(.id == ($id | tonumber)) | .name' "$(dirname "$(readlink -f "$0")")"/../../categories.json)"
  if [[ "$CAT_NAME" != "$CAT_NAME_IN_JSON" ]]; then
    echo "Category Name does not match Category ID"
    echo "In categories.json, Category ID: $CAT_ID is mapped to Category Name \"$CAT_NAME_IN_JSON\""
    echo "But the frontmatter declares that Category Name is \"$CAT_NAME\", which is not true"
    exit 1
  fi
fi

if [[ "$FLIP"x != "true"x ]]; then
  FLIP="false"
fi

## Optional fields
TITLE_OVERRIDE="${fields[TitleOverride]}"
TITLE_PREFIX="${fields[TitlePrefix]}"
TITLE_SUFFIX="${fields[TitleSuffix]}"
TITLE_REMOVE="${fields[TitleRemove]}"

# if they are wrapped in quotes, remove the first and last character
function unwrap-title-in-quotes() {
  local title="$1"
  # remove the wrapping quotes
  if [[ "$title" =~ ^\".*\"$ ]]; then
    # Bash magic
    title="${title:1:${#title}-2}"
    # remember to unescape the quotes, since they are not wrapped in quotes anymore
    title="${title//\\\"/\"}"
  fi
  echo "$title"
}

if [[ -n "$TITLE_OVERRIDE" ]]; then
  TITLE_OVERRIDE=$(unwrap-title-in-quotes "$TITLE_OVERRIDE")
fi
if [[ -n "$TITLE_PREFIX" ]]; then
  TITLE_PREFIX=$(unwrap-title-in-quotes "$TITLE_PREFIX")
fi
if [[ -n "$TITLE_SUFFIX" ]]; then
  TITLE_SUFFIX=$(unwrap-title-in-quotes "$TITLE_SUFFIX")
fi
if [[ -n "$TITLE_REMOVE" ]]; then
  TITLE_REMOVE=$(unwrap-title-in-quotes "$TITLE_REMOVE")
fi

# Set the github actions output, for debugging
if [[ -f "$GITHUB_OUTPUT" ]]; then
  echo "URL=$URL" >> "$GITHUB_OUTPUT"
  echo "CategoryID=$CAT_ID" >> "$GITHUB_OUTPUT"
  echo "CategoryName=$CAT_NAME" >> "$GITHUB_OUTPUT"
  echo "Flip=$FLIP" >> "$GITHUB_OUTPUT"
  echo "TitleOverride=$TITLE_OVERRIDE" >> "$GITHUB_OUTPUT"
  echo "TitlePrefix=$TITLE_PREFIX" >> "$GITHUB_OUTPUT"
  echo "TitleSuffix=$TITLE_SUFFIX" >> "$GITHUB_OUTPUT"
  echo "TitleRemove=$TITLE_REMOVE" >> "$GITHUB_OUTPUT"
fi

echo "====================================="
echo "ID: $AYA_ID"
echo "URL: $URL"
echo "Category ID: $CAT_ID"
echo "Category Name: $CAT_NAME"
echo "Flip: $FLIP"
echo "== Optional Fields =="
echo "Title Override: $TITLE_OVERRIDE"
echo "Title Prefix: $TITLE_PREFIX"
echo "Title Suffix: $TITLE_SUFFIX"
echo "Title Remove: $TITLE_REMOVE"
echo "====================================="

echo ":: Checking if URL already exists in staging area"
# Check if we already have this URL in the staging area
if bash "$(dirname "$(readlink -f "$0")")"/find-video-by-url.sh "$URL"; then
  echo "URL already exists in staging area, skipping: $URL"
  exit 0
fi

echo ":: URL not found in staging area, processing: $URL"

# construct arguments for the next step from optional fields
OPT_ARGS=()
if [[ -n "$TITLE_OVERRIDE" ]]; then
  OPT_ARGS+=("--title-override" "$TITLE_OVERRIDE")
fi
if [[ -n "$TITLE_PREFIX" ]]; then
  OPT_ARGS+=("--title-prefix" "$TITLE_PREFIX")
fi
if [[ -n "$TITLE_SUFFIX" ]]; then
  OPT_ARGS+=("--title-suffix" "$TITLE_SUFFIX")
fi
if [[ -n "$TITLE_REMOVE" ]]; then
  OPT_ARGS+=("--title-remove" "$TITLE_REMOVE")
fi

echo "Will pass the following optional arguments to the next step:"
echo "${OPT_ARGS[@]}"

# OK, just give the data to the next step
bash "$(dirname "$(readlink -f "$0")")"/process-url.sh \
  "$AYA_ID" "$URL" "$CAT_ID" "$CAT_NAME" "$FLIP" "$UPLOAD" \
  "${OPT_ARGS[@]}"
