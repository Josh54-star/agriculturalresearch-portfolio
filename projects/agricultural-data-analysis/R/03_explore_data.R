# 03_explore_data.R
# Descriptive analysis and visualization of Kenya maize yield.

library(dplyr)
library(ggplot2)
library(readr)

df <- read_csv("projects/agricultural-data-analysis/data/agricultural_clean.csv", show_col_types = FALSE)
dir.create("projects/agricultural-data-analysis/outputs/figures", recursive = TRUE, showWarnings = FALSE)
dir.create("projects/agricultural-data-analysis/outputs/tables", recursive = TRUE, showWarnings = FALSE)

summary_stats <- df %>%
  summarise(
    n = n(),
    start_year = min(year),
    end_year = max(year),
    mean_yield_kg_ha = mean(maize_yield_kg_ha),
    median_yield_kg_ha = median(maize_yield_kg_ha),
    min_yield_kg_ha = min(maize_yield_kg_ha),
    max_yield_kg_ha = max(maize_yield_kg_ha),
    sd_yield_kg_ha = sd(maize_yield_kg_ha)
  )
write_csv(summary_stats, "projects/agricultural-data-analysis/outputs/tables/summary_statistics.csv")

decade_summary <- df %>%
  group_by(decade) %>%
  summarise(
    mean_yield_kg_ha = mean(maize_yield_kg_ha),
    min_yield_kg_ha = min(maize_yield_kg_ha),
    max_yield_kg_ha = max(maize_yield_kg_ha),
    sd_yield_kg_ha = sd(maize_yield_kg_ha),
    n = n(),
    .groups = "drop"
  )
write_csv(decade_summary, "projects/agricultural-data-analysis/outputs/tables/decade_summary.csv")

p <- ggplot(df, aes(year, maize_yield_kg_ha)) +
  geom_line() +
  geom_point(size = 1.5) +
  labs(
    title = "Kenya maize yield, 1960–2011",
    x = "Year",
    y = "Maize yield (kg/ha)"
  ) +
  theme_minimal()

ggsave("projects/agricultural-data-analysis/outputs/figures/maize_yield_trend.png", p, width = 9, height = 5.5, dpi = 300)

cat("Exploratory analysis completed.\n")
