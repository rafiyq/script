#!/bin/sh

code_profiles_dir=~/.config/code_profile

start_vscode() {
    ext_dir=$code_profiles_dir/$lang/exts
    [ ! -d "$dir" ] && mkdir -pv "$ext_dir"
    data_dir=$code_profiles_dir/$lang/data
    [ ! -d "$dir" ] && mkdir -pv "$data_dir"
    code --extensions-dir $ext_dir --user-data-dir $data_dir $2
    echo "$ext_dir \n $data_dir"
}


case $1 in
    "cpp")
        lang="CPP"
        echo $lang
        start_vscode
        ;;
    "js")
        lang="JavaScript"
        echo $lang
        start_vscode
        ;;
    "py")
        lang="Python"
        echo $lang
        start_vscode
        ;;
    "rs"|"rust")
        lang="Rust"
        echo $lang
        start_vscode
        ;;
    *)
        echo "Unknown Option"; exit 1;
esac
