# Data extraction for word science related

library(twitteR)
library(base64enc)
require(RCurl)
library(wordcloud)
library (tm)

api_key <- ''

api_secret <- ''

access_token <- ''

access_token_secret <- ''

setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

tweets <- searchTwitter('23 marzo+malaga', n = 10000, lang='es', resultType = 'recent')

tweets_text <- sapply( tweets, function(x) x$getText() )

review_text <- paste(tweets_text, collapse = " ")
gsub("\n", "", review_text)

review_source <- VectorSource(review_text)

corpus <- Corpus(review_source)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords("spanish"))
corpus <- tm_map(corpus, removeWords, "martes")

dtm <- DocumentTermMatrix(corpus)
dtm2 <- as.matrix(dtm)

frequency <-colSums(dtm2)
frequency <- sort(frequency, decreasing=TRUE)

words <- names(frequency)
wordcloud(words[1:100], frequency[1:100])


inspect(DocumentTermMatrix(corpus, list(dictionary = c("concierto", "conferencia", "teatro"))))
