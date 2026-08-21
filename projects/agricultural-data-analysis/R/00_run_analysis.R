# 00_run_analysis.R
# Master script for the agricultural data-analysis project.
# Run this script from the repository root.

source("projects/agricultural-data-analysis/R/01_generate_demo_data.R")
source("projects/agricultural-data-analysis/R/02_clean_data.R")
source("projects/agricultural-data-analysis/R/03_explore_data.R")
source("projects/agricultural-data-analysis/R/04_model.R")

message("Agricultural data-analysis workflow completed.")
