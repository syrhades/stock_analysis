library(plyr)
library(quantmod)
library(TTR)
library(ggplot2)
library(scales)
require(data.table)

#下载数据
download<-function(stock,from="2010-01-01"){
df<-getSymbols(stock,from=from,env=environment(),auto.assign=FALSE)  #下载数据
names(df)<-c("Open","High","Low","Close","Volume","Adjusted")
write.zoo(df,file=paste(stock,".csv",sep=""),sep=",",quote=FALSE) #保存到本地
}

#本地读数据
read<-function(stock){  
 as.xts(read.zoo(file=paste(stock,".csv",sep=""),header = TRUE,sep=",", format="%Y-%m-%d"))
}

stock<-"IBM"
download(stock,from='2010-01-01')
IBM<-read(stock)


ma<-function(cdata,mas=c(5,20,60)){ 
    ldata<-cdata
    for(m in mas){
        ldata<-merge(ldata,SMA(cdata,m))
    }
    ldata<-na.locf(ldata, fromLast=TRUE)
    names(ldata)<-c('Value',paste('ma',mas,sep=''))
    return(ldata)
}

drawLine<-function(ldata,titie="Stock_MA",sDate=min(index(ldata)),eDate=max(index(ldata)),out=FALSE){
    g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
    g<-g+geom_line()
    g<-g+geom_line(aes(colour=Series),data=fortify(ldata[,-1],melt=TRUE))
    g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks("2 months"),limits = c(sDate,eDate))
    g<-g+xlab("") + ylab("Price")+ggtitle(title)
    if(out) ggsave(g,file=paste(titie,".png",sep=""))
    else g
}


cdata<-last(IBM, '9months')$Close    #['2010/2012']$Close
cdata<-IBM['2016']$Close    #['2010/2012']$Close

cdata<-IBM$Close    #['2010/2012']$Close
title<-"Stock_IBM" #
ldata<-ma(cdata,c(5,20,60))
sDate<-as.Date("2010-1-1") #开始日期
eDate<-as.Date("2012-1-1") #结束日期
#drawLine(ldata,title,sDate,eDate) #
drawLine(ldata,title) #


# 均线图+散点
drawPoint<-function(ldata,pdata,titie,sDate,eDate){
   g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
   g<-g+geom_line()
   g<-g+geom_line(aes(colour=Series),data=fortify(ldata[,-1],melt=TRUE))
   g<-g+geom_point(aes(x=Index,y=Value,colour=Series),data=fortify(pdata,melt=TRUE))
   g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks("2 months"),limits = c(sDate,eDate))
   g<-g+xlab("") + ylab("Price")+ggtitle(title)
   g
 }


# 基于上面的定义的均线函数，我们就可以设计自己的交易策略模型了。

# 模型设计思路：

# 1. 以股价和20日均线的交叉，进行交易信号的判断。
# 2. 当股价上穿20日均线则买入(红色)，下穿20日均线卖出(蓝色)。
# 画出股价和20日均线图


#        Index Series    Value
# 1 2010-01-04   down 128.7955
# 2 2010-01-05   down 128.7955
# 3 2010-01-06   down 128.7955
# 4 2010-01-07   down 128.7955
# 5 2010-01-08   down 128.7955
# 6 2010-01-11   down 128.7955



ldata<-ma(cdata,c(20))
drawLine(ldata,title,sDate,eDate)

genPoint<-function(pdata,ldata){


}

myFUN<-function(x,c1,c2){
	if (x[c1]>x[c2])

	return (c(as.complex(x[c1]),"down"))
	else return(c(as.complex(x[c1]),"up"))
}


Series<-apply(ldata,1,myFUN,c1='Value',c2='ma20')
#Transfer Series
Series<-t(Series)
df_series<-as.data.frame(Series)

df_series<-cbind(df_series,index(ldata))
colnames(df_series)<-c("Value","Series","Index")


pdata<-xts(pdata,index(ldata))


g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
g<-g+geom_line()
pdata<-df_series
g<-g+geom_point(aes(x=Index,y=Value,colour=Series),data=fortify(pdata,melt=TRUE))

g<-geom_line(data=df_series,aes(x=index(df_series),y=Value,colour=factor(Flag)))
g<-ggplot(data=df_series,aes(x=index(df_series),y=Value,colour=factor(Flag)))

g<-geom_line(df_series,aes(x=date,y=Flag,colour=factor(Flag)))
pdata<-xts(df_series,index(ldata))

# dimnames(Series)<-list(dimnames(Series[1]),c("Value","flag"))

g<-ggplot(aes(x=Index, y=Value),data=fortify(pdata,melt=TRUE))
g<-g+geom_point(aes(x=Index,y=Value,colour=Series),data=pdata)
 g
g<-g+geom_line(aes(x=Index,y=Value),data=pdata)
g

p <- ggplot(pdata, aes(Index, Value)) + geom_point()



# 均线图+散点
drawPoint<-function(ldata,pdata,titie,sDate,eDate){
   g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
   g<-g+geom_line()
   g<-g+geom_line(aes(colour=Flag),data=fortify(ldata[,-1],melt=TRUE))
   g<-g+geom_point(aes(x=Index,y=Value,colour=Flag),data=fortify(pdata,melt=TRUE))
   g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks("2 months"),limits = c(sDate,eDate))
   g<-g+xlab("") + ylab("Price")+ggtitle(title)
   g
 }



# is.matrix(as.matrix(1:10))
# !is.matrix(warpbreaks)  # data.frame, NOT matrix!
# warpbreaks[1:10,]
# as.matrix(warpbreaks[1:10,])  # using as.matrix.data.frame(.) method

# ## Example of setting row and column names
# mdat <- matrix(c(1,2,3, 11,12,13), nrow = 2, ncol = 3, byrow = TRUE,
#                dimnames = list(c("row1", "row2"),
#                                c("C.1", "C.2", "C.3")))
# mdat

#             Value op
# 2010-01-04 132.45  B
# 2010-01-22 125.50  S
# 2010-02-17 126.33  B
# 2010-03-09 125.55  S
# 2010-03-11 127.60  B
# 2010-04-08 127.61  S


# # 生成data.frame
# > x <- cbind(x1 = 3, x2 = c(4:1, 2:5)); x
#      x1 x2
# [1,]  3  4
# [2,]  3  3
# [3,]  3  2
# [4,]  3  1
# [5,]  3  2
# [6,]  3  3
# [7,]  3  4
# [8,]  3  5

# # 自定义函数myFUN，第一个参数x为数据
# # 第二、三个参数为自定义参数，可以通过apply的'...'进行传入。
# > myFUN<- function(x, c1, c2) {
# +   c(sum(x[c1],1), mean(x[c2])) 
# + }

# # 把数据框按行做循环，每行分别传递给myFUN函数，设置c1,c2对应myFUN的第二、三个参数
# > apply(x,1,myFUN,c1='x1',c2=c('x1','x2'))
#      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8]
# [1,]  4.0    4  4.0    4  4.0    4  4.0    4
# [2,]  3.5    3  2.5    2  2.5    3  3.5    4



# apply(series,1,setvalue)



# p<- ggplot(pdata, aes(Index, Value,colour=Series)) + geom_point()
# p<-p+geom_line(pdata, aes(Index, Value)


# #Transfer Series
# Series<-t(Series)
# df_series<-as.data.frame(Series)

# # df_series<-cbind(df_series,index(ldata))
# colnames(df_series)<-c("Value","Series")



# generate buy sell point part
# pdata<-xts(df_series,index(ldata))
pdata$Series

myFUN<-function(x,c1,c2){
	if (x[c1]>x[c2])
		return (c("down"))
	else return(c("up"))
}

Series<-apply(ldata,1,myFUN,c1='Value',c2='ma20')
pdata<-data.frame(Series=Series,Value=ldata$Value,Index=index(ldata))
pdata2<-xts(pdata,index(ldata))

myFUN_set_bs_point<-function(x,c1,c2){
# cat (x[c1])
	if (x[c1]== "up" && x[c2] == "down")
		return (c("S"))
	if (x[c1]== "down" && x[c2] == "up")
		return (c("B"))
}


myFUN_return_bs_point<-function(pdata2,cdata){
	# generate buy sell point 
	compare1<-cbind(pdata2$Series,Lag(pdata2$Series))
	# na.fill(z,)
	compare1<-compare1[-1]
	BSpoint<-apply(compare1,1,myFUN_set_bs_point,c1='Series',c2='Lag.1')
	# bslist<-unlist(BSpoint)

	# as.data.frame(BSpoint)
	dfBSpoint<-as.data.frame(unlist(BSpoint))
	dfBSpoint<-cbind(BS_POINT=dfBSpoint,Date=as.Date(row.names(dfBSpoint)))
	valuedf<-as.data.frame(cdata)
	valuedf<-cbind(BS_POINT=valuedf,Date=as.Date(row.names(valuedf)))
	BS_table<-merge(valuedf,dfBSpoint)
	colnames(BS_table)<-c("Date","Close","Type")
	return(BS_table)
}





BS_table<-myFUN_return_bs_point(pdata2,cdata)



drawPoint<-function(ldata,BS_table,titie,sDate,eDate){
	g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
	g<-g+geom_line()
	g<-g+geom_line(aes(colour=Series),data=fortify(ldata[,-1],melt=TRUE))

	g<-g+geom_point(aes(x=Date,y=Close,colour=Type),data=fortify(BS_table,melt=TRUE))
	g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks("2 months"),limits = c(sDate,eDate))
	g<-g+xlab("") + ylab("Price")+ggtitle(title)
	g
}

drawPoint(ldata,BS_table,titie,sDate,eDate)


#模拟交易
#参数：交易信号,本金,持仓比例,手续费比例
#接下来，我们要利用交易信号数据，进行模拟交易。我们设定交易参数，以$10W为本金，满仓买入或卖出，手续为0，传入交易信号。
#BS_table
#head(BS_table)
#        Date  Close Type
#1 2010-01-22 125.50    S
#2 2010-02-17 126.33    B
#3 2010-03-09 125.55    S
#4 2010-03-11 127.60    B
#5 2010-04-08 127.61    S
#6 2010-04-09 128.76    B


for (n in BS_table) {
	if (n["Type"] == "B")
		cat (n["Close"])
}


#             Value op     cash amount     asset     diff
# 2010-01-04 132.45  B     0.25    755 100000.00     0.00
# 2010-01-22 125.50  S 94752.75      0  94752.75 -5247.25
# 2010-02-17 126.33  B     5.25    750  94752.75     0.00
# 2010-03-09 125.55  S 94167.75      0  94167.75  -585.00
# 2010-03-11 127.60  B   126.55    737  94167.75     0.00
# 2010-04-08 127.61  S 94175.12      0  94175.12     7.37

my_trade<-function(BS_table,capital=100000,position=1,fee=0){
	capital=100000
	asset<-capital
	amount=0
	diff=0
	v_amount<-c()
	v_cash<-c()
	v_asset<-c()
	v_diff<-c()
	for (n in 1:nrow(BS_table)) {
			Type<-BS_table[n,3]
			Close<-BS_table[n,2]
			#print(Type)
			if (Type == "B"){
				amount<-asset%/%Close
				cash<-asset%%Close
				asset<-amount*Close+cash
			}
			if (Type == "S" && amount != 0){
				cash<-cash+amount*Close
				amount<-0
				asset<-cash
			}
			v_amount<-append(v_amount,amount)
			v_cash<-append(v_cash,cash)
			v_asset<-append(v_asset,asset)

			cur_postiont<-length(v_asset)
			if (cur_postiont>2){
				v_diff<-append(v_diff,v_asset[cur_postiont]-v_asset[cur_postiont-1])
			}
			else{v_diff<-append(v_diff,asset-capital)

			}
			#v_diff<-append(v_diff,asset-capital)
			#cat (Close,Type,cash,amount,asset,diff,"\n",sep="\t")
	}

	result<-cbind(BS_table,Amount=v_amount,Cash=v_cash,Asset=v_asset,Diff=v_diff)
	return(result)
}
# 修改column 名row name
#  fix_data_frame(BS_table,newname=c("test","1","2"))



my_trade_filter<-function(BS_table){
	# 查看每笔交易
	ticks<-data.table(my_trade(BS_table))
	# result1.ticks
	# 盈利的交易
	# 取盈利的索引
	s_list<-which(ticks[,Diff>0])
	# 取盈利的buy point 索引
	b_lists<-sapply(s_list,function(x){x-1})
	#get profit pair index
	s_pair_list<-sort(append(s_list,b_lists))
	# 盈利的交易
	profit<-ticks[s_pair_list]
	# 亏损的交易
	loss<-ticks[-s_pair_list]
	# result2<-cbind(ticks=result1.ticks,profit=profit,loss=loss)
	# combine 3 kinds data to a list 
	result<-list(ticks= ticks, profit = profit,loss=loss)
	return(result)
}
result1<-my_trade_filter(BS_table)
result1$ticks


# 查看最后的资金情况。


# > tail(result1$ticks,1)

# 股价+现金流量
drawCash<-function(ldata,adata){
  g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
  g<-g+geom_line()
  g<-g+geom_line(aes(x=as.Date(Index), y=Value,colour=Series),data=fortify(adata,melt=TRUE))
  g<-g+facet_grid(Series ~ .,scales = "free_y")
  g<-g+scale_y_continuous(labels = dollar)
  # g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks("2 months"),limits = c(sDate,eDate))
  g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks("2 months"))
  g<-g+xlab("") + ylab("Price")+ggtitle(title)
  g
}

# 现金流量
adata<-as.xts(result1$ticks[Type=='S',Cash],order.by=result1$ticks[Type=='S',Date])
drawCash(ldata,adata)


#           Date  Close Type Amount         Cash     Asset       Diff
#  1: 2015-11-02 140.37    B    712     56.56356 100000.00     0.0000
#  2: 2015-12-09 136.61    S      0  97322.88427  97322.88 -2677.1157
#  3: 2015-12-16 139.29    B    698     98.46916  97322.88     0.0000
#  4: 2015-12-17 136.75    S      0  95549.96916  95549.97 -1772.9151
#  5: 2015-12-22 137.93    B    692    102.41400  95549.97     0.0000
#  6: 2015-12-28 137.61    S      0  95328.53469  95328.53  -221.4345
#  7: 2015-12-29 139.78    B    681    138.35538  95328.53     0.0000
#  8: 2015-12-31 137.62    S      0  93857.57197  93857.57 -1470.9627
#  9: 2016-02-04 127.65    B    735     34.82050  93857.57     0.0000
# 10: 2016-02-09 124.07    S      0  91226.27050  91226.27 -2631.3015
# 11: 2016-02-17 126.10    B    723     55.97195  91226.27     0.0000
# 12: 2016-04-19 144.00    S      0 104167.97195 104167.97 12941.7014
# 13: 2016-04-27 150.47    B    692     42.73125 104167.97     0.0000
# 14: 2016-04-28 147.07    S      0 101815.17610 101815.18 -2352.7958
# 15: 2016-05-10 149.97    B    678    135.51542 101815.18     0.0000
# 16: 2016-05-18 147.34    S      0 100032.03271 100032.03 -1783.1434
# 17: 2016-05-24 148.31    B    674     71.09406 100032.03     0.0000
# 18: 2016-06-15 150.68    S      0 101629.40934 101629.41  1597.3766
# 19: 2016-06-17 151.99    B    668    100.08600 101629.41     0.0000
# 20: 2016-06-24 146.59    S      0  98022.20333  98022.20 -3607.2060


# 取a列中值为B的行的判断
# > dt[,a=='B']
# [1] FALSE  TRUE FALSE FALSE FALSE  TRUE

# # 取a列中值为B的行的索引
# > which(dt[,a=='B'])
# [1] 2 6
result1.ticks


http://blog.fens.me/finance-stock-ma/
# BSpoint<-apply(compare1,1,myFUN_set_bs_point,c1='Series',c2='Lag.1')
# # bslist<-unlist(BSpoint)

# # as.data.frame(BSpoint)
# # dfBSpoint<-as.data.frame(unlist(BSpoint))
# dfBSpoint<-cbind(BS_POINT=dfBSpoint,Date=as.Date(row.names(dfBSpoint)))
# valuedf<-as.data.frame(cdata)
# valuedf<-cbind(BS_POINT=valuedf,Date=as.Date(row.names(valuedf)))
# # xtsBSpoint<-xts(dfBSpoint,as.Date(row.names(dfBSpoint)))


# BS_table<-merge(valuedf,dfBSpoint)
# colnames(BS_table)<-c("Date","Close","Type")

# BS<- ggplot(data=BS_table, aes(Date, Close,colour=Type)) + geom_point()
# df_cdata<-as.data.frame(cdata)
# df_cdata<-cbind(Close=df_cdata,Date=as.Date(row.names(df_cdata)))
# colnames(df_cdata)<-c("Close","Date")

# #BS2<- ggplot(df_cdata, aes(Date, Close)) + geom_line()
# BS+geom_line(aes(Date, Close),df_cdata[-1,])


# p + geom_line(aes(HrEnd, MWh, group=factor(Date)), df.last, color="red") 


# BS2<- ggplot(data=df_cdata[-1,], aes(Date, Close)) + geom_line()


# BS



head(fortify(BS_table,melt=TRUE))
Date  Close Type


