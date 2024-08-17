#!/bin/bash


: '
lsframework.sh

This script searches for framework directories at a given path and outputs the results as a JSON array

Add the following line to your shell profile (.profile|.zprofile|.zshrc|.bash_profile|.bashrc|etc)
    alias lsframework="<full-path-to-lsframework.sh>"

Replace <full-path-to-lsframework.sh> with the full path to lsframework.sh on your computer

Requirements: 
    jq - Command-line JSON processor (https://github.com/jqlang/jq) 
    Install jq with "brew install jq"
'


show_prompt() {
    local path
    read -p "Enter the directory path to search: " path
    echo "$path"
}


show_usage() {
    echo "Usage: lsframework [-h,--help] [[-p,--path] <directory-path>] [-i,--interactive]"
}


show_help() {
    lines=(
        "LSFRAMEWORK(1)"
        ""
        "NAME"
        "    lsframework - list frameworks in a directory"
        ""
        "SYNOPSIS"
        "    lsframework [-h,--help] [[-p,--path] <directory-path>] [-i,--interactive]"
        ""
        "DESCRIPTION"
        "    The lsframework utility recursively descends the directory tree searching for .framework directories and returns their full paths as a JSON array"
        ""
        "   The following options are supported"
        ""
        "    -h, --help            Show this help message"
        "    -p, --path            Search the directory at the path specified for frameworks"
        "    -i, --interactive     Ask for the path to the directory to search for frameworks with an interactive prompt"
        ""
        "PROJECT"
        "    This script is from the mac-utils repo on GitHub."
        "    mac-utils is a collection of useful (mostly macOS specific) shell scripts."
        ""
        "    GitHub: https://github.com/Soliez/mac-utils"
        )

    printf "%s\n" "${lines[@]}" | less
}


main() {

    local path

    if  [ $# -lt 1 ]; then
        show_usage
        exit 1
    fi

    while [ $# -gt 0 ]; do
        case "$1" in
            -h|--help)
                show_help
                exit 0
                ;;
            -p|--path)
                shift
                if [ "$1" = "-" ]; then
                    path=$(realpath "$(cat -)")
                else
                    path=$(realpath "$1")
                fi
                ;;
            -i|--interactive)
                path=$(realpath "$(show_prompt)")
                ;;
            *)
                show_usage
                exit 1
                ;;
        esac
        shift
    done


    if [[ -z "$path" ]]; then
        show_usage
        exit 1
    fi

    if [[ -n "$path" && "${path: -1}" != "/" ]]; then
        path="$path/"
    fi

    find "$path" -type d -name "*.framework" 2>/dev/null | jq -R -s 'split("\n") | map(select(length > 0))'
}

main "$@"