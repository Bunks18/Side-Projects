
#Read in data

data<-read.csv("test.csv")

d3 <-Data_Blitz <- read.csv("C:/Users/hecastellanos/Desktop/FULL.csv")
setwd("C:/Users/hecastellanos/Desktop")

x<-sapply(d3,class)=='factor' 

y<-d3[,x=='TRUE'] #create a data frame of only categorical variables
d3.1<-d3[,x=='FALSE']


#MyHeader=names(y)     # I save the headers of the data frame to a temp matrix
#for (i in 1:length(y))  {
#  if (MyHeader[[i]]=="factor") y[[i]]=as.integer(y[[i]])
#}     

#for (i in 1:length(y))  {
#  if (MyHeader[[i]]=="ordinal") y[[i]]=as.integer(y[[i]])
#}     

z<-data.frame(matrix(nrow=359287,ncol=11)) 
#create an empty data frame with same dimensionality as original data for re-casting

#re-cast categorical variables as ordinal numeric columns
for (i in 1:11){
  z[,i]<-as.integer(y[,i])
}

#z[,1]<-as.integer(y[,1])
#z[,2]<-as.integer(y[,2])
#z[,3]<-as.integer(y[,3])
#z[,4]<-as.integer(y[,4])
#z[,5]<-as.integer(y[,5])
#z[,6]<-as.integer(y[,6])
#z[,7]<-as.integer(y[,7])
#z[,8]<-as.integer(y[,8])
#z[,9]<-as.integer(y[,9])
#z[,10]<-as.integer(y[,10])
#z[,11]<-as.integer(y[,11])
#z[,12]<-as.integer(y[,12])
#z[,13]<-as.integer(y[,13])
#z[,14]<-as.integer(y[,14])
#z[,15]<-as.integer(y[,15])

d4<-na.omit(cbind(d3.1,z))

sapply(d4,class)
class(d4[,1])

head(data)

#install.packages("polycor")
library(polycor)
#polychor(d4)
x<-hetcor(d4)
x.1<-x$correlations

####write column names

Names<-names(Data_Blitz)
colnames(x.1)<-Names
head(x.1)

x.2<-x.1[,-c(14,15)]

#compute PCA model components
library(caret)
library(kernlab)

#drop dependent variable 
prComp<-prcomp(data[,-1],center=TRUE,scale=TRUE) #make the data look more Gaussian; drop dependent variable of interest
summary(prComp)
pc<-prComp$x

#Build Cross-Correlation Matrix to interpret Principal Components
class(prComp)
str(prComp)


correl2<-abs(cor(data[,-1],pc,use='everything',method='pearson'))
diag(correl2)<-0
write.csv(correl2,'PCA Interpretation Data_Blitz.csv') 



