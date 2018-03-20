# https://fred.stlouisfed.org/series/CPIAUCNS
frm_R_PLATFORM_execute<-function(linux_part,windows_part){
	# frm_R_PLATFORM_execute(source("~/sdcard/syrhadestock/R/cl_part_function.R"),source("e:/syrhadestock/R/cl_part_function.R")) 
	R_PLATFORM <- Sys.getenv(c("R_PLATFORM"))
	if(stringr::str_detect(R_PLATFORM, "linux")) linux_part
	else windows_part
}

frm_R_PLATFORM_execute(source("~/sdcard/syrhadestock/R/cl_part_function.R")
	,source("e:/syrhadestock/R/cl_part_function.R"))

##############################################################
stock_pricedata <- "/media/syrhades/DAA4BB34A4BB11CD1/stock_data"
stock_pricedata <- "e:/stock_data"
window_bash <-function(cmd_string){
	return(paste("E:\\shell.w32-ix86",cmd_string,sep="/"))
}


stock_filename_list <- try(system(paste(window_bash("ls"),stock_pricedata), intern = TRUE))
stock_filename_list <- stock_filename_list %>% llp	ly(function(x) gsub("done_","",x))
stock_filename_list <- stock_filename_list %>% laply(function(x) gsub("\\.txt","",x))


##############################################################
# step1 generate xts
##############################################################
frm_gen_xts_step1<- function(stock_id){
	df_spec_stock<-frm_stock_from_tdx_file(stock_id)
	xts_spec_stock<- df_spec_stock[,1:7] %>% frm_repair_to_xts
	names(xts_spec_stock)<-c("Open","High","Low", "Close",    "Volume", "Amount",  "Adjusted")
	return(xts_spec_stock)
}
##############################################################
# step2 apply indicator on xts
##############################################################
frm_apply_indicator_step2 <- function(xts_obj,indicator_list=list()){
	# batch test indicator
	llply(indicator_list,function(x){xts_obj %>% x})
}

indicator_1<- function (xts_obj,...){
	rollapply(xts_obj[,4],...)
}
frm_TF_summary_xts_V2 <- function(xts){
	# ½«¶à¸ölist Çó½»¼¯
	Reduce("&", xts)
}

frm_T_or_F <- function(xts_obj){
	# show T if T > F
	length_T <- which(xts_obj == T) %>% length
	length_F <- which(xts_obj == F) %>% length
	ifelse(length_T>=length_F,T,F) %>% return
}
	################################################################################
	# customerize indicators
	################################################################################
indicator_bb <-function(xts_obj){
	max_xts<-rollapply(xts_obj,180,max,fill = 0, align = "right")
	mean_xts<-rollapply(xts_obj,180,mean,fill = 0, align = "right")
	min_xts<-rollapply(xts_obj,180,min,fill = 0, align = "right")
	band_xts<-max_xts-min_xts
	pos_xts <- xts_obj - min_xts
	i_pos_xts <- pos_xts/band_xts*100
	return(xts_obj<mean_xts)
}

frm_xts_for_strategy <- function(xts_obj,period=20,greed_f=0.5,fear_f=0.5,quantile_f=0.1){
	df_spec_stock_xts <- xts_obj
	l_strategy = list()

	l_strategy$test_price <- df_spec_stock_xts [,4]
	l_strategy$test_amount <- df_spec_stock_xts[,6]
	# data reparing
	l_strategy$max_xts<-rollapply(l_strategy$test_price,period,max,fill = 0, align = "right")
	l_strategy$mean_xts<-rollapply(l_strategy$test_price,period,mean,fill = 0, align = "right")
	l_strategy$min_xts<-rollapply(l_strategy$test_price,period,min,fill = 0, align = "right")
	l_strategy$quantile_xts <- rollapply(l_strategy$test_price,period*(1+greed_f),quantile,quantile_f,fill = 0, align = "right")
	l_strategy$band_xts<-l_strategy$max_xts-l_strategy$min_xts
	l_strategy$pos_xts <- l_strategy$test_price - l_strategy$min_xts
	l_strategy$i_pos_xts <- l_strategy$pos_xts/l_strategy$band_xts*100
	l_strategy$pric_xts<-l_strategy$test_price/l_strategy$mean_xts
	l_strategy$mean_amount_xts<-rollapply(l_strategy$test_amount,period,mean,fill = 0, align = "right")
	l_strategy$a_xts<-l_strategy$test_amount/l_strategy$mean_amount_xts
	l_strategy$b_list <- l_strategy$test_price %>% BBands
	# mean delt research
	l_strategy$lmean=list()
	l_strategy$lmean$Delt 			<-l_strategy$mean_xts %>%Delt * 100
	l_strategy$lmean$Delt_smooth	<-l_strategy$lmean$Delt %>%rollapply(period,mean,fill = 0, align = "right")
	return(l_strategy)
}

indicator_strategy1 <-function(xts_strategy,period=20,greed_f=0.5,fear_f=0.5,quantile_f=0.1){
	eventline<- xts_strategy$a_xts < 1 &  
		xts_strategy$pric_xts <1 & 
		xts_strategy$pric_xts/xts_strategy$a_xts < 1 & 
		xts_strategy$test_price < mean(xts_strategy$test_price)*(1-fear_f) & 
		xts_strategy$test_price < xts_strategy$quantile_xts  &
		xts_strategy$i_pos_xts < 5
	return(eventline)
}

indicator_strategy2 <-function(xts_strategy,period=20,greed_f=0.5,fear_f=0.5,quantile_f=0.1){
	eventline<- xts_strategy$a_xts < 1 &  
		xts_strategy$pric_xts <1 & 
		xts_strategy$pric_xts/xts_strategy$a_xts < 1 & 
		xts_strategy$test_price < mean(xts_strategy$test_price)*(1-fear_f) & 
		xts_strategy$test_price < xts_strategy$quantile_xts  &
		xts_strategy$i_pos_xts < 5
	return(eventline)
}

xts_strategy <- df_spec_stock %>% frm_xts_for_strategy
xts_strategy %>% indicator_strategy1


	# ################################################################################
	# # test single part start
	# ################################################################################
	# step2_ret<-frm_apply_indicator_step2(xts_obj,
	# 	list(
	# 		# function (x) indicator_1(x,180,max,fill = 0, align = "right"),
	# 		# function (x) indicator_1(x,180,mean,fill = 0, align = "right"),
	# 		# function (x) rollapply(x[,4],180,min,fill = 0, align = "right"),
	# 		# function (x) {x[,4] <10&x[,4] > 5},
	# 		function (x) {x %>% Cl < 5},    # price < 5
	# 		function (x) indicator_bb(x %>% Cl)  # indicator BB  generate indicator
	# 		)
	# 	)


##############################################################
# step main 
##############################################################
F6stocks <- read.table("e:/mystock.txt.csv")
frm_main<- function(stocklist){
	ret_list_v2<-stocklist %>%
		llply(frm_gen_xts_step1) %>% 
			llply(function(x) 
				frm_apply_indicator_step2(x,					# add indicator 
					list(
						function (x) {x %>% Cl < 10},				# price < 5
						function (x) {x %>% Cl > 5}				# price < 5
						# function (x) indicator_bb(x %>% Cl)	# indicator BB  generate indicator
						)
					) %>%
					# frm_cbind_xts #%>%
					frm_TF_summary_xts_V2 %>% # generate indicator intersection   using reducing
					# check current price whether suit the conditon
					tail(n=10) %>%
					frm_T_or_F
				)
	ret_list_v2 %>% return
}
ret_list <-	F6stocks  %>% 
			unlist%>% 
			frm_main

stock_filter_result <-data.frame(stock_id = F6stocks,shoot_flag = ret_list %>%unlist)
subset(stock_filter_result,shoot_flag==T) %>% write.table("e:/filter_stock.txt")

# url<-"http://www.iwencai.com/stockpick/search?typed=1&preParams=&ts=1&f=1&qs=result_rewrite&selfsectsn=&querytype=&searchfilter=&tid=stockpick&w=%E8%82%A1%E4%BB%B7%3C5"
# readHTMLTable(url)

# http://data.eastmoney.com/notice/NoticeStock.aspx?stockcode=601558&type=1&pn=1

# 601866
# 600027
#  2016Äê10ÔÂ£¬
#  ¹«Ë¾ºËÐÄ¾­Óª×Ê²ú´óÇØÏßÍê³É»õÎïÔËÊäÁ¿3352Íò¶Ö£¬Í¬±ÈÔö¼Ó12.52%¡£
#  ÈÕ¾ùÔËÁ¿108Íò¶Ö¡£´óÇØÏßÈÕ¾ù¿ªÐÐÖØ³µ75.5ÁÐ£¬ÆäÖÐ£º
#  ÈÕ¾ù¿ªÐÐ2Íò¶ÖÁÐ³µ50.9ÁÐ¡£2016Äê1-10ÔÂ£¬´óÇØÏßÀÛ¼ÆÍê³É»õÎïÔËÊäÁ¿27525Íò¶Ö,Í¬±È¼õÉÙ17.79%¡£

#  2016Äê9ÔÂ£¬¹«Ë¾ºËÐÄ¾­Óª×Ê²ú´óÇØÏßÍê³É»õÎïÔËÊäÁ¿2971Íò¶Ö£¬Í¬±È¼õÉÙ4.81%¡£ÈÕ¾ùÔËÁ¿99Íò¶Ö¡£
#  ´óÇØÏßÈÕ¾ù¿ªÐÐÖØ³µ72.7ÁÐ£¬ÆäÖÐ£ºÈÕ¾ù¿ªÐÐ2Íò¶ÖÁÐ³µ44.1ÁÐ¡£
#  2016Äê1-9ÔÂ£¬´óÇØÏßÀÛ¼ÆÍê³É»õÎïÔËÊäÁ¿24173Íò¶Ö,Í¬±È¼õÉÙ20.75%¡£


