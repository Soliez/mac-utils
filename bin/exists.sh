#!/bin/bash

show_usage() {
    echo "Usage: $0 [OPTION] [PATH]"
    echo "Try '$0 --help' or 'man exists' for more information."
}

show_help() {
    cat << EOF
Usage: $0 [OPTION] [PATH]

Check if a provided path exists, optionally providing detailed output.

Options:
  -h, --help        Display this help message and exit.
  -v, --verbose     Display detailed information about the path.

Examples:
  $0 ./myfile.txt
  $0 -v ./mydirectory/
EOF
}

isValid() {
    [[ -e "$1" ]];
}

isFile() {
    [[ -f "$1" ]];
}

isDirectory() {
    [[ -d "$1" ]]
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
        -v|--verbose)
            if [[ -z "$2" ]]; then
                echo -e "Error: Missing PATH argument for verbose option.\n"
                show_usage
                exit 1
            fi
            path="$2"
            if isFile "$path"; then
                echo "File: '$path'"
                exit 0
            elif isDirectory "$path"; then
                echo "Directory: '$path'"
                exit 0
            elif isValid "$path"; then
                echo "Exists but is neither file nor directory: '$path'"
                exit 0
            else
                echo "Invalid Location: '$path'"
                exit 1
            fi
            ;;
        *)
            path="$1"
            if isValid "$path"; then
                exit 0
            else
                exit 1
            fi
            ;;
    esac
}

main "$@"