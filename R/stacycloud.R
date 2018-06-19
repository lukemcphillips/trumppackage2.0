library(wordcloud2)
library(dplyr)

#' Get wordcoud
#'
#' @param num_words number of words desired in the cloud
#' @param final_scoring
#'
#' @return visualization of word cloud
#' @export
#'
#' @examples
get_cloud <- function(num_words, final_scoring){
  # count frequency of word
  word_freq <- final_scoring %>%
    group_by(word) %>%
    summarise(freq = as.numeric(table(word)))

  # group by word to get avg sentiment
  final_scoring <- final_scoring %>%
    group_by(word) %>%
    summarize(avg_sentiment = mean(avg_score))

  # merge freq with final_scoring
  final_scoring <- merge(x = final_scoring, y = word_freq, by = "word", all.x = TRUE)

  # assigning sentiment colors for cloud
  mutate(final_scoring, color = cut(avg_sentiment, breaks = c(-5.0, -4.0, -3.0, -2.0, -1.0, 0, 1.0, 2.0, 3.0, 4.0),
                                    labels = c("#CC0000", "#FF0000", "#FF3333",
                                               "#FF6666", "#C0C0C0", "#99CCFF",
                                               "#66B2FF", "#0080FF", "#0000FF"),
                                    include.lowest = TRUE)) -> final_scoring

  # create word cloud
  testing <- final_scoring %>% select(word, freq, color)

  testing <- testing %>% arrange(desc(freq)) %>% slice(0:num_words)

  (cloud <- wordcloud2-shiny(data = testing, color = testing$color, shape = 'circle'))
}
