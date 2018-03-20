library(RODBC)
myconn<-odbcConnect("bis")
#tAS2Address<-sqlFetch(myconn,tAS2Address)

alltable<-sqlQuery(myconn,
"SELECT a.name, b.rows
FROM sysobjects AS a INNER JOIN sysindexes AS b ON a.id = b.id
WHERE (a.type = 'u') AND (b.indid IN (0, 1)) AND b.rows <> 0
ORDER BY a.name,b.rows DESC")

#generate all table in BIS
alltable<-sqlQuery(myconn,
"SELECT a.name 
FROM sysobjects AS a INNER JOIN sysindexes AS b ON a.id = b.id
WHERE (a.type = 'u') AND (b.indid IN (0, 1)) AND b.rows <> 0
ORDER BY a.name,b.rows DESC")

sapply(testtable,nchar)
frm_SHOW_GREP_RESULT_from_sqlquery<-function (l_str,pattern){
	f2 <- function(x,y) grepl(y, x)
	tn<-as.character(l_str)
	resultdf<-sapply(tn,f2,pattern)
	tn[resultdf]
}

frm_SHOW_GREP_RESULT_from_sqlquery(alltable$name,"HTTP")

testtable<-sqlQuery(myconn,
"SELECT * 
FROM tHTTPListener")

#sapply(testtable$cLastModified,nchar)
#f2 <- function(x) grepl("syrhades",x )
frm_check_table_content<-function(df_table,tablename,pattern){
	f3 <- function(x,pattern) grepl(pattern,x )
	result<-df_table[apply(df_table,2,f3,pattern)] #ok sample
	#class(apply(testtable,2,f3,"syrhades"))
	if (length(result) >0){
		cat(tablename,"\n")
		print(result)
	}
}
frm_check_table_content(testtable,"tHTTPListener","syrhades")
#get a table content
frm_get_table_data <- function(tablename,dbconn){
	sqlQuery(dbconn,paste("SELECT * 
	FROM",tablename)
	)
}

frm_get_table_data("tBPChannels",myconn)
frm_get_table_data("tSchedulerExecutionState",myconn)
frm_get_table_data("tBPInboundProcessLinks",myconn)

 msg <- tryCatch({
    text[seq(which(text == "")[1] + 1, length(text), 1)]
  }, error = function(e) {
    ""
  })


main<-function(tablename,dbconn,pattern){
	print(tablename)
	testtable<-frm_get_table_data(tablename,dbconn)
	#print(testtable)
	frm_check_table_content(testtable,tablename,pattern)
}
#apply(alltable,1,main,myconn,"syrhades")
tn<-as.character(alltable$name)
sapply(tn[1:3],main,myconn,"SEEBURGER")

sapply(tn[4:6],main,myconn,"SEEBURGER")

close(myconn)
for (i in 1:length(tn)) {
	tablename=tn[i]
	
	myconn<-odbcConnect("bis",rows_at_time = 1)
	tryCatch({
		sapply(tablename,main,myconn,"SEEBURGER")
		}, error = function(e) {
			cat(tablename , "===>","no_check\n")
			#print(e)
		""
		})
	
	close(myconn)
	}

tAS2Address<-sqlQuery(myconn,"select * from tAS2Address")
close(myconn)