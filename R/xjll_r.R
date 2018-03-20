
report_type <- 
				c("xjll"
				)
frm_hexun_fin_table = function(stock_code,report_type,cn_en,year){
		#stock_code<-sprintf("%06d", stock_code)
		query <- switch(
				cn_en,
				en = paste("?stockid=",stock_code,"&type=1&date=",year,".12.31",sep="")  ,
				cn = paste("?stockid="  ,stock_code,"&accountdate=",year,".12.31",sep="")  ,
				"NA"
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
			return(tbls_list)
		finance_tb<-switch(
				cn_en,
				en = lapply(tbls_list,function(x) as.data.frame((x[[2]]))),
				cn = lapply(tbls_list,function(x) as.data.frame((x[[3]]))) ,
				#"NA"
		)
		return(finance_tb)
	}