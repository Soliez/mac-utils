#!/bin/bash

if [ $# -lt 1 ]; then
    path="$PWD"
else    
    path="$1"
fi

tree -J "$path" | plutil -convert xml1 - -o - | "$HOME/Developer/python/PythonTools/pylight/dist/pylight-arm64/v1.0.1/pylight -"
