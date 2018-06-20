library(twitteR)
library(tidytext)
library(dplyr)
library(tidyr)
library(stringr)
library(RCurl)
library(scRabble)

#' Import and clean data from twitter relating to Donald Trump
#'
#' @return Tidy data of tweets broken down by word and tweet index
#' @export
clean_data <- function() {
  # configuration
  d <- tweets()

  tweet_created = d %>% select(text, created)

  tweet_created$text <- gsub("@\\w+ *", "", tweet_created$text)
  tweet_created$text <- gsub("(R)T ", "", tweet_created$text)
  tweet_created$text <- gsub("https", "", tweet_created$text)
  tweet_created$text <- gsub("t.co", "", tweet_created$text)
  tweet_created$text <- gsub("[0-9]+", "", tweet_created$text)
  tweet_created$text <- gsub("amp", "", tweet_created$text)

  # cleaning the text from tweets
  word_bag <- tweet_created %>% mutate(line = 1:nrow(.))
  (word_bag <- word_bag %>% unnest_tokens(word, text))

  data(stop_words)
  word_bag <- word_bag %>% anti_join(stop_words)
  word_bag

}
