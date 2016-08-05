data(iris)
iris1<-iris
head(iris1)
# log transform 
summary(iris$Petal.Length)
log.ir <- log(iris[, 1:4])
ir.species <- iris[, 5]
head(ir.species)
head(log.ir)

# apply PCA - scale. = TRUE is highly 
# advisable, but default is FALSE. 
ir.pca <- prcomp(log.ir,
                 center = TRUE,
                 scale. = TRUE) 

head(ir.pca)

print(ir.pca)

# plot method
plot(ir.pca, type = "l")

### summary method
summary(ir.pca)


predict(ir.pca, 
        newdata=tail(log.ir, 2))

#### ggpplot
install.packages('Rtools')
library(Rtools)
library(devtools)
install_github("ggbiplot", "vqv")

library(ggbiplot)
g <- ggbiplot(ir.pca, obs.scale = 1, var.scale = 1, 
              groups = ir.species, ellipse = TRUE, 
              circle = TRUE)
g <- g + scale_color_discrete(name = '')
g <- g + theme(legend.direction = 'horizontal', 
               legend.position = 'top')
print(g)



###################33


# Author: Steve Pittard - wsp@emory.edu, ticopittard@gmail.com 
# This video is in support of the following YouTube video:

# Using prcomp and varimax for PCA in R www.youtube.com/watch?v=PSuvMBtvJcA 

library(lattice)

my.wines <- read.csv("http://steviep42.bitbucket.org/YOUTUBE.DIR/wines.csv", header=TRUE)

# Look at the correlations
install.packages("gclus")
library(gclus)
my.abs     <- abs(cor(my.wines[,-1]))
my.colors  <- dmat.color(my.abs)
my.ordered <- order.single(cor(my.wines[,-1]))
cpairs(my.wines, my.ordered, panel.colors=my.colors, gap=0.5)

# Do the PCA 

my.prc <- prcomp(my.wines[,-1], center=TRUE, scale=TRUE)
screeplot(my.prc, main="Scree Plot", xlab="Components")
screeplot(my.prc, main="Scree Plot", type="line" )
summary(my.prc)
ls(my.prc)
# DotPlot PC1

load    <- my.prc$rotation
sorted.loadings <- load[order(load[, 1]), 1]
myTitle <- "Loadings Plot for PC1" 
myXlab  <- "Variable Loadings"
dotplot(sorted.loadings, main=myTitle, xlab=myXlab, cex=1.5, col="red")

# DotPlot PC2

sorted.loadings <- load[order(load[, 2]), 2]
myTitle <- "Loadings Plot for PC2"
myXlab  <- "Variable Loadings"
dotplot(sorted.loadings, main=myTitle, xlab=myXlab, cex=1.5, col="red")

# Now draw the BiPlot
biplot(my.prc, cex=c(1, 0.7))

# Apply the Varimax Rotation
my.var <- varimax(my.prc$rotation)
plot(my.var)

my.var




install.packages("Rserve")
library(Rserve)
Rserve()
