HIVE<-read.csv("hive_test.csv")
names(HIVE)


library(stringr)
df<-str_split_fixed(HIVE$Col3, "#", 2, )

g<-data.frame(df)
names(g)
head(g)
H<-str_split_fixed(g$X2, '#', 4)
HH<-data.frame(H)
head(HH)

tmp <- matrix(unlist(strsplit(as.character(HIVE$Col3), '#')), ncol=7, byrow=TRUE)
after <- cbind(HIVE$Col3, as.data.frame(tmp))
names(after) <- c("path", "path2", "path3", "path4", "path5", "path6", "path7")



tmp <- matrix(unlist(strsplit(as.character(HIVE$Col3), '#')), ncol=2, byrow=TRUE)
after <- cbind(before$attr, as.data.frame(tmp))
names(after) <- c("attr", "type_1", "type_2")