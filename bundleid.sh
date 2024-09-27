#!/bin/bash

# This script returns the bundle identifier of the bundle or app specified at the provided.

# To run this this script without needing to provide the full path or file extension, add the line below to your shell profile file

# alias bundleid="<path-to-this-script-on-your-computer>"

#Replace <path-to-this-script-on-your-computer> with the path to this script on your computer
 

ensure_trailing_slash() {
    local path="$1"
    if [[ "$path" != */ ]]; then
        path="${path}/"
    fi
    echo "$path"
}

show_usage() {
    echo "Usage: $0 <path/to/bundle>"
    exit 1
}

main() {
    if [[ -z "$1" ]]; then
        show_usage
    else
        path="$1"
        full_path="$(ensure_trailing_slash "$path")Contents/Info.plist"
        identifier=$(plutil -extract "CFBundleIdentifier" raw "$full_path")
        echo "$identifier"
    fi
}

main "$@"