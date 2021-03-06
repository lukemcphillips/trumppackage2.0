
library(dplyr)
library(tidyr)

#' Assign average sentiment scores to each word in a tweet based on the average score for the tweet as a whole
#'
#' @param word_bag data frame of individual words (indexed by tweet)
#' @return Tidy data of tweets broken down by word and tweet index
#' @export
sentiments_score <- function(word_bag) {

  scored_words <- word_bag %>% inner_join(get_sentiments("afinn"))

  avg_scored_tweets <- scored_words %>%
    group_by(line) %>%
    dplyr::summarize(avg_score = mean(score))


  final_scoring <- left_join(scored_words, avg_scored_tweets, by = "line", all.X = TRUE)
  final_scoring
}
