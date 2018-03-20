w<-c(40,50,60,70,75,90)    
h<-c(148,150,170,166,67,191)  
a<-c(1,2,2,1,1,2)    
dat2<-data.frame(a=a,h=h,w=w)  
dat2  
sum_add2<-function(x){
sum(x)+2
}
apply(dat2,MARGIN=1,sum_aad2)  #自定义函数
[1] 191 204 234 239 145 285 
apply（dat2,1,function(x) sum(x)+2）
[1] 191 204 234 239 145 285
apply(dat2,1,function(x,y) mean(x)/y,y=10)
[1] 6.300000 6.733333 7.733333 7.900000 4.766667 9.433333
