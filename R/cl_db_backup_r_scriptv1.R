##/media/syrhades/DAA4BB34A4BB11CD1
##  R CMD BATCH /media/syrhades/DAA4BB34A4BB11CD1/stock_class_fin_report_v4.R
##  Rscript /media/syrhades/DAA4BB34A4BB11CD1/stock_class_fin_report_v5.R "stock_shanghai3.db"   
# step1
# Rscript e:/R/cl_db_backup_r_scriptv1.R  "E:\\R\\all_stock_sz_bak.log" "d:\\stock_sh.db" "d:/modify_sz_allstock.log"
# step2
# Rscript cl_stock_class_fin_report_v5_for_d2_no_rev.R  "modify_sz_allstock.log" "stock_sh.db"  


# Rscript e:/R/cl_db_backup_r_scriptv1.R  "E:\\R\\all_stock_sz_bak.log" "d:\\stock_sh.db" "d:/modify_sz_allstock.log"
# Rscript e:/R/cl_db_backup_r_scriptv1.R  "E:\\R\\all_stock_sz_bak.log" "d:\\stock_sh.db" "d:/modify_sz_allstock.log"

Args <- commandArgs()
#`R` 表示R interpreter，`CMD` 表示一个 R 工具会被使用。一般的语法是`R CMD 命令 参数`。`BATCH`支持非交互式地执行脚本命令，
#即程序执#行时不用与我们沟通，不用运行到半路还需要我们给个参数啥的。
stockfile<-Args[6]
dbfile<-Args[7]
lack_file<-Args[8]

print(Args)
library(pryr)             # 加载pryr包
library(R6)               # 加载R6包
library(stringr) 
require(dplyr)
require(reshape)
library(plyr)
library(quantmod)
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
		# print(dbListTables(con))
		alltable<-dbListTables(con)
		# print(alltable)
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
#shoulddownload<-shoulddownload %>% laply(function(x) sprintf("%s.SZ",x))
    shoulddownload<-shoulddownload %>% laply(function(x) sprintf("%s.SH",x))
	write(shoulddownload,result_file)
}


print(Args)





check_loss_code_db(dbfile=dbfile,log_file=stockfile,result_file=lack_file)







