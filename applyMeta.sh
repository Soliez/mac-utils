#!/bin/bash


show_usage() {
	echo "Usage: $0 <target-file> <metadata-template>"
}


if [ $# -lt 2 ]; then
	show_usage
	exit 1
else
	target="$1"
	template="$2"
fi


exiftool "$target" -overwrite_original -json="$template"


if [ $? -ne 0 ]; then
	printf 'Error: Template application unsuccessful\n'
else
	unlink "$template"
fi
