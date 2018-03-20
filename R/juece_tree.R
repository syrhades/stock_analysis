require(party)
require(dplyr)
require(plyr)

set.seed(1234)
ind <- sample(2,nrow(iris),replace=T,prob=c(0.7,0.3))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]

myFormula <- Species ~Sepal.Length + Sepal.Width+Petal.Length+Petal.Width
iris_ctree <- ctree(myFormula,data=trainData)
# check the prediction
table(predict(iris_ctree),trainData$Species)

iris_ctree %>% print
iris_ctree %>% plot
iris_ctree %>% plot(type="simple")

# predict on test data
testPred <- predict(iris_ctree,newdata=testData)
table(testPred,testData$Species)



rpart(myFormula,data=bodyfat.train,
        control = rpart.control(minsplit=10)
        )

################################
 # randomForest
################################
require(randomForest)
rf <- randomForest(Species~.,data=trainData,ntree=100,proximity=T)

评价
table(predict(rf),trainData$Species)

plot(rf)

importance(rf)

varImpPlot(rf)


margin(rf,testData$Species) %>%plot


# lmfun <- function(f_lm){
#   lm(f_lm)
# }
# lmfun(cpi~year+quarter)
lm(cpi~year+quarter)


# 观察值与拟合结果的残差使用residuals 来计算
residuals(fit)
# differences between observed values and fitted values
fit %>% plot

library(scatterplot3d)
s3d <- scatterplot3d(year,quarter,cpi,highlight.3d=T,type="h",lab=c(2,3))

s3d$plane3d(fit)

c(rep(1,12),rep(2,4))

www.ats.ucla.edu/stat/r/dae/logit.htm

nlp.stanford.edu/~manning/courses/ling289/logistic.pdf

#################################
# glm
#################################
bodyfat.glm<-glm(myFormula,family=gaussian("log"),data=bodyfat)
pred <- predict(bodyfat.glm,type="response")

plot(bodyfat$DEXfat,pred)
abline(a=0,b=1)

family= gaussian("identity")  ---> lm
family= binomial("logit")  ---> logistic regression

nls


cluster

k-means
iris2 <-iris
iris2$Species <-NULL
(kmeans.result <- kmeans(iris2,3))
table(iris$Species,kmeans.result$cluster)

########################################
# fpc
# pamk
################################################
library(fpc)
pamk.result <- pamk(iris2)
#number of clusters
pamk.result$nc
# check clustering against actual species
table(pamk.result$pamobject$clustering,iris$Species)

layout(matrix(c(1,2),1,2)) # 2 graphs per page
plot(pamk.result$pamobject)
layout(matrix(1)) # change back to one graph per page


#######################
#  hclust
#######################
hc <- hclust(dist(irissample),method="ave")
plot(hc,hang=-1,labels=iris$Species[idx])
# cut tree into 3 clusters
rect.hclust(hc,k=3)
groups<-cutree(hc,k=3)
#######################
#  fpc DBSCAN
#######################
将密度相连的对象划分到同一个簇中。
DBSCAN 
eps 可达距离，用于定义领域的大小
MinPts 最小数目的对象点


#########
require(fpc)
ds <-dbscan(iris2,eps=0.42,MinPts=5)

table(ds$cluster,iris$Species)

plot(ds,iris2)
plot(ds,iris2[c(1,4)])

plotcluster(iris2,ds$cluster)

# create a new dataset for labeling
set.seed(435)
idx <- sample(1:nrow(iris),10)
newdata <- iris[idx,-5]
newdata <- newData + matrix(runif(10*4,min=0,max=0.2),nrow=10,ncol=4)
# label new data
myPred <- predict(ds,iris2,newdata)
# plot result
plot(iris2[c(1,4)],col=1+ds$cluster)

points(newdata[c(1,4)],pch="ast",col=1+myPred,cex=3)

# check cluster labels
table(myPred,iris$Species[idx])

离群点检测
单变量的离群点检测
基于局部离群点因子LOF
聚类检测离群点

Time series 离群点检测

单变量的离群点检测
 boxplot.stats(vecs)
boxplot(vecs)

df (x,y)
# find the index of outliers from x
a<- which(x %in% boxplot.stats(x)$out)
# find the index of outliers from y
b<- which(y %in% boxplot.stats(y)$out)

outlier.list1 <- intersect(a,b)
plot(df)
points(df[outlier.list1,],col="red",pch="+",cex=2.5)



















