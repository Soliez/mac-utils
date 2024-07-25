#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <path-to-example.plist>"
    exit 1
fi

path="$1"

plutil -convert json "$path" -o - | jq 
