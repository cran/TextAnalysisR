## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(TextAnalysisR)

mydata <- SpecialEduTech[seq_len(5), c("title", "abstract")]
united <- unite_cols(mydata, listed_vars = c("title", "abstract"))
toks   <- prep_texts(united, text_field = "united_texts")
quanteda::ndoc(toks)

## ----eval = FALSE-------------------------------------------------------------
# Sys.setenv(OPENAI_API_KEY = "sk-...")

