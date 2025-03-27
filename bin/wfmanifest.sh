#!/bin/bash

# Run the command and capture the output
output=$(shortcuts list --show-identifiers | sort)

# Initialize JSON array
echo "["

# Loop through each line of the output
first_item=true
while IFS= read -r line; do
  # Use regex to capture the name and UUID separately
  if [[ "$line" =~ ^(.*)\ \((.*)\)$ ]]; then
    name="${BASH_REMATCH[1]}"
    identifier="${BASH_REMATCH[2]}"
    
    # Add a comma before each item except the first
    if [ "$first_item" = false ]; then
      echo ","
    fi
    first_item=false
    
    # Output as JSON object
    echo "  {"
    echo "    \"name\": \"$name\","
    echo "    \"identifier\": \"$identifier\""
    echo -n "  }"
  fi
done <<< "$output"

# Close JSON array
echo
echo "]"