#!/usr/bin/env bash

URL="https://www.amfiindia.com/spages/NAVAll.txt"
OUTFILE="schemes.tsv"

curl -sL "$URL" | awk -F ';' '
BEGIN {
    # TSV header
    print "Scheme Name\tNet Asset Value"
}
NR == 1 {
    # Skip original header line
    next
}
NF < 6 {
    # Skip blank lines, headings, AMC names, etc.
    next
}
{
    scheme = $4
    nav    = $5

    # Trim spaces
    gsub(/^[ \t]+|[ \t]+$/, "", scheme)
    gsub(/^[ \t]+|[ \t]+$/, "", nav)

    print scheme "\t" nav
}
' > "$OUTFILE"

echo "Saved scheme names and NAVs to $OUTFILE"
