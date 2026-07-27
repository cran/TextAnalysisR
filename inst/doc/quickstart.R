## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# install.packages("TextAnalysisR",
#   repos = c("https://mshin77.r-universe.dev", "https://cloud.r-project.org"))

## ----eval = FALSE-------------------------------------------------------------
# library(TextAnalysisR)
# run_app()

## -----------------------------------------------------------------------------
library(TextAnalysisR)

mydata <- SpecialEduTech
united_tbl <- unite_cols(mydata, listed_vars = c("title", "keyword", "abstract"))

tokens <- prep_texts(united_tbl, text_field = "united_texts")
dfm_object <- quanteda::dfm(tokens)

plot_word_frequency(dfm_object, n = 20)

