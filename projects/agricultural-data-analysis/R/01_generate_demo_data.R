# 01_generate_demo_data.R
# Agricultural Research & Data Portfolio
# Purpose: create a reproducible synthetic dataset for demonstrating the workflow.

set.seed(20260821)

n_farms <- 500
years <- 2019:2024

farm_data <- expand.grid(
  farm_id = seq_len(n_farms),
  year = years
)

farm_data$county <- sample(
  c("Bungoma", "Trans Nzoia", "Kakamega", "Uasin Gishu", "Nakuru"),
  nrow(farm_data), replace = TRUE,
  prob = c(0.30, 0.18, 0.20, 0.17, 0.15)
)

farm_data$farm_size_ha <- round(pmax(rnorm(nrow(farm_data), 1.8, 0.9), 0.2), 2)
farm_data$rainfall_mm <- round(rnorm(nrow(farm_data), 1050, 180))
farm_data$fertilizer_kg_ha <- round(pmax(rnorm(nrow(farm_data), 65, 25), 0), 1)
farm_data$improved_seed <- rbinom(nrow(farm_data), 1, 0.58)
farm_data$extension_contact <- rbinom(nrow(farm_data), 1, 0.52)

# Synthetic production process: yield is generated from observable farm conditions.
farm_data$maize_yield_t_ha <- round(
  pmax(
    0.5 +
      0.0015 * farm_data$rainfall_mm +
      0.006 * farm_data$fertilizer_kg_ha +
      0.75 * farm_data$improved_seed +
      0.35 * farm_data$extension_contact +
      rnorm(nrow(farm_data), 0, 0.65),
    0.2
  ),
  2
)

farm_data$production_t <- round(farm_data$maize_yield_t_ha * farm_data$farm_size_ha, 2)

farm_data$gross_farm_income_kes <- round(
  pmax(
    farm_data$production_t * 30000 +
      farm_data$farm_size_ha * 18000 +
      rnorm(nrow(farm_data), 0, 25000),
    0
  )
)

write.csv(
  farm_data,
  "projects/agricultural-data-analysis/data/agricultural_demo.csv",
  row.names = FALSE
)

message("Created synthetic dataset with ", nrow(farm_data), " farm-year observations.")
