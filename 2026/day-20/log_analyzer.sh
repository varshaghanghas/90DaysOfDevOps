#!/bin/bash

# Task 1: Input and Validation
if [ "$#" -eq 0 ]; then
    echo "Error: No log file provided." >&2
    echo "Usage: $0 <path_to_log_file>" >&2
    exit 1
fi

LOG_FILE="$1"

# check if logfile exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' does not exist." >&2
    exit 1
fi

# Variables for processing
DATE=$(date +%Y-%m-%d_%H-%M-%S)
REPORT_FILE="/var/log/syslog/log_report_${DATE}.txt"
ARCHIVE_DIR="/var/log/syslog/archive"



# Task 2: Error Count (Matches "ERROR" or "Failed" case-insensitively) start
ERROR_COUNT=$(grep -ci -E "error|failed" "$LOG_FILE")

# Print the total error count to the console
echo "Total error count: $ERROR_COUNT"
# Task 2: Error Count (Matches "ERROR" or "Failed" case-insensitively) end



# Task 3: Critical Events start
echo ""
echo "--- Critical Events ---"
# grep -n includes line numbers (format: line_num:line_content)
# awk transforms "84:content" into "Line 84: content"
grep -n -i "critical" "$LOG_FILE" | awk -F: '{line=$1; $1=""; print "Line " line ":" $0}'
# Task 3: Critical Events end


# Task 4: Top Error Messages start
echo ""
echo "--- Top 5 Error Messages ---"
# 1. grep -i "error": Extracts lines containing "ERROR"
# 2. sed: Strips typical timestamps/log prefixes (adjust pattern if logs use a specific format)
# 3. sort: Groups identical messages together
# 4. uniq -c: Counts occurrences of each unique message
# 5. sort -rn: Sorts numerically (-n) in reverse/descending (-r) order
# 6. head -n 5: Limits output to top 5 results
grep -i "error" "$LOG_FILE" | \
    sed -E 's/^([^[:alpha:]]*|[0-9 :-]*|\[[^]]*\][[:space:]]*)//g' | \
    sort | uniq -c | sort -rn | head -n 5
# Task 4: Top Error Messages end


# Analyze log events
TOTAL_LINES=$(wc -l < "$LOG_FILE")
ERROR_COUNTS=$(grep -ci "error" "$LOG_FILE")
CRITICAL_COUNT=$(grep -ci "critical" "$LOG_FILE")



# Task 5: CReate report summary start
# Generate the Summary Report
{
    echo "=================================================="
    echo "      Daily System Log Summary Report             "
    echo "=================================================="
    echo "Date of Report:     $DATE"
    echo "Analyzed Log File:  $LOG_FILE"
    echo "--------------------------------------------------"
    echo "Total lines processed:      $TOTAL_LINES"
    echo "Total ERROR messages found: $ERROR_COUNTS"
    echo "Total CRITICAL messages:    $CRITICAL_COUNT"
    echo "--------------------------------------------------"
    echo "Top 5 CRITICAL/ERROR events (if any):"
    grep -i -E "error|critical" "$LOG_FILE" | head -n 5
    echo "=================================================="
} > "$REPORT_FILE"

echo "Summary report successfully generated: $REPORT_FILE"
# Task 5: CReate report summary end


# task 6: archive processed logs
if [ ! -d "$ARCHIVE_DIR" ]; then
    mkdir -p "$ARCHIVE_DIR"
fi

# Move the processed file and print a confirmation message
mv "$LOG_FILE" "$ARCHIVE_DIR/"
echo "Processed log file successfully $LOG_FILE moved to '$ARCHIVE_DIR/'"

# task 6: archive processed end

