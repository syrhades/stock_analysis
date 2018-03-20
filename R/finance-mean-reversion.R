#finance-mean-reversion/
dateArea<-function(sDate=Sys.Date()-365,eDate= Sys.Date(),before=0){  #开始日期，结束日期，提单开始时
    if(class(sDate)=='character') sDate=as.Date(sDate)
    if(class(eDate)=='character') eDate=as.Date(eDate)  
    return(paste(sDate-before,eDate,sep="/"))
}

# 计算移动平均线
ma<-function(cdata,mas=c(5,20,60)){
    if(nrow(cdata)<=max(mas)) return(NULL)
    ldata<-cdata
    for(m in mas){
        ldata<-merge(ldata,SMA(cdata,m))
    }
    names(ldata)<-c('Value',paste('ma',mas,sep=''))
    return(ldata)
}

# 日K线和均线
title<-'000001.SZ'
SZ000011<-data[[title]]                             # 获得股票数据
sDate<-as.Date("2015-01-01")                        # 开始日期
eDate<-as.Date("2015-07-10")                        # 结束日期
cdata<-SZ000011[dateArea(sDate,eDate,360)]$Close    # 获得收盘价
ldata<-ma(cdata,c(5,20,60))                         # 选择移动平均指标
tail(ldata)

drawLine<-function(ldata,titie="Stock_MA",sDate=min(index(ldata)),eDate=max(index(ldata)),breaks="1 year",avg=FALSE,out=FALSE){
    if(sDate<min(index(ldata))) sDate=min(index(ldata))
    if(eDate>max(index(ldata))) eDate=max(index(ldata))  
    ldata<-na.omit(ldata)
    
    g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
    g<-g+geom_line()
    g<-g+geom_line(aes(colour=Series),data=fortify(ldata[,-1],melt=TRUE))

    if(avg){
        meanVal<<-round(mean(ldata[dateArea(sDate,eDate)]$Value),2) # 均值
        g<-g+geom_hline(aes(yintercept=meanVal),color="red",alpha=0.8,size=1,linetype="dashed")
        g<-g+geom_text(aes(x=sDate, y=meanVal,label=meanVal),color="red",vjust=-0.4)
    }
    g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks(breaks),limits = c(sDate,eDate))
    g<-g+ylim(min(ldata$Value), max(ldata$Value))
    g<-g+xlab("") ylab("Price")+ggtitle(title)
    g
}

drawLine(ldata,title,sDate,eDate,'1 month',TRUE)    # 画图




# 差值和平均标准差，大于2倍平均标准差的点
> buyPoint<-function(ldata,x=2,dir=2){})     # ...代码省略

# 画交易信号点
> drawPoint<-function(ldata,pdata,titie,sDate,eDate,breaks="1 year"){
+     ldata<-na.omit(ldata)
+     g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
+     g<-g+geom_line()
+     g<-g+geom_line(aes(colour=Series),data=fortify(ldata[,-1],melt=TRUE))
+     
+     if(is.data.frame(pdata)){
+         g<-g+geom_point(aes(x=Index,y=Value,colour=op),data=pdata,size=4)
+     }else{
+         g<-g+geom_point(aes(x=Index,y=Value,colour=Series),data=na.omit(fortify(pdata,melt=TRUE)),size=4)  
+     }
+     g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks(breaks),limits = c(sDate,eDate))
+     g<-g+xlab("") + ylab("Price")+ggtitle(title)
+     g
+ }
 
> buydata<-buyPoint(ldata20,2,2)                                       # 多空信号点
> drawPoint(ldata20[,c(1,2)],buydata$Value,title,sDate,eDate,'1 month')  # 画图

# 资产净值曲线
> drawAsset<-function(ldata,adata,sDate=FALSE,capital=100000){
+     if(!sDate) sDate<-index(ldata)[1]
+     adata<-rbind(adata,as.xts(capital,as.Date(sDate)))
+     
+     g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
+     g<-g+geom_line()
+     g<-g+geom_line(aes(x=as.Date(Index), y=Value,colour=Series),data=fortify(adata,melt=TRUE))
+     g<-g+facet_grid(Series ~ .,scales = "free_y")
+     g<-g+scale_y_continuous(labels=dollar_format(prefix = "￥"))
+     g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks("2 months"),limits = c(sDate,eDate))
+     g<-g+xlab("") + ylab("Price")+ggtitle(title)
+     g
+ }

> drawAsset(ldata20,as.xts(result$ticks['asset']))  # 资产净值曲线

chartSeries(IBM,TA = "addVo(); addSMA(); addEnvelope();addMACD(); addROC()")

