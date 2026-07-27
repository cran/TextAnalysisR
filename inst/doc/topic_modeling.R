## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(TextAnalysisR)

mydata <- SpecialEduTech[1:150, ]
united_tbl <- unite_cols(mydata, listed_vars = c("title", "keyword", "abstract"))
tokens <- prep_texts(united_tbl, text_field = "united_texts", remove_stopwords = TRUE)
dfm_object <- quanteda::dfm(tokens)

## -----------------------------------------------------------------------------
k_search <- find_optimal_k(dfm_object, topic_range = 5:6)
names(k_search)

## -----------------------------------------------------------------------------
out <- quanteda::convert(dfm_object, to = "stm")
out$meta$year <- as.numeric(out$meta$year)

model <- stm::stm(
  documents = out$documents,
  vocab = out$vocab,
  K = 5,
  prevalence = ~ reference_type + year,
  data = out$meta,
  max.em.its = 15,
  init.type = "Spectral",
  verbose = FALSE
)

## -----------------------------------------------------------------------------
terms <- get_topic_terms(model, top_term_n = 10)
head(terms, 15)

## ----eval = FALSE-------------------------------------------------------------
# labels <- generate_topic_labels(terms, provider = "openai")
# 
# content <- generate_topic_content(terms, content_type = "research_question", provider = "openai")

## -----------------------------------------------------------------------------
doc_topic <- calculate_topic_probability(model, top_n = 10, verbose = FALSE)
doc_topic

## -----------------------------------------------------------------------------
quotes <- stm::findThoughts(model, texts = united_tbl$united_texts, topics = 1, n = 3)
quotes

## -----------------------------------------------------------------------------
prep <- stm::estimateEffect(1:5 ~ reference_type + year, model, metadata = out$meta, uncertainty = "Global")
head(tidytext::tidy(prep), 10)

## -----------------------------------------------------------------------------
ec <- stm::plot.estimateEffect(prep, "reference_type", method = "pointestimate",
                               model = model, omit.plot = TRUE)
effects_cat <- do.call(rbind, lapply(seq_along(ec$topics), function(i) {
  data.frame(topic = ec$topics[i], value = as.character(ec$uvals),
             proportion = as.numeric(ec$means[[i]]),
             lower = as.numeric(ec$cis[[i]][1, ]), upper = as.numeric(ec$cis[[i]][2, ]))
}))
plot_topic_effects_categorical(effects_cat)

## -----------------------------------------------------------------------------
en <- stm::plot.estimateEffect(prep, "year", method = "continuous",
                               model = model, omit.plot = TRUE)
effects_cont <- do.call(rbind, lapply(seq_along(en$topics), function(i) {
  data.frame(topic = en$topics[i], value = en$x,
             proportion = as.numeric(en$means[[i]]),
             lower = as.numeric(en$ci[[i]][1, ]), upper = as.numeric(en$ci[[i]][2, ]))
}))
plot_topic_effects_continuous(effects_cont)

## ----eval = FALSE-------------------------------------------------------------
# embeddings <- get_best_embeddings(united_tbl$united_texts, provider = "openai")
# 
# topics <- fit_embedding_model(
#   united_tbl$united_texts,
#   method = "umap_hdbscan",
#   n_topics = 10,
#   precomputed_embeddings = embeddings
# )
# 
# embedding_labels <- generate_topic_labels(topics$topic_terms, provider = "openai")

