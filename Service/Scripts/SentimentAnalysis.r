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


# Get, for instance, tweets about covid

s <- searchTwitter('covid', lang="en", n=100)


# Converting the query results for a data frame
df <- do.call("rbind", lapply(s, as.data.frame))


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

# Bar plot
w <- rowSums(tdm)
w <- subset(w, w>=10)
barplot(w,
        las = 2,
)

#Plot the results
w <- sort(rowSums(tdm), decreasing = TRUE)
set.seed(666)
#wordcloud(words = names(w),
#          freq = w,
#          max.words = 150,
#          random.order = F,
#          min.freq = 5,
#          colors = brewer.pal(8, 'Dark2'),
#          scale = c(5, 0.3),
#          rot.per = 0.7)


# Sentimental analysis

library(syuzhet

# emotions and sentiments
sentimental <- get_nrc_sentiment(r_twitter_text, 
                                 lang = "english"
)
head(sentimental)

names(sentimental) <- c("raiva", "antecipação", "nojo", "medo", "alegria", 
                        "tristeza", "surpresa", "confiança", "negativo", 
                        "positivo")


#barplot(colSums(sentimental),
#        las = 2,
#        ylab = 'Count',
#        main = 'Sentiment Scores Tweets')


nrc   = get_sentiment(r_twitter_text, method = "nrc", lang = "portuguese")

