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
if (USE_SURVEY_DESIGN) {
  survey_design <- df_analytic |>
    srvyr::as_survey_design(
      weights = !!survey_vars$weights,
      strata  = !!survey_vars$strata,
      ids     = !!survey_vars$ids,
      nest    = TRUE
    )
  readr::write_rds(survey_design, fs::path(path_processed, "03_survey_design.rds"))
}

message("Analytic dataset ready: ", nrow(df_analytic), " rows x ", ncol(df_analytic), " cols")
