# ==============================================================================
# 06_figures.R
# Manuscript figures. Save at publication-ready resolution (300+ dpi).
# ==============================================================================

source(here::here("R", "00_config.R"))

df_analytic <- readr::read_rds(fs::path(path_processed, "03_analytic.rds"))

# --- Example figure template --------------------------------------------------
# fig1 <- df_analytic |>
#   ggplot(aes(x = exposure, y = outcome)) +
#   geom_point(alpha = 0.5) +
#   geom_smooth(method = "lm") +
#   labs(x = "Exposure", y = "Outcome", title = "Figure 1.") +
#   theme_minimal(base_size = 12)
#
# ggsave(fs::path(path_figures, "figure1.png"), fig1, width = 7, height = 5, dpi = 300)

message("Add figure code to 06_figures.R; each figure should ggsave() to output/figures/.")
