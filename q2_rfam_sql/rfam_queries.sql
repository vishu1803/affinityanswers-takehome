-- rfam_queries.sql
-- SQL queries for Task 2 – Rfam public MySQL DB
-- Docs: https://docs.rfam.org/en/latest/database.html
-- DB:   mysql-rfam-public.ebi.ac.uk:4497, user: rfamro, db: Rfam

/* ============================================================
   2(a) How many types of tigers in the taxonomy table?
        What is the ncbi_id of the Sumatran Tiger?

   Hint from the assignment: use the biological name.
   In NCBI taxonomy, tigers are in the species/genus Panthera tigris.
   The Rfam taxonomy table has (among others):
     - ncbi_id
     - species        -- usually scientific name
     - tax_string     -- full taxonomy path

   STEP 1: Count distinct tiger taxa (types of tigers).
   (You can adjust the LIKE condition if you prefer matching common_name instead.)
============================================================ */
-- Count distinct species entries whose scientific name contains "Panthera tigris"
SELECT COUNT(DISTINCT species) AS tiger_type_count
FROM taxonomy
WHERE species LIKE '%Panthera tigris%';

-- Alternative (if you want to match common names instead of scientific name):
-- SELECT COUNT(*) AS tiger_type_count
-- FROM taxonomy
-- WHERE common_name LIKE '%tiger%';


/* STEP 2: Find the ncbi_id of the Sumatran Tiger.
   Sumatran tiger scientific name: "Panthera tigris sumatrae"
============================================================ */
SELECT ncbi_id, species
FROM taxonomy
WHERE species = 'Panthera tigris sumatrae';
-- After running this, note the ncbi_id value as your answer in README.md


/* ============================================================
   2(b) Find all the columns that can be used to connect the tables.

   This is more of a schema understanding question than a single query.
   The main “key” columns used to connect tables in Rfam are:

   - family.rfam_acc        <--> full_region.rfam_acc
   - full_region.rfamseq_acc <--> rfamseq.rfamseq_acc
   - rfamseq.ncbi_id        <--> taxonomy.ncbi_id
   - clan.rfam_acc          <--> clan_membership.rfam_acc
   - genome.upid            <--> genseq.upid
   - genseq.rfamseq_acc     <--> rfamseq.rfamseq_acc

   If you want to inspect the columns of each table directly, you can use:
============================================================ */

-- Example: describe main tables (run these manually in MySQL)
-- DESCRIBE family;
-- DESCRIBE rfamseq;
-- DESCRIBE full_region;
-- DESCRIBE taxonomy;
-- DESCRIBE clan;
-- DESCRIBE clan_membership;


/* ============================================================
   2(c) Which type of rice has the longest DNA sequence?

   Hint: use rfamseq and taxonomy tables.

   The rfamseq table typically has:
     - rfamseq_acc   -- accession / sequence identifier
     - ncbi_id       -- taxonomy id
     - length        -- sequence length (nucleotides)

   The taxonomy table has:
     - ncbi_id
     - species       -- scientific name (e.g. "Oryza sativa Japonica Group")
     - tax_string    -- full taxonomy path

   Strategy:
     1. Join rfamseq and taxonomy on ncbi_id.
     2. Restrict to rice species (e.g. Oryza genus).
     3. Order by length descending.
     4. Take the top row.

   Adjust the WHERE filter depending on what you consider "rice":
     - species LIKE 'Oryza %'      (scientific genus)
     - OR tax_string LIKE '%Oryza%'
============================================================ */
SELECT
    tx.species        AS rice_type,
    rf.rfamseq_acc    AS sequence_acc,
    rf.length         AS sequence_length
FROM rfamseq rf
JOIN taxonomy tx
  ON rf.ncbi_id = tx.ncbi_id
WHERE tx.species LIKE 'Oryza %'    -- restrict to genus Oryza (rice)
ORDER BY rf.length DESC
LIMIT 1;
-- The "rice_type" in this top row is your answer.
-- You can also inspect the top N:
-- ORDER BY rf.length DESC
-- LIMIT 10;


/* ============================================================
   2(d) Paginated list of families and their longest DNA sequence lengths
        (descending by length), including ONLY families whose longest
        DNA sequence length > 1,000,000.

   We want:
     - family accession ID (rfam_acc)
     - family name (rfam_id)
     - maximum length

   Interpretation:
     "longest DNA sequence length" per family can be taken as the
     longest annotated region among all sequences in full_region
     for that family:

       region_length = seq_end - seq_start + 1

   We then:
     - join family + full_region (+ rfamseq if needed)
     - group by family
     - compute MAX(region_length)
     - keep families whose max length > 1,000,000
     - sort by max length descending
     - paginate: 15 results per page
       -> Page 1 : LIMIT 15 OFFSET 0
       -> Page 2 : LIMIT 15 OFFSET 15
       ...
       -> Page 9 : LIMIT 15 OFFSET 15 * (9-1) = 120

============================================================ */

-- Core aggregation (without pagination):
SELECT
    f.rfam_acc,
    f.rfam_id,
    MAX(fr.seq_end - fr.seq_start + 1) AS max_region_length
FROM family f
JOIN full_region fr
  ON f.rfam_acc = fr.rfam_acc
-- (optionally join rfamseq rf ON rf.rfamseq_acc = fr.rfamseq_acc
--  if you need more sequence details)
GROUP BY
    f.rfam_acc,
    f.rfam_id
HAVING
    max_region_length > 1000000
ORDER BY
    max_region_length DESC;


-- Paginated version: 9th page, 15 results per page.
-- OFFSET = 15 * (9 - 1) = 120
SELECT
    f.rfam_acc,
    f.rfam_id,
    MAX(fr.seq_end - fr.seq_start + 1) AS max_region_length
FROM family f
JOIN full_region fr
  ON f.rfam_acc = fr.rfam_acc
GROUP BY
    f.rfam_acc,
    f.rfam_id
HAVING
    max_region_length > 1000000
ORDER BY
    max_region_length DESC
LIMIT 15
OFFSET 120;
-- The rows returned here constitute "page 9" of the result set.
