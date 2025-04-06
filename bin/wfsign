#!/bin/bash

    
usage() {
    lines=(
        "Usage: $0 [-i <input>] [-m <mode>] [-o <output>]"
        ""
        "Arguments:"
        "  -i, --input   Path to the input shortcut file (extensions: .shortcut, .wflow). Use '-' to read from standard input"
        "  -m, --mode    Mode (must be 'people-who-know-me' or 'anyone')"
        "  -o, --output  Output file path"
        echo
        "Example:"
        "  $0 --input myfile.txt --mode 'people-who-know-me' --output output.txt"
    )
    printf '%s\n' "${lines[@]}"
    exit 1
}

    
validate_mode() {
    local mode="$1"
    if [[ "$mode" != "people-who-know-me" && "$mode" != "anyone" ]]; then
        echo "Error: Invalid mode. Must be 'people-who-know-me' or 'anyone'."
        exit 1
    fi
}

    
input=""
mode=""
output=""

    
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -i|--input)
            input="$2"
            shift 2
            ;;
        -m|--mode)
            mode="$2"
            shift 2
            ;;
        -o|--output)
            output="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Error: Invalid option '$1'"
            usage
            ;;
    esac
done

    
if [[ -z "$input" || -z "$mode" || -z "$output" ]]; then
    echo "Error: Missing required arguments."
    usage
fi

    
validate_mode "$mode"

    
if [[ "$input" == "-" ]]; then
    echo "Enter input file path (or press Ctrl+D to finish):"
    read -r input
    if [[ -z "$input" ]]; then
        echo "Error: No input file provided via standard input."
        exit 1
    fi
fi

    
if [[ ! -f "$input" ]]; then
    echo "Error: Input file '$input' does not exist."
    exit 1
fi

    
touch "$output" 2>/dev/null
if [[ $? -ne 0 ]]; then
    echo "Error: Cannot write to output file '$output'."
    exit 1
fi

shortcuts sign --input "$input" --mode "$mode" --output "$output"

if [ $? -ne 0 ];then
    printf 'Error: Unable to sign "%s" with "%s"\n' "$input" "$0"
    exit 1
else
    printf 'Success: Signed "%s" for mode "%s" as "%s" using "%s"\n' "$input" "$mode" "$output" "$0"
    exit 0
exit