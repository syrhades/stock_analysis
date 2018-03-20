#############################################################
## draw dygraphs
#############################################################
df_spec_stock_xts <- frm_gen_xts_step1(600027)
# df_spec_stock_xts %>% tail(n=500) %>% chartSeries()
df_spec_stock_xts  %>% chartSeries()

# show dygraph
# step 1 compute indicator
	s<-df_spec_stock_xts %>% Cl %>% frm_syr_bpctB
	l<-s$pctB
# step 2 get date line list for dyEvent 
	eventline <- l < 0
	buy_line<-eventline[eventline] %>% index

	eventline <- l > 100
	sell_line<-eventline[eventline] %>% index

max_xts<-rollapply(df_spec_stock_xts[,4],180,max,fill = 0, align = "right")
mean_xts<-rollapply(df_spec_stock_xts[,4],180,mean,fill = 0, align = "right")
min_xts<-rollapply(df_spec_stock_xts[,4],180,min,fill = 0, align = "right")
band_xts<-max_xts-min_xts
pos_xts <- df_spec_stock_xts[,4] - min_xts
i_pos_xts <- pos_xts/band_xts*100

show_xts<-cbind(max_xts,mean_xts,min_xts,df_spec_stock_xts[,4])
show_xts[1:6,]
dyplot<-dygraph(show_xts, main = "dygraph candlestick")%>%
	# dyCandlestick() %>%
	dyRangeSelector()
dyplot %>% dyLegend(show = "follow", hideOnMouseOut = T)  

###################################################################
# detail stock buy using graph
###################################################################
dy_plot1<-function(df_spec_stock_xts,stock_id,period=20,greed_f=0.5,fear_f=0.5,quantile_f=0.1){
	#period 
	# greed_f greed fatcor unit percent
	# fear_f    fear   fatcor unit percent
	test_price <- df_spec_stock_xts [,4]
	test_amount <- df_spec_stock_xts[,6]
	# data reparing
	max_xts<-rollapply(test_price,period,max,fill = 0, align = "right")
	mean_xts<-rollapply(test_price,period,mean,fill = 0, align = "right")
	min_xts<-rollapply(test_price,period,min,fill = 0, align = "right")

	quantile_xts <- rollapply(test_price,period*(1+greed_f),quantile,quantile_f,fill = 0, align = "right")

	band_xts<-max_xts-min_xts
	pos_xts <- test_price - min_xts
	i_pos_xts <- pos_xts/band_xts*100
	
	pric_xts<-test_price/mean_xts
	mean_amount_xts<-rollapply(test_amount,period,mean,fill = 0, align = "right")
	a_xts<-test_amount/mean_amount_xts

	b_list <- test_price %>% BBands
	# mean delt research
	lmean=list()
	lmean$Delt 			<-mean_xts %>%Delt * 100
	lmean$Delt_smooth	<-lmean$Delt %>%rollapply(period,mean,fill = 0, align = "right")

	show_xts2<-cbind(pric_xts,a_xts,df_spec_stock_xts %>%Cl,mean_xts,b_list$up)
	names(show_xts2) <-c("price_b","amount_b","Close","mean_price","ds")

	# buy point
	# eventline<- a_xts < 1 &  pric_xts <1 & test_price < mean_xts*(1-fear_f) & i_pos_xts < 10
	eventline<- a_xts < 1 &  
		pric_xts <1 & 
		pric_xts/a_xts < 1 & 
		test_price < mean(test_price)*(1-fear_f) & 
		test_price < quantile_xts  
		i_pos_xts < 5
	buy_line<-eventline[eventline] %>% index

	# sell point
	# eventline<- a_xts > 1 &  pric_xts >1 & test_price > mean(test_price) & i_pos_xts >100
	eventline<- a_xts > 1 &  
		pric_xts >1 & 
		# frm_cross_up(lmean$Delt_smooth,0) &   
		test_price > mean_xts*(1+greed_f)  &
		b_list$up < test_price
	# lmean$Delt_smooth %>% abs < delt_f
	# eventline<- lmean$Delt_smooth %>% abs < 0.1
	# print(lmean$Delt_smooth )
	# a_xts > 1 &  pric_xts >1 & 
	# test_price > mean_xts*(1+greed_f) & 
	
	# eventline<- test_price > mean(test_price) 
	sell_line<-eventline[eventline] %>% index


	eventline<- frm_cross_up(lmean$Delt_smooth,0) 
	test_line<-eventline[eventline] %>% index
	#  dygraph
	dyplot<-dygraph(show_xts2, main = paste(stock_id,"candlestick")) %>%
		# dyCandlestick() %>%
		dyRangeSelector()
	dyplot %>% dyLegend(show = "follow", hideOnMouseOut = T)  %>%
	dyAxis("y", label = "price", valueRange = c(range(test_price))) %>%

	dyEvent(buy_line,label=rep("b",length(buy_line)), labelLoc = "bottom",color="green",strokePattern = "dashed") %>%
	dyEvent(sell_line,label=rep("s",length(sell_line)), labelLoc = "top",color="red",strokePattern = "dotted") %>%
	dyEvent(test_line,label=rep("lead_indicator",length(test_line)), labelLoc = "top",color="black",strokePattern = "solid") %>%
	
	dySeries("price_b",  color = "red") %>%
	# dySeries("bb_pos",  color = "#AF0FAF") %>%
	dySeries("Close",  color = "blue") %>%
	dySeries("mean_price",  color = "#FAABD8") %>%
	dySeries("ds",  color = "#A5ABF8") %>%
	dySeries("amount_b", stepPlot = TRUE, color = "grey") 
}
frm_cross_up <- function(xts_a,xts_b){
  ## xts_a cross up xts_b (xts object , 0 )
  ## frm_cross_up(xts_a,xts_b)

  #step 1 compare 2 object
  list_ret <- list()
  list_ret$step1 <- xts_a - xts_b
  list_ret$Lag   <- list_ret$step1 %>% Lag
    Reduce("*",list_ret)  < 0 & 
    list_ret$step1 < 0 %>% 
    return
}

frm_cross_up <- function(xts_a,xts_b){
  ## xts_a cross up xts_b (xts object , 0 )
  ## frm_cross_up(xts_a,xts_b)
  #step 1 compare 2 object
  list_ret <- list()
  list_ret$step1 <- xts_a - xts_b
  list_ret$Lag   <- list_ret$step1 %>% Lag
    Reduce("*",list_ret)  < 0 %>% 
    return
}

frm_dy1<-function(stocid,func=to.weekly){
	df_spec_stock_xts <- frm_gen_xts_step1(stocid) # hdxx
	dy_plot1(df_spec_stock_xts %>%func,stocid,period=40,greed_f=0.65,fear_f=0.04,0.5)
}
frm_dy1(600642)
frm_dy1(600820,to.monthly)

dy_plot1(df_spec_stock_xts %>%to.weekly,period=40,greed_f=0.65,fear_f=0.04,0.4)

#####test
la=list()
mean_xts<-rollapply(df_spec_stock_xts %>%to.weekly %>%Cl,40,mean,fill = 0, align = "right")
la[[1]]<-mean_xts %>%Delt*100
la[[2]]<-la[[1]]%>%rollapply(50,mean,fill = 0, align = "right")
la[[3]]<-mean_xts 
la[[4]]<-df_spec_stock_xts %>%to.weekly %>%Cl
# la[[5]]<-la[[2]] %>%Delt

xts_all <- Reduce("cbind",la)
# xts_all[,1:2] %>%dygraph
xts_all %>%dygraph








dy_plot1(df_spec_stock_xts %>%to.weekly,40,greed_f=0.3,0.2)
dy_plot1(df_spec_stock_xts %>%to.weekly,60,greed_f=0.3,0.2)



df_spec_stock_xts <- frm_gen_xts_step1(600027)
dy_plot1(df_spec_stock_xts %>%to.weekly)


df_spec_stock_xts <- frm_gen_xts_step1(600642) #sheng neng gufeng
# dy_plot1(df_spec_stock_xts %>%to.weekly)
dy_plot1(df_spec_stock_xts %>%to.monthly)

df_spec_stock_xts <- frm_gen_xts_step1(601006) #dqtl
dy_plot1(df_spec_stock_xts %>%to.weekly,period=45,greed_f=0.65,fear_f=0.04,0.5)
dy_plot1(df_spec_stock_xts %>%to.weekly)
dy_plot1(df_spec_stock_xts %>%to.monthly)

df_spec_stock_xts <- frm_gen_xts_step1(601333) #gstl
# dy_plot1(df_spec_stock_xts %>%to.weekly)
dy_plot1(df_spec_stock_xts %>%to.weekly,period=45,greed_f=0.65,fear_f=0.04,0.5)

df_spec_stock_xts <- frm_gen_xts_step1(789) #gstl
# dy_plot1(df_spec_stock_xts %>%to.weekly)
dy_plot1(df_spec_stock_xts %>%to.weekly,period=45,greed_f=0.65,fear_f=0.04,0.5)
df_spec_stock_xts <- frm_gen_xts_step1(601333) #fjgs
dy_plot1(df_spec_stock_xts %>%to.weekly,period=45,greed_f=0.65,fear_f=0.04,0.5)


df_spec_stock_xts <- frm_gen_xts_step1(601288) # nyyh
dy_plot1(df_spec_stock_xts %>%to.weekly,period=45,greed_f=0.65,fear_f=0.04,0.5)

df_spec_stock_xts <- frm_gen_xts_step1(300170) # hdxx
dy_plot1(df_spec_stock_xts %>%to.weekly,period=45,greed_f=0.65,fear_f=0.04,0.5)


# 鐢宠兘鑲′唤[600642]鑲＄エ瀹炴椂琛屾儏_鏂版氮璐㈢粡
df_spec_stock_xts <- frm_gen_xts_step1(600642) # hdxx
dy_plot1(df_spec_stock_xts %>%to.monthly,period=40,greed_f=0.65,fear_f=0.04,0.5)
dy_plot1(df_spec_stock_xts %>%to.weekly,period=40,greed_f=0.65,fear_f=0.04,quantile_f=0.5)

##################################################
## TTR part
##################################################
df_spec_stock_xts %>%to.weekly %>%Cl %>% GMMA%>% dy_plot1

#############################
la=list()

la[[1]]<-mean_xts %>%Delt*100
la[[2]]<-la[[1]]%>%rollapply(50,mean,fill = 0, align = "right")
la[[3]]<-mean_xts 

xts_all <- Reduce("cbind",la)
xts_all[,1:2] %>%dygraph
xts_all[,1:3] %>%dygraph

xts_all

# frm_cross_up(test_data,0)
eventline <- frm_cross_up(xts_all[,2],0) 
eventline <- frm_cross_up(xts_all[,2],xts_all[,1]) 
p_line <- eventline[eventline] %>% index
xts_all[,1:3] %>%dygraph %>%
dyEvent(p_line)

eventlinex <-cbind(frm_cross_up(xts_all[,2],0), xts_all[,2])
