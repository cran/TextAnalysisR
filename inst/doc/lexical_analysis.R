## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(TextAnalysisR)

mydata <- SpecialEduTech[1:150, ]
united_tbl <- unite_cols(mydata, listed_vars = c("title", "keyword", "abstract"))
tokens <- prep_texts(united_tbl, text_field = "united_texts", remove_stopwords = TRUE)
dfm_object <- quanteda::dfm(tokens)

## ----eval = FALSE-------------------------------------------------------------
# pos <- extract_pos_tags(united_tbl$united_texts)

## ----eval = FALSE-------------------------------------------------------------
# morphology <- extract_morphology(united_tbl$united_texts)

## ----eval = FALSE-------------------------------------------------------------
# entities <- extract_named_entities(united_tbl$united_texts)

## -----------------------------------------------------------------------------
plot_word_frequency(dfm_object, n = 20)

## -----------------------------------------------------------------------------
keywords <- extract_keywords_tfidf(dfm_object, top_n = 10)
plot_tfidf_keywords(keywords)

## -----------------------------------------------------------------------------
keyness <- extract_keywords_keyness(
  dfm_object,
  target = quanteda::docvars(dfm_object, "reference_type") == "journal_article"
)
plot_keyness_keywords(keyness)

## -----------------------------------------------------------------------------
plot_keyword_comparison(keywords, top_n = 10)

## -----------------------------------------------------------------------------
diversity <- lexical_diversity_analysis(dfm_object)
plot_lexical_diversity_distribution(diversity$lexical_diversity, metric = "TTR")

## -----------------------------------------------------------------------------
readability <- calculate_text_readability(united_tbl$united_texts)
plot_readability_distribution(readability, metric = "flesch")

## -----------------------------------------------------------------------------
log_odds <- calculate_log_odds_ratio(
  dfm_object,
  group_var = "reference_type",
  comparison_mode = "binary",
  top_n = 15
)
plot_log_odds_ratio(log_odds)

## -----------------------------------------------------------------------------
weighted_odds <- calculate_weighted_log_odds(
  dfm_object,
  group_var = "reference_type",
  top_n = 15
)
plot_weighted_log_odds(weighted_odds)

## -----------------------------------------------------------------------------
dispersion <- calculate_lexical_dispersion(tokens[1:50], terms = c("education", "technology"))
plot_lexical_dispersion(dispersion)

## -----------------------------------------------------------------------------
compounds <- detect_multi_words(tokens, min_count = 10)
head(compounds, 10)

