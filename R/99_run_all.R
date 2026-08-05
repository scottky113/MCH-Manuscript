# ==============================================================================
# 99_run_all.R
# Run the full pipeline end to end, in order. Convenience script only —
# each numbered script can also be sourced or run individually.
# ==============================================================================

source(here::here("R", "00_config.R"))
source(here::here("R", "01_import_data.R"))
source(here::here("R", "02_clean_data.R"))
source(here::here("R", "03_derive_variables.R"))
source(here::here("R", "04_table1_descriptives.R"))
source(here::here("R", "05_analysis_models.R"))
source(here::here("R", "06_figures.R"))

message("Pipeline complete. See output/tables/ and output/figures/ for results.")
