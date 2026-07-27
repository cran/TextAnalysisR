## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(TextAnalysisR)

sample_text <- c(
  "Figure 1 shows the distribution of student outcomes.",
  "Table 2 reports the effect sizes for each intervention."
)
toks <- prep_texts(
  data.frame(united_texts = sample_text),
  text_field = "united_texts"
)
quanteda::ntoken(toks)

