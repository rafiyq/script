#!/bin/sh

save_to="$HOME/Documents/internet-speed-test"
temp_file="$HOME/Documents/internet-speed-temp"
interval=600

[ ! -f $save_to ] && echo "Date|Time|Ping|Download|Upload" > $save_to
while true
do
    date +%Y-%m-%d > $temp_file
    date | awk '{print $5}' >> $temp_file
    speedtest-cli --simple | awk '{print $2,$3}' >>$temp_file
    sed ':a;N;$!ba;s/\n/\|/g' $temp_file >> $save_to
    rm $temp_file
    sleep $interval
done
