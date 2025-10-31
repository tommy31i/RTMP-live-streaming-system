#!/usr/bin/env bash
set -euxo pipefail

# 外部ファイルから4つの変数を読み込み
source ./token.env

# 入力ファイルの確認
ffprobe -hide_banner -v error -show_streams "$FILE"

# まずはプライマリだけで疎通確認（tee無し）
ffmpeg -re -i "$FILE" \
  -c:v libx264 -preset veryfast -pix_fmt yuv420p -profile:v high -level 4.2 \
  -r 30 -g 60 -keyint_min 60 -b:v 4500k -maxrate 5000k -bufsize 10000k \
  -c:a aac -b:a 160k -ar 48000 -ac 2 \
  -f flv "${URL_PRIMARY%/}/$YT_KEY"

# 成功したら、バックアップ同時配信（tee）
ffmpeg -re -i "$FILE" \
  -c:v libx264 -preset veryfast -pix_fmt yuv420p -profile:v high -level 4.2 \
  -r 30 -g 60 -keyint_min 60 -b:v 4500k -maxrate 5000k -bufsize 10000k \
  -c:a aac -b:a 160k -ar 48000 -ac 2 \
  -f tee "[f=flv]${URL_PRIMARY%/}/$YT_KEY|[f=flv]${URL_BACKUP%/}/$YT_KEY"
