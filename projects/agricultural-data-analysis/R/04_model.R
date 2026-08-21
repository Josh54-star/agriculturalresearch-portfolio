# 04_model.R
# Descriptive time-trend model for Kenya maize yield.
# This is an association/trend model, not a causal model.

library(dplyr)
library(readr)

# install.packages("sandwich") if needed
library(sandwich)

df <- read_csv("projects/agricultural-data-analysis/data/agricultural_clean.csv", show_col_types = FALSE)

model <- lm(maize_yield_kg_ha ~ I(year - 1960), data = df)
robust <- coeftest(model, vcov = vcovHC(model, type = "HC1"))

results <- data.frame(
  term = rownames(robust),
  estimate = robust[, 1],
  robust_se = robust[, 2],
  statistic = robust[, 3],
  p_value = robust[, 4],
  row.names = NULL
)

write_csv(results, "projects/agricultural-data-analysis/outputs/tables/trend_model.csv")

fit <- data.frame(
  n = nobs(model),
  r_squared = summary(model)$r.squared,
  adj_r_squared = summary(model)$adj.r.squared
)
write_csv(fit, "projects/agricultural-data-analysis/outputs/tables/model_fit.csv")

cat("Estimated annual trend:", coef(model)[2], "kg/ha per year\n")
