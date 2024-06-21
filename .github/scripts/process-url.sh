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
OUT_DIR="out/staging_$AYA_ID"
rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"

YT_DLP="./yt-dlp"
INDEXER_JAR="./indexer.jar"

$YT_DLP --no-check-certificate \
  --no-cache-dir \
  --rm-cache-dir \
  -f "(mp4/best)[height<=?2160][height>=?256][width>=?256]" \
  -o "$OUT_DIR/video.mp4" \
  "$YOUTUBE_URL"

MD5SUM=$(md5sum "$OUT_DIR/video.mp4" | cut -d' ' -f1)

java -jar "$INDEXER_JAR" \
    --url "$YOUTUBE_URL" \
    --id "$AYA_ID" \
    --cat-id "$AYA_CAT_ID" \
    --cat-name "$AYA_CAT_NAME" \
    --flip "$FLIP" \
  | sed "s/CHECKSUM-PLACEHOLDER/$MD5SUM/g" \
  | tee "$OUT_DIR/metadata.json"

if [[ "$UPLOAD"x != "true"x ]]; then
  echo "Upload disabled, skipping..."
  exit 0
fi
echo ":: Uploading to staging area..."
bash "$(dirname "$(readlink -f "$0")")"/upload-video.sh "$OUT_DIR" "$AYA_ID"
