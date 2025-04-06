#!/bin/bash


if [ $# -eq 0 ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

path="$1"

kind=$(mdls -name kMDItemKind "$path" | awk '{print $3,$4}' | tr -d \")

if [[ "$kind" == "not find" ]]; then
   echo "Attribute not found: {'attribute': 'kMDItemKind', 'path': '$path'}"
else
    echo "$kind"
fi
