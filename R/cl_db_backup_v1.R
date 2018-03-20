##/media/syrhades/DAA4BB34A4BB11CD1
##  R CMD BATCH /media/syrhades/DAA4BB34A4BB11CD1/stock_class_fin_report_v4.R
##  Rscript /media/syrhades/DAA4BB34A4BB11CD1/stock_class_fin_report_v5.R "stock_shanghai3.db"   
##  Rscript e:/cl_stock_class_fin_report_v5.R  "stock_youse.log" "z:/stock_shanghai2.db" 
##  Rscript d:/cl_stock_class_fin_report_v5_for_d.R  "all_stock_sz.log.log" "stock_sz.db" 
##  Rscript ~/sdcard/R/cl_stock_tdx_2_db_v2.r  "all_stock_sz.log.log" "stock_sz.db" 

  
##  Rscript cl_stock_class_fin_report_v5.R  "R/all_stock_sz.log" "z:/stock_sz.db"  
Args <- commandArgs()
#`R` 表示R interpreter，`CMD` 表示一个 R 工具会被使用。一般的语法是`R CMD 命令 参数`。`BATCH`支持非交互式地执行脚本命令，
#即程序执#行时不用与我们沟通，不用运行到半路还需要我们给个参数啥的。

dbfile<-Args[7]
stockfile<-Args[6]

library(pryr)             # 加载pryr包
library(R6)               # 加载R6包
library(stringr) 
#install.packages("scrape")
#require(scrape)
#require(iterators)
#install.packages("iterators")
require(dplyr)
require(reshape)
library(plyr)
library(quantmod)
# library(TTR)
# library(ggplot2)
# library(scales)
require(data.table)
require(sqldf)
library(XML)
library(htmlTable)

cl_db_oprate <- R6Class("db_opr",    # 定义一个R6类
	lock_objects = FALSE,
	public=list(
	
	sql_dbfile 	= NA,
	tb_name		= NA,
	R_df		= NA,
	initialize = function(sql_dbfile){       # 构建函数方法
     self$sql_dbfile <- sql_dbfile
		},
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
	frm_append_fin_table2_sqlite = function(sql_dbfile,R_df,tb_name){
	                ## save data frame to sqlite db file
			require(DBI)
			# Create an ephemeral in-memory RSQLite database
			con <- dbConnect(RSQLite::SQLite(), sql_dbfile)
			dbListTables(con)
			#write dataframe R_df to Sqlite db file
			dbWriteTable(con, tb_name, R_df,append=TRUE)
			dbListTables(con)
			# Disconnect from the database
			dbDisconnect(con)
		},
	show_db_dbi = function(){         # show database table name
		# Create an ephemeral in-memory RSQLite database
		con <- dbConnect(RSQLite::SQLite(), self$sql_dbfile)
		print(dbListTables(con))
		alltable<-dbListTables(con)
		print(alltable)
		# Disconnect from the database
		dbDisconnect(con)
		return(alltable)		
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
		htmlTable(r_obj)},
	frm_backup = function(x,sql_dbfile){
		R_df<-self$query_db_dbi(sprintf("select * from %s",x))
		tb_name <- x
		self$frm_append_fin_table2_sqlite(sql_dbfile,R_df,tb_name)
	},
	frm_db_backup = function(dest_db_file){
		db_tb_wanted <- self$show_db_dbi()
		df_opr <-data.frame(tb=db_tb_wanted,sqlcmd= sprintf("select * from %s",db_tb_wanted) ,stringsAsFactors=F)
		# df_result1<-
		df_opr$tb%>% l_ply(function(x) self$frm_backup(x,sql_dbfile=dest_db_file) )
	}

###########end ################		
		)
)
frm_sqlite_db_bacup <- function(src_dbfile,dest_dbfile){
	# 
	ta <- cl_db_oprate$new(src_dbfile)
	ta$frm_db_backup(dest_dbfile)
}
###################effective function for backup append mode 
frm_main_v1 <- function(){
	frm_sqlite_db_bacup("d:\\stock_sh2.db","d:\\stock_sh.db")
}
# frm_main_v1()
# frm_sqlite_db_bacup("d:\\stock_sz_new.db","d:\\stock_sh.db")

frm_main_test<-function(){
frm_backup <- function(x,ta,sql_dbfile){
	R_df<-ta$query_db_dbi(sprintf("select * from %s",x))
	tb_name <- x
	ta$frm_append_fin_table2_sqlite(sql_dbfile,R_df,tb_name)
}


# ta <- cl_db_oprate$new("F:\\stock_sz.db")
# db_tb_wanted <- ta$show_db_dbi()
# df_opr <-data.frame(tb=db_tb_wanted,sqlcmd= sprintf("select * from %s",db_tb_wanted) ,stringsAsFactors=F)
# # df_result1<-
# df_opr$tb%>% l_ply(function(x) frm_backup(x,ta=ta,sql_dbfile="f:\\stock_sh2.db") )


# tb <- cl_db_oprate$new("F:\\stock_sh2.db")
# db_tb_wantedsh2 <- tb$show_db_dbi() %>%unlist
# db_tb_wanted %>%unlist
# setdiff(db_tb_wantedsh2,db_tb_wanted %>%unlist)
# setdiff(db_tb_wanted %>%unlist,db_tb_wantedsh2)
# setequal(db_tb_wanted %>%unlist,db_tb_wantedsh2)
# setequal(A,B)
# }
# check undownload report file
check_loss_code_db <- function(dbfile="F:\\stock_sz.db",log_file="E:\\R\\all_stock_sz_bak.log",result_file="e:/modify_sz_allstock.log"){
	ta <- cl_db_oprate$new(dbfile)
	db_tb_wanted <- ta$show_db_dbi()
	tk<- db_tb_wanted %>% laply(function(x) str_split(x,"_"))
	df_stock <- Reduce("cbind",tk) %>% as.data.frame(stringsAsFactors=F) %>%t %>% as.data.frame(stringsAsFactors=F)
	colnames(df_stock) <- c("report","id")
	col_name <- df_stock$report %>%unique
	sub_reportlist<- col_name %>% llply(function(x) filter(df_stock,report==x))
	all_stockid    <- read.table(log_file)
	all_stockid_2 <- transform(all_stockid,V1=gsub("\\..*","",V1))

	lack_list <-sub_reportlist %>% llply(function(x) setdiff(all_stockid_2%>%unlist,x$id))
	shoulddownload <- Reduce('union',lack_list) %>% sort
	# observation<- laply(lack_list,min)  #observer min value for not download from 
	# idx_target <- which(observation == observation %>%min) [1]
	# shoulddownload<-lack_list[[idx_target]]
	shoulddownload<-shoulddownload %>% laply(function(x) sprintf("%s.SZ",x))
	write(shoulddownload,result_file)
}
check_loss_code_db(dbfile="d:\\stock_sh.db",log_file="E:\\R\\all_stock_sz_bak.log",result_file="d:/modify_sz_allstock.log")

dbfile="d:\\stock_sh.db"
log_file="E:\\R\\all_stock_sz_bak.log"
result_file="d:/modify_sz_allstock.log"
ta <- cl_db_oprate$new(dbfile)
db_tb_wanted <- ta$show_db_dbi()
tk<- db_tb_wanted %>% laply(function(x) str_split(x,"_"))
df_stock <- Reduce("cbind",tk) %>% as.data.frame(stringsAsFactors=F) %>%t %>% as.data.frame(stringsAsFactors=F)
colnames(df_stock) <- c("report","id")
col_name <- df_stock$report %>%unique
sub_reportlist<- col_name %>% llply(function(x) filter(df_stock,report==x))
all_stockid    <- read.table(log_file)
all_stockid_2 <- transform(all_stockid,V1=gsub("\\..*","",V1))
lack_list <-sub_reportlist %>% llply(function(x) setdiff(all_stockid_2%>%unlist,x$id))

lack_list %>%str
# dbfile="F:\\stock_sz.db"
# ta <- cl_db_oprate$new(dbfile)
# db_tb_wanted <- ta$show_db_dbi()
# tk<- db_tb_wanted %>% laply(function(x) str_split(x,"_"))
# df_stock <- Reduce("cbind",tk) %>% as.data.frame(stringsAsFactors=F) %>%t %>%as.data.frame(stringsAsFactors=F)
# colnames(df_stock) <- c("report","id")
# col_name <- df_stock$report %>%unique
# sub_reportlist<- col_name %>% llply(function(x) filter(df_stock,report==x))


# all_stockid    <- read.table("E:\\R\\all_stock_sz_bak.log")
# all_stockid_2 <- transform(all_stockid,V1=gsub("\\..*","",V1))

# lack_list <-sub_reportlist %>% llply(function(x) setdiff(all_stockid_2%>%unlist,x$id))
# laply(lack_list,min)  #observer min value for not download from 
# shoulddownload<-lack_list[[1]]
# shoulddownload<-shoulddownload %>% laply(function(x) sprintf("%s.SZ",x))
# write(shoulddownload,"e:/modify_sz_allstock.log")
# write.table %>%args


# ## A list of all functions in the base environment:
# funs <- Filter(is.function, sapply(ls(baseenv()), get, baseenv()))
# ## Functions in base with more than 10 arguments:
# names(Filter(function(f) length(formals(args(f))) > 10, funs))
# ## Number of functions in base with a '...' argument:
# length(Filter(function(f)
#               any(names(formals(args(f))) %in% "..."),
#               funs))

# ## Find all objects in the base environment which are *not* functions:
# Filter(Negate(is.function),  sapply(ls(baseenv()), get, baseenv()))

# #首先对集合A,B,C赋值
# > A<-1:10
# > B<-seq(5,15,2)
# > C<-1:5
# > #求A和B的并集
# > union(A,B)
#  [1]  1  2  3  4  5  6  7  8  9 10 11 13 15
# > #求A和B的交集
# > intersect(A,B)
# [1] 5 7 9
# > #求A-B
# > setdiff(A,B)
# [1]  1  2  3  4  6  8 10
# > #求B-A
# > setdiff(B,A)
# [1] 11 13 15
# > #检验集合A,B是否相同
# > setequal(A,B)
# [1] FALSE
# > #检验元素12是否属于集合C
# > is.element(12,C)
# [1] FALSE
# > #检验集合A是否包含C
# > all(C%in%A)
# [1] TRUE
# > all(C%in%B)
# [1] FALSE


