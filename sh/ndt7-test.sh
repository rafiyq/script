#!/bin/bash

file_path=$HOME/Documents/internet_test.txt
ndt7_path=$HOME/.local/bin/ndt7-client
date_time=$(date +"%D %X")
string="{\"DateTime\":\"$date_time\","
echo -n $string >> $file_path
$ndt7_path -quiet -format=json | sed 's/{//' >> $file_path
