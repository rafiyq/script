#!/bin/sh

save_to="$HOME/Documents/logs/internet-speed-test.txt"
temp_file="$HOME/Documents/logs/internet-speed-temp"
interval=600

[ ! -f $save_to ] && echo "Date|Time|Wireles|IP Address|Ping|Download|Upload" > $save_to
while true
do
    date +%Y-%m-%d > $temp_file
    date | awk '{print $5}' >> $temp_file
    nmcli | grep -m2 "connected to\|inet4" | awk '{print $NF}' >> $temp_file
    speedtest-cli --simple | awk '{print $2,$3}' >> $temp_file
    sed ':a;N;$!ba;s/\n/\|/g' $temp_file >> $save_to
    rm $temp_file
    sleep $interval
done
