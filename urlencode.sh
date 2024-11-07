#!/bin/bash


show_usage(){
    echo "Usage: $0 [-h,--help] [[-e,--encode][-d, --decode] <DATA>]"
}

show_help(){
    lines=(
        "URLENCODE(1)"
        ""
        "NAME"
        "    urlencode - Percent Encoding Utility"
        ""
        "SYNOPSIS"
        "    urlencode [OPTION] [INPUT]"
        ""
        "DESCRIPTION"
        "    The urlencode utility is used to perform percent-encoding operations on data"
        ""
        "    The following options are supported"
        ""
        "    ┌── -e, --encode   Percent-encode the input data"
        "    ├── -d, --decode   Percent-decode the input data"
        "    └── -h, --help     Show this help message"
        ""
        "PROJECT"
        "    This script is from the mac-utils repo on GitHub."
        "    mac-utils is a collection of useful (mostly macOS specific) shell and python scripts."
        ""
        "    GitHub: https://github.com/Soliez/mac-utils"
    )
    printf "%s\n" "${lines[@]}" | less
}

encode(){
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done
    LC_COLLATE=$old_lc_collate
}

decode(){
    local url_encoded="${1//+/ }"
    printf '%b' "${url_encoded//%/\\x}"
}

main(){
    if [ $# -lt 2 ]; then
        show_usage
        exit 1
    else
        flag="$1"
        data="$2"
    fi

    if [[ "$data" == "-" ]]; then
        data=$(cat -)
    fi

    case "$flag" in
        -h|--help)
            show_help
            exit 0
            ;;
        -e|--encode)
            encode "$data" 2>/dev/null 
            ;;
        -d|--decode)
            decode "$data" 2>/dev/null
            ;;
        *)
            show_usage
            exit 1
            ;;
    esac

}

main "$@"