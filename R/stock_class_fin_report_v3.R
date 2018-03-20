library(R6)               # 加载R6包
library(pryr)             # 加载pryr包
library(R6)               # 加载R6包
library(pryr)             # 加载pryr包

library(stringr) 
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
        frm_get_finance_year_list2=function(url_report){
            process_obj<-cl_syrhades_tool$new()
            htmlresult<-process_obj$frm_get_url_xpath(url_report,"//div[@id='zaiyaocontent']/script")%>%sapply(xmlValue)
            year_list<-str_extract_all(htmlresult,"\\d{4}\\.\\d{2}\\.\\d{2}")
            return(year_list)
        },
	frm_hexun_fin_table = function(stock_code,cn_en,year,report_type){
		#stock_code<-sprintf("%06d", stock_code)
		query <- switch(
				cn_en,
				en = paste("?stockid=",stock_code,"&type=1&date=",year,sep="")  ,
				cn = paste("?stockid="  ,stock_code,"&accountdate=",year,sep="")  ,
				"NA"
		)
			# report_type <- 
				# c("zxcwzb",
				# "cwbl",
				# "zcfz",
				# "lr"
				# ##"xjll"
				# )
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
		self$frm_hexun_fin_table(stockid,language,year,report_type)
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
		dbWriteTable(con, tb_name, R_df,overwrite=TRUE)
		dbListTables(con)
		# Disconnect from the database
		dbDisconnect(con)
	},
	frm_all = function(){lapply(seq(1:5),self$frm_single_table)},
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
			##step1 get year list
			#get stock chinese Name
			stockname=self$frm_get_url_xpath(self$url_html,"//div[@class='content nav']/div/a")%>%sapply(xmlValue)
			#cat(stockname)
			stockname=stockname[[3]]
			report_type<-self$report_type[positon]
			#cat(url)
			url_report<-paste("http://stockdata.stock.hexun.com/2008en/",report_type,".aspx?stockid=",self$stockid,sep="");
			url_report<-paste("http://stockdata.stock.hexun.com/2008/",report_type,".aspx?stockid=",self$stockid,sep="");
			cat(url_report,"\n")
			year_list=self$frm_get_finance_year_list2(url_report)

			print(year_list)
			#return(year_list)
			self$n_year=length(year_list[[1]])
			cat("\ncarlos>>>>",self$n_year)
			all_reports_cn<-lapply(year_list,self$frm_collect_all_report,self$stockid,"cn",self$report_type[positon]);
			#return(all_reports_cn)
			#return(all_reports_cn);
			f_report_cn<-cl_report_combine$new(self$stockmarket)$single_table(all_reports_cn,self$n_year)%>%as.data.frame;
			#f_report_cn<-f_report_cn[[1]]
			f_report_cn$stockname<-stockname;
			return(f_report_cn)
			# save finance report to sqlite db file,
			#report_series<-cl_report_combine$new(self$stockmarket)$report_series;
			self$frm_save_fin_table2_sqlite(self$dbfileName,f_report_cn,paste(report_type,self$stockid,sep="_"))
		},
	
	frm_main = function(){
		##step1 get year list
		#get stock chinese Name
		stockname=self$frm_get_url_xpath(self$url_html,"//div[@class='content nav']/div/a")%>%sapply(xmlValue)
		#cat(stockname)
		stockname=stockname[[3]]
		#cat(url)
		year_list=self$frm_get_finance_year_list(self$url_html)
		#return(year_list)
		n_year=length(year_list)
		#cat(n_year)
		#return(n_year)
		#cat(year_list)
		#return (year_list)
		report_type<-c("zxcwzb",
						"cwbl",
						"zcfz",
						"lr"
						)
		# step2 get all years  stock finance table  chinese version
		#print(self$stockid)
		
		all_reports_cn<-lapply(year_list,self$frm_collect_all_report,self$stockid,"cn",report_type)
		return(all_reports_cn)
		#all_reports_en<-lapply(year_list,frm_collect_all_report,stockid,"en")
			#step3 
		# become 5 reports dataframe 
		#report_type_seq<-seq(1:5)
		#df_report_all_cn_xjll<-recursive_report_cn(n_year-2,report_type=5,all_reports_cn)%>%t%>%as.data.frame%>%frm_handle_row_name(60016)
		#mapply(recursive_report_cn,n_year-2,report_type_seq,all_reports_cn)
		#f_report_cn<-lapply(seq(1:5),function(x,y,z) self$recursive_report_cn(y,x,z)%>%t%>%as.data.frame%>% self$frm_handle_row_name(self$stockid,stockname),n_year-2,all_reports_cn )
		f_report_cn<-cl_report_combine$new(self$stockmarket)$test(all_reports_cn);
		f_report_cn$stockname<-stockname;
		#return(f_report_cn);
		
		#f_report_cn<-lapply(seq(1:5),function(x,y,z) self$frm_handle_row_name(as.data.frame(t(self$recursive_report_cn(y,x,z))),self$stockid,stockname),n_year-2,all_reports_cn )
		#return(f_report_cn)
		
		#(f_report_cn)
		#step4
		# save finance report to sqlite db file,
		#report_series<-cl_report_combine$new(self$stockmarket)$report_series;
		lapply(seq(1:4),function(x,reports,report_type,dbfile) 
									 self$frm_save_fin_table2_sqlite(dbfile,reports[[x]],paste(report_type[x],self$stockid,sep="_"))
									 ,reports=f_report_cn, report_type,dbfile=self$dbfileName )
	}
	)
)


cl_report_combine <- R6Class("Stock_report_combine",    # 定义一个R6类
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
               if ((n == 0) | (n == 1)| (n == 2)){
			sum =cbind(all_report[[1]][[2]][[3]])
			return (sum)
			}
		else
			sum = cbind(self$recursive_report_cn(n-1,all_report),all_report[[1]][[n]][[3]][,-1])
		return (sum)
	},
	single_table = function(all_reports_cn,year_len){
		n_year<- switch(
					self$stock_market,
					sz = year_len,
					sh = year_len-2  ,
					"NA"
			)
                cat(n_year)
                f_report_cn<-self$recursive_report_cn(n_year,all_reports_cn)
		#f_report_cn<-lapply(seq(1),self$test_lappy,n_year,all_reports_cn) 
		return(f_report_cn)
   },
	main = function(all_reports_cn){
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


ca<-cl_report_combine$new("sz")
lapply(seq(1),ca$test_lappy,10,ta) 
#####################################################
##   using regx find all matching words in string object  
##  frm_grex_str(htmlresult,"stock.{0,2}")
#####################################################

frm_grex_str(htmlresult,"stock.{0,2}")


cl_sample <- R6Class("r6_sample",    # 定义一个R6类
	lock_objects = FALSE,
	public=list(
	initialize = function(){

                }
            )
    )

###################################
## filter tool box
###################################

library(stringi)
stri_match_all_regex("breakfast=eggs, lunch=pizza, dessert=icecream",
   "(\\w+)=(\\w+)")

library(stringr)
strings <- c(" 219 733 8965", "329-293-8753 ", "banana", "595 794 7569",
  "387 287 6718", "apple", "233.398.9187  ", "482 952 3315",
  "239 923 8115 and 842 566 4692", "Work: 579-499-7527", "$1000",
  "Home: 543.355.3679")
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"

str_extract(strings, phone)
str_match(strings, phone)

# Extract/match all
str_extract_all(strings, phone)
str_match_all(strings, phone)
 
 
shopping_list <- c("apples x4", "bag of flour", "bag of sugar", "milk x2")
str_extract(shopping_list, "\\d")
str_extract(shopping_list, "[a-z]+")
str_extract(shopping_list, "[a-z]{1,4}")
str_extract(shopping_list, "\\b[a-z]{1,4}\\b")

# Extract all matches
str_extract_all(shopping_list, "[a-z]+")
str_extract_all(shopping_list, "\\b[a-z]+\\b")
str_extract_all(shopping_list, "\\d")

# Simplify results into character matrix
str_extract_all(shopping_list, "\\b[a-z]+\\b", simplify = TRUE)
str_extract_all(shopping_list, "\\d", simplify = TRUE)
 
 
 rbind(
  str_pad("hadley", 30, "left"),
  str_pad("hadley", 30, "right"),
  str_pad("hadley", 30, "both")
)

# All arguments are vectorised except side
str_pad(c("a", "abc", "abcdef"), 10)
str_pad("a", c(5, 10, 20))
str_pad("a", 10, pad = c("-", "_", " "))

# Longer strings are returned unchanged
str_pad("hadley", 3)

str_detect(strings, phone)

frm_set_path<-function(){
    R_PLATFORM<-Sys.getenv(c("R_PLATFORM"))
    if(str_detect(R_PLATFORM, "linux")) path<-"~/sdcard1"
    else path<-"e:"
    return (path)
}



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
urlt<-"http://stockdata.stock.hexun.com/2009_xjll_600298.shtml"
process_obj<-cl_syrhades_tool$new()
htmlresult<-process_obj$frm_get_url_xpath(urlt,"//div[@id='zaiyaocontent']/script")%>%sapply(xmlValue)
process_obj$frm_grex_str(htmlresult,"stock.{0,2}")





# htmlresult

# greg_result<-gregexpr("[0-9]{4}",htmlresult)    
# cl_syrhades_tool$new()$frm_grex_str(htmlresult,"stock.{0,2}")

###############################################
## test part
######################################################
frm_try<-function(try_function){
    tryCatch ( {
        try_function

    } , 
    warning = function ( w ) {

    print(w)

    } , error = function ( e ) {

    print(e)

    } ,
    finally = {

    cat("finally done")
    } 
)
}

st1<- cl_Stock_report_process$new(19,dbfile,"sz")
urlt<-st1$xjllurl_html
urlt<-"http://stockdata.stock.hexun.com/2009_xjll_000019.shtml"
process_obj<-cl_syrhades_tool$new()
htmlresult<-process_obj$frm_get_url_xpath(urlt,"//div[@id='zaiyaocontent']/script")%>%sapply(xmlValue)
year_list<-str_extract_all(htmlresult,"\\d{4}\\.\\d{2}\\.\\d{2}")


# xjll

# fav_stock<-c(600737)
# #cl_Stock_report_process$new(600016,"e:/tb_finance.db")$frm_main()
# lapply(fav_stock,function (x) cl_Stock_report_process$new(x,"e:/tb_finance.db","sh")$frm_main())

# cl_Stock_report_process$new(600873,"e:/tb_finance.db","sz")$frm_main()

# cl_Stock_report_process$new(2807,"e:/tb_finance.db","sz")$frm_main()

	
# cl_report_combine$new("sz")$test(all_reports_cn)[[1]]%>%htmlTable


# cl_report_combine$new()$test(all_reports_cn,22)[[2]]%>%htmlTable
# cl_report_combine$new()$test(all_reports_cn,22)[[4]]%>%htmlTable
# # stock6000305<-cl_Stock_report_process$new(600305,"e:/tb_finance.db")
# # stock6000305$frm_main()
# fav_stock<-c(1,2142,2807,600015,600016,600036,600919,601009,601166,601169,601288,601328,601398,601818,601939,601988,601997,601998)

# fav_stock<-c(600015,600036,600919,601009,601166,601997)
# fav_stock<-c(1,2142,2807)
# #cl_Stock_report_process$new(600016,"e:/tb_finance.db")$frm_main()
# lapply(fav_stock,function (x) cl_Stock_report_process$new(x,"e:/tb_finance.db","sz")$frm_main())
# year<-cl_Stock_report_process$new(1,"e:/tb_finance.db")$frm_main()
# all_reports_cn<-cl_Stock_report_process$new(1,"e:/tb_finance.db")$frm_main()
# cl_test$new()$test(all_reports_cn,22)%>%htmlTable
# #cl_Stock_report_process$new(1,"e:/tb_finance.db")$frm_hexun_fin_table(1,"cn",2015)
# #cl_Stock_report_process$new(600000,"e:/tb_finance.db")$frm_main())
# recursive_report_cn(10,report_type=5,all_reports_cn)%>%t%>%as.data.frame
# recursive_report_cn(19,report_type=5,all_reports_cn)%>%t%>%as.data.frame

# all_reports_cn[[19]][[1]][[3]]%>%htmlTable




# >>>>>>>>>>>
ta<-cl_Stock_report_process$new(603696,"e:/tb_finance.db","sh")
re_dfxjll<-ta$frm_all()


re_df_zcfz<-ta$frm_zcfz()



re_df_4<-ta$frm_main()
#re_df%>%htmlTable


cl_report_combine$new("sh")$test(re_df_4)

tb<-cl_report_combine$new("sh")
lapply(seq(1,4),tb$test_lappy,1,re_df_4) 

    filename<-paste(frm_set_path(),"stocklist.log",sep="/")
    stockdf<-read.csv(filename,sep =".",head = F)
    dbfile<-paste(frm_set_path(),"tb_finance5.db",sep="/")
    #frm_try(cl_Stock_report_process$new(603696,dbfile,"sh")$frm_all())
    lapply(seq(1,nrow(stockdf)),function(idx) d_ply(stockdf[idx,],"V2",function(x) cl_Stock_report_process$new(x$V1,dbfile,str_to_lower(x$V2))$frm_all()))

    cl_Stock_report_process$new(19,dbfile,"sz")$frm_1()
    
d_ply(stockdf,"V2",function(x) cl_Stock_report_process$new(x$V1,dbfile,str_to_lower(x$V2))$frm_all())

cl_Stock_report_process$new(603696,dbfile,"sh")
#stockdf<-read.csv("e:/stocklist.log",sep =".",head = F)
d_ply(stockdf,"V2",function(x) print(x$V2))
ta<-cl_Stock_report_process$new(603696,dbfile,"sh")$frm_all()
re_dfxjll<-ta$frm_all()
library(stringr)
d_ply(stockdf,"V2",function(x) cl_Stock_report_process$new(x$V1,"e:/tb_finance2.db",str_to_lower(x$V2))$frm_all())

sapply(stockdf,function(x) cl_Stock_report_process$new(x$V1,"e:/tb_finance3.db",str_to_lower(x$V2))$frm_all())


d_ply(stockdf,"V2",function(x) cl_Stock_report_process$new(x$V1,"e:/tb_finance2.db",str_to_lower(x$V2))$frm_all())



