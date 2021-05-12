install.packages('tm')

library (tm)

# Loading in the data
setwd("D:/pro/undermalaga")
reviews <- read.csv("reviews.csv", stringsAsFactors = FALSE)

# Combining all the reviews together
review_text <- paste(reviews$text, collapse = " ")

# Setting up Source and Corpus
review_source <- VectorSource(review_text)
corpus <- Corpus(review_source)

# Cleaning
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeWords, stopwords("english"))

# Stopwords are very common words that appear constanly in the text

# Making a document-term matrix. Cada fila es un documento y cada columna una palabra. 
dtm <- DocumentTermMatrix(corpus)
dtm2 <- as.matrix(dtm)

# Finding the most frequent terms
frequency <-colSums(dtm2)
str(frequency)
frequency <- sort(frequency, decreasing=TRUE)

install.packages('wordcloud')

library(wordcloud)

words <- names(frequency)

wordcloud(words[1:100], frequency[1:100])
