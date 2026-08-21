# 04_model.R
# Applied regression analysis.
# IMPORTANT: This is a demonstration using synthetic data.

library(dplyr)

input_file <- "projects/agricultural-data-analysis/data/agricultural_clean.csv"
farm_data <- read.csv(input_file, stringsAsFactors = FALSE)

# Baseline linear model for agricultural productivity.
# Outcome: maize yield (tonnes/ha)
# Predictors: rainfall, fertilizer use, improved seed, extension contact and farm size.
model_yield <- lm(
  maize_yield_t_ha ~ rainfall_mm + fertilizer_kg_ha + improved_seed +
    extension_contact + farm_size_ha,
  data = farm_data
)

print(summary(model_yield))

# A second model examines gross farm income on a log scale.
model_income <- lm(
  log_income ~ maize_yield_t_ha + farm_size_ha + improved_seed +
    extension_contact,
  data = farm_data
)

print(summary(model_income))

# Save model summaries for documentation.
model_output <- capture.output({
  cat("MODEL 1: MAIZE YIELD\n")
  print(summary(model_yield))
  cat("\nMODEL 2: LOG GROSS FARM INCOME\n")
  print(summary(model_income))
})

writeLines(
  model_output,
  "projects/agricultural-data-analysis/outputs/model_summary.txt"
)
