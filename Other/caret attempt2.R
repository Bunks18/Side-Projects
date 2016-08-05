C<-read.csv("CC.csv")
u
names(C)
library(caret)
data(GermanCredit)
#split data
inTrainingset<-createDataPartition(C$Sale, p=.75, list=FALSE)
CTrain<-C[inTrainingset,]
CTest<-C[-inTrainingset,]
names(GermanCredit)
G<-GermanCredit
#train
gbmfit<-gbm(Sale~., data=C,distribution="bernoulli",n.trees=5,interaction.depth=7,shrinkage= .01,)
plot(gbmfit)
print(C[1:10,])
#tune
gbmTune<-train(Sale~.,data=CTrain, method="gbm")

#change resampling
ctrl<-trainControl(method="repeatedcv",repeats=5)
gbmTune<-train(Sale~.,data=CTrain, 
               method="gbm", 
               verbose=FALSE, 
               trControl=ctrl)


ctrl<-trainControl(method="repeatedcv", repeats=5, classProbs=TRUE, summaryFunction = twoClassSummary)
gbmTune<-trainControl(Sale~., data=CTrain, 
                      method="gbm", 
                      metric="ROC", 
                      verbose=FALSE , 
                      trControl=ctrl)
print(C[1:10,])
## add grid

grid<-expand.grid(.interaction.depth=seq(1,7, by=2), .n.trees=seq(100,300, by=50), .shrinkage=c(.01,.1))
gbmTune<-train(Sale~., data=CTrain, 
               method="gbm", 
               metric="ROC", 
               tunegrid= grid, 
               verebose=FALSE,
               trControl=ctrl)


#run model

set.seed(1)
gbmTune <- train(Sale~., data = CTrain,
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

load(GermanCredit)

data()
Book<-read.csv("Book3.csv")
Book


dput(head(iris,4))

dput(head(Book,5))
