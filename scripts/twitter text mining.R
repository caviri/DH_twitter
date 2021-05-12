library(twitteR)
library(base64enc)
require(RCurl)

api_key <- ''

api_secret <- ''

access_token <- ''

access_token_secret <- ''

setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

tweets <- searchTwitter('conferencia', n = 10000, lang='es', resultType = 'recent')

tweets_text <- sapply( tweets, function(x) x$getText() )

tweets_lon <- sapply( tweets, function(x) x$getLongitude() )
tweets_lat <- sapply( tweets, function(x) x$getLatitude() )

tl <- twListToDF(tweets)


write.table(tl, "tl.txt", sep = "\t", eol = "\n", dec = ".", row.names = TRUE, col.names = TRUE)

con<-file('pro/text_mining/twitter/data.csv', encoding="utf8")

write.csv(tl, file=con)
