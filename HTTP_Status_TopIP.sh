#!/bin/bash

# Count HTTP Status Codes in Access Logs

# Log file should be placed in the user's "Downloads" folder
LOG_FILE="$HOME/Downloads/access.log"

# Check if the log file exists
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

# Extract HTTP Status Codes
echo "HTTP Status Code Analysis:"
# sort -nr sorts by frequency, greps only 3-digit results and discards others
awk '{print $9}' "$LOG_FILE" | grep -E '^[0-9]{3}$' | sort | uniq -c | sort -nr

# Extracts the Top 10 IPs accessing the server.
# Adjust head value for more/less TOP IPs
echo "Top 10 IPs Accessing the Server:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -10