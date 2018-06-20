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

  d <- tweets()

  tweet_loc = data.frame(lon = tweet_created$longitude, lat = tweet_created$latitude)

  tweet_loc

}
