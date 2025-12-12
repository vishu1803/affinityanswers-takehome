# AMFI NAV Extractor (Shell Script)

This script downloads the latest `NAVAll.txt` file from AMFI and extracts only the **Scheme Name** and **Net Asset Value** columns into a **TSV** file.

## Files

- `nav_extract.sh` – main shell script
- `schemes.tsv` – output file (generated)

## How to Run

From this directory:

```bash
chmod +x nav_extract.sh    # first time only
./nav_extract.sh
```

Method

The source file, NAVAll.txt, is a text document with the header:

Scheme Name; Net Asset Value; Date; ISIN Div Reinvestment; ISIN Div Payout/ISIN Growth; Scheme Code

Curl -sL is used to:

Get the file at https://www.amfiindia.com/spages/NAVAll.txt.

Go to https://portal.amfiindia.com/spages/NAVAll.txt after the redirect.

The response is piped into awk using -F ';' and:

Ignore the first line, which is the header.

AMC names, section headings, and blank lines are examples of lines with fewer than six fields.

Print the fourth field (Scheme Name) and fifth field (Net Asset Value) as tab-separated for rows of valid data.


JSON vs. TSV (Thoughts)

 For this type of bulk numerical/tabular data, TSV is effective:

 Small and simple to use with Excel or pandas as well as shell tools (awk, cut, etc.).

 Easy to append and stream.

 JSON would be helpful if

 A more complex, nested structure was required (e.g., grouping schemes by AMC, adding metadata).

 Web APIs and frontends that expected JSON were the main consumers.

 TSV/CSV works well for a simple daily NAV dump.  If the file develops into a more complicated API-style dataset, JSON might be a better option.
