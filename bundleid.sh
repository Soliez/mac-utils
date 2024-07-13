#!/bin/bash

# Dependencies: jq, a lightweight commandline json processors. Install jq via homebrew or from the github repo here: https://github.com/jqlang/jq

# This script returns the bundle identifier of the bundle or app specified at the provided.

# To run this this script without needing to provide the full path or file extension, add the line below to your shell profile file

# alias bundleid="<path-to-this-script-on-your-computer>"

# Replace <path-to-this-script-on-your-computer> with the path to this script on your computer


if [ $# -eq 0 ]; then
    echo "Usage: $0 <path/to/bundle>"
    exit 1
fi

path="$1"

info="${path}/Contents/Info.plist"

plutil -convert json "$info" -o - | jq .CFBundleIdentifier | tr -d \"
