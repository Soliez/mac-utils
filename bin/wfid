#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 \"shortcut-name\""
    exit 1
fi

shortcut="$1"

shortcuts list --show-identifiers | grep "$shortcut"  | grep -Eo '\([A-Za-z0-9\-]+\)' | tr -d  '()'
