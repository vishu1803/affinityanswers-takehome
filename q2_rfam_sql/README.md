# Q2 – Rfam SQL Exercises

This folder contains my SQL answers for the Rfam public MySQL database questions in Task 2.

Rfam provides a public **read-only MySQL database** with the latest data.  
Docs: https://docs.rfam.org/en/latest/database.html

---

## 🔌 Connection Details

Public MySQL DB:

- **Host:** mysql-rfam-public.ebi.ac.uk  
- **Port:** 4497  
- **User:** rfamro  
- **Password:** *(none)*  
- **Database:** Rfam  

Example connection from terminal:

```bash
mysql --user rfamro \
      --host mysql-rfam-public.ebi.ac.uk \
      --port 4497 \
      --database Rfam
