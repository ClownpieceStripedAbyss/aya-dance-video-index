#!/usr/bin/env bash

set -e -o pipefail

YOUTUBE_URL="$1"
AYA_ID="$2"
AYA_CAT_ID="$3"
AYA_CAT_NAME="$4"
FLIP="$5"

INDEXER_JAR="$6"
YT_DLP="$7"

if [[ -z "$YOUTUBE_URL" || -z "$AYA_ID" || -z "$AYA_CAT_ID" || -z "$AYA_CAT_NAME" || -z "$FLIP" ]]; then
  echo "Usage: $0 <youtube-url> <song-id> <category-id> <category-name> <flip> [indexer-jar] [yt-dlp]"
  exit 1
fi

if [[ -z "$INDEXER_JAR" ]]; then
  ./gradlew :indexer:fatJar
  INDEXER_JAR="./indexer/build/libs/indexer-*-fat.jar"
fi

if [[ -z "$YT_DLP" ]]; then
  YT_DLP="$(which yt-dlp)"
  if [[ -z "$YT_DLP" ]]; then
    echo "yt-dlp not found. Please install yt-dlp."
    exit 1
  fi
fi

OUT_DIR="out/staging_$AYA_ID"
mkdir -p "$OUT_DIR"

$YT_DLP --no-check-certificate \
  --no-cache-dir \
  --rm-cache-dir \
  -f "(mp4/best)[height<=?2160][height>=?256][width>=?256]" \
  -o "$OUT_DIR/video.mp4" \
  "$YOUTUBE_URL"
MD5SUM=$(md5sum "$OUT_DIR/video.mp4" | cut -d' ' -f1)
java -jar "$INDEXER_JAR" "$YOUTUBE_URL" "$AYA_ID" "$AYA_CAT_ID" "$AYA_CAT_NAME" "$FLIP" \
  | sed "s/CHECKSUM-PLACEHOLDER/$MD5SUM/g" \
  | tee "$OUT_DIR/metadata.json"
