#!/bin/bash


shortcuts run "Backup My Shortcuts"
current_date=$(date -I)
base_path="/Users/erik/Library/Mobile Documents/iCloud~is~workflow~my~workflows/Documents/Backups/"
file="${base_path}${current_date}.zip"
/opt/homebrew/bin/rclone copy "$file" Drive:/Shortcuts/Backups
/opt/homebrew/bin/rclone ls Drive:/Shortcuts/Backups
