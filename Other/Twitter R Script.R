### install packages#### 
install.packages("twitteR")
library(twitteR)
install.packages("httpuv")
library("httpuv")

##### Connect to Twitter API ####
setup_twitter_oauth("qyakR3vH9r3W5T3n1Bx871TR5", "F9u8qVdW8qsSBmTpSik2wR2GApgISgiPjjVl5tGt7CJ67MbDlc",
                    access_token=NULL, access_secret=NULL)

#### get tweets related to the word Ebola ###
tweets_trump<-searchTwitter("Drone", n=10000)

### convert to data frame
df_trump <- do.call("rbind", lapply(tweets_trump, as.data.frame))
            
geocode='37.781157,-122.39720,1mi'.


head(df_trump)

write.csv(df,file="df.csv")        
### write to csv### 
write.csv(df, file=(