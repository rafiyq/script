#!/usr/bin/env python3

import os
import re
import shutil
import subprocess

def matchFilm(s):
    '''
    Given string s,
    Return true if s match conventional film name
    '''
    film = re.fullmatch(r'(.*?)(19|20)\d{2}(.*?)(.mp4|.mkv|.rar|.zip)$', s)
    psarips = re.fullmatch(r'(.*?)(\d\d\d\d)(.*?)(\.x265\.HEVC\-PSA)(.mp4|.mkv|.rar|.zip)$', s)
    return psarips or film

def matchVideo(s):
    '''
    Given string s,
    Return true if s match conventional film name
    '''
    video = re.fullmatch(r'(.*?)(.mp4|.mkv)$', s)
    return video

def matchSeries(s):
    '''
    Given string s,
    Return true if s match conventional tv-series name
    '''
    return re.fullmatch(r'(.*?)(S\d\dE\d\d)(.*?)(.mp4|.mkv|.rar|.zip)$', s)

def matchArchive(s):
    '''
    Given string s,
    Return true if s match compressed file 
    '''
    return re.fullmatch(r'(.*?)(.7z|.rar|.zip)$', s)
    
def createDirIfNotExist(dir_path):
    '''
    Given directory path,
    Check if directory exist, if not create it.
    '''
    if not os.path.exists(dir_path):
        os.mkdir(dir_path)

def moveFile(source, destination):
    '''
    Given source and destination
    Move file from source to destination
    '''
    print("from:", end=" ")
    print(source) 
    createDirIfNotExist(destination)
    new_location = shutil.move(source, destination)
    print("to:", end=" ")
    print(new_location)

def createSimilarStr(a, b):
    '''
    Given string a and b,
    return first longest first similar string 
    '''
    sim = ''
    shortest = len(a) if a > b else len(b)
    for i in range(shortest):
        if a[i] == b[i]:
            sim += a[i]
        else:
            break
    return sim

def extract(file_path, destination):
    '''
    Given file and destination path,
    extract file in given directory
    '''
    sevzip = '/usr/bin/7z'
    print(f"Extracting: {file_path} into {destination}...")

    process = subprocess.Popen([sevzip, "x", file_path, "-o" + directory])
    status  = os.waitpid(process.pid, 0)[1]

    if status == 0:
        os.unlink(file_path)
        print(f'{file_path} Deleted.')


download_dir = os.path.expanduser("~/Downloads")
series_dir = os.path.join(download_dir, "Series")
film_dir = os.path.join(download_dir, "Films")
video_dir = os.path.join(download_dir, "Videos")

for file_name in os.listdir(download_dir):
    file_path = os.path.join(download_dir, file_name)
    if matchSeries(file_name):
        moveFile(file_path, series_dir)
    elif matchFilm(file_name):
        moveFile(file_path, film_dir)
    elif matchVideo(file_name):
        moveFile(file_path, video_dir)

for filename in os.listdir(series_dir):
    filename_path = os.path.join(series_dir, filename)
    if matchArchive(filename):
        extract(filename_path, series_dir)

for filename in os.listdir(film_dir):
    filename_path = os.path.join(film_dir, filename)
    if matchArchive(filename):
        extract(filename_path, film_dir)

holder = ''
try:
    for file_name in sorted(os.listdir(series_dir)):
        if holder:
            new_dir = createSimilarStr(holder, file_name)
            if len(new_dir) > 4:
                createDirIfNotExist(os.path.join(series_dir, new_dir))
                for file_name_2 in os.listdir(series_dir):
                    similar_dir = os.path.join(series_dir, new_dir)
                    file_path_2 = os.path.join(series_dir, file_name_2)
                    if new_dir == file_name_2[:len(new_dir)]:
                        moveFile(file_path_2, similar_dir)
            holder = file_name
        else:
            holder = file_name
except FileNotFoundError:
    print("Directory ~/Downloads/Series did not exist!")
