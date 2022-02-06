#!/bin/sh
py=/usr/bin/python3
ytdl_path=$HOME/.local/bin/yt-dlp
#ytdl_addr=https://youtube-dl.org/downloads/latest/youtube-dl
[ ! -f $ytdl_path ] && wget -O $ytdl_path $ytdl_addr

case $1 in
    "best")
        echo "best video(mp4) + best audio(m4a) + substitle"
        $py $ytdl_path -f \
            'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' \
            --write-sub --write-auto-sub --sub-lang en,id \
            --convert-subs=srt --embed-subs $2
        ;;
    "top")
        echo "best video + best audio + substitle"
        $py $ytdl_path -f \
            'bestvideo+bestaudio' --write-sub --write-auto-sub \
            --sub-lang en,id --convert-subs=srt --embed-subs $2
        ;;
    "music")
        echo "downloading music..."
        $py $ytdl_path -o %\(track\)s\ -\ %\(artist\)s.%\(ext\)s \
        -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 \
        --embed-thumbnail --add-metadata --metadata-from-title %\(track\)s\ -\ %\(artist\)s \
        $2
        ;;
    "thumbnail")
        echo "Download thumbnail"
        $py $ytdl_path --write-thumbnail --skip-download $2
        ;;
    "update")
        echo "Updating youtube-dl..."
        rm $ytdl_path
        wget -O $ytdl_path $ytdl_addr
        ;;
    *)
        echo "youtube-dl"
        $py $ytdl_path $*
        ;;
esac

