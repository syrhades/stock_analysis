install.packages("xlsx")
library(xlsx)
xls_file<-"e:/jx_jj.csv"
xj_table<-read.csv(xls_file,header=T) 


净值<现价 lof 可赎回



jj_url="http://fund.eastmoney.com/LOF_jzzzl.html#os_0;isall_0;ft_;pt_8"
eastmoney_jj<-readHTMLTable(jj_url)

eastmoney_jj[[3]]
http://quote.eastmoney.com/sz161226.html



http://www.iwencai.com/stockpick/search?typed=1&preParams=&ts=1&f=1&qs=index_rewrite&selfsectsn=&querytype=fund&searchfilter=&tid=stockpick&w=%E5%87%80%E5%80%BC%3E%E7%8E%B0%E4%BB%B7+lof


jj_url_in="http://finance.sina.com.cn/fund/quotes/161226/bc.shtml"
eastmoney_jj_in<-readHTMLTable(jj_url_in)

http://fund.eastmoney.com/f10/jjjz_161226.html


jj_url_lsjz="http://jingzhi.funds.hexun.com/database/jzzs.aspx?fundcode=161226"
eastmoney_lsjz<-readHTMLTable(jj_url_lsjz)
eastmoney_lsjz[[2]]


frm_lof<-function(in_p,out_p){
	delta_p<-(in_p-out_p)
	print(delta_p/in_p)*100
}


mapply(frm_lof,xj_table[,4],xj_table[,3],100000)

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

frm_lof(1.17,
            1.18,
            100000)
frm_lof(1.172,
            1.175,
            100000)			
160211.OF			
 2.83	2.89   
 
 frm_lof(2.89,
            2.83,
            100000)	
			
url_gzmt<-"http://f10.eastmoney.com/f10_v2/ShareholderResearch.aspx?code=sh600519#sdltgd-0"


eastmoney_gzmt<-readHTMLTable(url_gzmt)
eastmoney_gzmt[[13]]%>%htmlTable

url_f9<-"http://f9.eastmoney.com/sh601006.html#hypm"
eastmoney_f9<-readHTMLTable(url_f9)
lapply(seq(1:length(eastmoney_f9)),function(x,y) y[[x]]%>%htmlTable,eastmoney_f9 )

eastmoney_f9[!is.na(eastmoney_f9)]%>%length

frm_output_html<-function(idx,result_data){
	print_data<-result_data[[idx]]
	if (!is.na(print_data) && (length(print_data)>0))  htmlTable(print_data)
}
sapply(seq(1:length(eastmoney_f9)),frm_output_html,eastmoney_f9 )

frm_showf9_stockid<-function(stockid){
	url_f9<-paste("http://f9.eastmoney.com/",stockid,".html",sep="")
	cat(url_f9)
	
	eastmoney_f9<-readHTMLTable(url_f9)
	sapply(seq(1:length(eastmoney_f9)),frm_output_html,eastmoney_f9 )
}
#frm_showf9_stockid("sh600031")
#frm_showf9_stockid("sz000157")
frm_showf9_stockid("sz000001")
eastmoney_f9[[1]]%>%htmlTable

http://www.iwencai.com/stockpick/search?typed=1&preParams=&ts=1&f=1&qs=result_rewrite&selfsectsn=&querytype=fund&searchfilter=&tid=stockpick&w=%E7%BE%8E%E5%85%83+%E5%8F%AF%E8%B5%8E%E5%9B%9E####

市净率0-1.5，市盈率大于0小于15，概念
http://www.iwencai.com/stockpick/search?typed=1&preParams=&ts=1&f=1&qs=result_rewrite&selfsectsn=&querytype=&searchfilter=&tid=stockpick&w=%E5%B8%82%E5%87%80%E7%8E%870-1.5%EF%BC%8C%E5%B8%82%E7%9B%88%E7%8E%87%E5%A4%A7%E4%BA%8E0%E5%B0%8F%E4%BA%8E15%EF%BC%8C%E6%A6%82%E5%BF%B5

