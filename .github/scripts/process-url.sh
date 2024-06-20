#!/usr/bin/env bash

set -e -o pipefail

AYA_ID="$1"
YOUTUBE_URL="$2"
AYA_CAT_ID="$3"
AYA_CAT_NAME="$4"
FLIP="$5"

UPLOAD="${6:-false}"

if [[ -z "$AYA_ID" || -z "$YOUTUBE_URL" || -z "$AYA_CAT_ID" || -z "$AYA_CAT_NAME" || -z "$FLIP" ]]; then
  echo "Usage: $0 <id> <youtube-url> <category-id> <category-name> <flip> [upload]"
  exit 1
fi

# Download indexer from GitHub release
echo ":: Downloading indexer fat jar..."
INDEXER_URL="https://github.com/ClownpieceStripedAbyss/aya-dance-indexer/releases/latest/download/aya-dance-indexer-fatjar.jar"
wget -O indexer.jar "$INDEXER_URL"

# Download yt-dlp
echo ":: Downloading yt-dlp..."
YT_DLP_URL="https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp_linux"
wget -O yt-dlp "$YT_DLP_URL"
chmod +x yt-dlp

if [[ "$AYA_ID"x == "-1"x ]]; then
  echo ":: Computing available video ID from staging server..."
  AYA_ID=$(bash "$(dirname "$(readlink -f "$0")")"/find-available-id.sh)
  if [[ -z "$AYA_ID" ]]; then
    echo "Failed to find available ID"
    exit 1
  fi
  echo "Available ID: $AYA_ID"
else
  echo ":: Using provided video ID: $AYA_ID"
fi

echo ":: Fetching video with ID $AYA_ID..."
rm -rf "out/staging_$AYA_ID"
bash "$(dirname "$(readlink -f "$0")")"/fetch-video.sh "$YOUTUBE_URL" "$AYA_ID" "$AYA_CAT_ID" "$AYA_CAT_NAME" "$FLIP" "./indexer.jar" "./yt-dlp"

if [[ "$UPLOAD"x != "true"x ]]; then
  echo "Upload disabled, skipping..."
  exit 0
fi
echo ":: Uploading to staging area..."
bash "$(dirname "$(readlink -f "$0")")"/upload-video.sh "out/staging_$AYA_ID" "$AYA_ID"
