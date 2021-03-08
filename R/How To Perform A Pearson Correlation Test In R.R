#https://youtu.be/2J_ZlxLeuQU

#How To Perform A Pearson Correlation Test In R
install.packages("corrplot")
library(corrplot)
#Using Trees dataset that is already in R
data(trees)
#Previewing dataset of 31 cherry trees
head(trees)
#Pearson Correlation Test to see if there's a linear correlation between girth & height
cor.test(trees$Girth, trees$Height)
#Changing confidence interval
cor.test(trees$Girth, trees$Height, conf.level = 0.90)