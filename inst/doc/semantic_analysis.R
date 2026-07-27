## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(TextAnalysisR)

mydata <- SpecialEduTech[1:150, ]
united_tbl <- unite_cols(mydata, listed_vars = c("title", "keyword", "abstract"))
tokens <- prep_texts(united_tbl, text_field = "united_texts", remove_stopwords = TRUE)
dfm_object <- quanteda::dfm(tokens)

## -----------------------------------------------------------------------------
network <- word_co_occurrence_network(
  dfm_object,
  co_occur_n = 50,
  top_node_n = 30,
  node_label_size = 22,
  community_method = "leiden"
)

network$plot
network$table
network$summary

## -----------------------------------------------------------------------------
corr_network <- word_correlation_network(
  dfm_object,
  common_term_n = 15,
  corr_n = 0.3,
  community_method = "leiden"
)

corr_network$plot
corr_network$table

## -----------------------------------------------------------------------------
subset_texts <- united_tbl$united_texts[1:10]

similarity <- semantic_similarity_analysis(
  subset_texts,
  document_feature_type = "words",
  similarity_method = "cosine",
  verbose = FALSE
)

plot_similarity_heatmap(similarity$similarity_matrix, method_name = "Cosine")

## -----------------------------------------------------------------------------
term_matrix <- as.matrix(dfm_object)[1:30, ]
normalized <- term_matrix / sqrt(rowSums(term_matrix^2))
sim_matrix <- normalized %*% t(normalized)

docs_data <- data.frame(
  display_name = paste0("doc", 1:30),
  reference_type = quanteda::docvars(dfm_object, "reference_type")[1:30]
)
dimnames(sim_matrix) <- list(docs_data$display_name, docs_data$display_name)

cross <- extract_cross_category_similarities(
  sim_matrix,
  docs_data,
  reference_category = "journal_article",
  category_var = "reference_type",
  id_var = "display_name"
)

gaps <- analyze_similarity_gaps(cross)
gaps$summary_stats

## ----eval = FALSE-------------------------------------------------------------
# results <- run_rag_search(
#   query = "math intervention for students with disabilities",
#   documents = united_tbl$united_texts,
#   provider = "openai"
# )

## -----------------------------------------------------------------------------
sentiment <- sentiment_lexicon_analysis(dfm_object, lexicon = "bing")
plot_sentiment_distribution(sentiment$document_sentiment)

## ----eval = FALSE-------------------------------------------------------------
# emotion <- sentiment_lexicon_analysis(dfm_object, lexicon = "nrc")
# plot_emotion_radar(emotion$emotion_scores)

## -----------------------------------------------------------------------------
scored <- sentiment_lexicon_analysis(dfm_object, lexicon = "bing")$document_sentiment
scored$reference_type <- quanteda::docvars(dfm_object, "reference_type")[
  match(scored$document, quanteda::docnames(dfm_object))
]
plot_sentiment_by_category(scored, category_var = "reference_type")

## -----------------------------------------------------------------------------
data_matrix <- as.matrix(dfm_object)

groups <- cluster_embeddings(data_matrix, method = "kmeans", n_clusters = 5, verbose = FALSE)
groups$n_clusters

labels <- generate_cluster_labels_auto(data_matrix, groups$clusters, method = "tfidf", n_terms = 3)
labels

## -----------------------------------------------------------------------------
coords <- reduce_dimensions(data_matrix, method = "PCA", n_components = 2, verbose = FALSE)
head(coords$reduced_data)

