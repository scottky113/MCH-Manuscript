# ==============================================================================
# 04_table1_descriptives.R
# Table 1: sample characteristics, unweighted or survey-weighted depending on
# USE_SURVEY_DESIGN in 00_config.R.
# ==============================================================================

source(here::here("R", "00_config.R"))
pacman::p_load(survey, srvyr, gtsummary, flextable)

if (USE_SURVEY_DESIGN) {
  survey_design <- readr::read_rds(fs::path(path_processed, "03_survey_design.rds"))

  table1 <- survey_design |>
    gtsummary::tbl_svysummary(
      # include = c(exposure, covariate1, ...),
      statistic = list(
        gtsummary::all_continuous()  ~ "{mean} ({sd})",
        gtsummary::all_categorical() ~ "{n} ({p}%)"
      )
    )
} else {
  df_analytic <- readr::read_rds(fs::path(path_processed, "03_analytic.rds"))

  table1 <- df_analytic |>
    gtsummary::tbl_summary(
      # include = c(exposure, covariate1, ...),
      statistic = list(
        gtsummary::all_continuous()  ~ "{mean} ({sd})",
        gtsummary::all_categorical() ~ "{n} ({p}%)"
      )
    )
}

table1 |>
  gtsummary::as_flex_table() |>
  flextable::save_as_docx(path = fs::path(path_tables, "table1_descriptives.docx"))

readr::write_rds(table1, fs::path(path_tables, "table1_descriptives.rds"))

message("Table 1 written to output/tables/table1_descriptives.docx")
