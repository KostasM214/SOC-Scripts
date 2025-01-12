#!/bin/bash

# Extracts and counts the failed SSH login attempts from a log file

# Log file should be placed in the user's "Downloads" folder

# Defining the log file
LOG_FILE="$HOME/Downloads/auth.log"

# Check if the log file exists
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

# Extract failed login attempts
echo "Failed SSH login attempts:"
# sort -nr sorts by frequency
grep "Failed password" "$LOG_FILE" | awk '{print $1, $2, $3, $11}' | sort | uniq -c | sort -nr