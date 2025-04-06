#!/bin/bash


interactive_prompt() {
  local input
  read -p "Enter the path to an apple encrypted archive or Shortcut file: " input
  echo "$input"
}


main() {
  local input
  local flag

  if [ $# -gt 0 ]; then
    input="$1"
  else
    if [ ! -t 0 ]; then
      input=$(cat -)
    else
      input=$(interactive_prompt)
    fi
  fi

  if [[ -z "$input" ]]; then
    echo "No valid input provided. Exiting."
    exit 1
  fi

  aea id -i "$input"
}

main "$@"
