# 02_clean_data.R
# Data audit and transformation for the real public dataset.

library(dplyr)
library(readr)

input_file <- "projects/agricultural-data-analysis/data/agricultural_real_raw.csv"
output_file <- "projects/agricultural-data-analysis/data/agricultural_clean.csv"

raw <- read_csv(input_file, show_col_types = FALSE)

stopifnot(nrow(raw) > 0)
stopifnot(!anyDuplicated(raw$year))
stopifnot(all(raw$year == as.integer(raw$year)))
stopifnot(all(raw$maize_yield_kg_ha > 0))

clean <- raw %>%
  arrange(year) %>%
  mutate(
    year = as.integer(year),
    decade = paste0(floor(year / 10) * 10, "s")
  )

write_csv(clean, output_file)
cat("Rows retained:", nrow(clean), "\n")
cat("Years:", min(clean$year), "-", max(clean$year), "\n")
