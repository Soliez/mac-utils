#!/bin/bash

# Dependencies: jq, a lightweight commandline json processors. Install jq via homebrew or from the github repo here: https://github.com/jqlang/jq

# This scripts returns helpful information about the currently mounted volumes on your mac as a JSON object

# To run this this script without needing to provide the full path or file extension, add the line below to your shell profile file

# alias disks="<path-to-this-script-on-your-computer>"

# Replace <path-to-this-script-on-your-computer> with the path to this script on your computer


diskutil list -plist | plutil -convert json - -o - | jq
