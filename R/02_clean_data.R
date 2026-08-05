# ==============================================================================
# 02_clean_data.R
# Recode missing-data sentinels, set variable types, and apply the study's
# inclusion/exclusion criteria. Produces the analytic sample used downstream.
# ==============================================================================

source(here::here("R", "00_config.R"))

df_raw <- readr::read_rds(fs::path(path_processed, "01_raw_imported.rds"))

df_clean <- df_raw |>
  # TODO: recode dataset-specific missing-data codes (e.g., 7/8/9, 77/88/99,
  # -9) to NA before any analysis, e.g.:
  # mutate(across(c(var1, var2), ~ na_if(., 99))) |>

  # TODO: apply eligibility / inclusion-exclusion criteria, e.g.:
  # filter(age_years >= 0, age_years <= 17) |>

  identity()

# --- Document the analytic sample flow (useful for a STROBE-style diagram) --
sample_flow <- tibble::tibble(step = "Raw import", n = nrow(df_raw)) |>
  dplyr::add_row(step = "After cleaning/eligibility criteria", n = nrow(df_clean))

readr::write_csv(sample_flow, fs::path(path_tables, "sample_flow.csv"))
readr::write_rds(df_clean, fs::path(path_processed, "02_clean.rds"))

message("Analytic sample: ", nrow(df_clean), " rows retained of ", nrow(df_raw), " raw rows")
