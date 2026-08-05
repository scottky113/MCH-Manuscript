# ==============================================================================
# 01_import_data.R
# Import the raw secondary-data file from data/raw/ and cache an untouched
# copy in data/processed/ as .rds for fast reload in later scripts.
#
# Public-use secondary data commonly ships as .csv, .sas7bdat, .xpt (SAS
# transport), .dta (Stata), or .sav (SPSS); haven::read_*() handles all of
# these. Trim the branches you don't need once the source format is known.
# ==============================================================================

source(here::here("R", "00_config.R"))

raw_file <- fs::dir_ls(path_raw, regexp = "\\.(csv|sas7bdat|xpt|dta|sav)$")

if (length(raw_file) == 0) {
  stop(
    "No raw data file found in data/raw/. Place the downloaded public-use ",
    "file there (e.g., data/raw/dataset.csv) before running this script."
  )
}
if (length(raw_file) > 1) {
  message("Multiple raw files found; using the first: ", raw_file[1])
}
raw_file <- raw_file[1]

df_raw <- switch(
  tolower(fs::path_ext(raw_file)),
  csv      = readr::read_csv(raw_file, guess_max = 10000),
  sas7bdat = haven::read_sas(raw_file),
  xpt      = haven::read_xpt(raw_file),
  dta      = haven::read_dta(raw_file),
  sav      = haven::read_sav(raw_file),
  stop("Unrecognized file extension for: ", raw_file)
)

df_raw <- df_raw |> janitor::clean_names()

readr::write_rds(df_raw, fs::path(path_processed, "01_raw_imported.rds"))

message(
  "Imported ", nrow(df_raw), " rows x ", ncol(df_raw),
  " cols from ", fs::path_file(raw_file)
)
