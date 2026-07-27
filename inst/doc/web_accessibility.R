## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(TextAnalysisR)

mydata <- SpecialEduTech[seq_len(20), c("title", "abstract")]
united <- unite_cols(mydata, listed_vars = c("title", "abstract"))
toks   <- prep_texts(united, text_field = "united_texts")
dfm    <- quanteda::dfm(toks)
plot_word_frequency(dfm, n = 10)

