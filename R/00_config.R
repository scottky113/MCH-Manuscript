# ==============================================================================
# 00_config.R
# Project configuration: packages, paths, and analysis-wide settings.
# Every other script sources this file first.
# ==============================================================================

# --- Packages -----------------------------------------------------------------
if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")

pacman::p_load(
  here,          # portable file paths anchored at the project root
  fs,            # filesystem helpers (path building, file discovery)
  tidyverse,     # data wrangling + ggplot2
  janitor,       # clean_names(), tabyl()
  haven,         # read .sas7bdat / .xpt / .dta / .sav (common public-use formats)
  labelled,      # work with variable/value labels carried over from haven
  survey,        # complex survey design (weights/strata/clusters)
  srvyr,         # tidyverse-style wrapper around the survey package
  gtsummary,     # publication-ready summary/regression tables
  flextable,     # export gtsummary tables to Word
  broom,         # tidy model output
  broom.helpers  # tidy() support for svyglm and other complex models
)

# --- Paths ----------------------------------------------------------------
path_raw       <- here::here("data", "raw")
path_processed <- here::here("data", "processed")
path_tables    <- here::here("output", "tables")
path_figures   <- here::here("output", "figures")

# --- Survey design ----------------------------------------------------------
# NSCH is a complex sample, so weighted estimation is required. Per U.S.
# Census Bureau guidance for the redesigned (2016+) NSCH:
#   weight:  fwc               (child-level analysis weight)
#   strata:  fipsst + stratum  (state FIPS code combined with sampling stratum)
#   ids:     none — NSCH selects at most one child per household, so there is
#            no PSU/cluster variable (ids = 1 in as_survey_design(), below)
USE_SURVEY_DESIGN <- TRUE

survey_vars <- list(
  weights = "fwc",
  strata  = c("fipsst", "stratum")
)

# --- Reproducibility ---------------------------------------------------------
set.seed(2026)
options(scipen = 999) # avoid scientific notation in printed/exported tables
