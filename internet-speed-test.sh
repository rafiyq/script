#!/bin/sh

url_speedtest="https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py"
loc_speedtest="$HOME/.local/bin/speedtest.py"
loc_csv="$HOME/Documents/logs/speedtest.csv"
py="/usr/bin/python3"
interval=300

# Download speedtest.py if file do not exist
[ ! -f $loc_speedtest ] && curl -Lo $loc_speedtest $url_speedtest

# Create file and fill the header if file do not exist
[ ! -f $loc_csv ] && $py $loc_speedtest --csv-header > $loc_csv

while true
do
  $py $loc_speedtest --csv >> $loc_csv
  sleep $interval
done

#################################################################
# save_to="$HOME/Documents/logs/internet-speed-test.txt"
# temp_file="$HOME/Documents/logs/internet-speed-temp"
# interval=600
# 
# [ ! -f $save_to ] && echo "Date|Time|Wireles|IP Address|Ping|Download|Upload" > $save_to
# while true
# do
#     date +%Y-%m-%d > $temp_file
#     date | awk '{print $5}' >> $temp_file
#     nmcli | grep -m2 "connected to\|inet4" | awk '{print $NF}' >> $temp_file
#     speedtest-cli --simple | awk '{print $2,$3}' >> $temp_file
#     sed ':a;N;$!ba;s/\n/\|/g' $temp_file >> $save_to
#     rm $temp_file
#     sleep $interval
# done
################################################################
