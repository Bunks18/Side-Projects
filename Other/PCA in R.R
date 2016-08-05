rm(list = ls())
set.seed(12345)

par(mar=rep(.2,4))

dataMatrix<-matrix(rnorm(400), nrow=40)
image(1:10, 1:40, t(dataMatrix) [,nrow(dataMatrix):1])
head(dataMatrix)

###  cluster

par(mar= rep(.2, 4))
heatmap(dataMatrix)


### add pattern
set.seed(678910)

for( i in 1:40){
  # coin flip
  coinFlip<-rbinom(1, size=1, prob=.5)
  # if coin is heads add common pattern
  if (coinFlip){
    dataMatrix[i,] <-dataMatrix[i,] + rep(c(0,3), each=5 )
  }
}

par(mar=rep(.2,4))
image(1:10, 1:40, t(dataMatrix) [,nrow(dataMatrix):1])


head(dataMatrix)



##### 
hh<-hclust(dist(dataMatrix))
dataMatrixOrdered<-dataMatrix[hh$order,]
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrix):1])
plot(rowMeans(dataMatrixOrdered), 40:1, ,xlab="Row Mean", ylab="Row", pch=19)
plot(rowMeans(dataMatrixOrdered),xlab="Column", ylab="Row", pch=19)



svd1<-svd(scale(dataMatrixOrdered))
head(svd1)
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,dataMatrixOrdered]:1)
plot(svd1$u[,1], 40:1, , xlab="Row", ylab="First Left singular vector",
     pch=19)
plot(svd1$v[,1], xlab="Column", ylab= "First right singular vector",
     pch=19)




install.packages("impute")
library(impute)
load("data/face.rda")

