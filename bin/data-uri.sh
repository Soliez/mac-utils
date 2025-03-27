#!/bin/bash


if [ $# -eq 0 ];then
    echo "usage: data-uri <file>"
    exit 1
fi

mimetype=$(file -bN --mime-type "$1")

content=$(base64 < "$1")

echo "data:$mimetype;base64,$content"