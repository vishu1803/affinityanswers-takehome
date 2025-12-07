# Q2 – Rfam SQL Exercises

This folder contains SQL queries for interacting with the **public Rfam MySQL database**, as required in Task 2.

Rfam DB docs:  
https://docs.rfam.org/en/latest/database.html

Public DB connection:

- **Host:** `mysql-rfam-public.ebi.ac.uk`
- **Port:** `4497`
- **User:** `rfamro`
- **Password:** *(empty)*
- **Database:** `Rfam`

---

## How to Connect (MySQL CLI)

From a terminal:

```bash
mysql -h mysql-rfam-public.ebi.ac.uk \
      -P 4497 \
      -u rfamro \
      --protocol=TCP \
      Rfam
