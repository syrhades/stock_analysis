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


######################################################################################
## main stock finance report process
######################################################################################
cl_Stock_report_process <- R6Class("Stock_report_process",    # 定义一个R6类
	lock_objects = FALSE,
	public=list(
	stockid 	= NA,
	dbfileName	= NA,
	R_df		= NA,
	initialize = function(stockid,dbfileName,stockmarket){       # 构建函数方法
		self$stockid <- sprintf("%06d", stockid)
		self$url_html <- paste("http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid=",self$stockid,sep="")
		self$dbfileName <- dbfileName
		#self$url_html <- paste(self$stockid,sep="")
		self$stockmarket<-stockmarket
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
		stock_code<-sprintf("%06d", stock_code)
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
			print(report_url)
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
	#all_reports_cn = lapply(year_list,frm_collect_all_report,600016,"cn"),
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
			sum = cbind(self$recursive_report_cn(n-1,report_type,all_report),all_report[[n]][[report_type]][[3]][,-1])
		return (sum)
	},
	frm_handle_row_name = function(df_table,stock_id,stock_name){
		row.names(df_table)<-seq(length(row.names(df_table)))
		df_table$stock_id <-stock_id
		df_table$stock_name <-stock_name
		return(df_table)
	},
	frm_save_fin_table2_sqlite = function(sql_dbfile,R_df,tb_name){
		require(DBI)
		# Create an ephemeral in-memory RSQLite database
		con <- dbConnect(RSQLite::SQLite(), sql_dbfile)

		dbListTables(con)
		#write dataframe R_df to Sqlite db file
		dbWriteTable(con, tb_name, R_df)
		dbListTables(con)
		# Disconnect from the database
		dbDisconnect(con)
	},
	frm_main = function(){
		##step1 get year list
		#get stock chinese Name
		stockname=self$frm_get_url_xpath(self$url_html,"//div[@class='content nav']/div/a")%>%sapply(xmlValue)
		stockname=stockname[[3]]
		#cat(url)
		year_list=self$frm_get_finance_year_list(self$url_html)
		#return(year_list)
		n_year=length(year_list)
		cat(n_year)
		#return(n_year)
		#cat(year_list)
		#return (year_list)
		report_type<-c(	"zxcwzb",
						"cwbl",
						"zcfz",
						"lr",
						"xjll")
		# step2 get all years  stock finance table  chinese version
		print(self$stockid)
		
		all_reports_cn<-lapply(year_list,self$frm_collect_all_report,self$stockid,"cn")
		#return(all_reports_cn)
		#all_reports_en<-lapply(year_list,frm_collect_all_report,stockid,"en")
			#step3 
	# become 5 reports dataframe 
	#report_type_seq<-seq(1:5)
	#df_report_all_cn_xjll<-recursive_report_cn(n_year-2,report_type=5,all_reports_cn)%>%t%>%as.data.frame%>%frm_handle_row_name(60016)
	#mapply(recursive_report_cn,n_year-2,report_type_seq,all_reports_cn)
	#f_report_cn<-lapply(seq(1:5),function(x,y,z) self$recursive_report_cn(y,x,z)%>%t%>%as.data.frame%>% self$frm_handle_row_name(self$stockid,stockname),n_year-2,all_reports_cn )
	f_report_cn<-cl_report_combine$new(self$stockmarket)$test(all_reports_cn)
	#f_report_cn<-lapply(seq(1:5),function(x,y,z) self$frm_handle_row_name(as.data.frame(t(self$recursive_report_cn(y,x,z))),self$stockid,stockname),n_year-2,all_reports_cn )
	#return(f_report_cn)
	
	#(f_report_cn)
	#step4
	# save finance report to sqlite db file,
	report_series<-cl_report_combine$new(self$stockmarket)$report_series
	lapply(report_series,function(x,reports,report_type,dbfile) 
								 self$frm_save_fin_table2_sqlite(dbfile,reports[[x]],paste(report_type[x],self$stockid,sep="_"))
							     ,reports=f_report_cn, report_type,dbfile=self$dbfileName )
	}
	)
)

fav_stock<-c(600298,600305)
#cl_Stock_report_process$new(600016,"e:/tb_finance.db")$frm_main()
lapply(fav_stock,function (x) cl_Stock_report_process$new(x,"e:/tb_finance.db","sz")$frm_main())

cl_Stock_report_process$new(2807,"e:/tb_finance.db","sz")$frm_main()

cl_Stock_report_process$new(2807,"e:/tb_finance.db","sz")$frm_main()
cl_report_combine <- R6Class("Stock_report_combine",    # 定义一个R6类
	lock_objects = FALSE,
	public=list(
	initialize = function(stock_market){
		self$report_series <- switch(
					stock_market,
					sz = seq(1:5)  ,
					sh = seq(1:5)  ,
					"NA"
			)
		self$stock_market<-stock_market
	},
	test_lappy = function(x,y,z){
			tmpdf<-self$recursive_report_cn(y,x,z)
			colnames(tmpdf)<-NULL
			tmpdf<-tmpdf%>%t%>%as.data.frame
			return(tmpdf)},
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
			sum = cbind(self$recursive_report_cn(n-1,report_type,all_report),all_report[[n]][[report_type]][[3]][,-1])
		return (sum)
	},
	test = function(all_reports_cn){
		n_year<- switch(
					self$stock_market,
					sz = length(all_reports_cn)  ,
					sh = length(all_reports_cn)-2  ,
					"NA"
			)
		f_report_cn<-lapply(self$report_series,self$test_lappy,n_year,all_reports_cn) 
		return(f_report_cn)
	   }
	)
	)
	
cl_report_combine$new("sz")$test(all_reports_cn)[[1]]%>%htmlTable


cl_report_combine$new()$test(all_reports_cn,22)[[2]]%>%htmlTable
cl_report_combine$new()$test(all_reports_cn,22)[[4]]%>%htmlTable
# stock6000305<-cl_Stock_report_process$new(600305,"e:/tb_finance.db")
# stock6000305$frm_main()
fav_stock<-c(1,2142,2807,600015,600016,600036,600919,601009,601166,601169,601288,601328,601398,601818,601939,601988,601997,601998)

fav_stock<-c(600015,600036,600919,601009,601166,601997)
fav_stock<-c(1,2142,2807)
#cl_Stock_report_process$new(600016,"e:/tb_finance.db")$frm_main()
lapply(fav_stock,function (x) cl_Stock_report_process$new(x,"e:/tb_finance.db","sz")$frm_main())
year<-cl_Stock_report_process$new(1,"e:/tb_finance.db")$frm_main()
all_reports_cn<-cl_Stock_report_process$new(1,"e:/tb_finance.db")$frm_main()
cl_test$new()$test(all_reports_cn,22)%>%htmlTable
#cl_Stock_report_process$new(1,"e:/tb_finance.db")$frm_hexun_fin_table(1,"cn",2015)
#cl_Stock_report_process$new(600000,"e:/tb_finance.db")$frm_main())
recursive_report_cn(10,report_type=5,all_reports_cn)%>%t%>%as.data.frame
recursive_report_cn(19,report_type=5,all_reports_cn)%>%t%>%as.data.frame

all_reports_cn[[19]][[1]][[3]]%>%htmlTable

http://stockdata.stock.hexun.com/2009_xjll_600298.shtml


