#!/bin/bash


if [ $# -eq 0 ]; then
    echo "Usage: $0 your text here"
    exit 1
fi

text="$1"

python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))" "$text"
