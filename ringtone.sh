#!/bin/bash

# This script is used to convert audio files to the iOS ringtone format (.m4r)


if [ $# -gt 0 ]; then
    input_path="$1"
    filename="$(basename "$input_path")"
    base_name="${filename%.*}"
    output_path="${base_name}.m4r"
    ffmpeg -i "$input_path" -t 30 -acodec aac -b:a 192k -f ipod "$output_path"

    if [ $? -ne 0 ]; then
        echo "Error ... Unable to convert input file"
    else
        echo "Converted file saved to ${output_path}"
    fi
else
    echo "Usage: $0 input_file"
fi
