##/media/syrhades/DAA4BB34A4BB11CD1
##  R CMD BATCH /media/syrhades/DAA4BB34A4BB11CD1/stock_class_fin_report_v4.R

#`R` 表示R interpreter，`CMD` 表示一个 R 工具会被使用。一般的语法是`R CMD 命令 参数`。`BATCH`支持非交互式地执行脚本命令，
#即程序执#行时不用与我们沟通，不用运行到半路还需要我们给个参数啥的。

args <- commandArgs()
print(args)

library(R6)               # 加载R6包
library(pryr)             # 加载pryr包
library(R6)               # 加载R6包
library(pryr)             # 加载pryr包
library(stringr) 
#install.packages("scrape")
#require(scrape)
#require(iterators)
install.packages("iterators")
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

frm_try<-function(try_function){
    ## try wrapper function 
    tryCatch ( {
        try_function
    } , 
    warning = function ( w ) {
        print(w)
    } ,
    error = function ( e ) {
        print(e)
    } ,
    finally = {
        print("finally done")
    } 
)
}




##Return CPU (and other) times that expr used.
##Usage

##system.time(expr, gcFirst = TRUE)
##unix.time(expr, gcFirst = TRUE)



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
		self$url_html <- paste("http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid=",self$stockid,sep="");
		self$xjllurl_html <- paste("http://stockdata.stock.hexun.com/2008en/xjll.aspx?stockid=",self$stockid,sep="")
		self$lrurl_html <- paste("http://stockdata.stock.hexun.com/2008en/lr.aspx?stockid=",self$stockid,sep="")
		self$zcfzurl_html <- paste("http://stockdata.stock.hexun.com/2008en/zcfz.aspx?stockid=",self$stockid,sep="")
		self$dbfileName <- dbfileName
		#self$url_html <- paste(self$stockid,sep="")
		self$stockmarket<-stockmarket
		self$report_type<-c("zxcwzb",
							"cwbl",
							"zcfz",
							"lr",
							"xjll")
	},
	frm_get_url_xpath = function(url,xpath_exp){
                ## using  xpath to extract content in html 
		url_html <- htmlParse(url) 
		ans <- getNodeSet(url_html , xpath_exp)
		#sapply(ans, xmlValue)
		#return(ans)
	},
	frm_get_finance_year_list = function(url){
                ## not using in the future
		url_html <- htmlParse(url) 
		ans <- getNodeSet(url_html , "//table//ul[1]/li")
		year_list <- sapply(ans, xmlValue)
		year_list <- year_list[-length(year_list)]
		year_list <-as.numeric(year_list)
		return(year_list[!is.na(year_list)])
	},
        frm_get_finance_year_list2=function(url_report){
            ## extract detail date for report 
            process_obj<-cl_syrhades_tool$new()
            htmlresult<-process_obj$frm_get_url_xpath(url_report,"//div[@id='zaiyaocontent']/script")%>%sapply(xmlValue)
            year_list<-str_extract_all(htmlresult,"\\d{4}\\.\\d{2}\\.\\d{2}")
            return(year_list)
        },
	frm_hexun_fin_table = function(stock_code,cn_en,year,report_type){
                ## extract html format finance table from hexun 
		#stock_code<-sprintf("%06d", stock_code)
		query <- switch(
				cn_en,
				en = paste("?stockid=",stock_code,"&type=1&date=",year,sep="")  ,
				cn = paste("?stockid="  ,stock_code,"&accountdate=",year,sep="")  ,
				"NA"
		)
			url_head <- switch(
				cn_en,
				en = paste("http://stockdata.stock.hexun.com/2008en/")  ,
				cn = paste("http://stockdata.stock.hexun.com/2008/")  ,
				"NA"
		)
			report_url<-paste(url_head,report_type,".aspx",query,sep="")
			#print(report_url)
			tbls_list    <- lapply(report_url,readHTMLTable)
			names(tbls_list)<-report_type
			return(tbls_list)
		finance_tb<-switch(
				cn_en,
				en = lapply(tbls_list,function(x) as.data.frame((x[[2]]))),
				cn = lapply(tbls_list,function(x) as.data.frame((x[[3]]))) ,
				#"NA"
		)
		return(finance_tb)
	},
	frm_collect_all_report = function (year,stockid,language,report_type){
                ## temp function for lapply
		self$frm_hexun_fin_table(stockid,language,year,report_type)
	},
	#frm_handle_row_name = function(df_table,stock_id,stock_name){
	#	row.names(df_table)<-seq(length(row.names(df_table)))
	#	df_table$stock_id <-stock_id
	#	df_table$stock_name <-stock_name
	#	return(df_table)
	#},
	frm_save_fin_table2_sqlite = function(sql_dbfile,R_df,tb_name){
                ## save data frame to sqlite db file
		require(DBI)
		# Create an ephemeral in-memory RSQLite database
		con <- dbConnect(RSQLite::SQLite(), sql_dbfile)
		dbListTables(con)
		#write dataframe R_df to Sqlite db file
		dbWriteTable(con, tb_name, R_df,overwrite=TRUE)
		dbListTables(con)
		# Disconnect from the database
		dbDisconnect(con)
	},
	## generate 5 type reports
	frm_all = function(){lapply(seq(1:5),function (x) frm_try(self$frm_single_table(x)))},
	frm_cwbl = function(){self$frm_single_table(2)},
        frm_1 = function(){
		self$frm_single_table(1)
	},
        frm_2 = function(){
		self$frm_single_table(2)
	},
	frm_3 = function(){
		self$frm_single_table(3)
	},
        frm_4 = function(){
		self$frm_single_table(4)
	},
        frm_5 = function(){
		self$frm_single_table(5)
	},
	frm_lr = function(){
		self$frm_single_table(4)
	},
        frm_xjll = function(){
		self$frm_single_table(5)
	},
	frm_single_table = function(positon){
                        ## cell function for one kind finance report 
			##step1 get year list
			#get stock chinese Name
			stockname=self$frm_get_url_xpath(self$url_html,"//div[@class='content nav']/div/a")%>%sapply(xmlValue)
			#cat(stockname)
			stockname=stockname[[3]]
			report_type<-self$report_type[positon]
			#cat(url)
			url_report<-paste("http://stockdata.stock.hexun.com/2008en/",report_type,".aspx?stockid=",self$stockid,sep="");
			url_report<-paste("http://stockdata.stock.hexun.com/2008/",report_type,".aspx?stockid=",self$stockid,sep="");
			#cat(url_report,"\n")
			## generate year list
			year_list=self$frm_get_finance_year_list2(url_report)
			#print(year_list)
			#return(year_list)
			self$n_year=length(year_list[[1]])
			#cat("\ncarlos>>>>",self$n_year)
			## extract all year for one type finance report from www
			all_reports_cn<-lapply(year_list,self$frm_collect_all_report,self$stockid,"cn",self$report_type[positon]);
			#return(all_reports_cn)
			#return(all_reports_cn);
			## using recursive method to combine all reports 
			f_report_cn<-cl_report_combine$new(self$stockmarket)$rec_single_table(all_reports_cn,self$n_year)%>%as.data.frame;
			#f_report_cn<-f_report_cn[[1]]
			f_report_cn$stockname<-stockname;
			#return(f_report_cn)
			# save finance report to sqlite db file,
			#report_series<-cl_report_combine$new(self$stockmarket)$report_series;
			## save data frame to database file
			table_name<-paste(report_type,self$stockid,sep="_")
			self$frm_save_fin_table2_sqlite(self$dbfileName,f_report_cn,table_name)
			cat(table_name,"has been saved","to",self$dbfileName,"\n")
		}
	)
)


cl_report_combine <- R6Class("Stock_report_combine",    # 定义一个R6类
        ## using recursive method to combine reports
	lock_objects = FALSE,
	public=list(
	initialize = function(stock_market){
		self$report_series <- switch(
					stock_market,
					sz = seq(1:4)  ,
					sh = seq(1:4)  ,
					"NA"
			)
		self$stock_market<-stock_market
	},
	test_lappy = function(x,y,z){
			tmpdf<-self$recursive_report_cn(y,z)
			colnames(tmpdf)<-NULL
			tmpdf<-tmpdf%>%t%>%as.data.frame
			return(tmpdf)},
        recursive_report_cn = function(n,all_report){
                ## recursive method  important
               if ((n == 0) | (n == 1)| (n == 2)){
			sum =cbind(all_report[[1]][[2]][[3]])
			return (sum)
			}
		else
			sum = cbind(self$recursive_report_cn(n-1,all_report),all_report[[1]][[n]][[3]][,-1])
		return (sum)
	},
	rec_single_table = function(all_reports_cn,year_len){
		n_year<- switch(
					self$stock_market,
					sz = year_len,
					sh = year_len-2  ,
					"NA"
			)
                #cat(n_year)
                f_report_cn<-self$recursive_report_cn(n_year,all_reports_cn)
                colnames(f_report_cn)<-NULL
                f_report_cn<-f_report_cn%>%t%>%as.data.frame
		#f_report_cn<-lapply(seq(1),self$test_lappy,n_year,all_reports_cn) 
		return(f_report_cn)
   },
	main = function(all_reports_cn){
                ## no using now
		n_year<- switch(
					self$stock_market,
					sz = length(all_reports_cn)  ,
					sh = length(all_reports_cn)-2  ,
					"NA"
			)

		f_report_cn<-lapply(self$report_series,self$test_lappy,n_year,all_reports_cn) 
		return(f_report_cn)
	   },
	test = function(all_reports_cn){
                ## test function
		n_year<- switch(
					self$stock_market,
					sz = length(all_reports_cn)  ,
					sh = length(all_reports_cn)-2  ,
					"NA"
			)
		cat("carlos>>>>>>",n_year,"\n")
		
		cat(self$stock_market,"\n")
		cat(self$report_series,"\n")
		f_report_cn<-lapply(self$report_series,self$test_lappy,n_year,all_reports_cn) 
		return(f_report_cn)
	   }
	)
)


#########################################################
cl_syrhades_tool <- R6Class("tool",    # 定义一个R6类
	lock_objects = FALSE,
	public=list(
            initialize = function(){
                },
            frm_get_url_xpath = function(url,xpath_exp){
                url_html <- htmlParse(url) 
                ans <- getNodeSet(url_html , xpath_exp)
                #sapply(ans, xmlValue)
                #return(ans)
                },
            frm_grex_str = function(strobj,grep_expr){
                greg_result<-gregexpr(grep_expr,strobj)[[1]]
                startpos<-greg_result
                length_pos<-attr(greg_result,"match.length")
                lapply(startpos,function(x) substr(strobj,x,x+length_pos-1))
                }
                
            )
    )
#da<-cl_Stock_report_process$new(19,dbfile,"sz")$frm_1()
#da%>%htmlTable
frm_set_path<-function(){
    ## check OS R_PLATFORM
    R_PLATFORM<-Sys.getenv(c("R_PLATFORM"))
    if(str_detect(R_PLATFORM, "linux")) path<-"~/sdcard1"
    else path<-"e:"
    return (path)
}

frm_batch_stock_report<-function(stockfile,dbf_name){
    ## reading stock list file to save report information to dbfile 
    filename<-paste(frm_set_path(),stockfile,sep="/")
    stockdf<-read.csv(filename,sep =".",head = F)
    dbfile<-paste(frm_set_path(),dbf_name,sep="/")

    lapply(seq(1,nrow(stockdf)),
                        function(idx) d_ply(stockdf[idx,],"V2",
                                                            function(x) cl_Stock_report_process$new(x$V1,dbfile,str_to_lower(x$V2))$frm_all()))
}

system.time(frm_batch_stock_report(stockfile="stocklist.log",dbf_name="tb_finance_test2.db"))

library(profvis)

p <-profvis({
  frm_batch_stock_report(stockfile="stocklist.log",dbf_name="tb_finance_test2.db")
})
