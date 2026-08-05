# ==============================================================================
# 03_derive_variables.R
# Derive exposure, outcome, and covariate variables, and (if applicable)
# build the survey design object used by the downstream table/model scripts.
# ==============================================================================

source(here::here("R", "00_config.R"))

df <- readr::read_rds(fs::path(path_processed, "02_clean.rds"))

df_analytic <- df |>
  mutate(
    # TODO: exposure(s) of interest
    # exposure = ...,

    # TODO: primary outcome
    # outcome = ...,

    # TODO: covariates for adjusted models
    # covariate1 = ...,
  )

readr::write_rds(df_analytic, fs::path(path_processed, "03_analytic.rds"))

# --- Survey design object (used by 04/05 when USE_SURVEY_DESIGN is TRUE) ----
# NSCH: no PSU/cluster variable (ids = 1), strata = fipsst + stratum, nest =
# TRUE because stratum values repeat across states.
if (USE_SURVEY_DESIGN) {
  survey_design <- df_analytic |>
    srvyr::as_survey_design(
      ids     = 1,
      strata  = tidyselect::all_of(survey_vars$strata),
      weights = tidyselect::all_of(survey_vars$weights),
      nest    = TRUE
    )
  readr::write_rds(survey_design, fs::path(path_processed, "03_survey_design.rds"))
}

message("Analytic dataset ready: ", nrow(df_analytic), " rows x ", ncol(df_analytic), " cols")
