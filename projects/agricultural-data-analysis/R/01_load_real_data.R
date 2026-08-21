# 01_load_real_data.R
# Load a public Kenya maize-yield dataset.
# Source snapshot: FAOSTAT-derived Kenya crop-yield series published in
# the public agri-mtl-research repository (see data/README.md).

library(readr)

dir.create("projects/agricultural-data-analysis/data", recursive = TRUE, showWarnings = FALSE)

input_file <- "projects/agricultural-data-analysis/data/kenya_maize_yield.csv"
raw <- read_csv(input_file, show_col_types = FALSE)

stopifnot(all(c("year", "maize_yield_kg_ha") %in% names(raw)))
stopifnot(!anyDuplicated(raw$year))
stopifnot(all(raw$maize_yield_kg_ha > 0))

write_csv(raw, "projects/agricultural-data-analysis/data/agricultural_real_raw.csv")
cat("Loaded", nrow(raw), "annual observations from", min(raw$year), "to", max(raw$year), "\n")
