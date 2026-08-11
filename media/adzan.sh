#!/bin/bash

####### Set Variables ##########
log_file=/tmp/adzan.log
jadwal_shalat=~/Documents/jadwal-sholat.csv
columns_names=("NO" "TANGGAL" "" "IMSAK" "SUBUH" "TERBIT" "DUHA" "ZUHUR" "ASAR" "MAGRIB" "ISYA")
video_adzan=$HOME/Music/video_adzan.mp4
audio_adzan=$HOME/Music/adzan.m4a
audio_adzan_subuh=$HOME/Music/adzan_subuh.m4a
################################    


echo "===========================" >> $log_file
is_interactive=false
[ "$1" = "-i" ] && is_interactive=true
echo "$(date) -> Starting adzan.sh" >> $log_file

play_mpv() {
    audio_dur=$(ffprobe -v error -select_streams v:0 -show_entries format=duration -of default=noprint_wrappers=1:0 -of csv="p=0" $1 | awk '{printf "%.0f\n", $1}')
    video_dur=$(ffprobe -v error -select_streams v:0 -show_entries format=duration -of default=noprint_wrappers=1:0 -of csv="p=0" $2 | awk '{printf "%.0f\n", $1}')
    max_vid_dur=$((video_dur - audio_dur))
    random_start_time=$((RANDOM % $max_vid_dur))

    mpv --no-osc \
        --input-ipc-server=/tmp/mpvsocket \
        --no-input-default-bindings \
        --input-conf=- \
        --length=$audio_dur \
        --volume=100 \
        --autofit=70% \
        --geometry=50%:50% \
        --no-border \
        --no-window-dragging \
        --audio-file=$1 \
        --start=$random_start_time \
        --audio-delay=$random_start_time \
        $2 <<EOF
    # Enable volume control using mouse wheel
    UP add volume 2
    DOWN add volume -2
    MOUSE_BTN3 add volume 2
    MOUSE_BTN4 add volume -2
    # Enable mute using 'm' key
    m cycle audio-mute
EOF
}

adzan() {
    today=$(date '+%d/%m/%Y')
    my_string=$(grep $today $jadwal_shalat)
    prayers_names=("Subuh" "Zuhur" "Asar" "Magrib" "Isya")
    prayers_idx=0

    if $is_interactive; then
        echo "Running adzan.sh in interactive mode"
        date
    fi

    if [ -z "$my_string" ]; then
        echo "$(date) -> Prayer schedule not available, update it at https://bimasislam.kemenag.go.id/jadwalshalat." >> $log_file
        if $is_interactive; then
            echo "Prayer schedule not available, update it at https://bimasislam.kemenag.go.id/jadwalshalat"
        fi
    fi
    
    IFS='|' read -r -a my_array <<< "$my_string"
    
    for ((i = 0; i < ${#my_array[@]}; i++))
    do
        column_name=${columns_names[i]}
        prayer_name=${prayers_names[prayers_idx]}
    
        if [ "${column_name,,}"  = "${prayer_name,,}" ]; then
            prayer_time="${my_array[i]}"
            current_timestamp=$(date -d $(date +%H:%M) +%s)
            prayer_timestamp=$(date -d "$prayer_time" +%s)
            duration=$((prayer_timestamp - current_timestamp))
            let "prayers_idx=prayers_idx+1"
    
            # Check if the prayer time is in the future
            if [ "$duration" -gt 0 ]; then

                echo "$(date) -> Waiting for the $prayer_name prayer at $prayer_time." >> $log_file
                if $is_interactive; then
                    echo "Waiting for the $prayer_name prayer at $prayer_time."
                fi
                sleep "$duration"
                echo "$(date) -> Calling the adhan for $prayer_name" >> $log_file
                if $is_interactive; then
                    echo "Calling the adhan for $prayer_name at $prayer_time ..."
                fi
                if [ "$prayer_name" = "Subuh" ]; then
                    play_mpv $audio_adzan_subuh $video_adzan
                else
                    play_mpv $audio_adzan $video_adzan
                fi
    
            else
                echo "$(date) -> The $prayer_name prayer already passed at $prayer_time." >> $log_file
                if $is_interactive; then
                    echo "The $prayer_name prayer already passed at $prayer_time."
                fi
            fi
       fi
    done

    current_date=$(date '+%d/%m/%Y')
    if [ "$today" = "$current_date" ]; then
        current_time=$(date +%s)
        midnight_time=$(date -d "tomorrow 00:00:00" +%s)
        seconds_until_midnight=$((midnight_time - current_time))
        echo "$(date) -> Waiting for the next day." >> $log_file
        if $is_interactive; then
            echo "Waiting for $(date -d "tomorrow" +"%A, %d %B %Y")"
        fi
        sleep "$seconds_until_midnight"
        adzan
    else
        adzan
    fi
}

adzan
#play_mpv $audio_adzan_subuh $video_adzan
