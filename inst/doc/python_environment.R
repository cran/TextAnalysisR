## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(TextAnalysisR)

tokens <- quanteda::tokens(SpecialEduTech$abstract[1:5])
dispersion <- calculate_lexical_dispersion(
  tokens,
  terms = c("learning", "instruction")
)
head(dispersion)

