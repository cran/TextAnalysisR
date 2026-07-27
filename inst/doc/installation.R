## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(TextAnalysisR)
packageVersion("TextAnalysisR")

data("SpecialEduTech")
nrow(SpecialEduTech)
head(SpecialEduTech[, c("title", "year")], 3)

## ----eval = FALSE-------------------------------------------------------------
# install.packages("TextAnalysisR",
#   repos = c("https://mshin77.r-universe.dev", "https://cloud.r-project.org"))
# library(TextAnalysisR)
# run_app()

