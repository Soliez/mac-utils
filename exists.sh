#!/bin/bash

# Dependencies: python3. MacOS ships with python3.8

# This scripts determines whether a provided filepath points to a valid location on disk, and returns the result as boolean

# To run this this script without needing to provide the full path or file extension, add the line below to your shell profile file

# alias bundleid="<path-to-this-script-on-your-computer>"

# Replace <path-to-this-script-on-your-computer> with the path to this script on your computer 


if [ $# -eq 0 ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

path="$1"
python3 -c "import sys, os; print(os.path.exists(sys.argv[1]))" "$path"
