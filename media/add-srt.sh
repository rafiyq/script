#!/bin/sh
# Merge a video with its subtitle file into an MP4 container (ffmpeg).
#
# Usage:
#   add-srt.sh <video> [<subtitle>]   merge a single file; the subtitle is
#                                     auto-detected by basename if omitted
#   add-srt.sh -d <ext>               merge every *.<ext> video in the current directory

if [ "$1" = "-d" ]; then
    ext=$2
    for video in *."$ext"; do
        [ -f "$video" ] && "$0" "$video"
    done
    exit $?
fi

video=$1

if [ -z "${2:-}" ]; then
    base_name=${video%.*}
    total_subs=$(find "$base_name"*.srt 2>/dev/null | wc -l)
    if [ "$total_subs" -eq 1 ]; then
        subs=$(find "$base_name"*.srt 2>/dev/null)
    else
        echo "Error: expected exactly one subtitle file matching '$base_name', found $total_subs" >&2
        exit 1
    fi
else
    subs=$2
fi

ffmpeg_bin=$(command -v ffmpeg)
if [ -z "$ffmpeg_bin" ]; then
    echo "Error: ffmpeg is not installed" >&2
    exit 1
fi

"$ffmpeg_bin" -i "$video" -f srt -i "$subs" \
    -c:v copy -c:a copy -c:s mov_text -metadata:s:s:0 language=eng outfile.mp4 \
    && gio trash "$video" "$subs" \
    && mv outfile.mp4 "$video"
