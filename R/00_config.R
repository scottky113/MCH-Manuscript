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
# Set TRUE for datasets that require weighted estimation (e.g., NSCH, NHANES,
# NHIS, PRAMS, BRFSS). Set FALSE for a simple random sample / unweighted
# extract. Fill in the real weight/strata/cluster variable names once known —
# 03_derive_variables.R uses these to build the survey design object.
USE_SURVEY_DESIGN <- FALSE

survey_vars <- list(
  weights = "PLACEHOLDER_WEIGHT_VAR",
  strata  = "PLACEHOLDER_STRATA_VAR",
  ids     = "PLACEHOLDER_CLUSTER_VAR"   # PSU/cluster id; use ~1 if none
)

# --- Reproducibility ---------------------------------------------------------
set.seed(2026)
options(scipen = 999) # avoid scientific notation in printed/exported tables
