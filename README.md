📁 Assignment – Affinity Answers Take-Home Tasks

This repository contains solutions for the three tasks required in the Affinity Answers recruitment assignment:

Python Web Scraping (OLX Car Cover Search)

SQL Analysis using the Public Rfam MySQL Database

Shell Script (AMFI NAV Extraction)

Each task is organized into its own folder with code, documentation, and output files.

📂 Repository Structure
assignment12/
│
├── q1_olx_scraper/     # Task 1: Python web scraping
│   ├── scrape_car_cover.py
│   ├── requirements.txt
│   ├── README.md
│   └── .gitignore
│
├── q2_rfam_sql/        # Task 2: SQL queries on Rfam public database
│   ├── rfam_queries.sql
│   ├── README.md
│   └── .gitignore
│
└── q3_amfi_shell/      # Task 3: Shell script for AMFI NAVAll.txt
    ├── nav_extract.sh
    ├── README.md
    └── .gitignore

✅ Task 1 – OLX Car Cover Scraper (Python + Selenium)

Location: q1_olx_scraper/

The goal was to extract live search results from the OLX page:

https://www.olx.in/items/q-car-cover?isSearchCall=true


Since OLX loads all listings via JavaScript, a normal requests.get() cannot scrape the ads.

To solve this:

A headless Chrome browser (Selenium) is used.

It loads the page like a real user.

Waits for elements such as:

li[data-aut-id="itemBox"]


Extracts:

Title (data-aut-id="itemTitle")

Price (data-aut-id="itemPrice")

Location (used as description)

Prints the results in a Markdown-style table.

See detailed explanation and running instructions in
➡️ q1_olx_scraper/README.md

✅ Task 2 – Rfam SQL Queries (MySQL)

Location: q2_rfam_sql/

Connected to the public Rfam MySQL database at:

Host: mysql-rfam-public.ebi.ac.uk
Port: 4497
User: rfamro
Database: Rfam
Password: (none)


Topics solved:

✔️ (2a) Tiger taxonomy

Count tiger types (Panthera tigris subspecies)

Retrieve ncbi_id for Sumatran Tiger (Panthera tigris sumatrae)

✔️ (2b) Schema join columns

Documented all foreign key relationships between:

taxonomy

rfamseq

full_region

family

clan

clan_membership

✔️ (2c) Rice species with the longest DNA sequence

Using joins between rfamseq and taxonomy.

✔️ (2d) Paginated query

Produces the 9th page (15 rows per page) of families whose longest region > 1,000,000 nt, using:

LIMIT 15 OFFSET 120


All SQL queries are fully documented in
➡️ q2_rfam_sql/rfam_queries.sql

✅ Task 3 – AMFI NAV Extractor (Shell Script)

Location: q3_amfi_shell/

The goal was to download:

https://www.amfiindia.com/spages/NAVAll.txt


Which contains semicolon-separated NAV rows.

The script:

Downloads the file using curl -sL (follows redirect automatically)

Uses awk -F ';' to extract only:

Scheme Name (column 4)

Net Asset Value (column 5)

Outputs a clean TSV file: schemes.tsv

The script is fully documented in
➡️ q3_amfi_shell/README.md

🚀 How to Run Everything
Install Python Dependencies (Task 1)
cd q1_olx_scraper
python -m venv venv
source venv/Scripts/activate      # Windows Git Bash
pip install -r requirements.txt
python scrape_car_cover.py

Run SQL Queries (Task 2)
mysql -h mysql-rfam-public.ebi.ac.uk \
      -P 4497 \
      -u rfamro \
      --protocol=TCP \
      Rfam


Then copy–paste queries from rfam_queries.sql.

Run Shell Script (Task 3)
cd q3_amfi_shell
chmod +x nav_extract.sh
./nav_extract.sh
head schemes.tsv

📝 Notes

Each task is self-contained with its own README.

Code is clean, documented, and reproducible.

The repository mimics a professional engineering assignment structure.