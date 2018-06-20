library(twitteR)
library(tidytext)
library(dplyr)
library(tidyr)
library(stringr)
library(RCurl)


#' Retrieve location data for tweets about Donald Trump
#'
#' @return Data of latitude and longitudes of tweet data
#' @export
lat_lon <- function() {

  d <- tweet_retrieval()

  tweet_loc = data.frame(tweet = d$text, lon = d$longitude, lat = d$latitude)

}
