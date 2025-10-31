
# RTMP-live-streaming-system
1. トークンファイルに情報を書き込んで名前を `token.env` にする
2. ffmpegとscreenを入れる
3. したのコマンドを叩く
```
screen -dmS stream bash -lc '/root/RTMP-live-streaming-system/streamer.sh >>/root/stream.log 2>&1' && tail -f /root/stream.log
```
