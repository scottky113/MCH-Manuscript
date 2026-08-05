# data/raw/

Place the downloaded NSCH data file(s) here, untouched.

This folder is git-ignored (see `.gitignore`) — NSCH files are large and
redistributed by the Census Bureau, so they should not be committed.

- **Source:** National Survey of Children's Health (NSCH), U.S. Census Bureau
- **Download:** https://www.census.gov/programs-surveys/nsch/data/datasets.html
- **File to download:** the **Topical** data file (contains the survey items
  and the analysis weight `FWC`) in **SAS (.sas7bdat)** or **Stata (.dta)**
  format for each year needed
- **Typical file name:** `nsch_<year>_topical.sas7bdat` or
  `nsch_<year>_topical.dta` (e.g. `nsch_2023_topical.dta`); some years are
  suffixed `e` for a corrected re-release (e.g. `nsch_2022e_topical.dta`)
- **Codebook/documentation:**
  https://www.census.gov/programs-surveys/nsch/technical-documentation.html

`R/01_import_data.R` looks for `.sas7bdat`/`.dta` files in this folder
(preferring ones with "topical" in the name), reads whichever format is
present, and stacks multiple years into one data frame if more than one is
provided.
