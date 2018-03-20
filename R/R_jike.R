

#################################################
 require(ggplot2)
 x<-seq(-2*pi,2*pi,by=0.01)
 s1<-data.frame(x,y=sin(x),type=rep('sin',length(x)))
 df<-rbind(s1)
 g<-ggplot(df,aes(x,y))
 g<-g+geom_line(aes(colour=type,stat='identity'))
 g

 ######################################

 f1 <- function(x,a,b) a*x+b
a<-5
b<-10
result <- uniroot(f1,c(-10,10),a=a,b=b,tol=0.0001)
result$root

f2 <- function(x,a,b,c) a*x^2+b*x +c
a<-1
b<-5
c<-6
result <- uniroot(f2,c(-4,10),a=a,b=b,c=c,tol=0.0001)
result$root

lf<-matrix(c(3,5,1,2),nrow=2,byrow=TRUE)
rf<-matrix(c(4,1),nrow=2,byrow=TRUE)
result<- solve(lf,rf)
result

lf<-matrix(c(3),nrow=2,byrow=TRUE)
rf<-matrix(c(4,1),nrow=2,byrow=TRUE)
result<- solve(lf,rf)
result


sample(1:5,1)
runif(10,0,1)
mode

names(which.max(table(S)))
min(S)
which.min(S)
median(s)

quantile(S)

fivenum(s)

require(PerformanceAnalytics)
S <- rnorm(10000)
skewness(S) #偏度
hist(S,breaks=100)

kurtosis(S) # 峰态系数
choose(4,2)/2^4

pbinom(5000,10000,0.5)

uniform distribution


dx <- deriv(y~x^3,"x")
dx
x<-1
eval(dx)

dx <- deriv(y~sin(x),"x",func = TRUE)
dx

