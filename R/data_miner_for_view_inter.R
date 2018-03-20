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

局部离群点因子LOF
LOF只适用于数值型数据

DMwR package 
dprep package
lofactor()
k 领域个数

require(DMwR)
# remove "Species"， which is a categorical column
iris2 <- iris[,1:4]
outlier.scores <- lofactor(iris2,k=5)
outlier.scores %>% density %>% plot
# pick top 5 as outliers
outliers <- order(outlier.scores,decreasing=T)[1:5]
# who are outliers
print(outliers)
print(iris2[outliers,])

n <- nrow(iris2)
labels <- 1:n
labels[-outliers] <- "."
biplot(prcomp(iris2),cex=.8,xlabs=labels)

prcomp  主成分分析

配对散步图矩阵表示离群点
pch <- rep(".",n)
pch[outliers] <- "+"
col <- rep("black",n)
col[outliers] <- "red"
pairs(iris2,pch=pch,col=col)

Rlof package
lof 实现了并行执行LOF算法
计算所有离群点得分后，选择得分最高的作为离群点。
require(Rlof)
outlier.scores <- lof(iris2,k=5)
# try with different number of neighbors(k=5,6,7,8,9 10)
outlier.scores <- lof(iris2,k=c(5:10))

聚类方法 离群点检测
数据进行划分，那些没有被划分到任何簇的数据点即为离群点

# remove species from the data to cluster
iris2 <- iris[,1:4]
kmeans.result <- kmeans(iris2,centers=3)
# cluster centers
kmeans.result$centers
# cluster IDs
kmeans.result$cluster
# calculate distance between objects and cluster centers
centers <- kmeans.result$centers[kmeans.result$cluster,]
distances <- sqrt(rowSums((iris2-centers)^2))
# pick top 5 largest distances
outliers <- order(distances,decreasing=T)[1:5]
# who are outliers
outliers %>% print
iris2[outliers,] %>% print
# plot clusters
plot(iris2[,c("Sepal.Length","Sepal.Width")],
                pch="o",
                col = kmeans.result$cluster,
                cex=0.3
                )
#plot cluster centers
points(kmeans.result$centers[,c("Sepal.Length","Sepal.Width")],
            col=1:3,
            pch=8,
            cex=1.5
  )
# plot outliers
points(iris2[outliers,c("Sepal.Length","Sepal.Width")],
            col=4,
            pch="+",
            cex=1.5
  )

time series outliers
stl() 根据稳健回归对time series 数据进行分解，进行离群点识别
STL seasonal -trend decomposition based on Loess
# use robust fitting
f<- stl(AirPassengers,"periodic",robust=T)
(outliers <- which(f$weights<1e-8))
# set layout
op <- par(mar=c(0,4,0,3),oma=c(5,0,4,0),mfcol=c(4,1))
plot(f,set.pars=NULL)
sts <- f$time.series

# plot outliers
points(time(sts)[outliers],
          0.8*sts[,"remainder"][outliers],
          pch="x",
          col="red"
          )

par(op) # reset layout

extremevalues   单变量的离群点检测
mvoutlier 基于鲁棒法的多变量离群点
outliers 


Time series 分析与挖掘
分解，预测，聚类，分类
自回归综合移动平均 ARIMA
DTW动态时间规整

ts class
freq =7 ==》 由每周的数据构成
freq =12 ==》 由每月的数据构成
freq =4 ==》 由每季度的数据构成

a <- ts(1:30,frequency=12,start=c(2011,3))
str(a)
a %>% attributes

时间序列分解
趋势性，季节性，周期性
不规则

# decompose time series
apts <- ts(AirPassengers,frequency=12)
f <- decompose(apts)
# seasonal figures
f$figure

plot(f$figure,type="b",xaxt="n",xlab="")
# get names of 12 months in English words
monthName <- months(ISOdate(2011,1:12,1))
# label x-axis with month names
# 1 as is set to 2 for vertical label orientation
axis(1,at=1:12,labels=monthName,las=2)
plot(f)

stats::stl
timsac::decomp
ast::tsr

Time series predict
ARMA 自回归移动平均
ARIMA 自回归综合移动平均

fit <- arima(AirPassengers,order=c(1,0,0),
                    list(order=c(2,1,0),
                          period=12
                    )
                  )
fore <- predict(fit,n.ahead=24)
# error bounds at 95% confidence level
U <- fore$pred + 2*fore$se 
L <- fore$pred - 2*fore$se 
ts.plot(AirPassengers,fore$pred,U,L,
            col=c(1,2,4,4),
            lty=c(1,1,2,2)
          )
legend("topleft",
            c("Actual","Forecast","Error bounds(95% confidence)"),
            col =c(1,2,4),
            lty=c(1,1,2)
          )

ts cluster
基于相似度或者距离将ts划分为不同的组
距离或相异度
欧式距离
曼哈顿距离
最大范数
海明距离
两个向量之间的角度（內积）
动态时间规整

require(dtw)
idx <- seq(0,2*pi,len=100)
a <- sin(idx)+runif(100)/10
b <- cos(idx)

align <- dtw(a,b,step=asymmetricP1,keep=T)
dtwPlotTwoWay(align)

合成控制图的ts 数据

set.seed(6218)
n <-10
s <- sample(1:100,n)
idx <- c(s,100+s,200+s,300+s,400+s,500+s)

sample2 <- sc[idx,]
observedLabels <- rep(1:6,each=n)
# hierarchical clustering with euclidean distance
hc <-hclust(dist(sample2),method="average")
plot(hc,labels=observedLabels,main="")
rect.hclust(hc,k=6)

memb <- cutree(hc,k=6)
table(observedLabels,memb)

DTW距离的层次cluster
require(dtw)
distMatrix <- dist(sample2,method="DTW")
hc <- hclust(distMatrix,method="average")
plot(hc,labels=observedLabels,main="")
# cut tree to get 6 clusters
rect.hclust(hc,k=6)

memb <- cutree(hc,k=6)
table(observedLabels,memb)

TS 分类
奇异值分解 SVD
离散傅里叶变换DFT
离散小波变换 DWT
分段积累近似法 PAA
连续重要点PIP
分段线性表示
符号表示

classId <- rep(as.character(1:6),each=100)
newSc <- data.frame(cbind(classId,sc))
require(party)
ct <- ctree(classId~.,data=newSc,
                  controls = ctree_control(minsplit=30,minbucket=10,maxdepth=5)
  )

pClassId <- predict(ct)
table(classId,pClassId)
# accuracy
(sum(classId==pClassId))/nrow(sc)

plot(ct,ip_args=list(pval=F),
        ep_args=list(digits=0)
        )

基于特征提取的分类
DWT
wavelets::DWT

require(wavelets)
wtData <- NULL
for (i in 1:nrow(sc)){
  a <- t(sc[i,])
  wt <- dwt(a,filter="haar",boundary="periodic")
  wtData <- rbind(wtData,unlist(c(wt@W,wt@V[[wt@level]])))
}

wtData <- as.data.frame(wtData)
wtSc <- data.frame(cbind(classId,wtData))
# build a decision tree with DWT coefficients
ct <- ctree(classId~.,data=wtSc,
                  controls= ctree_control(minsplit=30,minbucket=10,maxdepth=5)
  )
pClassId <- predict(ct)
table(classId,pClassId)
(sum(classId==pClassId))/nrow(wtSc)
plot(ct,ip_args=list(pval=F),ep_args=list(digits=0))

kNN
k <- 20
# create a new time series by adding noise to ts 501
newTS <- sc[501,]+runif(100) *15
distances <- dist(newTS,sc,method="DTW")
s <- sort(as.vector(distances),index.return=T)
# class IDs of k nearest neighbors
table(classId[s$ix[1:k]])

www.rdatamining.com/docs
Time series Analysis and Mining with Rlof

关联规则
修剪冗余规则，描述并绘制可视化图像的列子

关联规则（表示两个集间的关联度或相关性的规则，关联规划的形式为A=》B，其中A，B是2个互斥的集，
3个常用于选择有趣关联规则的度量是支持度（support），置信度（confidence），提升度（lift）
support：既包含A又包含B 的实例所占百分比
confidence：包含A的实例中也包含B所占的百分比
lift： 置信度与B的实例所占百分比
support(A=>B) = P(A U B)
confidence(A=>B) = P(B|A)
                              = P(A U B) / P(A)

lift(A=>B) = confidence(A => B)/P(A)
                = P(A U B) / (P(A)P(B))
P(A)为包含A的实例所占的百分比（或概率）

卡方检验 chiquare
确信度 conviction
基尼系数 gini
杠杆值 leverage

APRIORI
Arules::apriori
Arules::eclat

require(arules)
# find asscociation rules with default settings
rules.all <- apriori()

rules.all
inspect(rules.all)

rules <- apriori(,controls=list(verbose=F),
                          parameter = list(minlen=2,supp=0.005,conf=0.8),
                          appearance = list(rhs=c("Survived=No","Survived=Yes"),
                                                        default="lhs"
                                                      )
                      )

quality(rules) <- round(quality(rules),digits=3)
rules.sorted <- sort(rules,by="lift")

rules.sorted %>% inspect

arules::interestMeasure

消除冗余
#find redundant rules
subset.matrix <- is.subset(rules.sorted,rules.sorted)
subset.matrix[lower.tri(subset.matrix,diag=T)] <- NA
redundant <- colSums(subset.matrix,na.rm=T) >=1
which(redundant)

# remove redundant rules
rules.pruned <- rules.sorted[!redundant]
inspect[rules.pruned]

viz
require(arulesViz)
plot(rules.all)
plot(rules.all,method="grouped")
plot(rules.all,method="graph")
plot(rules.all,method="graph",control=list(type="item"))
plot(rules.all,method="paracoord",control=list(reorder=T))

arulesSequences
arulesNBMiner

writeLines(strwrap(rdmTweets[[i]]$getText(),width=73))

# convert tweets to a data frame
df <- do.call("rbind",lapply(rdmTweets,as.data.frame))
dim(df)

page 99
128029.Zhang


text miner
twitteR
tm
wordcloud

require(twitteR)
# retrieve the first 200 tweets(or all tweets if fewer than 200) from 
# the user timeline of @rdatammining
rdmTweets <- userTimeline("rdatamining",n=200)
(nDocs <- length(rdmTweets))

for (i in 11:15){
  cat(paste("[[",i,"]]",sep=""))
  writeLines(strwrap(rdmTweets[[i]]$getText(),width=73))
}

# convert tweets to a data frame
df <- do.call("rbind",lapply(rdmTweets,as.data.frame))
dim(df)
require(tm)
# build a corpus ,and specify the source to be character vectors
myCorpus <- Corpus(vectorSource(df$text))
# convert to lower case
myCorpus <- tm_map(myCorpus,tolower)
# remove punctuation
myCorpus <- tm_map(myCorpus,removePunctuation)
# remove numbers
myCorpus <- tm_map(myCorpus,removeNumbers)
# remove URLs
removeURL <-function(x) gsub("http[[:alnum:]]*","",x)
myCorpus <- tm_map(myCorpus,removeURL)
# add two extra stop words: "available" and "via"
myStopwords <- c(stopwords('english'),"available","via")
# remove "r" and "big" from  stopwords
myStopwords <- setdiff(myStopwords,c("r","big"))
myCorpus <- tm_map(myCorpus,removeWords,myStopwords)


#package 词干提取 Snowball RWeka,rJava,RWekajars


myCorpusCopy <- myCorpus
# stem words
myCorpus <- tm_map(myCorpus,stemDocument)
# stem completion
myCorpus <- tm_map(myCorpus,stemCompletion,dictionary = myCorpusCopy)

# count frequency of "mining"
miningCases <- tm_map(myCorpusCopy,grep,pattern="\\<mining")
sum(unlist(miningCases))

myTdm <- TermDocumentMatrix(myCorpus,
                control= list(wordLengths=c(1,Inf))
                )
聚类，分类，关联规则

# inspect frequent words
findFreqTerms(myTdm,lowfreq=10)
termFrequency <- rowSums(as.matrix(myTdm))
termFrequency <- subset(termFrequency,termFrequency>=10)
require(ggplot2)
qplot(names(termFrequency),termFrequency,geom="bar",xlab="Terms")+coord_flip()

barplot(termFrequency,las=2)

# which words are associated with "r"
findAssocs(myTdm,'r',0.25)
# which words are associated with "mining"
findAssocs(myTdm,'mining',0.25)

require(wordcloud)
m<- as.matrix(myTdm)
# calculate the frequency of words and sort it descendingly by frequency
wordFreq <- sort (rowSums(m),decreasing=T)
# word cloud
set.seed(375)
grayLevels <- gray((wordFreq+10)/(max(wordFreq)+10))
wordcloud(words=names(wordFreq),freq=wordFreq,min.freq=3,
                  random.order=F,colors=grayLevels
                  )

dist() 计算词项之间的距离，
hclust 对词项进行层次聚类
# remove sparse terms
myTdm2 <- removeSparseTerms (myTdm,sparse=0.95)
m2 <- as.matrix(myTdm2)
# cluster terms
distMatrix <- dist(scale(m2))
fit <- hclust(distMatrix,method="ward")
plot(fit)
# cut tree into 10 clusters
rect.hclust(fit,k=10)
(groups <- cutree(fit,k=10))

k-means

require(fpc)
# partitioning around medoids with estimation of number of clusters
pamResult <- pamk(m3,metric="manhattan")
# number of clusters identified
(k<- pamResult$nc)
pamResult<- pamResult$pamobject
for (i in 1:k){
  cat(paste("cluster",i,":"))
  cat(colnames(pamResult$medoids)[which(pamResult$medoids[i,]==1)],"\n")
}

layout(matrix(c(1,2),2,1)) # set to two graphs per page
plot(pamResult,color=F,labels=4,lines=0,cex=.8,col.clus=1,
      col.p=pamResult$clustering)
layout(matrix(1)) # change back to one graph per page
社交网络分析

require(igraph)

adjm <- matrix(sample(0:1, 100, replace=TRUE, prob=c(0.9,0.1)), nc=10)
g <- graph_from_adjacency_matrix( adjm )
g<- simplify(g)
V(g)$label <- V(g)$name
V(g)$degree <- degree(g)

set.seed(1952)
layout1 <- layout.fruchterman.reingold(g)
plot(g,layout=layout1)

plot(g,layout=layout.kamada.kawai)
tkplot(g,layout=layout.kamada.kawai)

t(M) %*% M

strptime(xxx$date,format="%d-%b-%y")

dates <- as.Date(housexxx$date,format="%d-%b-%y")
as.numeric(format(dates,"%y"))
as.numeric(format(dates,"%m"))

f<-stl(nottem, "per")

decompose
ARIMA
prop.table(table(cup),digits=1)

cut (xxx,right=F,breaks=c(0,0.1,10,15,20,max(xxx)))

age2 <- cut(xxx$age,right=F,breaks=seq(0,100,by=5))
boxplot(xxx$ttt~ age2,ylim=c(0,40),las=3)

correlation <- cor(xxx$d,xxx[,idx.num],use="pairwise.complete.obs")
correlation <- abs(correlation)
correlation <- correlation[,order(correlation,decreasing=T)]

cor(cup98[,idx.num])
paris(cup98)

分类变量 卡方检验 变量之间的关联
myChisqTest <- function(x){
  t1 <- table(xxx[,x],xxx$target_d2)
  plot(t1)
  print(x)
  print(chisq.test(t1))

}


nlevels

memory.limit()
memory.size()
memory.profile()

www.rdatamining.com

cran.r-project.org/doc/contrib/Ricci-refcard-regression.pdf
cran.r-project.org/doc/contrib/Ricci-refcard-ts.pdf
www.statmethods.net
pj.freefaculty.org/R/Rtips.html
www.cyclismo.org/tutorial/R/index.html
cran.r-project.org/other-docs.html
journal.r-project.org/current.html
processtrends.com/Learn_R_toolkit.htm
www.ats.ucla.edu/stat/r
www.r-tutor.com
www.matthewckeller.com/html/memory.html
https://stats.idre.ucla.edu/r/

www.autonlab.org/tutorials

www.liaad.up.pt/~ltorgo/dataMiningWithR
zoonek2.free.fr/unix/48_R/all.html
www.togaware.com/datamining/survivor


www-users.cs.umn.edu/%7ekumar/dmbook
www.cs.waikato.ac.nz/~ihw/dataMiningTalk






Data Visualization and Summarization

1. Collecting data: Whether the data is written on paper, recorded in text fles
and spreadsheets, or stored in an SQL database, you will need to gather it in
an electronic format suitable for analysis. This data will serve as the learning
material an algorithm uses to generate actionable knowledge.

2. Exploring and preparing the data: The quality of any machine learning
project is based largely on the quality of data it uses. This step in the machine
learning process tends to require a great deal of human intervention. An
often cited statistic suggests that 80 percent of the effort in machine learning
is devoted to data. Much of this time is spent learning more about the data
and its nuances during a practice called data exploration.

3. Training a model on the data: By the time the data has been prepared for
analysis, you are likely to have a sense of what you are hoping to learn from
the data. The specifc machine learning task will inform the selection of an
appropriate algorithm, and the algorithm will represent the data in the form
of a model.

4. Evaluating model performance: Because each machine learning model
results in a biased solution to the learning problem, it is important to
evaluate how well the algorithm learned from its experience. Depending
on the type of model used, you might be able to evaluate the accuracy of
the model using a test dataset, or you may need to develop measures of
performance specifc to the intended application.

5. Improving model performance: If better performance is needed, it becomes
necessary to utilize more advanced strategies to augment the performance
of the model. Sometimes, it may be necessary to switch to a different type of
model altogether. You may need to supplement your data with additional
data, or perform additional preparatory work as in step two of this process.


library(lattice)
bwplot(size ~ a1, data=algae,ylab=’River Size’,xlab=’Alga A1’)

minO2 <- equal.count(na.omit(algae$mnO2),number=4,overlap=1/5)
stripplot(season ~ a3|minO2,data=algae[!is.na(algae$mnO2),])

stripplot(size ~ mxPH | speed, data=algae, jitter=T)
library(cluster)

symnum
cor


Dear team 
The server cndcasp01b6 172.29.50.10 in China data center,
need a permission of accessing  to 117.28.233.124.
We wish can ping the Ip address and access the port 21.
The request has been already applied for.
But no reply from SSD.
The request is urgent.
Thanks a lot.


regression tree
library(rpart)
rt.a1 <- rpart(a1 ~ .,data=algae[,1:12])

plot(rt.a1,uniform=T,branch=1, margin=0.1, cex=0.9)
text(rt.a1,cex=0.75)

Fit a rpart model
Usage

rpart(formula, data, weights, subset, na.action = na.rpart, method,
      model = FALSE, x = FALSE, y = TRUE, parms, control, cost, ...)

Arguments
formula   

a formula, with a response but no interaction terms. If this a a data frame, that is taken as the model frame (see model.frame).
data  

an optional data frame in which to interpret the variables named in the formula.
weights   

optional case weights.
subset  

optional expression saying that only a subset of the rows of the data should be used in the fit.
na.action   

the default action deletes all observations for which y is missing, but keeps those in which one or more predictors are missing.
method  

one of "anova", "poisson", "class" or "exp". If method is missing then the routine tries to make an intelligent guess. If y is a survival object, then method = "exp" is assumed, if y has 2 columns then method = "poisson" is assumed, if y is a factor then method = "class" is assumed, otherwise method = "anova" is assumed. It is wisest to specify the method directly, especially as more criteria may added to the function in future.

Alternatively, method can be a list of functions named init, split and eval. Examples are given in the file ‘tests/usersplits.R’ in the sources, and in the vignettes ‘User Written Split Functions’.
model   

if logical: keep a copy of the model frame in the result? If the input value for model is a model frame (likely from an earlier call to the rpart function), then this frame is used rather than constructing new data.
x   

keep a copy of the x matrix in the result.
y   

keep a copy of the dependent variable in the result. If missing and model is supplied this defaults to FALSE.
parms   

optional parameters for the splitting function.
Anova splitting has no parameters.
Poisson splitting has a single parameter, the coefficient of variation of the prior distribution on the rates. The default value is 1.
Exponential splitting has the same parameter as Poisson.
For classification splitting, the list can contain any of: the vector of prior probabilities (component prior), the loss matrix (component loss) or the splitting index (component split). The priors must be positive and sum to 1. The loss matrix must have zeros on the diagonal and positive off-diagonal elements. The splitting index can be gini or information. The default priors are proportional to the data counts, the losses default to 1, and the split defaults to gini.
control   

a list of options that control details of the rpart algorithm. See rpart.control.
cost  

a vector of non-negative costs, one for each variable in the model. Defaults to one for all variables. These are scalings to be applied when considering splits, so the improvement on splitting on a variable is divided by its cost in deciding which split to choose.
...   

arguments to rpart.control may also be specified in the call to rpart. They are checked against the list of valid arguments.
Details

This differs from the tree function in S mainly in its handling of surrogate variables. In most details it follows Breiman et. al (1984) quite closely. R package tree provides a re-implementation of tree.
Value

An object of class rpart. See rpart.object. 



fit <- rpart(Kyphosis ~ Age + Number + Start, data = kyphosis)
fit2 <- rpart(Kyphosis ~ Age + Number + Start, data = kyphosis,
              parms = list(prior = c(.65,.35), split = "information"))
fit3 <- rpart(Kyphosis ~ Age + Number + Start, data = kyphosis,
              control = rpart.control(cp = 0.05))
par(mfrow = c(1,2), xpd = NA) # otherwise on some devices the text is clipped
plot(fit)
text(fit, use.n = TRUE)
plot(fit2)
text(fit2, use.n = TRUE)

printcp(fit)
rt2.a1 <- prune(rt.a1,cp=0.08)

The following R function obtains the h-days returns of a vector of values (for
instance the closing prices of a stock),

h.returns <- function(x,h=1) {
 diff(x,lag=h)/x[1:(length(x)-h)]
}
h.returns(c(45,23,4,56,-45,3),h=2)
# [1] -0.9111111 1.4347826 -12.2500000 -0.9464286
x <- c(45,23,4,56,-45,3)
h <- 2
diff(x,lag=h)



library(nnet)
nn <- nnet(r1.f1 ~ .,data=ibm.train[,-ncol(ibm.train)],
linout=T,size=10,decay=0.01,maxit=1000)

Description

Fit single-hidden-layer neural network, possibly with skip-layer connections.
Usage

nnet(x, ...)

## S3 method for class 'formula'
nnet(formula, data, weights, ...,
     subset, na.action, contrasts = NULL)

## Default S3 method:
nnet(x, y, weights, size, Wts, mask,
     linout = FALSE, entropy = FALSE, softmax = FALSE,
     censored = FALSE, skip = FALSE, rang = 0.7, decay = 0,
     maxit = 100, Hess = FALSE, trace = TRUE, MaxNWts = 1000,
     abstol = 1.0e-4, reltol = 1.0e-8, ...)

Arguments
formula   

A formula of the form class ~ x1 + x2 + ...
x   

matrix or data frame of x values for examples.
y   

matrix or data frame of target values for examples.
weights   

(case) weights for each example – if missing defaults to 1.
size  

number of units in the hidden layer. Can be zero if there are skip-layer units.
data  

Data frame from which variables specified in formula are preferentially to be taken.
subset  

An index vector specifying the cases to be used in the training sample. (NOTE: If given, this argument must be named.)
na.action   

A function to specify the action to be taken if NAs are found. The default action is for the procedure to fail. An alternative is na.omit, which leads to rejection of cases with missing values on any required variable. (NOTE: If given, this argument must be named.)
contrasts   

a list of contrasts to be used for some or all of the factors appearing as variables in the model formula.
Wts   

initial parameter vector. If missing chosen at random.
mask  

logical vector indicating which parameters should be optimized (default all).
linout  

switch for linear output units. Default logistic output units.
entropy   

switch for entropy (= maximum conditional likelihood) fitting. Default by least-squares.
softmax   

switch for softmax (log-linear model) and maximum conditional likelihood fitting. linout, entropy, softmax and censored are mutually exclusive.
censored  

A variant on softmax, in which non-zero targets mean possible classes. Thus for softmax a row of (0, 1, 1) means one example each of classes 2 and 3, but for censored it means one example whose class is only known to be 2 or 3.
skip  

switch to add skip-layer connections from input to output.
rang  

Initial random weights on [-rang, rang]. Value about 0.5 unless the inputs are large, in which case it should be chosen so that rang * max(|x|) is about 1.
decay   

parameter for weight decay. Default 0.
maxit   

maximum number of iterations. Default 100.
Hess  

If true, the Hessian of the measure of fit at the best set of weights found is returned as component Hessian.
trace   

switch for tracing optimization. Default TRUE.
MaxNWts   

The maximum allowable number of weights. There is no intrinsic limit in the code, but increasing MaxNWts will probably allow fits that are very slow and time-consuming.
abstol  

Stop if the fit criterion falls below abstol, indicating an essentially perfect fit.
reltol  

Stop if the optimizer is unable to reduce the fit criterion by a factor of at least 1 - reltol.
...   

arguments passed to or from other methods.
Details

If the response in formula is a factor, an appropriate classification network is constructed; this has one output and entropy fit if the number of levels is two, and a number of outputs equal to the number of classes and a softmax output stage for more levels. If the response is not a factor, it is passed on unchanged to nnet.default.

Optimization is done via the BFGS method of optim.
Value

object of class "nnet" or "nnet.formula". Mostly internal structure, but has components
wts   

the best set of weights found
value   

value of fitting criterion plus weight decay term.
fitted.values   

the fitted values for the training data.
residuals   

the residuals for the training data.
convergence   

1 if the maximum number of iterations was reached, otherwise 0. 

# use half the iris data
ir <- rbind(iris3[,,1],iris3[,,2],iris3[,,3])
targets <- class.ind( c(rep("s", 50), rep("c", 50), rep("v", 50)) )
samp <- c(sample(1:50,25), sample(51:100,25), sample(101:150,25))
ir1 <- nnet(ir[samp,], targets[samp,], size = 2, rang = 0.1,
            decay = 5e-4, maxit = 200)


test.cl <- function(true, pred) {
    true <- max.col(true)
    cres <- max.col(pred)
    table(true, cres)
}
test.cl(targets[-samp,], predict(ir1, ir[-samp,]))


# or
ird <- data.frame(rbind(iris3[,,1], iris3[,,2], iris3[,,3]),
        species = factor(c(rep("s",50), rep("c", 50), rep("v", 50))))
ir.nn2 <- nnet(species ~ ., data = ird, subset = samp, size = 2, rang = 0.1,
               decay = 5e-4, maxit = 200)
table(ird$species[-samp], predict(ir.nn2, ird[-samp,], type = "class"))



summary(nn)
nn.preds <- predict(nn,ibm.test)
plot(ibm.test[,1],nn.preds,ylim=c(-0.01,0.01),
main=’Neural Net Results’,xlab=’True’,ylab=’NN predictions’)
abline(h=0,v=0); abline(0,1,lty=2)

library(modreg)
pp <- ppr(r1.f1 ~ ., data=ibm.train[,-ncol(ibm.train)],nterms=5)

Multivariate adaptive regression splines (MARS)
library(mda)
m <- mars(ibm.train[,2:10],ibm.train[,1])
m.preds <- predict(m,ibm.test[,2:10])

Evaluating time series models

1. Given a series Rh(1), Rh(2), . . . , Rh(n) and a time t (< n)
2. Obtain a prediction model with training data Rh(1), Rh(2), . . . , Rh(t − 1)
3. REPEAT
4. Obtain a prediction for observation Rh(t)
5. Record the prediction error
6. Add Rh(t) to the training data
7. Obtain a new model with the new training set
8. Let t = t + 1
9. UNTIL t = n

An alternative is to use a sliding window,
1. Given a series Rh(1), Rh(2), . . . , Rh(n), a time t and a window size w
2. Obtain a prediction model with training data Rh(t− w − 1), . . . , Rh(t− 1)
3. REPEAT
4. Obtain a prediction for Rh(t)
5. Record the prediction error
6. Add Rh(t) to the training data and remove Rh(t − w − 1)
7. Obtain a new prediction model with the new training data
8. Let t = t + 1
9. UNTIL t = n


> naive.returns <- c(ibm.train[nrow(ibm.train),1],
+ ibm.test[1:(nrow(ibm.test)-1),1])
> theil <- function(preds,naive,true) {
+ sqrt(sum((true-preds)^2))/sqrt(sum((true-naive)^2))
+ }
> theil(nn.preds,naive.returns,ibm.test[,1])
[1] 0.7006378

> hit.rate <- function(preds,true) {
+ length(which(preds*true > 0))/length(which(true != 0))
+ }
> positive.hit.rate <- function(preds,true) {
+ length(which(preds > 0 & true > 0))/length(which(true > 0))
+ }
> negative.hit.rate <- function(preds,true) {
+ length(which(preds < 0 & true < 0))/length(which(true < 0))
+ }
> hit.rate(nn.preds,ibm.test[,1])
[1] 0.5051172
> positive.hit.rate(nn.preds,ibm.test[,1])
[1] 0.5753247
> negative.hit.rate(nn.preds,ibm.test[,1])
[1] 0.432505

> timeseries.eval <- function(preds,naive,true) {
+ th <- sqrt(sum((true-preds)^2))/sqrt(sum((true-naive)^2))
+ hr <- length(which(preds*true > 0))/length(which(true != 0))
+ pr <- length(which(preds > 0 & true > 0))/length(which(true > 0))
+ nr <- length(which(preds < 0 & true < 0))/length(which(true < 0))
+ n.sigs <- length(which(preds != 0))
+ perc.up <- length(which(preds > 0)) / n.sigs
+ perc.down <- length(which(preds < 0)) / n.sigs
+ round(data.frame(N=length(true),Theil=th,HitRate=hr,PosRate=pr,NegRate=nr,
+ Perc.Up=perc.up,Perc.Down=perc.down),
+ 3)
+ }
> timeseries.eval(nn.preds,naive.returns,ibm.test[,1])
N Theil HitRate PosRate NegRate Perc.Up Perc.Down
1 3122 0.701 0.505 0.575 0.433 0.573 0.427

> annualized.timeseries.eval <- function(preds,naive,test) {
+ res <- timeseries.eval(preds,naive,test[,1])
+
+ years <- unique(substr(test[,’Date’],1,4))
+ for(y in years) {
+ idx <- which(substr(test[,’Date’],1,4)==y)
+ res <- rbind(res,timeseries.eval(preds[idx],naive[idx],test[idx,1]))
+ }
+
+ row.names(res) <- c(’avg’,years)
+ res
+ }
> annualized.timeseries.eval(nn.preds,naive.returns,ibm.test)
first12y <- nrow(ibm.data[ibm.data$Date < ’1982-01-01’,])
train <- ibm.train[1:first12y,]
select <- ibm.train[(first12y+1):nrow(ibm.train),]


> res <- expand.grid(Size=c(5,10,15,20),
+ Decay=c(0.01,0.05,0.1),
+ MSE=0,
+ Hit.Rate=0)
> for(i in 1:12) {
+ nn <- nnet(r1.f1 ~ .,data=train[,-ncol(train)],linout=T,
+ size=res[i,’Size’],decay=res[i,’Decay’],maxit=1000)
+ nn.preds <- predict(nn,select)
+ res[i,’MSE’] <- mean((nn.preds-select[,1])^2)
+ res[i,’Hit.Rate’] <- hit.rate(nn.preds,select[,1])
+ }

> nn <- nnet(r1.f1 ~ .,data=train[,-ncol(train)],linout=T,size=20,decay=0.1,maxit=1000)
> nn.preds <- predict(nn,select)
> pp <- ppr(r1.f1 ~ ., data=train[,-ncol(train)],nterms=5)
> pp.preds <- predict(pp,select)
> m <- mars(train[,2:20],train[,1])
> m.preds <- predict(m,select[,2:20])
> naive.returns <- c(train[first12y,1],select[1:(nrow(select)-1),1])



> annualized.timeseries.eval(nn.preds,naive.returns,select)
N Theil HitRate PosRate NegRate Perc.Up Perc.Down
avg 2022 0.684 0.509 1 0 1 0
1982 253 0.687 0.506 1 0 1 0
1983 253 0.666 0.551 1 0 1 0
1984 253 0.695 0.492 1 0 1 0
1985 252 0.760 0.543 1 0 1 0
1986 253 0.696 0.492 1 0 1 0

> annualized.timeseries.eval(pp.preds,naive.returns,select)
N Theil HitRate PosRate NegRate Perc.Up Perc.Down
avg 2022 0.713 0.504 0.490 0.519 0.488 0.512
1982 253 0.709 0.506 0.492 0.522 0.498 0.502
1983 253 0.687 0.519 0.500 0.541 0.490 0.510
1984 253 0.727 0.463 0.450 0.476 0.482 0.518
1985 252 0.780 0.490 0.444 0.545 0.452 0.548
1986 253 0.722 0.561 0.521 0.600 0.455 0.545
1987 253 0.703 0.524 0.562 0.483 0.545 0.455
1988 253 0.700 0.485 0.449 0.520 0.474 0.526
1989 252 0.748 0.484 0.500 0.469 0.508 0.492
> annualized.timeseries.eval(m.preds,naive.returns,select)
N Theil HitRate PosRate NegRate Perc.Up Perc.Down
avg 2022 0.745 0.516 0.495 0.539 0.476 0.524
1982 253 0.687 0.545 0.517 0.574 0.482 0.518
1983 253 0.664 0.572 0.545 0.606 0.462 0.538
1984 253 0.699 0.504 0.533 0.476 0.522 0.478
1985 252 0.767 0.465 0.436 0.500 0.456 0.544
1986 253 0.709 0.492 0.455 0.528 0.462 0.538
1987 253 0.828 0.549 0.538 0.560 0.486 0.514
1988 253 0.705 0.519 0.483 0.553 0.470 0.530
1989 252 0.707 0.488 0.447 0.523 0.464 0.536

3.4 From predictions into trading actions

> buy.signals <- function(pred.ret,buy=0.05,sell=-0.05) {
+ sig <- ifelse(pred.ret < sell,’sell’,
+ ifelse(pred.ret > buy,’buy’,’hold’))
+ factor(sig,levels=c(’sell’,’hold’,’buy’))
+ }

3.4.1 Evaluating trading signals
> mars.actions <- buy.signals(m.preds,buy=0.01,sell=-0.01)
> market.moves <- buy.signals(select[,1],buy=0.01,sell=-0.01)
> table(mars.actions,market.moves)
market.moves
mars.actions sell hold buy
sell 7 3 7
hold 377 1200 415
buy 3 8 2

> signals.eval <- function(pred.sig,true.sig,true.ret) {
+ t <- table(pred.sig,true.sig)
+ n.buy <- sum(t[’buy’,])
+ n.sell <- sum(t[’sell’,])
+ n.sign <- n.buy+n.sell
+ hit.buy <- round(100*t[’buy’,’buy’]/n.buy,2)
+ hit.sell <- round(100*t[’sell’,’sell’]/n.sell,2)
+ hit.rate <- round(100*(t[’sell’,’sell’]+t[’buy’,’buy’])/n.sign,2)
+ ret.buy <- round(100*mean(as.vector(true.ret[which(pred.sig==’buy’)])),4)
+ ret.sell <- round(100*mean(as.vector(true.ret[which(pred.sig==’sell’)])),4)
+ data.frame(n.sess=sum(t),acc=hit.rate,acc.buy=hit.buy,acc.sell=hit.sell,
+ n.buy=n.buy,n.sell=n.sell,ret.buy=ret.buy,ret.sell=ret.sell)
+ }
> annualized.signals.results <- function(pred.sig,test) {
+ true.signals <- buy.signals(test[,1],buy=0,sell=0)
+ res <- signals.eval(pred.sig,true.signals,test[,1])
+ years <- unique(substr(test[,’Date’],1,4))
+ for(y in years) {
+ idx <- which(substr(test[,’Date’],1,4)==y)
+ res <- rbind(res,signals.eval(pred.sig[idx],true.signals[idx],test[idx,1]))
+ }
+ row.names(res) <- c(’avg’,years)
+ res
+ }
> annualized.signals.results(mars.actions,select)
n.sess acc acc.buy acc.sell n.buy n.sell ret.buy ret.sell
avg 2022 46.67 46.15 47.06 13 17 -0.0926 0.9472
1982 253 0.00 0.00 NaN 1 0 -1.0062 NaN
1983 253 NaN NaN NaN 0 0 NaN NaN
1984 253 NaN NaN NaN 0 0 NaN NaN
1985 252 NaN NaN NaN 0 0 NaN NaN
1986 253 NaN NaN NaN 0 0 NaN NaN
1987 253 40.00 42.86 37.50 7 8 -0.2367 2.2839
1988 253 50.00 33.33 60.00 3 5 0.0254 0.4773
1989 252 66.67 100.00 50.00 2 4 0.6917 -1.1390

> annualized.signals.results(buy.signals(pp.preds,buy=0.01,sell=-0.01),select)
n.sess acc acc.buy acc.sell n.buy n.sell ret.buy ret.sell
avg 2022 45.61 44.12 47.83 34 23 -0.4024 -0.2334
1982 253 42.86 50.00 0.00 6 1 -0.4786 1.4364
1983 253 100.00 NaN 100.00 0 1 NaN -1.8998
1984 253 100.00 NaN 100.00 0 1 NaN -1.8222
1985 252 NaN NaN NaN 0 0 NaN NaN
1986 253 0.00 0.00 0.00 4 2 -0.7692 0.1847
1987 253 48.00 47.37 50.00 19 6 -0.7321 -0.1576
1988 253 70.00 75.00 66.67 4 6 1.7642 -0.7143
1989 252 28.57 0.00 33.33 1 6 -0.8811 0.2966
> annualized.signals.results(buy.signals(nn.preds,buy=0.01,sell=-0.01),select)
n.sess acc acc.buy acc.sell n.buy n.sell ret.buy ret.sell
avg 2022 NaN NaN NaN 0 0 NaN NaN
1982 253 NaN NaN NaN 0 0 NaN NaN


> market <- ibm[ibm$Date > ’1981-12-31’ & ibm$Date < ’1990-01-01’,]
> t <- trader.eval(market,mars.actions)
> names(t)
[1] "trading" "N.trades" "N.profit" "Perc.profitable"
[5] "N.obj" "Max.L" "Max.P" "PL"
[9] "Max.DrawDown" "Avg.profit" "Avg.loss" "Avg.PL"
[13] "Sharpe.Ratio"

> plot(ts(t$trading[,c(2,4,5)]),main=’MARS Trading Results’)
> annualized.trading.results <- function(market,signals,...) {
+
+ res <- data.frame(trader.eval(market,signals,...)[-1])
+
+ years <- unique(substr(market[,’Date’],1,4))
+ for(y in years) {
+ idx <- which(substr(market[,’Date’],1,4)==y)
+ res <- rbind(res,data.frame(trader.eval(market[idx,],signals[idx],...)[-1]))
+ }
+ row.names(res) <- c(’avg’,years)
+ round(res,3)
+ }
If we apply this function to the trading actions of MARS we get the following
results,
> annualized.trading.results(market,mars.actions)
N.trades N.profit Perc.profitable N.obj Max.L Max.P PL Max.DrawDown
avg 13 9 69.231 9 6.857 5.797 211.818 312.075
1982 1 0 0.000 0 0.359 0.000 -7.120 85.440
1983 0 0 NaN 0 0.000 0.000 0.000 0.000
1984 0 0 NaN 0 0.000 0.000 0.000 0.000
1985 0 0 NaN 0 0.000 0.000 0.000 0.000
1986 0 0 NaN 0 0.000 0.000 0.000 0.000
1987 7 5 71.429 5 6.857 5.797 85.087 266.203
1988 3 3 100.000 3 0.000 2.875 149.341 38.580
1989 2 1 50.000 1 3.462 2.625 -17.029 69.150
Avg.profit Avg.loss Avg.PL Sharpe.Ratio
avg 2.853 3.725 0.829 0.011
1982 NaN 0.359 -0.359 -0.004
1983 NaN NaN NaN NaN
1984 NaN NaN NaN NaN
1985 NaN NaN NaN NaN
1986 NaN NaN NaN NaN
1987 3.100 5.543 0.631 0.014
1988 2.510 NaN 2.510 0.087
1989 2.625 3.462 -0.419 -0.015


> annualized.trading.results(market,mars.actions,bet=0.1,exp.prof=0.02,hold.time=15)
N.trades N.profit Perc.profitable N.obj Max.L Max.P PL Max.DrawDown
avg 13 9 69.231 10 5.685 4.258 34.672 197.031
1982 1 1 100.000 1 0.000 2.028 20.115 5.000
1983 0 0 NaN 0 0.000 0.000 0.000 0.000
1984 0 0 NaN 0 0.000 0.000 0.000 0.000
1985 0 0 NaN 0 0.000 0.000 0.000 0.000
1986 0 0 NaN 0 0.000 0.000 0.000 0.000
1987 7 4 57.143 5 5.685 4.258 -22.738 197.031
1988 3 3 100.000 3 0.000 1.353 29.594 21.560
1989 2 1 50.000 1 0.321 1.108 7.701 34.160
Avg.profit Avg.loss Avg.PL Sharpe.Ratio
avg 1.553 2.624 0.268 0.004
1982 2.028 NaN 2.028 0.045
1983 NaN NaN NaN NaN
1984 NaN NaN NaN NaN
1985 NaN NaN NaN NaN

ma <- function(x,lag) {
require(’ts’)
c(rep(NA,lag),apply(embed(x,lag+1),1,mean))
}

ma20.close <- ma(ibm$Close,lag=20)
> plot(ibm$Close[1:1000],main=’’,type=’l’,ylab=’Value’,xlab=’Day’)
> lines(ma20.close[1:1000],col=’red’,lty=2)
> lines(ma(ibm$Close,lag=100)[1:1000],col=’blue’,lty=3)
> legend(1.18, 22.28, c("Close", "MA(20)", "MA(100)"),
+ col = c(’black’,’red’,’blue’),lty = c(1,2,3))

> ma.indicator <- function(x,ma.lag=20) {
+ d <- diff(sign(x-c(rep(NA,ma.lag-1),apply(embed(x,ma.lag),1,mean))))
+ factor(c(rep(0,ma.lag),d[!is.na(d)]),
+ levels=c(-2,0,2),labels=c(’sell’,’hold’,’buy’))
+ }

> trading.actions <- data.frame(Date=ibm$Date[1:1000],
+ Signal=ma.indicator(ibm$Close[1:1000]))
> trading.actions[which(trading.actions$Signal==’buy’),][1:10,]
Date Signal
29 1970-02-11 buy
58 1970-03-25 buy
69 1970-04-10 buy
104 1970-05-29 buy
116 1970-06-16 buy
138 1970-07-17 buy
147 1970-07-30 buy
162 1970-08-20 buy
207 1970-10-23 buy
210 1970-10-28 buy

> ma30.actions <- data.frame(Date=ibm[ibm$Date < ’1990-01-01’,’Date’],
+ Signal=ma.indicator(ibm[ibm$Date < ’1990-01-01’,’Close’],ma.lag=30))
> ma30.actions <- ma30.actions[ma30.actions$Date > ’1981-12-31’,’Signal’]
> annualized.trading.results(market,ma30.actions)
N.trades N.profit Perc.profitable N.obj Max.L Max.P PL Max.DrawDown
avg 96 38 39.583 2 9.195 8.608 -1529.285 1820.19
1982 10 5 50.000 2 7.194 8.608 207.665 243.28

> ema <- function (x, beta = 0.1, init = x[1])
+ {
+ require(’ts’)
+ filter(beta*x, filter=1-beta, method="recursive", init=init)
+ }

> plot(ibm$Close[1:1000],main=’’,type=’l’,ylab=’Value’,xlab=’Day’)
> lines(ma(ibm$Close[1:1000],lag=100),col=’blue’,lty=3)
> lines(ema(ibm$Close[1:1000],beta=0.0198),col=’red’,lty=2)
> legend(1.18, 22.28, c("Close", "MA(100)", "EMA(0.0198)"),
+ col = c(’black’,’blue’,’red’),lty = c(1,3,2),bty=’n’)

> macd <- function(x,long=26,short=12) {
+ ema(x,lambda=1/(long+1))-ema(x,lambda=1/(short+1))
+ }

> macd.indicator <- function(x,long=26,short=12,signal=9) {
+ v <- macd(x,long,short)
+ d <- diff(sign(v-ema(v,lambda=1/(signal+1))))
+ factor(c(0,0,d[-1]),levels=c(-2,0,2),labels=c(’sell’,’hold’,’buy’))
+ }

> moving.function <- function(x, lag, FUN, ...) {
+ require(’ts’)
+ FUN <- match.fun(FUN)
+ c(rep(NA,lag),apply(embed(x,lag+1),1,FUN,...))
+ }
> rsi.aux <- function(diffs,lag) {
+ u <- length(which(diffs > 0))/lag
+ d <- length(which(diffs < 0))/lag
+ ifelse(d==0,100,100-(100/(1 + u/d)))
+ }
> rsi <- function(x,lag=20) {
+ d <- c(0,diff(x))
+ moving.function(d,lag,rsi.aux,lag)
+ }

> rsi.indicator <- function(x,lag=20) {
+ r <- rsi(x,lag)
+ d <- diff(ifelse(r > 70,3,ifelse(r<30,2,1)))
+ f <- cut(c(rep(0,lag),d[!is.na(d)]),breaks=c(-3,-2,-1,10),
+ labels=c(’sell’,’buy’,’hold’),right=T)
+ factor(f,levels=c(’sell’,’hold’,’buy’))
+ }

> ad.line <- function(df) {
+ df$Volume*((df$Close-df$Low) - (df$High-df$Close))/(df$High-df$Low)
+ }
> chaikin.oscillator <- function(df,short=3,long=10) {
+ ad <- ad.line(df)
+ ewma(ad,lambda=1/(short+1))-ewma(ad,lambda=1/(long+1))
+ }

chaikin <- chaikin.oscillator(ibm[1:first12y,])

> d5.returns <- h.returns(ibm[,’Close’],h=5)
> var.20d <- moving.function(ibm[,’Close’],20,sd)
> dif.returns <- diff(h.returns(ibm[,’Close’],h=1))

unit of observation


The phrase unit of observation is used to describe the units that the examples are
measured in. Commonly, the unit of observation is in the form of transactions,
persons, time points, geographic regions, or measurements. Other possibilities
include combinations of these such as person years, which would denote cases where
the same person is tracked over multiple time points.
A feature is a characteristic or attribute of an example, which might be useful for
learning the desired concept. In the previous examples, attributes in the spam
detection dataset might consist of the words used in the e-mail messages. For the
cancer dataset, the attributes might be genomic data from the biopsied cells, or
measured characteristics of the patient such as weight, height, or blood pressure.

Features come in various forms as well. If a feature represents a characteristic
measured in numbers, it is unsurprisingly called numeric. Alternatively, if it
measures an attribute that is represented by a set of categories, the feature is called
categorical or nominal. A special case of categorical variables is called ordinal,
which designates a nominal variable with categories falling in an ordered list.
Some examples of ordinal variables include clothing sizes such as small, medium,
and large, or a measurement of customer satisfaction on a scale from 1 to 5. It is
important to consider what the features represent because the type and number
of features in your dataset will assist with determining an appropriate machine
learning algorithm for your task.


因数据定model

Thinking about types of machine learning
algorithms
Machine learning algorithms can be divided into two main groups: supervised
learners that are used to construct predictive models, and unsupervised learners that
are used to build descriptive models. Which type you will need to use depends on
the learning task you hope to accomplish.
A predictive model is used for tasks that involve, as the name implies, the prediction
of one value using other values in the dataset. The learning algorithm attempts to
discover and model the relationship among the target feature (the feature being
predicted) and the other features. Despite the common use of the word "prediction"
to imply forecasting predictive models need not necessarily foresee future events. For
instance, a predictive model could be used to predict past events such as the date of a
baby's conception using the mother's hormone levels; or, predictive models could be
used in real time to control traffc lights during rush hours.
Because predictive models are given clear instruction on what they need to learn and
how they are intended to learn it, the process of training a predictive model is known
as supervised learning. The supervision does not refer to human involvement, but
rather the fact that the target values provide a supervisory role, which indicates to
the learner the task it needs to learn. Specifcally, given a set of data, the learning
algorithm attempts to optimize a function (the model) to fnd the combination of
feature values that result in the target output.
The often used supervised machine learning task of predicting which category an
example belongs to is known as classifcation. It is easy to think of potential uses for
a classifer. For instance, you could predict whether:
• A football team will win or lose
• A person will live past the age of 100
• An applicant will default on a loan
• An earthquake will strike next year
The target feature to be predicted is a categorical feature known as the class and is
divided into categories called levels. A class can have two or more levels, and the
levels need not necessarily be ordinal. Because classifcation is so widely used in
machine learning, there are many types of classifcation algorithms.

supervised learners  ---》 construct predictive models

unsupervised learners --》 build descriptive models
 learning task 

predictive models：
 involve, as the name implies, the prediction
of one value using other values in the dataset.
The learning algorithm attempts to
discover and model the relationship among the target feature (the feature being
predicted) and the other features. 

the process of training a predictive model is known
as supervised learning. 

 Specifcally, given a set of data, the learning
algorithm attempts to optimize a function (the model) to fnd the combination of
feature values that result in the target output


predicting which category an
example belongs to is known as classifcation

It is easy to think of potential uses for
a classifer. For instance, you could predict whether:

 A football team will win or lose
• A person will live past the age of 100
• An applicant will default on a loan
• An earthquake will strike next year

The target feature to be predicted is a categorical feature known as the class and is
divided into categories called levels. A class can have two or more levels, and the
levels need not necessarily be ordinal. Because classifcation is so widely used in
machine learning, there are many types of classifcation algorithms.

it is easy to convert numbers to categories
categories to numbers 
between classifcation models and numeric prediction models

A descriptive model is used for tasks that would beneft from the insight gained
from summarizing data in new and interesting ways. As opposed to predictive
models that predict a target of interest; in a descriptive model, no single feature is
more important than any other. In fact, because there is no target to learn, the process
of training a descriptive model is called unsupervised learning. Although it can be
more diffcult to think of applications for descriptive models—after all, what good is
a learner that isn't learning anything in particular—they are used quite regularly for
data mining.


For example, the descriptive modeling task called pattern discovery is used to
identify frequent associations within data. Pattern discovery is often used for market
basket analysis on transactional purchase data. Here, the goal is to identify items
that are frequently purchased together, such that the learned information can be used
to refne the marketing tactics. For instance, if a retailer learns that swimming trunks
are commonly purchased at the same time as sunscreen, the retailer might reposition
the items more closely in the store, or run a promotion to "up-sell" customers on
associated items.

Originally used only in retail contexts, pattern discovery is now
starting to be used in quite innovative ways. For instance, it can
be used to detect patterns of fraudulent behavior, screen for
genetic defects, or prevent criminal activity.

 detect patterns of fraudulent behavior, screen for
genetic defects, or prevent criminal activity

The descriptive modeling task of dividing a dataset into homogeneous groups is
called clustering. This is sometimes used for segmentation analysis that identifes
groups of individuals with similar purchasing, donating, or demographic
information so that advertising campaigns can be tailored to particular audiences.
Although the machine is capable of identifying the groups, human intervention is
required to interpret them. For example, given fve different clusters of shoppers at
a grocery store, the marketing team will need to understand the differences among
the groups in order to create a promotion that best suits each group. However, this is
almost certainly easier than trying to create a unique appeal for each customer


Matching your data to an appropriate algorithm



The following table lists the general types of machine learning algorithms covered
in this book, each of which may be implemented in several ways. Although this
covers only some of the entire set of all machine learning algorithms, learning these
methods will provide a suffcient foundation for making sense of other methods as
you encounter them.
Model Task Chapter
Supervised Learning Algorithms
Nearest Neighbor Classification Chapter 3
naive Bayes Classification Chapter 4
Decision Trees Classification Chapter 5
Classification Rule Learners Classification Chapter 5
Linear Regression Numeric
prediction
Chapter 6
Regression Trees Numeric
prediction
Chapter 6
Model Trees Numeric
prediction
Chapter 6
Neural Networks Dual use Chapter 7
Support Vector Machines Dual use Chapter 7
Unsupervised Learning Algorithms
Association Rules Pattern detection Chapter 8
k-means Clustering Clustering Chapter 9

Managing and
Understanding Data

become very familiar with these structures as you create and manipulate datasets
practical, as it covers several functions that are useful for getting data in and out of R
methods for understanding data are illustrated throughout the process of exploring a real-world dataset

The basic R data structures and how to use them to store and extract data
How to get data into R from a variety of source formats
Common methods for understanding and visualizing complex data

features that represent a
characteristic with categories of values are known as nominal. Although it is possible
to use a character vector to store nominal data, R provides a data structure known as
a factor specifcally for this purpose. A factor is a special case of vector that is solely
used for representing nominal variables. In the medical dataset we are building,
we might use a factor to represent gender, because it uses two categories: MALE
and FEMALE.

gender <- factor(c("MALE", "FEMALE", "MALE"))
> gender %>%str
 Factor w/ 2 levels "FEMALE","MALE": 2 1 2
blood <- factor(c("O", "AB", "A"),
levels = c("A", "B", "AB", "O"))


subject1 <- list(fullname = subject_name[1],
temperature = temperature[1],
flu_status = flu_status[1],
gender = gender[1],
blood = blood[1])

subject1[c("temperature", "flu_status")]

pt_data <- data.frame(subject_name, temperature, flu_status,
gender, blood, stringsAsFactors = FALSE)

pt_data

pt_data[c("temperature", "flu_status")]
pt_data[c(1, 3), c(2, 4)]

pt_data[ , ]

Matrixes and arrays
m <- matrix(c('a', 'b', 'c', 'd'), nrow = 2)
m <- matrix(c('a', 'b', 'c', 'd'), ncol = 2)

save(x, y, z, file = "mydata.RData")
load("mydata.RData")
save.image()

pt_data <- read.csv("pt_data.csv", stringsAsFactors = FALSE)

mydata <- read.csv("mydata.csv", stringsAsFactors = FALSE,
header = FALSE)

write.csv(pt_data, file = "pt_data.csv")
install.packages("RODBC")
library(RODBC)
mydb <- odbcConnect("my_dsn")
mydb <- odbcConnect("my_dsn", uid = "my_username"
pwd = "my_password")

patient_query <- "select * from patient_data where alive = 1"
patient_data <- sqlQuery(channel = mydb, query = patient_query,
stringsAsFactors = FALSE)

usedcars <- read.csv("usedcars.csv", stringsAsFactors = FALSE)


Measuring the central tendency – mean and median
mean(c(36000, 44000, 56000))
median(c(36000, 44000, 56000))




