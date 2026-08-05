# Codebook notes

Working notes on the variables pulled from the NSCH codebook. Fill in as
decisions are made — this becomes the reference for what each variable in
`data/processed/03_analytic.rds` means and where it came from.

## Data source

- **Database/survey:** National Survey of Children's Health (NSCH), U.S. Census Bureau
- **Cycle/year(s):** _TBD — which year(s) of NSCH (2016+ redesign)_
- **Unit of analysis:** one child per sampled household
- **Complex survey design:** Yes — see `USE_SURVEY_DESIGN` / `survey_vars` in `R/00_config.R`
  - Weight: `fwc` (child-level analysis weight)
  - Strata: `fipsst` + `stratum`
  - Clusters/PSUs: none (NSCH selects at most one child per household)
- **Codebook:** https://www.census.gov/programs-surveys/nsch/technical-documentation.html

## Variables

| Analytic name | Source variable (NSCH) | Definition / coding | Notes |
|---|---|---|---|
| exposure | | | |
| outcome | | | |
| covariate1 | | | |

## Missing data codes

NSCH generally uses `90`/`95`/`96`/`99`-style codes (varies by item) for
"don't know," "refused," "not in universe," etc. — confirm per variable
against the year-specific codebook before recoding to `NA`.

| Source variable | Sentinel value(s) | Meaning |
|---|---|---|
| | | |

## Inclusion / exclusion criteria

1. _TBD_

## Notes on pooling multiple NSCH years

Question wording, response options, and variable names can change between
NSCH cycles. If combining years in `data/raw/`, check the year-specific
codebooks for any variable that changed before treating it as consistent
across `nsch_year`.
