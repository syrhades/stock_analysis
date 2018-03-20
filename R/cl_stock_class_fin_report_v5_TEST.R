##/media/syrhades/DAA4BB34A4BB11CD1
##  R CMD BATCH /media/syrhades/DAA4BB34A4BB11CD1/stock_class_fin_report_v4.R
##  Rscript /media/syrhades/DAA4BB34A4BB11CD1/stock_class_fin_report_v5.R "stock_shanghai.db"   
##  Rscript e:/cl_stock_class_fin_report_v5.R "stock_shanghai2.db"   

Args <- commandArgs()
#`R` 表示R interpreter，`CMD` 表示一个 R 工具会被使用。一般的语法是`R CMD 命令 参数`。`BATCH`支持非交互式地执行脚本命令，
#即程序执#行时不用与我们沟通，不用运行到半路还需要我们给个参数啥的。

dbfile<-Args[6]

library(R6)               # 加载R6包
library(pryr)             # 加载pryr包
library(R6)               # 加载R6包
library(pryr)             # 加载pryr包
library(stringr) 
#install.packages("scrape")
#require(scrape)
#require(iterators)
#install.packages("iterators")
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


# # Find the quantile bounds
# qa <-  quantile(crimes$Assault,  c(0, 0.2, 0.4, 0.6, 0.8, 1.0))
# qa
# 0% 20% 40% 60% 80% 100%
# 45.0 98.8 135.0 188.8 254.2 337.0
# # Add a column of the quantile category
# crimes$Assault_q <-  cut(crimes$Assault,  qa,
# labels=c("0-20%" , "20-40%" , "40-60%" , "60-80%" , "80-100%" ),
# include.lowest=TRUE)
# crimes
# state Murder Assault UrbanPop Rape Assault_q
# Alabama alabama 13.2 236 58 21.2 60-80%
# Alaska alaska 10.0 263 48 44.5 80-100%
# ...
# Wisconsin wisconsin 2.6 53 66 10.8 0-20%
# Wyoming wyoming 6.8 161 60 15.6 40-60%

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

cl_stock_data_tool <- R6Class("stock_data",    # 定义一个R6类
	lock_objects = FALSE,
	public=list(
            stock_id 	= NA,
            initialize = function(stock_id){
		self$stock_id = sprintf("%06d", stock_id)
		self$datafile = paste("stock_data/done_",self$stock_id,".txt",sep="")
		},
            frm_modify_path = function(filename){
		## check OS R_PLATFORM
		R_PLATFORM<-Sys.getenv(c("R_PLATFORM"))
		if(str_detect(R_PLATFORM, "linux")) path<-"~/sdcard1"
		else path<-"e:"
		return (paste(path,filename,sep="/") )
		},
            frm_datagen = function(datastr){
                    year=substr(datastr,0,4)
                    month=substr(datastr,5,6)
                    #cat(month)
                    day=substr(datastr,7,8)
                    #cat(day)
                    paste(year,"-",month,"-",day)
                    return(paste(year,"-",month,"-",day, sep = ""))
            },
            func_set_type = function(c1,c2){
                if (c1>c2) return("UP")
                if (c1<c2) return("DOWN")
                if (c1==c2) return("EQUAL")
            },
            roll_indicator = function(BS_table2,windows_period,fieldname){
                #cmdstr=paste("BS_table2$avg_max_roll_",windows_period,"<-rollmax(BS_table2$avg,3,fill = NA,align='right')",sep="")
                BS_table2[paste(fieldname,"_max_roll_",windows_period,sep="")]<-rollmax(BS_table2[paste(fieldname)],windows_period,fill = NA,align='right')
                BS_table2[paste(fieldname,"_min_roll_",windows_period,sep="")]<-rollapply(BS_table2[paste(fieldname)],windows_period,function(x) min(x),fill = NA,align='right')
                BS_table2[paste(fieldname,"_mean_roll_",windows_period,sep="")]<-rollapply(BS_table2[paste(fieldname)],windows_period,function(x) mean(x),fill = NA,align='right')
                return (BS_table2)
            },
            func_up_down = function(x, c1, c2) {
                if (x[c1]>x[c2]) return("UP")
                if (x[c1]<x[c2]) return("DOWN")
                if (x[c1]==x[c2]) return("EQUAL")
            },
            frm_generate_BS_table = function(){
		self$datafile <- self$frm_modify_path(self$datafile)
                df1<-read.table(self$datafile,header=TRUE,sep=",")
                df1<-mutate(df1,date=self$frm_datagen(date))
                olch=df1[2:6]
                xtsobject=xts(olch, as.Date(df1$date))     #包xts
                xtsobject<-cbind(xtsobject,close1=Lag(xtsobject$close))
                colnames(xtsobject)[[6]]<-"close1"
                head(is.na(xtsobject$close1))
                xts_non_na<-xtsobject[!is.na(xtsobject$close1)]
                #######优化处理#######
                typepoint2<-mapply(self$func_set_type,xts_non_na$close,xts_non_na$close1)
                BS_table2<-as.data.frame(xts_non_na)
                BS_table2$type<-typepoint2
                BS_table2$avg<-rowSums(BS_table2[,1:4])/4
                BS_table2$Date<-as.Date(row.names(BS_table2))
                #generate roll indicator
                #BS_table2[paste(windows_period)]<-2
                BS_table2<-self$roll_indicator(BS_table2,50,"close")
                #BS_table2[1:10,]
                return(BS_table2)
                }
            )
    )



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
frm_test_cl_db_oprate<-function(){
    paste0("th",4:8)
    
    ta<-cl_db_oprate$new("e:/tb_finance.db")
    #ta<-cl_db_oprate$new("~/sdcard1/stock_shanghai.db")
    ta$show_db_dbi()
    #ta$query_db_dbi("select * from cwbl_000157")
    #ta$query_db_dbi("select * from zxcwzb_000157")
    ta$query_db_dbi("select * from cwbl_000001")
    n_col<- ncol(ta$query_df)
    ta$query_df%>%htmlTable(    col.columns = c("none", "#FF00FF"),
                                                        caption="syrhades test caption",
                                                        col.rgroup = c("none", "#00FFFF"),
                                                        align=paste(rep('c',n_col),collapse='|'))


	

    class(ta$query_df)
    ta$frm_get_table_dplyr(tb_name="lr_000157")
    
    as.data.frame(ta$get_table_dplyr) %>% htmlTable(align=paste(rep('c',50),collapse='|'))
    help(package="dplyr")
}

frm_zl_year_fi_indicator <- function(extracted_df,colum_vec,colum_name_vec){
	##################################################
	## get information from cwbl table
	##################################################
	temp_table<-extracted_df[-1,]
	tile<-extracted_df[1,]
	tileName<-as.vector(tile[colum_vec])
	#mgsy<-temp_table[c("V1","V99")]
	#colnames(mgsy)<-c("Date","mgsy")
	df_indicator<-temp_table[colum_vec]
	colnames(df_indicator)<-tileName
	## change column format 	
	df_indicator[,1]<-as.Date(df_indicator[,1],"%Y.%m.%d")
	l_ply(seq(2,ncol(df_indicator)),function (x) df_indicator[,x]<- as.numeric(df_indicator[,x]))
#return(df_indicator)
	#df_indicator$mgsy<-as.numeric(df_indicator$mgsy)
	#sort using Date
	df_indicator<-df_indicator[order(df_indicator[,1]),]  #order sort
	nday<-diff(df_indicator[,1])
	##align two column
	ret_df<-data.frame(nday,df_indicator[-nrow(df_indicator),])
#return(ret_df)
	xts_quarter<-function(per_jz,nday,day_begin){
		result<-xts(rep(per_jz,nday),day_begin+1:nday-1)
		return(result)
	}

	recursive_mgsy_data = function(n,all_report){
		## recursive method  important
	       if ((n == 0) | (n == 1)){
			sum =cbind(all_report[[1]])
			return (sum)
			}
		else
			sum = rbind(recursive_mgsy_data(n-1,all_report),all_report[[n]])
		return (sum)
	}

	recursive_data = function(n,all_report,call_function){
		## recursive method  important
		## call_function = rbind or cbind
	       if ((n == 0) | (n == 1)){
			sum =call_function(all_report[[1]])
			return (sum)
			}
		else
			sum = call_function(recursive_mgsy_data(n-1,all_report),all_report[[n]])
		return (sum)
	}
	col_seq<-seq(3,ncol(ret_df))
	
	frm_xts_gen<-function(col_x,data_df){
		temp_data<-mapply(xts_quarter,data_df[,col_x],data_df[,1],data_df[,2])
		ret_xts<- recursive_data(length(temp_data),temp_data,rbind)
		return(ret_xts)

	}
	list_data<-llply(col_seq,frm_xts_gen,ret_df)
	#return(list_data)
	ret_xts<- recursive_data(length(list_data),list_data,cbind)
	return(ret_xts)
}

# ta<-cl_db_oprate$new("e:/tb_finance.db")
# #ta<-cl_db_oprate$new("~/sdcard1/stock_shanghai.db")
# ta$show_db_dbi()
#ta$query_db_dbi("select * from cwbl_000157")
#ta$query_db_dbi("select * from zxcwzb_000157")
#############################################
## get information from database 
#############################################
# ta$query_db_dbi("select * from cwbl_000001")
# n_col<- ncol(ta$query_df)
# ta$query_df%>%htmlTable(    col.columns = c("none", "#FF00FF"),
#                                                     caption="syrhades test caption",
#                                                     col.rgroup = c("none", "#00FFFF"),
#                                                     align=paste(rep('c',n_col),collapse='|'))
# tseq2<-frm_zl_year_fi_indicator (extracted_df=ta$query_df,colum_vec=c("V1","V99","V101"),colum_name_vec=c("Date","mgsy"))
# plot(tseq2,major.ticks='months',minor.ticks=FALSE,main=NULL,col=3)
# plot(tseq2[,1])
# test_xts1<-tseq2[[1]]

#############draw plot
# colnames(tseq2)<-c("v1","v2")
# pt<-ggplot(tseq2)+
#  geom_point(aes(index(tseq2), v1,colour = I("blue")))
# pt+geom_point(aes(index(tseq2) ,v2,colour = I("red")))
#############draw plot


# tseq2['1995/1996']
# axTicksByTime(test_xts1, ticks.on='months')
# plot(test_xts1,major.ticks='months',minor.ticks=FALSE,main=NULL,col=3)

library(stringi)

#frm_zl_year_fi_indicator (extracted_df=ta$query_df,colum_vec=c("V1","V99","V101"),colum_name_vec=c("Date","mgsy"))
#frm_zl_year_fi_indicator (extracted_df=ta$query_df,colum_vec=c("V1","V99"),colum_name_vec=c("Date","mgsy"))
# df_xtsseq<-as.data.frame(tseq2)
# df_xtsseq$Date<-as.Date(row.names(df_xtsseq))

# df_xtsseq[df_xtsseq[,1]!= "--"]
#################################
#draw function
##################################
 # pt<-ggplot(df_xtsseq, aes(Date, ..1))+
 # geom_line()

 # pt
 # pt<-ggplot(BS_table2, aes(Date, avg))+
 # geom_point(aes(colour = vol))



## get BS_table from csv file
# df_BS_table2<-cl_stock_data_tool$new(000001)$frm_generate_BS_table()
# df_all<-merge(df_BS_table2, df_xtsseq,all = F)
# df_all[1:10,]

# df_all[500:510,]$close/df_all[500:510,]$v1

# frm_convert_factor2_num<-function (factor_obj){as.numeric(as.character(factor_obj))}
# df_all[500:510,]$close/frm_convert_factor2_num(df_all[500:510,]$v1)
# pt<-ggplot(df_all)+
#  geom_point(aes(Date, v1,colour = I("blue")))
# pt+geom_point(aes(Date ,v2,colour = I("red")))+
# geom_point(aes(Date ,avg,colour = I("red")))

# pt<-ggplot(df_all, aes(Date, avg))+ geom_point(aes(colour = vol))
# pt+geom_point(aes(Date ,v2,colour = I("red")))
#xts_BS_table2<-as.xts(df_BS_table2)
#xts_all<-merge(xts_BS_table2, tseq2,all = F)


# , by.x = "Date", by.y = "Date",all = F)
# as.xts(BS_table2)

# BS<-merge(BS_table2, tseq2F)
# BS[1000:1010,]
# ## Then plot price and finance indictor 
# BS$..1<-as.numeric(BS$..1)
# BS$pe<-BS$close / BS$..1


frm_test<- function(){
#> strptime("2001-02-01","%Y-%m-%d")
#[1] "2001-02-01 CST"
#> as.Date("2001-02-01","%Y-%m-%d")
#[1] "2001-02-01"
#> 


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

# system.time(frm_batch_stock_report(stockfile="stocklist.log",dbf_name=dbfile))
system.time(frm_batch_stock_report(stockfile="stock_f6.log",dbf_name=dbfile))

#library(profvis)

#p <-profvis({
#  frm_batch_stock_report(stockfile="stocklist.log",dbf_name="tb_finance_test2.db")
#})
