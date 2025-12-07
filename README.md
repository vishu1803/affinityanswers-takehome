# 📁 Affinity Answers – Take-Home Assignment  
This repository contains solutions for all three required tasks:

1. **Python Web Scraper – OLX Car Cover Search**  
2. **SQL Queries – Rfam Public MySQL Database**  
3. **Shell Script – AMFI NAV Extraction**  

Each task is placed in its own dedicated folder with source code, documentation, and required outputs.

---
```
# 📂 Repository Structure

assignment12/
│
├── q1_olx_scraper/ # Task 1: Python web scraping
│ ├── scrape_car_cover.py
│ ├── requirements.txt
│ ├── README.md
│ └── .gitignore
│
├── q2_rfam_sql/ # Task 2: SQL queries on Rfam public DB
│ ├── rfam_queries.sql
│ ├── README.md
│ └── .gitignore
│
└── q3_amfi_shell/ # Task 3: Shell script for AMFI NAVAll.txt
├── nav_extract.sh
├── README.md
└── .gitignore
```
---

# ✅ Task 1 – OLX Car Cover Scraper (Python + Selenium)

**Folder:** `q1_olx_scraper/`

The goal was to extract **live search results** from:

https://www.olx.in/items/q-car-cover?isSearchCall=true


Because OLX loads listings dynamically using JavaScript, a standard `requests` scraper does not work.  
This solution uses:

- **Selenium + Headless Chrome**
- Automatic ChromeDriver download
- Structured extraction of:
  - Title  
  - Price  
  - Location (used as description)

The script then prints a clean table of results.

➡️ See `q1_olx_scraper/README.md` for running instructions and explanation.

---

# ✅ Task 2 – Rfam SQL Queries (MySQL)

**Folder:** `q2_rfam_sql/`

Connected to the public Rfam MySQL DB using:

Host: mysql-rfam-public.ebi.ac.uk
Port: 4497
User: rfamro
Password: (none)
Database: Rfam

sql
Copy code

To connect:

```bash
mysql --user rfamro \
      --host mysql-rfam-public.ebi.ac.uk \
      --port 4497 \
      --database Rfam
Topics solved:

✔️ 2(a) Tiger Species
Counted distinct tiger types (Panthera tigris subspecies)

Returned the ncbi_id of the Sumatran Tiger (Panthera tigris sumatrae)

✔️ 2(b) Schema Join Columns
Documented all connecting fields between:
family, rfamseq, full_region, taxonomy, clan, clan_membership.

✔️ 2(c) Rice Species with Longest Sequence
Joined rfamseq + taxonomy to find the Oryza species with the largest DNA sequence.

✔️ 2(d) Paginated Longest-Sequence Families
Returned page 9 (15 items/page) for families with max_region_length > 1,000,000.

➡️ All SQL queries are in: q2_rfam_sql/rfam_queries.sql

✅ Task 3 – AMFI NAV Extractor (Shell Script)
Folder: q3_amfi_shell/

The script downloads:

arduino
Copy code
https://www.amfiindia.com/spages/NAVAll.txt
Steps:

Uses curl -sL to follow redirects (AMFI redirects to portal.amfiindia.com).

Parses the semicolon-separated file using awk.

Extracts only:

Scheme Name (4th field)

Net Asset Value (5th field)

Saves them to schemes.tsv in tab-separated format.

Run:

bash
Copy code
chmod +x nav_extract.sh
./nav_extract.sh
head schemes.tsv
➡️ Detailed explanation in: q3_amfi_shell/README.md

🚀 How to Run Everything
Task 1 – Python Scraper
bash
Copy code
cd q1_olx_scraper
python -m venv venv
source venv/Scripts/activate   # Windows Git Bash
pip install -r requirements.txt
python scrape_car_cover.py
Task 2 – Rfam MySQL
bash
Copy code
mysql -h mysql-rfam-public.ebi.ac.uk \
      -P 4497 \
      -u rfamro \
      --protocol=TCP \
      Rfam
Then paste queries from rfam_queries.sql.

Task 3 – Shell Script
bash
Copy code
cd q3_amfi_shell
chmod +x nav_extract.sh
./nav_extract.sh
📝 Notes
Each task has its own README with detailed explanation.

Code is clean, modular, and documented.

All tasks follow a professional repository structure suitable for review.
