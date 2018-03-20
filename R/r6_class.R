install.packages("R6")    # 安装R6包
install.packages("pryr")    # 安装R6包

library(R6)               # 加载R6包
library(pryr)             # 加载pryr包
require(DBI)
help(package="DBI")
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


frm_save_fin_table2_sqlite<-function(sql_dbfile,R_df,tb_name){
    require(DBI)
    # Create an ephemeral in-memory RSQLite database
    con <- dbConnect(RSQLite::SQLite(), sql_dbfile)

    dbListTables(con)
    dbListTables(con)
    # Disconnect from the database
    dbDisconnect(con)
}

cl_db_oprate <- R6Class("db_opr",    # 定义一个R6类
	lock = FALSE,
	public=list(
	
	sql_dbfile 	= NA,
	tb_name		= NA,
	R_df		= NA,
	initialize = function(sql_dbfile){       # 构建函数方法
      self$sql_dbfile <- sql_dbfile
		},
	show_db = function(){         # show database table name
		# Create an ephemeral in-memory RSQLite database
		con <- dbConnect(RSQLite::SQLite(), self$sql_dbfile)
		print(dbListTables(con))
		# Disconnect from the database
		dbDisconnect(con)		
		},
	query_db = function(sql_cmd){         # select table name
		# Create an ephemeral in-memory RSQLite database
		con <- dbConnect(RSQLite::SQLite(), self$sql_dbfile)
		self$query_df <- dbGetQuery(con, sql_cmd)
		
		# Disconnect from the database
		dbDisconnect(con)	
		return(self$query_df)
		
		}
	)
)
ta<-cl_db_oprate$new("e:/tb_finance.db")
ta$show_db()
ta$query_db("select * from cwbl_000157")
ta$query_db("select * from zxcwzb_000157")
""
ta$query_df%>%htmlTable
class(ta$query_df)