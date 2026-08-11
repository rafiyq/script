#!/bin/sh

[ -z "$1" ] && echo "Please provide a profile!" && exit 1

profiles_dir=~/.config/code_profiles
vscode_path="/bin/code"
[ ! -d "$profiles_dir" ] && mkdir -pv "$profiles_dir"

start_vscode() {
    profile=$profiles_dir/$1
    [ ! -d "$profile" ] && mkdir -pv "$profile"
    ext_dir=$profile/exts
    [ ! -d "$ext_dir" ] && mkdir -pv "$ext_dir"
    data_dir=$profile/data
    [ ! -d "$data_dir" ] && mkdir -pv "$data_dir"
    $vscode_path --extensions-dir $ext_dir --user-data-dir $data_dir $2
}

if [ ! -d "$profiles_dir/$1" ] 
then
    read -p "Profile \"$1\" doesn't exist, Create new? " ans
    if [ $ans = 'y' ]
    then
        echo "Open VSCode with $1's Profile" 
        start_vscode $1 $2
    else
        echo "Abort."
    fi
else
    echo "Open VSCode with $1's Profile" 
    start_vscode $1 $2
fi


# case $1 in
#     "cpp")
#         lang="CPP"
#         echo $lang
#         start_vscode $2
#         ;;
#     "js")
#         lang="JavaScript"
#         echo $lang
#         start_vscode $2
#         ;;
#     "py")
#         lang="Python"
#         echo $lang
#         start_vscode $2
#         ;;
#     "rs"|"rust")
#         lang="Rust"
#         echo $lang
#         start_vscode $2
#         ;;
#     *)
#         echo "Unknown Option"; exit 1;
# esac
