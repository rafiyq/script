#!/bin/bash

log_file=/tmp/adzan_log
is_interactive=false
[ "$1" = "-i" ] && is_interactive=true

play_mpv() {
    mpv --input-ipc-server=/tmp/mpvsocket \
        --no-input-default-bindings \
        --input-conf=- \
        --length=180 \
        --volume=100 \
        --autofit=70% \
        --geometry=50%:50% \
        --no-border \
        --no-window-dragging \
        --audio-file=$1 \
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
    file=~/Documents/jadwal-sholat.csv
    columns_names=("NO" "TANGGAL" "" "IMSAK" "SUBUH" "TERBIT" "DUHA" "ZUHUR" "ASAR" "MAGRIB" "ISYA")
    
    today=$(date '+%d/%m/%Y')
    my_string=$(grep $today $file)
    #my_string="7|Kamis, 07/12/2023||03:39|03:49|05:09|05:38|11:15|11:31|11:52|12:01"
    prayers_names=("Subuh" "Zuhur" "Asar" "Magrib" "Isya")
    prayers_idx=0

    echo "\n$(date) -> Memulai adzan..." >> $log_file
    if $is_interactive; then
        date
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

                echo "$(date) -> Menantikan waktu adzan $prayer_name pukul $prayer_time." >> $log_file
                if $is_interactive; then
                    echo "Menantikan waktu adzan $prayer_name pukul $prayer_time."
                fi
                sleep "$duration"
                echo "$(date) -> Mengumandangkan adzan $prayer_name pukul $prayer_time ..." >> $log_file
                if $is_interactive; then
                    echo "Mengumandangkan adzan $prayer_name pukul $prayer_time ..."
                fi
                if [ "$prayer_name" = "Subuh" ]; then
                    play_mpv $HOME/Music/adzan_subuh.m4a $HOME/Downloads/video.mp4
                else
                    play_mpv $HOME/Music/adzan.m4a $HOME/Downloads/video.mp4
                fi
    
            else
                echo "$(date) -> Adzan $prayer_name telah berkumandang pukul $prayer_time." >> $log_file
                if $is_interactive; then
                    echo "Adzan $prayer_name telah berkumandang pukul $prayer_time."
                fi
            fi
       fi
    done

    current_date=$(date '+%d/%m/%Y')
    if [ "$today" = "$current_date" ]; then
        current_time=$(date +%s)
        midnight_time=$(date -d "tomorrow 00:00:00" +%s)
        seconds_until_midnight=$((midnight_time - current_time))
        echo "$(date) -> Menanti pergantian hari." >> $log_file
        if $is_interactive; then
            echo "Menanti pergantian hari."
        fi
        sleep "$seconds_until_midnight"
        adzan
    else
        adzan
    fi
}

adzan
