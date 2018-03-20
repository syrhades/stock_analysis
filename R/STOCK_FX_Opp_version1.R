#GMMA
#function (x, short = c(3, 5, 8, 10, 12, 15), long = c(30, 35, 
#    40, 45, 50, 60), maType) 
#https://github.com/cosname/ggplot2-translation
install.packages("dplyr")


http://f9.eastmoney.com/sh600519.html
http://soft-f9.eastmoney.com/soft/gp61.php?code=60051901


install.packages("iterators")
install.packages("foreach")
require(foreach)
install.packages("XRPython")
require(XRPython)
library(R6)               # 加载R6包
library(pryr)             # 加载pryr包
library(R6)               # 加载R6包
library(pryr)             # 加载pryr包

#install.packages("scrape")
require(scrape)
require(iterators)
require(dplyr)
library(plyr)
library(quantmod)
library(TTR)
library(ggplot2)
library(scales)
require(data.table)
require(sqldf)
library(XML)
library(htmlTable)
###################################
# repare data
#####################################
datafile<-"~/sdcard1/stock_data/done_601006.txt"
datafile<-"E:/stock_data/done_600519.txt"
datafile<-"E:/stock_data/done_601006.txt"
datafile<-"~/sdcard1/stock_data/done_601006.txt"




frm_output_html<-function(idx,result_data){
	print_data<-result_data[[idx]]
	if (!is.na(print_data) && (length(print_data)>0))  htmlTable(print_data)
}


frm_lof<-function(in_p,out_p,amount){
	if (in_p>out_p) {
                tl_type<-"inout_yj" # 溢價 buy out sold in
                delta_p<-(in_p-out_p)
                loss_percent<-delta_p/out_p*100
                buy_percent<-1.5/100
                sold_percent<-0.3/100
                buy_amount<-amount*out_p*(1+buy_percent)
                sold_amount<-amount*in_p*(1-sold_percent)
                }else{
                tl_type<-"outin_zj" # 折價 buy in sold out
                delta_p<-(out_p-in_p)
                loss_percent<-delta_p/in_p*100
                buy_percent<-0.3/100
                sold_percent<-0.5/100
                buy_amount<-amount*in_p*(1+buy_percent)
                sold_amount<-amount*out_p*(1-sold_percent)

                }
            result_amount<-sold_amount-buy_amount
            result_percent<-result_amount/buy_amount*100
            print("===========================")
            print(tl_type)
            cat("buy_amount:\t",buy_amount,"\n")
            cat("result_amount:\t",result_amount,"\n")
            cat("result_percent:\t",result_percent,"\n")
            
            
            print("===========================")
            
}

frm_lof(1.0613,
            1.0710,
            100000)

frm.datagen<-function(datastr){
	year=substr(datastr,0,4)
	month=substr(datastr,5,6)
	#cat(month)
	day=substr(datastr,7,8)
	#cat(day)
	paste(year,"-",month,"-",day)
	return(paste(year,"-",month,"-",day, sep = ""))
}
func_up_down <- function(x, c1, c2) {
  if (x[c1]>x[c2]) return("UP")
  if (x[c1]<x[c2]) return("DOWN")
  if (x[c1]==x[c2]) return("EQUAL")
}
func_set_type<-function(c1,c2){
	if (c1>c2) return("UP")
	if (c1<c2) return("DOWN")
	if (c1==c2) return("EQUAL")
}

roll_indicator<-function(BS_table2,windows_period,fieldname){
	#cmdstr=paste("BS_table2$avg_max_roll_",windows_period,"<-rollmax(BS_table2$avg,3,fill = NA,align='right')",sep="")
	BS_table2[paste(fieldname,"_max_roll_",windows_period,sep="")]<-rollmax(BS_table2[paste(fieldname)],windows_period,fill = NA,align='right')
	BS_table2[paste(fieldname,"_min_roll_",windows_period,sep="")]<-rollapply(BS_table2[paste(fieldname)],windows_period,function(x) min(x),fill = NA,align='right')
	BS_table2[paste(fieldname,"_mean_roll_",windows_period,sep="")]<-rollapply(BS_table2[paste(fieldname)],windows_period,function(x) mean(x),fill = NA,align='right')
	return (BS_table2)
}

# 生成BS_table
###################################
# generate BS_table
#####################################
frm_generate_BS_table<- function(datafile)
{
	df1<-read.table(datafile,header=TRUE,sep=",")
	df1<-mutate(df1,date=frm.datagen(date))
	olch=df1[2:6]
	xtsobject=xts(olch, as.Date(df1$date))     #包xts
	xtsobject<-cbind(xtsobject,close1=Lag(xtsobject$close))
	colnames(xtsobject)[[6]]<-"close1"

	head(is.na(xtsobject$close1))
	xts_non_na<-xtsobject[!is.na(xtsobject$close1)]
	#######优化处理#######

	typepoint2<-mapply(func_set_type,xts_non_na$close,xts_non_na$close1)
	BS_table2<-as.data.frame(xts_non_na)
	BS_table2$type<-typepoint2
	BS_table2$avg<-rowSums(BS_table2[,1:4])/4
	BS_table2$Date<-as.Date(row.names(BS_table2))
	#generate roll indicator
	#BS_table2[paste(windows_period)]<-2


	BS_table2<-roll_indicator(BS_table2,50,"close")
	#BS_table2[1:10,]

	return(BS_table2)
}

BS_table2<-frm_generate_BS_table(datafile)
#df2<-transform(df1,test=frm.datagen(df1))





#df1$date<-frm.datagen(df1$date)



# typepoint<-apply(xts_non_na,1,func_up_down,c1="close",c2="close1")
# dftypepoint<-as.data.frame(unlist(typepoint))
# dftypepoint<-cbind(BS_POINT=dftypepoint,Date=as.Date(row.names(dftypepoint)))

# valuedf<-as.data.frame(xts_non_na)
# valuedf<-cbind(BS_POINT=valuedf,Date=as.Date(row.names(valuedf)))
# BS_table<-merge(valuedf,dftypepoint)
# colnames(BS_table)<-c("Date","open","high","low","close","vol","close1","type")




#判断两个对象是否一致
#identical(melt_bs_table2, melt_bs_table)
#################################
#indicator function
##################################
func_cross<-function(c1,c2){
	if (is.na(c1) || is.na(c2)) return (NA)
	if (c1>c2) return("UP")
	if (c1<c2) return("DOWN")
	if (c1==c2) return("EQUAL")
}
BS_table2$ind_type<-mapply(func_cross,BS_table2$close,BS_table2$close_mean_roll_50)
BS_table2$deltaroll<-BS_table2$close_max_roll_50-BS_table2$close_min_roll_50
n=2
frm_add_boll<-function(BS_table2,n){
	BS_table2$boll_up<-BS_table2$close_mean_roll_50+n*runSD(BS_table2$close,50)
	BS_table2$boll_down<-BS_table2$close_mean_roll_50-n*runSD(BS_table2$close,50)
	return(BS_table2)
}
BS_table2<-frm_add_boll(BS_table2,n=2)

#######优化处理#######
#################################
#draw function
##################################
# pt<-ggplot(BS_table2, aes(Date, avg))+
    # geom_line(aes(colour = vol))

# pt
# pt<-ggplot(BS_table2, aes(Date, avg))+
    # geom_point(aes(colour = vol))

# require(reshape2)
# melt_bs_table2<- melt(BS_table2[1:200,],id="Date",measure = c("close","high"))
# gline<-ggplot(melt_bs_table2, aes(Date, value),colour=variable) 
# gline+geom_line()
# gline+geom_point()
	
# lineplot<-ggplot(BS_table2[1:200,], aes(Date, close)) +
    # geom_line(aes(colour = vol))

# lineplot+geom_line(aes(Date ,close_max_roll_50))+geom_line(aes(Date ,close_min_roll_50))
	
# lineplot+geom_line(aes(Date ,close_max_roll_50))+geom_line(aes(Date ,close_min_roll_50))+geom_line(aes(Date ,close_mean_roll_50))



# lineplot<-ggplot(tail(BS_table2,1000), aes(Date, close)) +
    # geom_line(aes(colour = vol))

# lineplot+geom_line(aes(Date ,close_max_roll_50))+geom_line(aes(Date ,close_min_roll_50))
	
# lineplot+geom_line(aes(Date ,close_max_roll_50))+geom_line(aes(Date ,close_min_roll_50))+geom_line(aes(Date ,close_mean_roll_50,color=factor(ind_type)))

close_plot<-ggplot(tail(BS_table2,1000), aes(Date, close)) + geom_point(aes(colour = type))
+ geom_point(aes(colour = ind_type))
#close_plot+geom_line(aes(Date,close_mean_roll_50,color=1))+geom_line(aes(Date,close,color=2))
close_plot+
geom_line(aes(Date,close_mean_roll_50,colour="blue"))+
geom_line(aes(Date,close))+
geom_line(aes(Date,close_min_roll_50))+
geom_line(aes(Date,close_max_roll_50))+
geom_point(aes(Date,deltaroll,colour = ind_type))+
geom_line(aes(Date,boll_down,colour = I("green")))+
geom_line(aes(Date,boll_up,colour = I("red")))+
geom_line(aes(Date,boll_up-boll_down,colour = I("yellow")))+
geom_line(aes(Date,(close-boll_down)/(boll_up-boll_down)*10,colour = I("BBposition")))


# main<-function(BS_table){
  # plot<-ggplot(BS_table, aes(Date, close)) +
    # geom_point(aes(colour = vol))
    
  # plot+scale_colour_gradient2()
  # plot+scale_colour_gradientn(colours = terrain.colors(10))

  # plot+scale_colour_gradient2(low = "white", mid ="grey",high = "black",midpoint = mean(BS_table$vol))

  # fill_gradn <- function(pal) {
    # scale_fill_gradientn(colours = pal(7), limits = c(0, 0.04))
  # }
  # require(colorspace)
  # plot + fill_gradn(rainbow_hcl)
  # plot + fill_gradn(diverge_hcl)
  # plot + fill_gradn(heat_hcl)
  # plot + fill_gradn(sequential_hcl)
  # plot + fill_gradn(terrain_hcl)
  # plot + fill_gradn(sequential_hcl)

  # plot + fill_gradn(sequential_hcl)

  # plot +scale_fill_brewer()

  # lineplot<-ggplot(BS_table, aes(Date, close)) +
    # geom_line(aes(colour = vol))
  # lineplot +scale_fill_brewer()
# }
#################################
## get finance table from website Hexun
## sample  tb2006<-frm_hexun_fin_table(601006,"en",2006)
##################################
frm_hexun_fin_table<-function(stock_code,cn_en,year){
	query <- switch(
            cn_en,
            en = paste("?stockid=",stock_code,"&type=1&date=",year,".12.31",sep="")  ,
            cn = paste("?stockid="  ,stock_code,"&accountdate=",year,".12.31",sep="")  ,
            "NA"
	)

        report_type <- 
            c("zxcwzb",
            "cwbl",
            "zcfz",
            "lr",
            "xjll"
            )
        url_head <- switch(
            cn_en,
            en = paste("http://stockdata.stock.hexun.com/2008en/")  ,
            cn = paste("http://stockdata.stock.hexun.com/2008/")  ,
            "NA"
	)
        report_url<-paste(url_head,report_type,".aspx",query,sep="")
        tbls_list    <- lapply(report_url,readHTMLTable)
        names(tbls_list)<-report_type
        
        #frm_trans_table<-function(df_table){
        #  rownames(df_table) <- df_table[,1]
        #return(t(df_table))
        #}
        
       # return(tbls_list)
       return(tbls_list)
	finance_tb<-switch(
            cn_en,
            en = lapply(tbls_list,function(x) as.data.frame((x[[2]]))),
            cn = lapply(tbls_list,function(x) as.data.frame((x[[3]]))) ,
            #"NA"
	)
        #return(finance_tb)
        #finance_tb<-lapply(finance_tb,frm_trans_table)
	
	return(finance_tb)
}

tb2006<-frm_hexun_fin_table(601006,"en",2006)
htmlTable(tb2006$zcfz)
##show zcfz table
##htmlTable(tb2006$zcfz)
htmlTable(tb2006$zcfz[[1]])
htmlTable(tb2006$zcfz[[2]])

class(tb2006$zcfz[[2]])

lapply(tb2016,htmlTable)
lapply(tb2016,function (x) htmlTable(x[,1]))

#################################
## check and inspect R object 
## sample  
##              tb2006<-frm_hexun_fin_table(601006,"en",2006)
##################################
frm_inspect_R_object <- function(R_object){
    show_content<-list(
                                class   = class(R_object),
                                mode = mode(R_object),
                                #str      = str(R_object),
                                attrs  = attributes(R_object),
								location_info = location(R_object)

                                )
    print(show_content)
}
frm_inspect_R_object(tb2006$zcfz)
frm_inspect_R_object(tb2006$zcfz[[2]])

frm_inspect_R_object(as.data.frame(t(tb2006$zcfz[[2]])))
#################################
## save finance table to SQLite database
## sample 
##               frm_save_fin_table2_sqlite("/tmp/tb_finance.db",tb2006$zcfz[[2]],"zcfztb")
##               frm_save_fin_table2_sqlite("/tmp/tb_finance.db",as.data.frame(t(tb2006$zcfz[[2]])),"zcfztb2")
##################################

frm_save_fin_table2_sqlite<-function(sql_dbfile,R_df,tb_name){
    require(DBI)
    # Create an ephemeral in-memory RSQLite database
    con <- dbConnect(RSQLite::SQLite(), sql_dbfile)

    dbListTables(con)
    #write dataframe R_df to Sqlite db file
    dbWriteTable(con, tb_name, R_df)
    dbListTables(con)
    # Disconnect from the database
    dbDisconnect(con)
}
frm_save_fin_table2_sqlite("/tmp/tb_finance.db",tb2006$zcfz[[2]],"zcfztb")
frm_save_fin_table2_sqlite("/tmp/tb_finance.db",as.data.frame(t(tb2006$zcfz[[2]])),"zcfztb2")


#tb2015<-frm_hexun_fin_table(600016,"en",2015)
tb2016_zxcwzb<-tb2016$zxcwzb
htmlTable(tb2016_zxcwzb)

tb2016c<-frm_hexun_fin_table(600016,"cn",2016)
tb2015c<-frm_hexun_fin_table(600016,"cn",2015)

frm_hexun_fin_table(600016,"cn",2016)


#############################
##generate year finance indicator ex. per stock jz
##sample
##              per_jz<-c(1,3,5,7)
##            frm_generate_year_indicator(2016,per_jz)
#############################

per_jz<-c(1,3,5,7)
frm_generate_year_indicator<-function(year,per_jz){
	date_quarter<-seq(as.Date(paste(year,"/1/1",sep="")), as.Date(paste(year,"/12/31",sep="")), by = "quarter")
	date_quarter[5]<-as.Date(paste(year,"/12/31",sep=""))
	nday<-diff(date_quarter)
	ret_df<-data.frame(nday,date_quarter[1:4],per_jz)

	xts_quarter<-function(per_jz,nday,day_begin){
		result<-xts(rep(per_jz,nday),day_begin+1:nday-1)
		return(result)
	}
	xxx<-mapply(xts_quarter,ret_df$per_jz,ret_df$nday,ret_df[,2])
	ret_xts<-rbind(xxx[[1]],xxx[[2]],xxx[[3]],xxx[[4]])
	return(ret_xts)
}

tseq2<-frm_generate_year_indicator(2016,per_jz)

tseq2

df_xtsseq<-as.data.frame(tseq2)
df_xtsseq$Date<-as.Date(row.names(df_xtsseq))

##BS<-merge(BS_table2,df_xtsseq)
BS<-merge(BS_table2, df_xtsseq, by.x = "Date", by.y = "Date",all = TRUE)


close_plot<-ggplot(tail(BS,1000), aes(Date, close)) + geom_point(aes(colour = ind_type))
close_plot+
geom_line(aes(Date,V1,colour="per_jz"))

######################################################################################
## html tool
######################################################################################

frm_html_xpath<-function(url,xpath_expr){
	url_html <- htmlParse(url) 
	ans <- getNodeSet(url_html , "//table//ul[1]/li")
	return(sapply(ans, xmlValue))
}
url<-"http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid=600016&type=1&date=2015.12.31"
frm_html_xpath(url,"//table//ul[1]/li")


cat(as(toHTML(rnorm(10)), "character"))




######################################################################################
## get stock finance report peroid  all report
######################################################################################
frm_get_finance_year_list<-function(url){
	
	url_html <- htmlParse(url) 
	ans <- getNodeSet(url_html , "//table//ul[1]/li")
	year_list <- sapply(ans, xmlValue)
	year_list <- year_list[-length(year_list)]
	year_list <-as.numeric(year_list)
	return(year_list[!is.na(year_list)])
}
frm_get_url_xpath<-function(url,xpath_exp){
	url_html <- htmlParse(url) 
	ans <- getNodeSet(url_html , xpath_exp)
	#sapply(ans, xmlValue)
	#return(ans)
}
test_frm_get_finance_year_list<-function(url){
	
	url_html <- htmlParse(url) 
	ans <- getNodeSet(url_html , "//table//ul[1]/li")
	year_list <- sapply(ans, xmlValue)
	year_list <- year_list[-length(year_list)]
	year_list <-as.numeric(year_list)
	return(year_list[!is.na(year_list)])
}


url<-"http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid=600016&type=1&date=2015.12.31"

frm_get_url_xpath(url,"//div[@class='content nav']/div/a")%>%sapply(xmlValue)%>%htmlTable

year_list<-frm_get_finance_year_list(url)

frm_collect_all_report <- function (year,stockid,language){
	# print (year)
	# print (stockid)
	# print (language)
	frm_hexun_fin_table(stockid,language,year)
}
# get all years  stock finance table  chinese version
all_reports_cn<-lapply(year_list,frm_collect_all_report,600016,"cn")

all_reports_cn[[2]]$lr[[3]] %>% htmlTable
all_reports_cn[[3]]$zcfz[[3]] %>% htmlTable
all_reports_cn[[4]]$xjll[[3]] %>% htmlTable
all_reports_cn[[20]]$zxcwzb[[3]] %>% htmlTable
all_reports_cn[[20]]$cwbl[[3]] %>% htmlTable

# get all years  stock finance table  english version
all_reports_en<-lapply(year_list,frm_collect_all_report,600016,"en")


all_reports_en[[20]]$cwbl[[2]] %>% htmlTable


ctable<-cbind(all_reports_en[[20]]$cwbl[[2]],all_reports_en[[19]]$cwbl[[2]]) %>% htmlTable


all_reports_en[[1]]$cwbl[[2]]%>% htmlTable

##recursive 递归 to combine all year to a dataframe

recursive_report_en <- function(n){
	if (0 == n){
		sum =cbind(all_reports_en[[1]]$cwbl[[2]])
		return (sum)
		}
	else
		sum = cbind(recursive_report_en(n-1),all_reports_en[[n]]$cwbl[[2]])
	return (sum)
}
recursive_report_en(6)%>% htmlTable 

recursive_report_cn <- function(n,report_type,all_report){
	######################################################################################
	#report_type 1-5
	#c("zxcwzb",
	#    "cwbl",
	#    "zcfz",
	#    "lr",
	#    "xjll"
	#   )
	######################################################################################
	if ((n == 0) | (n == 1)| (n == 2)){
		sum =cbind(all_report[[2]][[report_type]][[3]])
		return (sum)
		}
	else
		sum = cbind(recursive_report_cn(n-1,report_type,all_report),all_report[[n]][[report_type]][[3]][,-1])
	return (sum)
}
#report_type=5 xjll
recursive_report_cn(6,report_type=5,all_reports_cn)%>% htmlTable 

recursive_report_cn(6,report_type=5,all_reports_cn)%>%t%>%htmlTable 

df_report_all_cn<-recursive_report_cn(6,report_type=5,all_reports_cn)%>%t%>%as.data.frame

frm_handle_row_name<-function(df_table,stock_id,stock_name){
	row.names(df_table)<-seq(length(row.names(df_table)))
	df_table$stock_id <-stock_id
	df_table$stock_name <-stock_name
	return(df_table)
}
df_report_all_cn<-recursive_report_cn(6,report_type=5,all_reports_cn)%>%t%>%as.data.frame%>%frm_handle_row_name(60016)
df_report_all_cn%>%htmlTable


url<-"http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid=600031&type=1&date=2015.12.31"
year_list<-frm_get_finance_year_list(url)
all_reports_cn600031<-lapply(year_list,frm_collect_all_report,600031,"cn")
df_report_all_cn600031<-recursive_report_cn(6,report_type=5,all_reports_cn600031)%>%t%>%as.data.frame%>%frm_handle_row_name(600031)
df_report_all_cn600031%>%htmlTable


all_reports[[2]][[1]][[3]]%>%htmlTable

all_reports[[1]]$lr[[3]]%>%htmlTable

######################################################################################
## main stock finance report process
######################################################################################
cl_Stock_report_process <- R6Class("Stock_report_process",    # 定义一个R6类
	lock_objects = FALSE,
	public=list(
	
	stockid 	= NA,
	dbfileName	= NA,
	R_df		= NA,
	initialize = function(stockid){       # 构建函数方法
		self$stockid <- sprintf("%06d", stockid)
		self$url_html <- paste("http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid=",self$stockid,sep="")
		#self$url_html <- paste(self$stockid,sep="")
	
	},
	frm_get_url_xpath = function(url,xpath_exp){
		url_html <- htmlParse(url) 
		ans <- getNodeSet(url_html , xpath_exp)
		#sapply(ans, xmlValue)
		#return(ans)
	},
	frm_get_finance_year_list = function(url){
		url_html <- htmlParse(url) 
		ans <- getNodeSet(url_html , "//table//ul[1]/li")
		year_list <- sapply(ans, xmlValue)
		year_list <- year_list[-length(year_list)]
		year_list <-as.numeric(year_list)
		return(year_list[!is.na(year_list)])
	},
	frm_hexun_fin_table = function(stock_code,cn_en,year){
		query <- switch(
				cn_en,
				en = paste("?stockid=",stock_code,"&type=1&date=",year,".12.31",sep="")  ,
				cn = paste("?stockid="  ,stock_code,"&accountdate=",year,".12.31",sep="")  ,
				"NA"
		)

			report_type <- 
				c("zxcwzb",
				"cwbl",
				"zcfz",
				"lr",
				"xjll"
				)
			url_head <- switch(
				cn_en,
				en = paste("http://stockdata.stock.hexun.com/2008en/")  ,
				cn = paste("http://stockdata.stock.hexun.com/2008/")  ,
				"NA"
		)
			report_url<-paste(url_head,report_type,".aspx",query,sep="")
			tbls_list    <- lapply(report_url,readHTMLTable)
			names(tbls_list)<-report_type
			
			#frm_trans_table<-function(df_table){
			#  rownames(df_table) <- df_table[,1]
			#return(t(df_table))
			#}
			
		   # return(tbls_list)
		   return(tbls_list)
		finance_tb<-switch(
				cn_en,
				en = lapply(tbls_list,function(x) as.data.frame((x[[2]]))),
				cn = lapply(tbls_list,function(x) as.data.frame((x[[3]]))) ,
				#"NA"
		)
			#return(finance_tb)
			#finance_tb<-lapply(finance_tb,frm_trans_table)
		
		return(finance_tb)
	},
	frm_collect_all_report = function (year,stockid,language){
		frm_hexun_fin_table(stockid,language,year)
	},
	all_reports_cn = lapply(year_list,frm_collect_all_report,600016,"cn"),
	recursive_report_cn = function(n,report_type,all_report){
		######################################################################################
		#report_type 1-5
		#c("zxcwzb",
		#    "cwbl",
		#    "zcfz",
		#    "lr",
		#    "xjll"
		#   )
		######################################################################################
		if ((n == 0) | (n == 1)| (n == 2)){
			sum =cbind(all_report[[2]][[report_type]][[3]])
			return (sum)
			}
		else
			sum = cbind(recursive_report_cn(n-1,report_type,all_report),all_report[[n]][[report_type]][[3]][,-1])
		return (sum)
	},
	frm_handle_row_name = function(df_table,stock_id,stock_name){
		row.names(df_table)<-seq(length(row.names(df_table)))
		df_table$stock_id <-stock_id
		df_table$stock_name <-stock_name
		return(df_table)
	},
	
	)
)

stock600031<-cl_Stock_report_process$new(600031)
stock600031$frm_get_finance_year_list(self$url_html)

stock600031$frm_show_attr()

frm_main_stock_report_process<-function(stockid,dbfileName){
	######################################################################################
	## save stock finance tables to database file sqlite
	######################################################################################
		
	stockid<-sprintf("%06d", stockid)

	##step1 get year list
	url<-paste("http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid=",stockid
	,sep="")
	#get stock chinese Name
	stockname<-frm_get_url_xpath(url,"//div[@class='content nav']/div/a")%>%sapply(xmlValue)
	stockname<-stockname[[3]]
	#cat(url)
	year_list<-frm_get_finance_year_list(url)
	n_year<-length(year_list)
	cat(n_year)
	#cat(year_list)
	#return (year_list)
	report_type<-c(	"zxcwzb",
					"cwbl",
					"zcfz",
					"lr",
					"xjll")
		
	# step2 get all years  stock finance table  chinese version
	all_reports_cn<-lapply(year_list,frm_collect_all_report,stockid,"cn")

	#all_reports_en<-lapply(year_list,frm_collect_all_report,stockid,"en")

	#step3 
	# become 5 reports dataframe 
	#report_type_seq<-seq(1:5)
	#df_report_all_cn_xjll<-recursive_report_cn(n_year-2,report_type=5,all_reports_cn)%>%t%>%as.data.frame%>%frm_handle_row_name(60016)
	#mapply(recursive_report_cn,n_year-2,report_type_seq,all_reports_cn)
	f_report_cn<-lapply(seq(1:5),function(x,y,z) recursive_report_cn(y,x,z)%>%t%>%as.data.frame%>%frm_handle_row_name(stockid,stockname),n_year-2,all_reports_cn )
	#df_report_all_cn%>%htmlTable 
	#step4
	# save finance report to sqlite db file,
	lapply(seq(1:5),function(x,reports,report_type,dbfile) 
								frm_save_fin_table2_sqlite(dbfile,reports[[x]],paste(report_type[x],stockid,sep="_"))
								,reports=f_report_cn, report_type,dbfile=dbfileName )
 

}

reports_600031<-frm_main_stock_report_process(000833,"e:/tb_finance.db")
stock_list<-c(000157,6000016,600362,000833)




##########################################################################
## class R6
##########################################################################

cl_db_oprate <- R6Class("db_opr",    # 定义一个R6类
	lock_objects = FALSE,
	public=list(
	
	sql_dbfile 	= NA,
	tb_name		= NA,
	R_df		= NA,
	initialize = function(sql_dbfile){       # 构建函数方法
      self$sql_dbfile <- sql_dbfile
		},
	show_db_dbi = function(){         # show database table name
		# Create an ephemeral in-memory RSQLite database
		con <- dbConnect(RSQLite::SQLite(), self$sql_dbfile)
		print(dbListTables(con))
		# Disconnect from the database
		dbDisconnect(con)		
		},
	query_db_dbi = function(sql_cmd){         # select table name
		# Create an ephemeral in-memory RSQLite database
		con <- dbConnect(RSQLite::SQLite(), self$sql_dbfile)
		self$query_df <- dbGetQuery(con, sql_cmd)
		
		# Disconnect from the database
		dbDisconnect(con)	
		return(self$query_df)
		},
	frm_get_table_dplyr = function(tb_name){
		require(dplyr)
		my_db <- src_sqlite(self$sql_dbfile, create = T)
		self$get_table_dplyr <- tbl(my_db, tb_name)
		},	
	frm_show_html = function(r_obj){
		htmlTable(r_obj)}
		)
)


ta<-cl_db_oprate$new("e:/tb_finance.db")
ta$show_db_dbi()
ta$query_db_dbi("select * from cwbl_000157")
ta$query_db_dbi("select * from zxcwzb_000157")
""
ta$query_df%>%htmlTable
class(ta$query_df)
ta$frm_get_table_dplyr(tb_name="lr_000157")

as.data.frame(ta$get_table_dplyr) %>% htmlTable(align=paste(rep('c',50),collapse='|'))
help(package="dplyr")

##########################################################################
## dplyr handle database
##########################################################################
require(dplyr)

my_db <- src_sqlite("e:/my_db.sqlite3", create = T)

bs_sqlite <- copy_to(my_db, BS_table2, temporary = FALSE, )


frm_save_df2db<-function(df_table,dbname){
	my_db <- src_sqlite(dbname, create = T)

	db_saved <- copy_to(my_db, df_table, temporary = FALSE, )
	return(db_saved)
}
??dplyr


install.packages("xtable")
library(xtable)
output <- 
  matrix(sprintf("Content %s", LETTERS[1:4]),
         ncol=2, byrow=TRUE)
colnames(output) <- 
  c("1st header", "2nd header")
rownames(output) <- 
  c("1st row", "2nd row")
  

print(xtable(output, 
             caption="A test table", 
             align = c("l", "c", "r")), 
      type="html")
	  
	  

##########################################################################
##tonghuasun
##########################################################################
url_thx<-"http://www.iwencai.com/stockpick/search?typed=0&preParams=&ts=1&f=1&qs=index_original&selfsectsn=&querytype=&searchfilter=&tid=stockpick&w=%E4%B8%BB%E5%8A%9B%E6%8A%A2%E7%AD%B9%E7%9A%84%E6%88%BF%E5%9C%B0%E4%BA%A7%E5%BC%80%E5%8F%91%E8%82%A1"
thx_f10<-readHTMLTable(url_thx)

# Save to sqlite db file
report_type<-c(	"zxcwzb",
				"cwbl",
				"zcfz",
				"lr",
				"xjll")
stockid<-600031


frm_save_fin_table2_sqlite("e:/tb_finance.db",reports_600031[[2]],paste(report_type[2],stockid,sep=""))
http://www.iwencai.com/stockpick/search?typed=1&preParams=&ts=1&f=1&qs=result_rewrite&selfsectsn=&querytype=&searchfilter=&tid=stockpick&w=%E5%B8%82%E7%9B%88%E7%8E%87+%E5%B8%82%E5%87%80%E7%8E%87+%E8%B0%83%E5%91%B3%E5%93%81+&queryarea=selfstock


http://www.iwencai.com/stockpick/search?typed=1&preParams=&ts=1&f=1&qs=result_rewrite&selfsectsn=&querytype=&searchfilter=&tid=stockpick&w=%E5%B8%82%E7%9B%88%E7%8E%87%3E0+%E5%B8%82%E5%87%80%E7%8E%87+%E8%B4%9F%E5%80%BA%E7%8E%87+%E8%B0%83%E5%91%B3%E5%93%81&queryarea=selfstock


# testdf[[1]]%>%htmlTable
# testdf[[5]]%>%htmlTable
tapply(X=BS_table$close, INDEX=list(BS_table$Type), FUN=sum)
# testdf<-df_report_all_cn<-recursive_report_cn(15,report_type=5,testdf)%>%t%>%as.data.frame%>%frm_handle_row_name(60016)
# df_report_all_cn<-recursive_report_cn(15,report_type=1,testdf)%>%t%>%as.data.frame%>%frm_handle_row_name(60016)
# df_report_all_cn<-recursive_report_cn(15,report_type=2,testdf)%>%t%>%as.data.frame%>%frm_handle_row_name(60016)
# df_report_all_cn<-recursive_report_cn(15,report_type=3,testdf)%>%t%>%as.data.frame%>%frm_handle_row_name(60016)
# df_report_all_cn<-recursive_report_cn(15,report_type=4,testdf)%>%t%>%as.data.frame%>%frm_handle_row_name(60016)
# df_report_all_cn<-recursive_report_cn(15,report_type=5,testdf)%>%t%>%as.data.frame%>%frm_handle_row_name(60016)
# mapply(recursive_report_cn,15,seq(1:5),testdf)
# testdf%>%htmlTable 
# test_report<-lapply(seq(1:5),function(x,y,z) recursive_report_cn(y,x,z)%>%t%>%as.data.frame%>%frm_handle_row_name(60016),15,testdf )
# lapply(seq(1:5),function(x) test_report[[x]]%>%htmlTable)


require(stats)
groups <- as.factor(rbinom(32, n = 5, prob = 0.4))
tapply(groups, groups, length) #- is almost the same as
table(groups)

## contingency table from data.frame : array with named dimnames
tapply(warpbreaks$breaks, warpbreaks[,-1], sum)
tapply(warpbreaks$breaks, warpbreaks[, 3, drop = FALSE], sum)

n <- 17; fac <- factor(rep(1:3, length = n), levels = 1:5)
table(fac)
tapply(1:n, fac, sum)
tapply(1:n, fac, sum, simplify = FALSE)
tapply(1:n, fac, range)
tapply(1:n, fac, quantile)

## example of ... argument: find quarterly means
tapply(presidents, cycle(presidents), mean, na.rm = TRUE)

ind <- list(c(1, 2, 2), c("A", "A", "B"))
table(ind)
tapply(1:3, ind) #-> the split vector
tapply(1:3, ind, sum)

## Some assertions (not held by all patch propsals):
nq <- names(quantile(1:5))
stopifnot(
  identical(tapply(1:3, ind), c(1L, 2L, 4L)),
  identical(tapply(1:3, ind, sum),
            matrix(c(1L, 2L, NA, 3L), 2, dimnames = list(c("1", "2"), c("A", "B")))),
  identical(tapply(1:n, fac, quantile)[-1],
            array(list(`2` = structure(c(2, 5.75, 9.5, 13.25, 17), .Names = nq),
                 `3` = structure(c(3, 6, 9, 12, 15), .Names = nq),
                 `4` = NULL, `5` = NULL), dim=4, dimnames=list(as.character(2:5)))))
				 
				 
require(stats)
by(warpbreaks[, 1:2], warpbreaks[,"tension"], summary)
by(warpbreaks[, 1],   warpbreaks[, -1],       summary)
by(warpbreaks, warpbreaks[,"tension"],
   function(x) lm(breaks ~ wool, data = x))

## now suppose we want to extract the coefficients by group
tmp <- with(warpbreaks,
            by(warpbreaks, tension,
               function(x) lm(breaks ~ wool, data = x)))
sapply(tmp, coef)

aggregate(BS_table,by=list(BS_table$Type),FUN=sum)


aggregate(BS_table$Close,by=list(BS_table$Type),FUN=sum)

Aggregating Tables with rowsum
Sometimes, you would simply like to calculate the sum of certain variables in an
object, grouped together by a grouping variable. To do this in R, use the rowsum
function:
rowsum(x, group, reorder = TRUE, ...)
For example, we can use rowsum to summarize batting statistics by team:
> rowsum(batting.2008[,c("AB", "H", "BB", "2B", "3B", "HR")],
+ group=batting.2008$teamID)
 AB H BB X2B X3B HR
ARI 5409 1355 587 318 47 159
ATL 5604 1514 618 316 33 130
BAL 5559 1486 533 322 30 172
BOS 5596 1565 646 353 33 173
CHA 5553 1458 540 296 13 235
CHN 5588 1552 636 329 21 184
CIN 5465 1351 560 269 24 187
CLE 5543 1455 560 339 22 171
COL 5557 1462 570 310 28 160
DET 5641 1529 572 293 41 200
FLO 5499 1397 543 302 28 208
HOU 5451 1432 449 284 22 167
KCA 5608 1507 392 303 28 120
LAA 5540 1486 481 274 25 159
LAN 5506 1455 543 271 29 137
MIL 5535 1398 550 324 35 198
MIN 5641 1572 529 298 49 111
Counting Values
Often, it can be useful to count the number of observations that take on each possible
value of a variable. R provides several functions for doing this.
The simplest function for counting the number of observations that take on a value
is the tabulate function. This function counts the number of elements in a vector
that take on each integer value and returns a vector with the counts.
As an example, suppose that you wanted to count the number of players who hit
0 HR, 1 HR, 2 HR, 3 HR, and so on. You could do this with the tabulate function:
> HR.cnts <- tabulate(batting.w.names.2008$HR)
> # tabulate doesn't label results, so let's add names:
> names(HR.cnts) <- 0:(length(HR.cnts) - 1)
> HR.cnts
 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
92 63 45 20 15 26 23 21 22 15 15 18 12 10 12 4 9 3 3 13 9 7 10
23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45
 4 8 2 5 2 4 0 1 6 6 3 1 2 4 1 0 0 0 0 0 0 0 0
46 47
 0 1
 For example, suppose that we wanted to count the number of left-handed batters,
right-handed batters, and switch hitters in 2008. We could use the data frame
batting.w.names.2008 defined above to provide the data and table to tabulate the
results:
> table(batting.w.names.2008$bats)
B L R
118 401 865
To make this a little more interesting, we could make this a two-dimensional table
showing the number of players who batted and threw with each hand:
> table(batting.2008[,c("bats", "throws")])
throws
bats L R
B 10 108
L 240 161
R 25 840
We could extend the results to another dimension, adding league ID:
, , lgID = AL
throws
bats L R
B 4 47
L 109 77
R 11 393
, , lgID = NL
throws
bats L R
B 6 61
L 131 84
R 14 447

Another useful function is xtabs, which creates contingency tables from factors using
formulas:
xtabs(formula = ~., data = parent.frame(), subset, na.action,
exclude = c(NA, NaN), drop.unused.levels = FALSE)
The xtabs function works the same as table, but it allows you to specify the group
ings by specifying a formula and a data frame. In many cases, this can save you some
typing. For example, here is how to use xtabs to tabulate batting statistics by batting
arm and league:
> xtabs(~bats+lgID, batting.2008)
lgID
bats AL NL
B 51 67
L 186 215
R 404 461
The table function only works on factors, but sometimes you might like to calculate
tables with numeric values as well. For example, suppose you wanted to count the
number of players with batting averages in certain ranges. To do this, you could use
the cut function and the table function:
> # first, add batting average to the data frame:
> batting.w.names.2008 <- transform(batting.w.names.2008, AVG = H/AB)
> # now, select a subset of players with over 100 AB (for some
> # statistical significance):
> batting.2008.over100AB <- subset(batting.2008, subset=(AB > 100))
> # finally, split the results into 10 bins:
> battingavg.2008.bins <- cut(batting.2008.over100AB$AVG,breaks=10)
> table(battingavg.2008.bins)
battingavg.2008.bins
(0.137,0.163] (0.163,0.189] (0.189,0.215] (0.215,0.24] (0.24,0.266]
4 6 24 67 121
(0.266,0.292] (0.292,0.318] (0.318,0.344] (0.344,0.37] (0.37,0.396]
132 70 11 5 2

Z <- stats::rnorm(10000)
table(cut(Z, breaks = -6:6))
sum(table(cut(Z, breaks = -6:6, labels = FALSE)))
sum(graphics::hist(Z, breaks = -6:6, plot = FALSE)$counts)

cut(rep(1,5), 4) #-- dummy
tx0 <- c(9, 4, 6, 5, 3, 10, 5, 3, 5)
x <- rep(0:8, tx0)
stopifnot(table(x) == tx0)

table( cut(x, b = 8))
table( cut(x, breaks = 3*(-2:5)))
table( cut(x, breaks = 3*(-2:5), right = FALSE))

##--- some values OUTSIDE the breaks :
table(cx  <- cut(x, breaks = 2*(0:4)))
table(cxl <- cut(x, breaks = 2*(0:4), right = FALSE))
which(is.na(cx));  x[is.na(cx)]  #-- the first 9  values  0
which(is.na(cxl)); x[is.na(cxl)] #-- the last  5  values  8


## Label construction:
y <- stats::rnorm(100)
table(cut(y, breaks = pi/3*(-3:3)))
table(cut(y, breaks = pi/3*(-3:3), dig.lab = 4))

table(cut(y, breaks =  1*(-3:3), dig.lab = 4))
# extra digits don't "harm" here
table(cut(y, breaks =  1*(-3:3), right = FALSE))
#- the same, since no exact INT!

## sometimes the default dig.lab is not enough to be avoid confusion:
aaa <- c(1,2,3,4,5,2,3,4,5,6,7)
cut(aaa, 3)
cut(aaa, 3, dig.lab = 4, ordered = TRUE)

## one way to extract the breakpoints
labs <- levels(cut(aaa, 3))
cbind(lower = as.numeric( sub("\\((.+),.*", "\\1", labs) ),
      upper = as.numeric( sub("[^,]*,([^]]*)\\]", "\\1", labs) ))
Reshaping data frames and matrices
R includes several functions that let you change data between narrow and wide
formats. Let’s use a small table of stock data to show how these functions work.
First, we’ll define a small portfolio of stocks. Then we’ll get monthly observation for
the first three months of 2009:
> my.tickers <- c("GE", "GOOG", "AAPL", "AXP", "GS")
> my.quotes <- get.multiple.quotes(my.tickers, from=as.Date("2009-01-01"),
+  to=as.Date("2009-03-31"), interval="m")
> my.quotes
symbol Date Open High Low Close Volume Adj.Close
1 GE 2009-03-02 8.29 11.35 5.87 10.11 277426300 10.11
2 GE 2009-02-02 12.03 12.90 8.40 8.51 1949288ls00 8.51
3 GE 2009-01-02 16.51 17.24 11.87 12.13 117846700 11.78
4 GOOG 2009-03-02 333.33 359.16 289.45 348.06 5346800 348.06
5 GOOG 2009-02-02 334.29 381.00 329.55 337.99 6158100 337.99
6 GOOG 2009-01-02 308.60 352.33 282.75 338.53 5727600 338.53
7 AAPL 2009-03-02 88.12 109.98 82.33 105.12 25963400 105.12
8 AAPL 2009-02-02 89.10 103.00 86.51 89.31 27394900 89.31
9 AAPL 2009-01-02 85.88 97.17 78.20 90.13 33487900 90.13
10 AXP 2009-03-02 11.68 15.24 9.71 13.63 31136400 13.45
11 AXP 2009-02-02 16.35 18.27 11.44 12.06 24297100 11.90
12 AXP 2009-01-02 18.57 21.38 14.72 16.73 19110000 16.51
13 GS 2009-03-02 87.86 115.65 72.78 106.02 30196400 106.02
14 GS 2009-02-02 78.78 98.66 78.57 91.08 28301500 91.08
15 GS 2009-01-02 84.02 92.20 59.13 80.73 22764300 80.29

We can use the unstack function to change the format of this data from a stacked
form to an unstacked form:
> unstack(my.quotes.narrow, form=Close~symbol)
GE GOOG AAPL AXP GS
1 10.11 348.06 105.12 13.63 106.02
2 8.51 337.99 89.31 12.06 91.08
3 12.13 338.53 90.13 16.73 80.73

> unstacked <- unstack(my.quotes.narrow, form=Close~symbol)
> stack(unstacked)
values ind
1 10.11 GE
2 8.51 GE
3 12.13 GE
4 348.06 GOOG
5 337.99 GOOG
6 338.53 GOOG
7 105.12 AAPL
8 89.31 AAPL
9 90.13 AAPL
10 13.63 AXP
11 12.06 AXP
12 16.73 AXP
13 106.02 GS

> my.quotes.wide <- reshape(my.quotes.narrow, idvar="Date",
+  timevar="symbol", direction="wide")
> my.quotes.wide
Date Close.GE Close.GOOG Close.AAPL Close.AXP Close.GS
1 2009-03-02 10.11 348.06 105.12 13.63 106.02
2 2009-02-02 8.51 337.99 89.31 12.06 91.08
3 2009-01-02 12.13 338.53 90.13 16.73 80.73

> attributes(my.quotes.wide)
$row.names
[1] 1 2 3
$names
[1] "Date" "Close.GE" "Close.GOOG" "Close.AAPL" "Close.AXP"
[6] "Close.GS"
$class
[1] "data.frame"
$reshapeWide
$reshapeWide$v.names
NULL
$reshapeWide$timevar
[1] "symbol"
$reshapeWide$idvar
[1] "Date"
$reshapeWide$times
[1] GE GOOG AAPL AXP GS
Levels: GE GOOG AAPL AXP GS
$reshapeWide$varying
[,1] [,2] [,3] [,4] [,5]
[1,] "Close.GE" "Close.GOOG" "Close.AAPL" "Close.AXP" "Close.GS"

> reshape(my.quotes.narrow, idvar="symbol", timevar="Date", direction="wide")
symbol Close.2009-03-02 Close.2009-02-02 Close.2009-01-02
1 GE 10.11 8.51 12.13
4 GOOG 348.06 337.99 338.53
7 AAPL 105.12 89.31 90.130
> my.quotes.oc <- my.quotes[,c("symbol", "Date", "Close", "Open")]
> my.quotes.oc
 symbol Date Close Open
1 GE 2009-03-02 10.11 8.29
2 GE 2009-02-02 8.51 12.03
3 GE 2009-01-02 12.13 16.51

reshape(my.quotes.oc, timevar="Date", idvar="symbol", direction="wide")

melt(BS_table)

Now that we have the data into a molten form, it’s very straightforward to transform
it with cast. Here are a few examples:
> # prices by date for just GE
> cast(data=my.molten.quotes, variable~Date, subset=(symbol=='GE'))
variable 2009-01-02 2009-02-02 2009-03-02
1 Open 16.51 12.03 8.29
2 High 17.24 12.90 11.35
3 Low 11.87 8.40 5.87
4 Close 12.13 8.51 10.11
5 Volume 117846700.00 194928800.00 277426300.00
6 Adj.Close 10.75 7.77 9.235

#Air quality example
names(airquality) <- tolower(names(airquality))
aqm <- melt(airquality, id=c("month", "day"), na.rm=TRUE)

acast(aqm, day ~ month ~ variable)
acast(aqm, month ~ variable, mean)
acast(aqm, month ~ variable, mean, margins = TRUE)
dcast(aqm, month ~ variable, mean, margins = c("month", "variable"))

library(plyr) # needed to access . function
acast(aqm, variable ~ month, mean, subset = .(variable == "ozone"))
acast(aqm, variable ~ month, mean, subset = .(month == 5))

#Chick weight example
names(ChickWeight) <- tolower(names(ChickWeight))
chick_m <- melt(ChickWeight, id=2:4, na.rm=TRUE)

dcast(chick_m, time ~ variable, mean) # average effect of time
dcast(chick_m, diet ~ variable, mean) # average effect of diet
acast(chick_m, diet ~ time, mean) # average effect of diet & time

# How many chicks at each time? - checking for balance
acast(chick_m, time ~ diet, length)
acast(chick_m, chick ~ time, mean)
acast(chick_m, chick ~ time, mean, subset = .(time < 10 & chick < 20))

acast(chick_m, time ~ diet, length)

dcast(chick_m, diet + chick ~ time)
acast(chick_m, diet + chick ~ time)
acast(chick_m, chick ~ time ~ diet)
acast(chick_m, diet + chick ~ time, length, margins="diet")
acast(chick_m, diet + chick ~ time, length, drop = FALSE)

#Tips example
dcast(melt(tips), sex ~ smoker, mean, subset = .(variable == "total_bill"))

ff_d <- melt(french_fries, id=1:4, na.rm=TRUE)
acast(ff_d, subject ~ time, length)
acast(ff_d, subject ~ time, length, fill=0)
dcast(ff_d, treatment ~ variable, mean, margins = TRUE)
dcast(ff_d, treatment + subject ~ variable, mean, margins="treatment")
if (require("lattice")) {
 lattice::xyplot(`1` ~ `2` | variable, dcast(ff_d, ... ~ rep), aspect="iso")
}


cast(data=BS_table, Type~close)

> duplicated(my.quotes.2)
[1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[12] FALSE FALSE FALSE FALSE TRUE TRUE TRUE
As expected, duplicated shows that the last three rows are duplicates of earlier rows.
You can use the resulting vector to remove duplicates:
> my.quotes.unique <- my.quotes.2[!duplicated(my.quotes.2),]
Alternatively, you could use the unique function to remove the duplicate values:
> my.quotes.unique <- unique(my.quotes.2)



Sorting
Two final operations that you might find useful for analysis are sorting and ranking
functions.
To sort the elements of an object, use the sort function:
> w <- c(5, 4, 7, 2, 7, 1)
> sort(w)
[1] 1 2 4 5 7 7
Add the decreasing=TRUE option to sort in reverse order:
> sort(w, decreasing=TRUE)
[1] 7 7 5 4 2 1
You can control the treatment of NA values by setting the na.last argument:
> length(w)
[1] 6
> length(w) <- 7
> # note that by default, NA.last=NA and NA values are not shown
> sort(w)
[1] 1 2 4 5 7 7
> # set NA.last=TRUE to put NA values last
> sort(w, na.last=TRUE)
[1] 1 2 4 5 7 7 NA
> # set NA.last=FALSE to put NA values first
> sort(w, na.last=FALSE)
[1] NA 1 2 4 5 7 7

Sorting data frames is somewhat nonintuitive. To sort a data frame, you need to
create a permutation of the indices from the data frame and use these to fetch the
rows of the data frame in the correct order. You can generate an appropriate permutation of the indices using the order function:
order(..., na.last = , decreasing = )
The order function takes a set of vectors as arguments. It sorts recursively by each
vector, breaking ties by looking at successive vectors in the argument list. At the end,
it returns a permutation of the indices of the vector corresponding to the sorted
order. (The arguments na.last and decreasing work the same way as they do for
sort.) To see what this means, let’s use a simple example. First, we’ll define a vector
with two elements out of order:
> v <- c(11, 12, 13, 15, 14)
You can see that the first three elements (11, 12, 13) are in order, and the last two
(15, 14) are reversed. Let’s call order to see what it does:
> order(v)
[1] 1 2 3 5 4
This means “move row 1 to row 1, move row 2 to row 2, move row 3 to row 3, move
row 4 to row 5, move row 5 to row 4.” We can return a sorted version of v using an
indexing operator:
> v[order(v)]
[1] 11 12 13 14 15
Suppose that we created the following data frame from the vector v and a second
vector u:
> u <- c("pig", "cow", "duck", "horse", "rat")
> w <- data.frame(v, u)
> w
 v u
1 11 pig
2 12 cow
3 13 duck
4 15 horse
5 14 rat
We could sort the data frame w by v using the following expression:
> w[order(w$v),]
 v u
1 11 pig
2 12 cow
3 13 duck
5 14 rat
4 15 horse
As another example, let’s sort the my.quotes data frame (that we created earlier) by
closing price:
So

> my.quotes[order(my.quotes$Close),]
symbol Date Open High Low Close Volume Adj.Close
2 GE 2009-02-02 12.03 12.90 8.40 8.51 194928800 8.51
1 GE 2009-03-02 8.29 11.35 5.87 10.11 277426300 10.11
11 AXP 2009-02-02 16.35 18.27 11.44 12.06 24297100 11.90
3 GE 2009-01-02 16.51 17.24 11.87 12.13 117846700 11.78
10 AXP 2009-03-02 11.68 15.24 9.71 13.63 31136400 13.45
12 AXP 2009-01-02 18.57 21.38 14.72 16.73 19110000 16.51
15 GS 2009-01-02 84.02 92.20 59.13 80.73 22764300 80.29
8 AAPL 2009-02-02 89.10 103.00 86.51 89.31 27394900 89.31
9 AAPL 2009-01-02 85.88 97.17 78.20 90.13 33487900 90.13
14 GS 2009-02-02 78.78 98.66 78.57 91.08 28301500 91.08
7 AAPL 2009-03-02 88.12 109.98 82.33 105.12 25963400 105.12
13 GS 2009-03-02 87.86 115.65 72.78 106.02 30196400 106.02
5 GOOG 2009-02-02 334.29 381.00 329.55 337.99 6158100 337.99
6 GOOG 2009-01-02 308.60 352.33 282.75 338.53 5727600 338.53
4 GOOG 2009-03-02 333.33 359.16 289.45 348.06 5346800 348.06
You could sort by symbol and then by closing price using the following expression:
> my.quotes[order(my.quotes$symbol, my.quotes$Close),]
symbol Date Open High Low Close Volume Adj.Close
2 GE 2009-02-02 12.03 12.90 8.40 8.51 194928800 8.51
1 GE 2009-03-02 8.29 11.35 5.87 10.11 277426300 10.11
3 GE 2009-01-02 16.51 17.24 11.87 12.13 117846700 11.78
5 GOOG 2009-02-02 334.29 381.00 329.55 337.99 6158100 337.99
6 GOOG 2009-01-02 308.60 352.33 282.75 338.53 5727600 338.53
4 GOOG 2009-03-02 333.33 359.16 289.45 348.06 5346800 348.06
8 AAPL 2009-02-02 89.10 103.00 86.51 89.31 27394900 89.31
9 AAPL 2009-01-02 85.88 97.17 78.20 90.13 33487900 90.13
7 AAPL 2009-03-02 88.12 109.98 82.33 105.12 25963400 105.12
11 AXP 2009-02-02 16.35 18.27 11.44 12.06 24297100 11.90
10 AXP 2009-03-02 11.68 15.24 9.71 13.63 31136400 13.45
12 AXP 2009-01-02 18.57 21.38 14.72 16.73 19110000 16.51
15 GS 2009-01-02 84.02 92.20 59.13 80.73 22764300 80.29
14 GS 2009-02-02 78.78 98.66 78.57 91.08 28301500 91.08
13 GS 2009-03-02 87.86 115.65 72.78 106.02 30196400 106.02
Sorting a whole data frame is a little strange. You can create a suitable permutation
using the order function, but you need to call order using do.call for it to work
properly. (The reason for this is that order expects a list of vectors and interprets the
data frame as a single vector, not as a list of vectors.) Let’s try sorting the
my.quotes table we just created:
> # what happens when you call order on my.quotes directly: the data
> # frame is interpreted as a vector
> order(my.quotes)
[1] 61 94 96 95 31 62 77 107 70 76 106 46 71 40 108 63
[17] 116 32 86 78 47 115 85 72 55 41 33 117 87 48 56 42
[33] 102 57 105 101 97 98 104 103 100 99 75 73 69 74 44 120
[49] 90 67 45 39 68 43 37 38 83 113 84 114 89 119 60 54
[65] 59 53 82 112 88 118 52 58 93 92 18 21 24 27 30 17
[81] 20 23 26 29 16 19 22 25 28 91 66 64 36 65 34 35
[97] 80 110 81 111 79 109 51 49 50 7 8 9 10 11 12 1
[113] 2 3 4 5 6 13 14 15
> # what you get when you use do.call:
> do.call(order,my.quotes)
[1] 3 2 1 6 5 4 9 8 7 12 11 10 15 14 13
> # now, return the sorted data frame using the permutation:
> my.quotes[do.call(order, my.quotes),]
symbol Date Open High Low Close Volume Adj.Close
3 GE 2009-01-02 16.51 17.24 11.87 12.13 117846700 11.78
2 GE 2009-02-02 12.03 12.90 8.40 8.51 194928800 8.51
1 GE 2009-03-02 8.29 11.35 5.87 10.11 277426300 10.11
6 GOOG 2009-01-02 308.60 352.33 282.75 338.53 5727600 338.53
5 GOOG 2009-02-02 334.29 381.00 329.55 337.99 6158100 337.99
4 GOOG 2009-03-02 333.33 359.16 289.45 348.06 5346800 348.06
9 AAPL 2009-01-02 85.88 97.17 78.20 90.13 33487900 90.13
8 AAPL 2009-02-02 89.10 103.00 86.51 89.31 27394900 89.31
7 AAPL 2009-03-02 88.12 109.98 82.33 105.12 25963400 105.12
12 AXP 2009-01-02 18.57 21.38 14.72 16.73 19110000 16.51
11 AXP 2009-02-02 16.35 18.27 11.44 12.06 24297100 11.90
10 AXP 2009-03-02 11.68 15.24 9.71 13.63 31136400 13.45
15 GS 2009-01-02 84.02 92.20 59.13 80.73 22764300 80.29
14 GS 2009-02-02 78.78 98.66 78.57 91.08 28301500 91.08
13 GS 2009-03-02 87.86 115.65 72.78 106.02 30196400 106.02


An Overview of R Graphics
R includes tools for drawing most common types of charts, including bar charts, pie
charts, line charts, and scatter plots. Additionally, R can also draw some less-familiar
charts like quantile-quantile (Q-Q) plots, mosaic plots, and contour plots. The fol
lowing table shows many of the charts included in the graphics package.
Graphics package function Description
barplot Bar and column charts
dotchart Cleveland dot plots
hist Histograms
density Kernel density plots
stripchart Strip charts
qqnorm (in stats package) Quantile-quantile plots
xplot Scatter plots
smoothScatter Smooth scatter plots
qqplot (in stats package) Quantile-quantile plots
Graphics package function Description
pairs Scatter plot matrices
image Image plots
contour Contour plots
persp Perspective charts of three-dimensional data
interaction.plot Summary of the response for two-way combinations of factors
sunflowerplot Sunflower plots

Scatter Plots
To show how to use scatter plots, we will look at cases of cancer in 2008 and toxic
waste releases by state in 2006. Data on new cancer cases (and deaths from cancer)
are tabulated by the American Cancer Society; information on toxic chemicals re
leased into the environment is tabulated by the U.S. Environmental Protection
Agency (EPA).1
The sample data is included in the nutshell package:
> library(nutshell)
> data(toxins.and.cancer)
To show a scatter plot, use the plot function. plot is a generic function (you can
“plot” many different types of objects); plot also can draw many types of objects,
including vectors, tables, and time series. For simple scatter plots with two vectors,
the function that is called is plot.default:
plot(x, y = NULL, type = "p", xlim = NULL, ylim = NULL,
log = "", main = NULL, sub = NULL, xlab = NULL, ylab = NULL,
ann = par("ann"), axes = TRUE, frame.plot = axes,
panel.first = NULL, panel.last = NULL, asp = NA, ...)
Here is a description of the arguments to plot.

library(nutshell)
data(toxins.and.cancer)
attach(toxins.and.cancer)
plot(total_toxic_chemicals/Surface_Area, deaths_total/Population)

plot(air_on_site/Surface_Area, deaths_lung/Population)


plot(air_on_site/Surface_Area, deaths_lung/Population,
xlab="Air Release Rate of Toxic Chemicals",
ylab="Lung Cancer Death Rate")
text(air_on_site/Surface_Area, deaths_lung/Population,
labels=State_Abbrev,
cex=0.5,
adj=c(0,-1))


