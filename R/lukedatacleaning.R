library(twitteR)
library(tidytext)
library(dplyr)
library(tidyr)
library(stringr)
library(RCurl)


#' Import and clean data from twitter relating to Donald Trump
#'
#' @return Tidy data of tweets broken down by word and tweet index
#' @export
clean_data <- function(startDate, endDate) {
  # configuration
  consumer_key <- "ul0zL1WmoQ9tKWgv0f5AZhiDn"
  consumer_secret <- "TJ3i0v6wNFx91nqfNNbVFSYyDC9vXp1QuOYo0gZ8HdiSTnDmcF"
  access_token <- "76037206-OCx8lq0rB3hiHz8WQfw9QRBv0S6ViEcZB8v9gUHcW"
  access_secret <- "OvTdlW1GHZ9MhBBypUq70gnSgfB5Pah13Bg7d5yh3wFmH"


  # getting tweets using twitteR API
  twitteR::setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

  tw = twitteR::searchTwitter('@realDonaldTrump', n = 1000, lang = 'en', retryOnRateLimit = 1e3)
  d = twitteR::twListToDF(tw)

  tweet_stats = data.frame(tweet = d$text, favoriteCount = d$favoriteCount, retweetCount = d$retweetCount)
  tweet_loc = data.frame(tweet = d$text, lon = d$longitude, lat = d$latitude)
  tweet_created = d %>% select(text, created)

  tweet_created$text <- gsub("@\\w+ *", "", tweet_created$text)
  tweet_created$text <- gsub("(R)T ", "", tweet_created$text)
  tweet_created$text <- gsub("https", "", tweet_created$text)
  tweet_created$text <- gsub("t.co", "", tweet_created$text)
  tweet_created$text <- gsub("[0-9]+", "", tweet_created$text)

  # cleaning the text from tweets
  word_bag <- tweet_created %>% mutate(line = 1:nrow(.))
  (word_bag <- word_bag %>% unnest_tokens(word, text))

  data(stop_words)
  word_bag <- word_bag %>% anti_join(stop_words)
  word_bag
}
