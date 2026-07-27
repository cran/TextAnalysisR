## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(TextAnalysisR)
packageVersion("TextAnalysisR")

mydata <- SpecialEduTech[seq_len(20), c("title", "abstract")]
united <- unite_cols(mydata, listed_vars = c("title", "abstract"))
toks   <- prep_texts(united, text_field = "united_texts")
dfm    <- quanteda::dfm(toks)
extract_keywords_tfidf(dfm, top_n = 10)

