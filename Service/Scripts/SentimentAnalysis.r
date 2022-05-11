library("twitteR")
library(ROAuth)
library(RCurl)
library(httr)
library(tm)
library(RColorBrewer)
library(wordcloud)
library("base64enc")
library("openssl")
library("httpuv")
library(syuzhet)
library('RPostgres')


download.file(url="http://curl.haxx.se/ca/cacert.pem",
              destfile="cacert.pem")


api_key <- 'hIEzmw5cbjlvMoDRpaCpIaJBH'
api_secret <- '4lsOy255wEj2T4lKYKE1dk4lKZJNaV3GSBBgkFbLHYAr8zE3P2'
access_token <- '1297006087-U1vUxrXlqoXXUJInNI6EnPJvSXFXw0FVHOX6sr4'
access_secret <- 'SvgjuDDLkkH0siIZcJ5xZMmrq8vToJcXvvTcCJi48eCSw'
setup_twitter_oauth(api_key,
                    api_secret,
                    access_token,
                    access_secret
)

movieId <- 10

#Connect to database
drv <- RPostgres::Postgres()

connec <- dbConnect(drv, 
                    dbname = "DAS-014",
                    host = "localhost", 
                    port = 5432,
                    user = "postgres",
                    password = "teste1234")

# Get, for instance, tweets about covid
s <- searchTwitter('Scream', lang="en", n=100)

# Converting the query results for a data frame
df <- do.call("rbind", lapply(s, as.data.frame))

query <- 'INSERT INTO "Tweets"(
	"Text", "Favorited", "FavoriteCount", "Created", "ScreenName", "RetweetCount", "IsRetweet", "Language", "MovieId")
	VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9);'

#Insert the tweets on the database
for(record in rownames(df)){
  
  values <- c(df[record, "text"], df[record, "favorited"], df[record, "favoriteCount"],
              "2022-05-10", df[record, "screenName"], df[record, "retweetCount"],
              df[record, "isRetweet"], "en", movieId)
  
  dbSendQuery(connec, query, values)
}

# Get only tweets
r_twitter_text <- sapply(s, function(x) x$getText())

# Convert tweets in a corpus
corpus <- Corpus(VectorSource(r_twitter_text))

# Convert text to lowercase
corpus <- tm_map(corpus, content_transformer(tolower))

# Remove links from corpus
removeURL <- function(x) gsub("(http.*)", "", x, perl=TRUE)
corpus <- tm_map(corpus, content_transformer(removeURL))

#cRemove stopwords
corpus <- tm_map(corpus, removeWords, stopwords("english"))

# Term document matrix
tdm <- TermDocumentMatrix(corpus)
tdm <- as.matrix(tdm)

# Sentimental analysis
sentimental <- get_nrc_sentiment(r_twitter_text, 
                                 lang = "english"
)

names(sentimental) <- c("anger", "anticipation", "disgust", "fear", "joy", 
                        "sadness", "surprise", "trust", "negative", 
                        "positive")

sums <- colSums(sentimental)

query <- 'INSERT INTO "Sentiments"(
	"Date", "Anger", "Anticipation", "Disgust", "Fear", "Joy", "Sadness", "Surprise", "Trust", "Negative", "Positive", "MovieId")
	VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12);'

#Insert the sentiments on the database
values <- c("2022-05-10", sums[["anger"]], sums[["anticipation"]], sums[["disgust"]],
            sums[["fear"]], sums[["joy"]], sums[["sadness"]], sums[["surprise"]],
            sums[["trust"]], sums[["negative"]], sums[["positive"]], movieId)
  
dbSendQuery(connec, query, values)



