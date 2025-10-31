#!/usr/bin/env bash
set -euxo pipefail

# トークンファイル読み込み
source ~/token.env

FILE="/home/ubuntu/A.mp4"

ffmpeg -re -stream_loop -1 -i "$FILE" \
  -c:v libx264 -preset veryfast -pix_fmt yuv420p -profile:v high -level 4.2 \
  -r 30 -g 60 -keyint_min 60 -b:v 4500k -maxrate 5000k -bufsize 10000k \
  -c:a aac -b:a 160k -ar 48000 -ac 2 \
  -f tee "[f=flv]${URL_PRIMARY%/}/${YT_KEY}|[f=flv]${URL_BACKUP%/}/${YT_KEY}"
