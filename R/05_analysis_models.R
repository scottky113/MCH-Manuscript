# ==============================================================================
# 05_analysis_models.R
# Primary and adjusted regression models for the main research question.
# Choose the model family (lm/glm/svyglm) to match the outcome type, and swap
# in svyglm() whenever USE_SURVEY_DESIGN is TRUE.
# ==============================================================================

source(here::here("R", "00_config.R"))
pacman::p_load(survey, srvyr, broom, broom.helpers)

if (USE_SURVEY_DESIGN) {
  survey_design <- readr::read_rds(fs::path(path_processed, "03_survey_design.rds"))

  # TODO: replace with the real model(s), e.g.:
  # model_unadjusted <- survey::svyglm(outcome ~ exposure,
  #   design = survey_design, family = quasibinomial())
  # model_adjusted <- survey::svyglm(outcome ~ exposure + covariate1 + covariate2,
  #   design = survey_design, family = quasibinomial())

} else {
  df_analytic <- readr::read_rds(fs::path(path_processed, "03_analytic.rds"))

  # TODO: replace with the real model(s), e.g.:
  # model_unadjusted <- glm(outcome ~ exposure,
  #   data = df_analytic, family = binomial())
  # model_adjusted <- glm(outcome ~ exposure + covariate1 + covariate2,
  #   data = df_analytic, family = binomial())
}

# --- Tidy + export model results ---------------------------------------------
# model_table <- list(Unadjusted = model_unadjusted, Adjusted = model_adjusted) |>
#   purrr::map(~ broom::tidy(.x, exponentiate = TRUE, conf.int = TRUE)) |>
#   dplyr::bind_rows(.id = "model")
#
# readr::write_csv(model_table, fs::path(path_tables, "regression_results.csv"))

message("Fill in 05_analysis_models.R with the study's actual model specification(s).")
