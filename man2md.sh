#!/bin/bash


if [ $# -eq 0 ]; then
    echo "Usage: $0 <command name>"
    exit 1
fi

TEMP_HTML=$(mktemp)

trap 'rm -f "$TEMP_HTML"' EXIT

cmd="$1"

man "$cmd" | man2html -title "Man Page for ${cmd}"  > "$TEMP_HTML"

if [[ $? -ne 0 ]]; then
    echo "Failed to convert man page to HTML"
    exit 1
fi

pandoc -f html -t markdown -o "${cmd}.md" "$TEMP_HTML"

if [[ $? -ne 0 ]]; then
    echo "Failed to convert HTML to Markdown"
    exit 1
fi

echo "Results saved to $(realpath "${cmd}.md")"
