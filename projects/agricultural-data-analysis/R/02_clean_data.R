# 02_clean_data.R
# Data audit, validation and transformation.

library(dplyr)

input_file <- "projects/agricultural-data-analysis/data/agricultural_demo.csv"
output_file <- "projects/agricultural-data-analysis/data/agricultural_clean.csv"

raw <- read.csv(input_file, stringsAsFactors = FALSE)

# Basic structural audit
stopifnot(nrow(raw) > 0)
stopifnot(!anyDuplicated(raw[c("farm_id", "year")]))

# Validate plausible ranges and create analysis-ready variables.
clean <- raw %>%
  mutate(
    county = trimws(county),
    year = as.integer(year),
    improved_seed = as.integer(improved_seed),
    extension_contact = as.integer(extension_contact),
    log_income = log1p(gross_farm_income_kes),
    yield_group = case_when(
      maize_yield_t_ha < 2 ~ "Low",
      maize_yield_t_ha < 4 ~ "Medium",
      TRUE ~ "High"
    )
  ) %>%
  filter(
    farm_size_ha > 0,
    rainfall_mm > 0,
    fertilizer_kg_ha >= 0,
    maize_yield_t_ha > 0,
    gross_farm_income_kes >= 0
  )

write.csv(clean, output_file, row.names = FALSE)

cat("Rows retained:", nrow(clean), "\n")
cat("Columns:", ncol(clean), "\n")
