## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## -----------------------------------------------------------------------------
library(TextAnalysisR)

## -----------------------------------------------------------------------------
codebook <- tibble::tibble(
  code = c("access", "instruction", "assessment"),
  definition = c(
    "Availability of technology, materials, or services to students",
    "Teaching methods, strategies, or curriculum delivery",
    "Measurement of student performance or progress"
  ),
  example = c(
    "tablets were provided to every student",
    "the teacher modeled each step before practice",
    "progress was measured with weekly probes"
  )
)
codebook

## ----eval = FALSE-------------------------------------------------------------
# texts <- SpecialEduTech$abstract[1:20]
# names(texts) <- paste0("doc", seq_along(texts))
# 
# suggestions <- apply_codes(
#   texts,
#   codebook,
#   unit = "paragraph",
#   max_codes = 3,
#   provider = "gemini"
# )

## ----eval = FALSE-------------------------------------------------------------
# review <- subset(suggestions, status == "ok")
# review$coder <- "coder1"

## ----eval = FALSE-------------------------------------------------------------
# stability <- code_retest(texts, codebook, n_runs = 2, sample_n = 20)
# stability$summary

## -----------------------------------------------------------------------------
# synthetic units, paraphrased from the corpus
suggestions <- tibble::tibble(
  doc_id  = c("d1", "d1", "d2"),
  unit_id = c("d1.1", "d1.2", "d2.1"),
  start   = c(1L, 68L, 1L),
  end     = c(66L, 128L, 74L),
  code    = c("access", NA_character_, NA_character_)
)

texts <- c(
  d1 = paste("Text-to-speech tools give students access to grade-level readings.",
             "Teachers report growing confidence after the training series."),
  d2 = "The review summarizes methodological features across the included studies."
)

uncoded_units(suggestions, texts)

## -----------------------------------------------------------------------------
# synthetic assignments
assignments <- tibble::tibble(
  doc_id = rep(paste0("doc", 1:10), each = 2),
  code   = c("access", "access", "access", "access", "access", "access",
             "instruction", "instruction", "instruction", "instruction",
             "instruction", "assessment", "assessment", "assessment",
             "assessment", "assessment", "assessment", "access",
             "access", "access"),
  coder  = rep(c("c1", "c2"), times = 10)
)

agreement <- code_agreement(assignments)
agreement$overall

## -----------------------------------------------------------------------------
agreement$disagree

## -----------------------------------------------------------------------------
agreement$by_code

## -----------------------------------------------------------------------------
# synthetic assignments, one code dominating
skewed <- tibble::tibble(
  doc_id = rep(paste0("doc", 1:8), each = 2),
  code   = c("access", "access", "access", "access", "access", "access",
             "access", "access", "access", "access", "access", "access",
             "access", "instruction", "instruction", "access"),
  coder  = rep(c("c1", "c2"), times = 8)
)

code_agreement(skewed, by_code = FALSE)$overall

## ----eval = FALSE-------------------------------------------------------------
# code_agreement(assignments, codebook_authors = "c1")$independent

## -----------------------------------------------------------------------------
# synthetic spans
spans <- tibble::tibble(
  doc_id = c("doc1", "doc1", "doc1"),
  coder  = c("c1", "c1", "c2"),
  code   = c("access", "instruction", "access"),
  start  = c(1, 200, 50),
  end    = c(100, 300, 80)
)

code_agreement(spans, align = "coverage")$overall

## ----eval = FALSE-------------------------------------------------------------
# combined <- merge_codes(c("coder1.csv", "coder2.xlsx"))
# code_agreement(combined)$overall

