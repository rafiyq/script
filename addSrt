#!/bin/sh
ffmpeg -i $1 -f srt -i $2 -c:v copy -c:a copy -c:s mov_text -metadata:s:s:0 language=eng outfile.mp4
rm $1 $2
mv outfile.mp4 $1
