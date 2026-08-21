# 05_export_results.R
# Create publication-ready Markdown result tables from the R workflow.

library(readr)

trend <- read_csv("projects/agricultural-data-analysis/outputs/tables/trend_model.csv", show_col_types = FALSE)
fit <- read_csv("projects/agricultural-data-analysis/outputs/tables/model_fit.csv", show_col_types = FALSE)

annual <- trend$estimate[trend$term == "I(year - 1960)"]
annual_p <- trend$p_value[trend$term == "I(year - 1960)"]

out <- c(
  "# Analytical results",
  "",
  "## Trend model",
  "",
  "The OLS model estimates the descriptive association between calendar year and Kenya maize yield.",
  "",
  sprintf("- Annual trend: %.2f kg/ha per year", annual),
  sprintf("- Equivalent decadal trend: %.1f kg/ha per decade", annual * 10),
  sprintf("- p-value: %.4g", annual_p),
  sprintf("- R-squared: %.3f", fit$r_squared),
  sprintf("- Observations: %d", fit$n),
  "",
  "These estimates describe the historical series and should not be interpreted as causal effects.",
  ""
)

writeLines(out, "projects/agricultural-data-analysis/outputs/results.md")
cat("Results narrative exported.\n")
