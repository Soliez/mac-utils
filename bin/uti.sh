#!/bin/bash


if [ $# -eq 0 ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

path="$1"

mdls -name kMDItemContentType  "$path"  | grep -Eo '"(.+?)"' | tr -d \"
