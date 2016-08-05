C<-read.csv("C.csv")
names(C)
head(C)
library(caret)
inTrainingset<-createDataPartition(C$Sale, p=.75, list=FALSE)
CTrain<-C[inTrainingset,]
CTest<-C[-inTrainingset,]
library(gbm)
#turn into binary
forGBM <- CTrain
CTrain$Sale <- ifelse(CTrain$Sale == "yes", 1, 0)
levels(forGBM$Sale)
head(CTrain)
gbmfit<-gbm(Sale~category_name+shipping_free+exposition+condition+level_id+power_seller+price, data=CTrain,distribution="bernoulli",n.trees=5,interaction.depth=7,shrinkage= .01,)
plot(gbmfit)

gbmTune<-train(Sale~category_name+shipping_free+exposition+condition+level_id+power_seller+price,data=CTrain, method="gbm")
warnings()

ctrl<-trainControl(method="repeatedcv",repeats=5)
gbmTune<-train(Sale~category_name+shipping_free+exposition+condition+level_id+power_seller+price,data=CTrain, method="gbm", verbose=FALSE, trControl=ctrl)
plot(gbmTune)
ctrl<-trainControl(method="repeatedcv", repeats=5, classProbs=TRUE, summaryFunction = twoClassSummary)
gbmTune<-trainControl(Sale~category_name+shipping_free+exposition+condition+level_id+ power_seller +price , data=CTrain, method="gbm", metric="ROC", verbose=FALSE , trControl=ctrl)
names(C)
## add grid

grid<-expand.grid(.interaction.depth=seq(1,7, by=2), .n.trees=seq(100,300, by=50), .shrinkage=c(.01,.1))
gbmTune<-train(Sale~category_name+shipping_free+exposition+condition+level_id+ power_seller +price, data=CTrain, method="gbm", metric="ROC", tunegrid= grid, verebose=FALSE,trControl=ctrl)
trainControl()
#run model
> set.seed(1)
> gbmTune <- train(Sale~category_name+shipping_free+exposition+condition+level_id+ power_seller +price, data = CTrain,
                   method = "gbm",
                   metric = "ROC",
                   tuneGrid = grid,
                   verbose = FALSE,
                   trControl = ctrl)
##plot
ggplot(gbmTune) + theme(legend.position = "top")wa

#predict

> gbmPred <- predict(gbmTune, CTest)
> str(gbmPred)


#predict with probs

gbmProbs <- predict(gbmTune, churnTest, type = "prob")
> str(gbmProbs)

### confusion matrix

confusionMatrix(gbmPred, CTest$Sale)

