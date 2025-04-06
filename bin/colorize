#!/bin/bash

RESET="\033[0m"


show_usage() {
    echo "Usage: $0 [OPTION] [TEXT]"
    echo "Try '$0 --help' or 'man colorize' for more information."
}

show_help() {
    cat << EOF
Usage: $0 [OPTION] [TEXT]

Add color to text using ANSI color escape sequences.

Options:
  -h, --help        Display this help message and exit.
  -black            Color the input text black.
  -red              Color the input text red.
  -green            Color the input text green.
  -yellow           Color the input text yellow.
  -blue             Color the input text blue.
  -magenta          Color the input text magenta.
  -cyan             Color the input text cyan.
  -white            Color the input text white.

Examples:
  $0 -red "Hello World"
  echo "Hello World" | $0 -green
EOF
}

get_color_code() {
    case "$1" in
        black)   echo "30" ;;
        red)     echo "31" ;;
        green)   echo "32" ;;
        yellow)  echo "33" ;;
        blue)    echo "34" ;;
        magenta) echo "35" ;;
        cyan)    echo "36" ;;
        white)   echo "37" ;;
        *)       echo "" ;;
    esac
}

color_text() {
    local color_code="$1"
    local text="$2"
    echo -e "\033[${color_code}m${text}${RESET}"
}

main() {
    if [[ $# -eq 0 ]]; then
        show_usage
        exit 1
    fi

    case "$1" in
        -h|--help)
            show_help
            exit 0
            ;;
        -*)
            color="${1#-}"
            color_code=$(get_color_code "$color")
            if [[ -z "$color_code" ]]; then
                echo "Error: Unknown color '$color'."
                show_usage
                exit 1
            fi
            if [[ -n "$2" ]]; then
                color_text "$color_code" "$2"
            else
                text="$(cat -)"
                if [[ -z "$text" ]]; then
                    echo "Error: No text provided."
                    show_usage
                    exit 1
                fi
                color_text "$color_code" "$text"
            fi
            ;;
        *)
            echo "Error: Invalid option '$1'."
            show_usage
            exit 1
            ;;
    esac
}

main "$@"