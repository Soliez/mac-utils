#!/bin/bash

# Define the directory containing the .shortcut files
SHORTCUTS_DIR="$HOME/Library/Mobile Documents/iCloud~is~workflow~my~workflows/Documents/Backups/All Current Shortcuts"


# Define the directory containing the folders with the same names as the shortcuts
FOLDERS_DIR="$HOME/Library/Mobile Documents/iCloud~is~workflow~my~workflows/Documents"

# Loop through each .shortcut file in the SHORTCUTS_DIR
for file in "$SHORTCUTS_DIR"/*.shortcut; do
    # Extract the base name of the file (without the extension)
    basename=$(basename "$file" .shortcut)

    # Define the target directory based on the basename
    target_dir="$FOLDERS_DIR/$basename"

    # Check if the target directory exists
    if [ -d "$target_dir" ]; then
        # Move the .shortcut file to the target directory
        mv "$file" "$target_dir/"
        echo "Moved $file to $target_dir/"
    else
        echo "Directory $target_dir does not exist. Skipping $file."
    fi
done