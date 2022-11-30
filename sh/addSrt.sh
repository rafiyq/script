#!/bin/sh

# save video name to variable
video=$1

if [ -z $2 ]
then
    base_name=$(echo $video | rev | cut -f 2- -d '.' | rev)
    total_subs=$(find "$base_name"*.srt | wc -l)
    if [ $total_subs -eq 1 ]
    then
        subs=$(find "$base_name"*.srt)
    else
        echo "There're multiple substitle"
        exit 1
    fi
else  
    subs=$2
fi

ffmpeg_bin=$(command -v ffmpeg)
if [ ! -z "$ffmpeg_bin" ]
then
    $ffmpeg_bin -i "$video" -f srt -i "$subs" -c:v copy -c:a copy -c:s mov_text -metadata:s:s:0 language=eng outfile.mp4 && \
    gio trash "$video" "$subs" && \
    mv outfile.mp4 "$video"
else
    echo "ffmpeg isn't installed"
    exit 1
fi

#echo "$video"
#echo "$subs"
