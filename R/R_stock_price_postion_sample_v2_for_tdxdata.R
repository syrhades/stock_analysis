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

#indicator 
# 指标是可变的======================
ma<-function(cdata,mas=c(5,20,60)){ 
	ldata<-cdata
	for(m in mas){
	    ldata<-merge(ldata,SMA(cdata,m))
	}
	ldata<-na.locf(ldata, fromLast=TRUE)
	names(ldata)<-c('Value',paste('ma',mas,sep=''))
	return(ldata)
}

#set trend
myFUN<-function(x,c1,c2){
	if (x[c1]>x[c2])
		return (c("down"))
	else return(c("up"))
}
# repair pdata2
# generate BS point 
# set trend up ,down function
Series<-apply(ldata,1,myFUN,c1='Value',c2='ma20')

myFUN_set_trend<-function(Series,ldata){
	
	pdata<-data.frame(Series=Series,Value=ldata$Value,Index=index(ldata))
	pdata2<-xts(pdata,index(ldata))
	return(pdata2)
}
# set buy sold point
myFUN_set_bs_point<-function(x,c1,c2){
# cat (x[c1])
	if (x[c1]== "up" && x[c2] == "down")
		return (c("S"))
	if (x[c1]== "down" && x[c2] == "up")
		return (c("B"))
}


myFUN_return_bs_point<-function(pdata2,cdata,my_opr_fun=myFUN_set_bs_point){
	# generate buy sell point 
	compare1<-cbind(pdata2$Series,Lag(pdata2$Series))
	compare1<-compare1[-1]
	BSpoint<-apply(compare1,1,my_opr_fun,c1='Series',c2='Lag.1')
	dfBSpoint<-as.data.frame(unlist(BSpoint))
	dfBSpoint<-cbind(BS_POINT=dfBSpoint,Date=as.Date(row.names(dfBSpoint)))
	valuedf<-as.data.frame(cdata)
	valuedf<-cbind(BS_POINT=valuedf,Date=as.Date(row.names(valuedf)))
	BS_table<-merge(valuedf,dfBSpoint)
	colnames(BS_table)<-c("Date","Close","Type")
	return(BS_table)
}


# 指标是可变的======================


# draw tool
drawLine<-function(ldata,titie="Stock_MA",sDate=min(index(ldata)),eDate=max(index(ldata)),out=FALSE){
    g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
    g<-g+geom_line()
    g<-g+geom_line(aes(colour=Series),data=fortify(ldata[,-1],melt=TRUE))
    g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks("2 months"),limits = c(sDate,eDate))
    g<-g+xlab("") + ylab("Price")+ggtitle(title)
    if(out) ggsave(g,file=paste(titie,".png",sep=""))
    else g
}


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

 
drawPoint<-function(ldata,BS_table,titie,sDate,eDate){
	g<-ggplot(aes(x=Index, y=Value),data=fortify(ldata[,1],melt=TRUE))
	g<-g+geom_line()
	g<-g+geom_line(aes(colour=Series),data=fortify(ldata[,-1],melt=TRUE))

	g<-g+geom_point(aes(x=Date,y=Close,colour=Type),data=fortify(BS_table,melt=TRUE))
	g<-g+scale_x_date(labels=date_format("%Y-%m"),breaks=date_breaks("2 months"),limits = c(sDate,eDate))
	g<-g+xlab("") + ylab("Price")+ggtitle(title)
	g
}
#  simulate trade
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
				v_amount<-append(v_amount,amount)
				v_cash<-append(v_cash,cash)
				v_asset<-append(v_asset,asset)

				cur_postiont<-length(v_asset)
				if (cur_postiont>2){
					v_diff<-append(v_diff,v_asset[cur_postiont]-v_asset[cur_postiont-1])
				}
				else{v_diff<-append(v_diff,asset-capital)

				}
			}
			if (Type == "S" && amount != 0){
				cash<-cash+amount*Close
				amount<-0
				asset<-cash

				v_amount<-append(v_amount,amount)
				v_cash<-append(v_cash,cash)
				v_asset<-append(v_asset,asset)

				cur_postiont<-length(v_asset)
				if (cur_postiont>2){
					v_diff<-append(v_diff,v_asset[cur_postiont]-v_asset[cur_postiont-1])
				}
				else{v_diff<-append(v_diff,asset-capital)

				}
			}
			
			#v_diff<-append(v_diff,asset-capital)
			#cat (Close,Type,cash,amount,asset,diff,"\n",sep="\t")
	}
	delta_data<-length(BS_table) - length(v_amount)
	if (delta_data) {
		result<-cbind(BS_table[,],Amount=v_amount,Cash=v_cash,Asset=v_asset,Diff=v_diff)
		}
	else{
		result<-cbind(BS_table[-delta_data,],Amount=v_amount,Cash=v_cash,Asset=v_asset,Diff=v_diff)
	}
	cat ("delta_data:",delta_data,"\n")
	return(result)
}

my_trade_filter<-function(BS_table){
	# 查看每笔交易
	ticks<-data.table(BS_table)
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

frm.datagen<-function(datastr){
	year=substr(datastr,0,4)
	month=substr(datastr,5,6)
	#cat(month)
	day=substr(datastr,7,8)
	#cat(day)
	paste(year,"-",month,"-",day)
	return(paste(year,"-",month,"-",day, sep = ""))
}




# main=====================================
# syrhades choic 
func.test_stock<- function(dataframe){
	#cat("enter in ","\n")
	gzmt<-dataframe
	close<-gzmt$close
	# open<-gzmt$open
	# high<-gzmt$high
	# low<-gzmt$low
	current_price=close[length(close)]
	all<-as.list(summary(close))
	#cat("current_price:===>",current_price,"\n")
	#cat(current_price,"\n")
	#Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
	#1,2,3,4,5,6
	flag<-0
	# if (current_price[[1]]<all[[9]]) flag<-flag+1
	# if (current_price[[1]]<all[[2+6]]) flag<-flag+1
	# if (current_price[[1]]<all[[1+6]]) flag<-flag+1
	# if (current_price[[1]]>all[[5+6]]) flag<-flag-1
	#print(all)
	# if (flag ==-1) cat("sold","\n")
	# if (flag ==0) cat("wait","\n")
	# if (flag ==1) cat("think","\n")
	# if (flag ==2) cat("can buy","\n")
	if (current_price[[1]]<all[[8]]) return("b")
	if (current_price[[1]]>all[[11]]) return("s")
	# if (flag ==-1) return("s")
	# # if (flag ==0) cat("wait","\n")
	# # if (flag ==1) cat("think","\n")
	# if (flag ==2) return("b")
	# return("w")
};



# close<-cdata$close
#get stock data IBM
gzmt<-read.table("e:/stock_data/done_000001.txt",header=TRUE,sep=",")
gzmt$date<-frm.datagen(gzmt$date)
olch=gzmt[2:6]
xtsobject=xts(olch, as.Date(gzmt$date))     #包xts

title<-"TDX done_000001 CLOSE" #
cdata<-xtsobject$close

cdata<-to.weekly(cdata)
cdata<-cdata$cdata.Close
seriesdata<-cbind(cdata,No=1:nrow(cdata))
colnames(seriesdata)<-c("close","No")
# set buy sold point
s_Func<-function(x,c1,c2){
# cat (x[c1])
	# xtsdata<-cdata[1:n]
	# x[c1]  No value
	NO=x[c1]
	# print(NO)
	data_waiting=seriesdata[1:NO,]

	return (func.test_stock(data_waiting))
	# if (x[c1]== "up" && x[c2] == "down")
	# 	return (c("S"))
	# if (x[c1]== "down" && x[c2] == "up")
	# 	return (c("B"))
}

# BSpoint<-apply(seriesdata,1,s_Func,c1='No')
# testdata<-seriesdata[1:1000,]

s_return_bs_point<-function(seriesdata,my_opr_fun=s_Func){
	# generate buy sell point 
	BSpoint<-apply(seriesdata,1,my_opr_fun,c1='No')
	dfBSpoint<-as.data.frame(unlist(BSpoint))
	dfBSpoint<-cbind(BS_POINT=dfBSpoint,Date=as.Date(row.names(dfBSpoint)))
	valuedf<-as.data.frame(seriesdata)
	valuedf<-cbind(BS_POINT=valuedf,Date=as.Date(row.names(valuedf)))
	BS_table<-merge(valuedf,dfBSpoint)
	# colnames(BS_table)<-c("Date","Close","Type")
	colnames(BS_table)<-c("Date","Close","No","Type")
	return(BS_table)
}
# subset(bs_table,Type=="s")
bstable<-s_return_bs_point(seriesdata)

# for (n in 1:nrow(cdata)) {
# 	xtsdata<-cdata[1:n]
# 	return (func.test_stock(cdata))
# }

ldata<-ma(cdata,c(5,20,60))
sDate<-as.Date("2010-1-1") #开始日期
eDate<-as.Date("2012-1-1") #结束日期
#drawLine(ldata,title,sDate,eDate) #
drawLine(ldata,title) #
# generate MA 20 line data
ldata<-ma(cdata,c(20))
drawLine(ldata,title,sDate,eDate)

#set trend
pdata2<-myFUN_set_trend(Series,ldata)


#set buy sold point
BS_table<-myFUN_return_bs_point(pdata2,cdata)
drawPoint(ldata,BS_table,titie,sDate,eDate)


#  simulate trade
tb1<-my_trade(BS_table)
result1<-my_trade_filter(my_trade(BS_table))
result1$ticks

# BS_table<-my_trade(BS_table)
# 查看最后的资金情况。
# > tail(result1$ticks,1)
# 现金流量
adata<-as.xts(result1$ticks[Type=='S',Cash],order.by=result1$ticks[Type=='S',Date])
drawCash(ldata,adata)
