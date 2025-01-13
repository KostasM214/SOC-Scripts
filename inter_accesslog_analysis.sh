#!/bin/bash

# Interactive Log Analysis Script

# NOTICE: SCRIPT MIGHT NEED ADJUSTMENTS BASED ON THE LOG FORMAT YOU NEED TO ANALIZE
# Default log file path is Downloads. The user can pass the log file path as an argument.
LOG_FILE="$HOME/Downloads/access_log"

# Check if the log file exists
if [[ ! -f "$LOG_FILE" ]]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

# Flag to indicate if the user wants to exit
exit_script=false

# Function to prompt the user to select which analysis should run
ask_user() {
    while true; do
        read -p "$1 (y/n/x to exit): " choice
        case "$choice" in
            y|Y ) return 0 ;;  # User said yes
            n|N ) return 1 ;;  # User said no
            x|X ) 
                echo "Exiting script."
                exit_script=true
                return 0 ;;
            * ) echo "Please answer y, n, or x." ;;
        esac
    done
}

echo "Welcome to the Interactive Log Analysis Script!"

# Prompt for each analysis

# Provides a list of HTTP Status Codes. Eliminates non-standard codes that could occur from malformed packets. Contains counter of occurrences and sorted Desc
if ask_user "Analyze HTTP Status Codes?"; then
    if $exit_script; then exit 0; fi
    echo "HTTP Status Code Analysis:"
    awk '{print $9}' "$LOG_FILE" | grep -E '^[0-9]{3}$' | sort | uniq -c | sort -nr
    echo
fi

# Provides a list of the Top 10 IPs that accessed the server.
# Change number of IP results by altering <head [-num]>
if ask_user "Display Top 10 IPs Accessing the Server?"; then
    if $exit_script; then exit 0; fi
    echo "Top 10 IPs Accessing the Server:"
    awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -10
    echo
fi

# Provides a list of the top 10 Requested URLs.
# Change number of URL results by altering <head [-num]>
if ask_user "Display Top 10 Requested URLs?"; then
    if $exit_script; then exit 0; fi
    echo "Top 10 Requested URLs:"
    awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -10
    echo
fi

# Provides a list of the top 10 User-Agent strings.
# Change number of User-Agent String results by altering <head [-num]>
if ask_user "Analyze Most Common User-Agent Strings?"; then
    if $exit_script; then exit 0; fi
    echo "Most Common User-Agent Strings:"
    awk -F\" '{print $6}' "$LOG_FILE"  | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sort | uniq -c | sort -nr | head -10
    echo
fi

# Provides a list of the top 10 HTTP Methods.
if ask_user "Analyze HTTP Methods?"; then
    if $exit_script; then exit 0; fi
    echo "HTTP Methods Analysis:"
    awk '{print $6}' "$LOG_FILE" | tr -d '"' | sort | uniq -c | sort -nr
    echo
fi

# Provides a list of requests by hour. Example: 1337 21, there were 1337 requests on the 21st hour (9PM). Results sorted ascending per hour.
if ask_user "Display Requests by Hour?"; then
    if $exit_script; then exit 0; fi
    echo "Requests by Hour:"
    awk -F'[:[]' '{print $3}' "$LOG_FILE" | grep -E '^[0-9]{1,2}$' | sort -n | uniq -c
    echo
fi

# Provides a list of IPs with suspicious access patterns based on the resource requests. 
if ask_user "Check for Suspicious Access Patterns?"; then
    if $exit_script; then exit 0; fi
    echo "Suspicious Access Patterns:"
    grep -E "/(wp-admin|login|phpmyadmin)" "$LOG_FILE" | awk '{print $1}' | sort | uniq -c | sort -nr | head -10
    echo
fi

# Provides a list of the Top 10 referrers. 
if ask_user "Analyze Top Referrers?"; then
    if $exit_script; then exit 0; fi
    echo "Top Referrers:"
    awk -F\" '{print $4}' "$LOG_FILE" | grep -v '-' | sort | uniq -c | sort -nr | head -10
    echo
fi

# Provides a list of the Top 10 largest requests.
if ask_user "Display Large Requests?"; then
    if $exit_script; then exit 0; fi
    echo "Large Requests:"
    awk '{print $10}' "$LOG_FILE" | sort -nr | head -10
    echo
fi

# Counts Error Codes (4xx,5xx) and provides a list of how many occurrences are found for each
if ask_user "Analyze Error Trends (4xx and 5xx)?"; then
    if $exit_script; then exit 0; fi
    echo "Error Trends (4xx and 5xx):"
    awk '{print $9}' "$LOG_FILE" | grep -E '^(4|5)[0-9]{2}$' | sort | uniq -c | sort -nr
    echo
fi

# Provides a list of the Top 10 IPs that encountered the most error codes (4xx,5xx)
if ask_user "Identify IPs with Frequent Errors?"; then
    if $exit_script; then exit 0; fi
    echo "IPs with Frequent Errors:"
    awk '{if ($9 ~ /^(4|5)/) print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -10
    echo
fi

echo "Analysis complete! Thank you for using this script."
echo "Git@KostasM214"
