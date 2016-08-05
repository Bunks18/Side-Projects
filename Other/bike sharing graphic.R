library(ggplot2)
library(lubridate)
library(scales)
install.packages('lubridate')
# Tweak these to show something else on the axes
x_axis <- "jitter_times"
y_axis <- "count"
color  <- "temp_f" # for example swap this to "humidity"

# The competition data is stored in the ../input directory
train <- read.csv("../input/train.csv")
test  <- read.csv("../input/test.csv")
train<-read.csv("train1.csv")
test<-read.csv("test1.csv")
# Write some basic stats to the log
cat("Number of training rows ", nrow(train), "\n")
cat("Number of test rows ", nrow(test), "\n")
head(train)

train$hour  <- hour(ymd_hms(train$datetime))
train$times <- as.POSIXct(strftime(ymd_hms(train$datetime), format="%H:%M:%S"), format="%H:%M:%S")
train$jitter_times <- train$times+minutes(round(runif(nrow(train),min=0,max=59)))
train$day <- wday(ymd_hms(train$datetime), label=TRUE)
train$temp_f <- train$temp*9/5+32

p <- ggplot(train[train$workingday==1,], aes_string(x=x_axis, y=y_axis, color=color)) +
  geom_point(position=position_jitter(w=0.0, h=0.4)) +
  theme_light(base_size=20) +
  xlab("Hour of the Day") +
  scale_x_datetime(breaks = date_breaks("4 hours"), labels=date_format("%I:%M %p")) + 
  ylab("Number of Bike Rentals") +
  scale_colour_gradientn("Temp (°F)", colours=c("#5e4fa2", "#3288bd", "#66c2a5", "#abdda4", "#e6f598", "#fee08b", "#fdae61", "#f46d43", "#d53e4f", "#9e0142")) +
  ggtitle("On workdays, most bikes are rented on warm mornings and evenings\n") +
  theme(plot.title=element_text(size=18))
p

ggsave("bike_rentals_by_time_and_temperature.png", p)

####################

set.seed(1)

train <- read.csv("../input/train.csv")
test <- read.csv("../input/test.csv")

library(randomForest)

extractFeatures <- function(data) {
  features <- c("season",
                "holiday",
                "workingday",
                "weather",
                "temp",
                "atemp",
                "humidity",
                "windspeed",
                "hour")
  data$hour <- hour(ymd_hms(data$datetime))
  return(data[,features])
}

trainFea <- extractFeatures(train)
testFea  <- extractFeatures(test)

submission <- data.frame(datetime=test$datetime, count=NA)

# We only use past data to make predictions on the test set, 
# so we train a new model for each test set cutoff point
for (i_year in unique(year(ymd_hms(test$datetime)))) {
  for (i_month in unique(month(ymd_hms(test$datetime)))) {
    cat("Year: ", i_year, "\tMonth: ", i_month, "\n")
    testLocs   <- year(ymd_hms(test$datetime))==i_year & month(ymd_hms(test$datetime))==i_month
    testSubset <- test[testLocs,]
    trainLocs  <- ymd_hms(train$datetime) <= min(ymd_hms(testSubset$datetime))
    rf <- randomForest(extractFeatures(train[trainLocs,]), train[trainLocs,"count"], ntree=100)
    submission[testLocs, "count"] <- predict(rf, extractFeatures(testSubset))
  }
}

write.csv(submission, file = "1_random_forest_submission.csv", row.names=FALSE)

# Train a model across all the training data and plot the variable importance
rf <- randomForest(extractFeatures(train), train$count, ntree=100, importance=TRUE)
imp <- importance(rf, type=1)
featureImportance <- data.frame(Feature=row.names(imp), Importance=imp[,1])

p <- ggplot(featureImportance, aes(x=reorder(Feature, Importance), y=Importance)) +
  geom_bar(stat="identity", fill="#53cfff") +
  coord_flip() + 
  theme_light(base_size=20) +
  xlab("Importance") +
  ylab("") + 
  ggtitle("Random Forest Feature Importance\n") +
  theme(plot.title=element_text(size=18))
