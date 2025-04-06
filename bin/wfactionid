#!/bin/bash

show_usage() {
    echo "Usage: $0 [-r] <path-to-shortcuts-action-file>"
    exit 1
}

main() {
    if [ $# -eq 0 ]; then
        show_usage
    else
        if [ $# -eq 2 ]; then
            flag="$1"
            path="$2"
            if [ "$flag" = "-r" ]; then
                identifier=$(plutil -extract "WFWorkflowActionIdentifier" raw "$path")
                mv "$path" "$identifier"
                echo "$path renamed to $identifier"
            else
                show_usage
            fi
        else
            path="$1"
            identifier=$(plutil -extract "WFWorkflowActionIdentifier" raw "$path")
            echo "$identifier"
        fi
    fi
}

main "$@"