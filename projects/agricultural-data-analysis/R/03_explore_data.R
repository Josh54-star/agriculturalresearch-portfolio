# 03_explore_data.R
# Exploratory analysis and summary statistics.

library(dplyr)
library(ggplot2)

input_file <- "projects/agricultural-data-analysis/data/agricultural_clean.csv"

farm_data <- read.csv(input_file, stringsAsFactors = FALSE)

# Overall descriptive statistics
summary_stats <- farm_data %>%
  summarise(
    observations = n(),
    farms = n_distinct(farm_id),
    mean_farm_size_ha = mean(farm_size_ha),
    mean_yield_t_ha = mean(maize_yield_t_ha),
    median_yield_t_ha = median(maize_yield_t_ha),
    mean_income_kes = mean(gross_farm_income_kes),
    extension_contact_rate = mean(extension_contact),
    improved_seed_rate = mean(improved_seed)
  )

print(summary_stats)

# County-level production summary
county_summary <- farm_data %>%
  group_by(county) %>%
  summarise(
    observations = n(),
    mean_yield_t_ha = mean(maize_yield_t_ha),
    mean_income_kes = mean(gross_farm_income_kes),
    .groups = "drop"
  ) %>%
  arrange(desc(mean_yield_t_ha))

print(county_summary)

# Distribution of yield
p_yield <- ggplot(farm_data, aes(x = maize_yield_t_ha)) +
  geom_histogram(bins = 30) +
  labs(
    title = "Distribution of Maize Yield",
    x = "Maize yield (tonnes/ha)",
    y = "Number of farm-year observations"
  ) +
  theme_minimal()

ggsave(
  "projects/agricultural-data-analysis/outputs/yield_distribution.png",
  p_yield, width = 8, height = 5, dpi = 300
)

# Yield by county
p_county <- ggplot(farm_data, aes(x = reorder(county, maize_yield_t_ha, FUN = median), y = maize_yield_t_ha)) +
  geom_boxplot() +
  coord_flip() +
  labs(
    title = "Maize Yield Distribution by County",
    x = "County",
    y = "Maize yield (tonnes/ha)"
  ) +
  theme_minimal()

ggsave(
  "projects/agricultural-data-analysis/outputs/yield_by_county.png",
  p_county, width = 8, height = 5, dpi = 300
)
