#!/bin/bash

current_date=$(date -I)
file="${current_date}.txt"
cat .bash_history >> "$file"
/opt/homebrew/bin/rclone copy "$file" Drive:/Developer/Bash/History
/opt/homebrew/bin/rclone ls Drive:/Developer/Bash/History
unlink "$file"
