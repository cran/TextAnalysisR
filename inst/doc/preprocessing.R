## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(TextAnalysisR)

mydata <- SpecialEduTech

united_tbl <- unite_cols(mydata, listed_vars = c("title", "keyword", "abstract"))

tokens <- prep_texts(
  united_tbl,
  text_field = "united_texts",
  remove_punct = TRUE,
  remove_numbers = TRUE
)

tokens_clean <- quanteda::tokens_remove(tokens, quanteda::stopwords("en"))

dfm_object <- quanteda::dfm(tokens_clean)

## ----eval = FALSE-------------------------------------------------------------
# compounds <- detect_multi_words(tokens, min_count = 10)
# tokens <- quanteda::tokens_compound(tokens, compounds)

