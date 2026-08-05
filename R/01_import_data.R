# ==============================================================================
# 01_import_data.R
# Import NSCH (National Survey of Children's Health) raw data file(s) from
# data/raw/ and cache a combined copy in data/processed/ as .rds.
#
# Source: U.S. Census Bureau NSCH data page
#   https://www.census.gov/programs-surveys/nsch/data/datasets.html
# Download the "Topical" data file (the one with survey content and the
# analysis weight FWC) in SAS (.sas7bdat) or Stata (.dta) format and place it
# in data/raw/ — either format is read automatically. To pool multiple
# survey years, drop each year's topical file in data/raw/; they are
# stacked into one data frame with a `nsch_year` column recording the
# source year (parsed from the file name, e.g. nsch_2022e_topical.dta).
# ==============================================================================

source(here::here("R", "00_config.R"))

all_raw_files <- fs::dir_ls(path_raw, regexp = "\\.(sas7bdat|dta)$")

if (length(all_raw_files) == 0) {
  stop(
    "No NSCH .sas7bdat or .dta file found in data/raw/. Download the ",
    "Topical data file (SAS or Stata format) from ",
    "https://www.census.gov/programs-surveys/nsch/data/datasets.html ",
    "and place it in data/raw/."
  )
}

# NSCH also distributes a separate "Screener" file; most secondary analyses
# only need the Topical file (it carries FWC and the survey items), so
# prefer files with "topical" in the name when present.
topical_files <- all_raw_files[grepl("topical", all_raw_files, ignore.case = TRUE)]
raw_files <- if (length(topical_files) > 0) topical_files else all_raw_files

if (length(topical_files) == 0) {
  message(
    "No file with 'topical' in its name was found in data/raw/; reading ",
    "all .sas7bdat/.dta files found there instead. A screener-only file ",
    "will not contain FWC or most analysis variables."
  )
}

read_nsch_file <- function(path) {
  df <- switch(
    tolower(fs::path_ext(path)),
    sas7bdat = haven::read_sas(path),
    dta      = haven::read_dta(path),
    stop("Unrecognized file extension for: ", path)
  )
  df |>
    janitor::clean_names() |>
    dplyr::mutate(nsch_year = readr::parse_number(fs::path_file(path)), .before = 1)
}

df_raw <- raw_files |>
  purrr::map(read_nsch_file) |>
  dplyr::bind_rows()

readr::write_rds(df_raw, fs::path(path_processed, "01_raw_imported.rds"))

message(
  "Imported ", nrow(df_raw), " rows x ", ncol(df_raw), " cols from ",
  length(raw_files), " file(s): ", paste(fs::path_file(raw_files), collapse = ", ")
)
