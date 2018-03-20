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
# step main 
##############################################################


# ret_list<-stock_filename_list %>%head(n=3) %>% 
# 	llply(frm_gen_xts_step1) %>% 
# 		llply(function(x) 
# 			frm_apply_indicator_step2(x,					# add indicator 
# 				list(
# 					function (x) {x %>% Cl < 5},				# price < 5
# 					function (x) indicator_bb(x %>% Cl)	# indicator BB  generate indicator
# 					)
# 				) %>%
# 				frm_TF_summary_xts %>% # generate indicator intersection 
# 				# check current price whether suit the conditon
# 				tail(n=10) %>%
# 				frm_T_or_F
# 			)


# ret_list_v2<-stock_filename_list %>%head(n=3) %>% 

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

# ret_list <-	stock_filename_list  %>% 
# 			# unlist%>% 
# 			frm_main
stock_filter_result <-data.frame(stock_id = F6stocks,shoot_flag = ret_list %>%unlist)
subset(stock_filter_result,shoot_flag==T) %>% write.table("e:/filter_stock.txt")

# stock_filter_result <-data.frame(stock_filename_list,ret_list_v2)
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
	llply(indicator_list,function(x){xts_obj %>% x})
}
indicator_1<- function (xts_obj,...){
	rollapply(xts_obj[,4],...)
}
# xts_obj<-xts_list[[6]]
# frm_apply_indicator_step2(xts_obj,list(Cl %>%head,Op%>%head))  # 调用function list head，tail 后合并是可以的
# frm_apply_indicator_step2(xts_obj,list(function (x) head(Cl(x))))

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
	################################################################################
	# test single part start
	################################################################################
	step2_ret<-frm_apply_indicator_step2(xts_obj,
		list(
			# function (x) indicator_1(x,180,max,fill = 0, align = "right"),
			# function (x) indicator_1(x,180,mean,fill = 0, align = "right"),
			# function (x) rollapply(x[,4],180,min,fill = 0, align = "right"),
			# function (x) {x[,4] <10&x[,4] > 5},
			function (x) {x %>% Cl < 5},    # price < 5
			function (x) indicator_bb(x %>% Cl)  # indicator BB  generate indicator
			)
		)
# which(ret_TF_summary_xts== T)
# which(tttccc== T)
frm_TF_summary_xts <- function(xts){
	ret_TF_summary_xts <- xts[[1]]
	ret_TF_summary_xts[ret_TF_summary_xts == F] <- T
	for (i in xts) {ret_TF_summary_xts<-ret_TF_summary_xts & i}
	ret_TF_summary_xts %>% return 
}

frm_TF_summary_xts_V2 <- function(xts){
	Reduce("&", xts)
}

ta<-list(list(1,2),list(3,4),list(5,6))
frm_cbind_xts<- function(xts){
	Reduce("cbind", xts)
}
frm_cbind_xts(ta)

frm_TF_summary_xts(step2_ret)

frm_T_or_F <- function(xts_obj){
	length_T <- which(xts_obj == T) %>% length
	length_F <- which(xts_obj == F) %>% length
	ifelse(length_T>=length_F,T,F) %>% return
}
# n_list<-length(step2_ret)
# # 将多个TF xts 求交集  
# step2_summary_TF_xts<-paste0("step2_ret[[",seq(n_list),"]]",collapse="&") %>% frm_run_char_cmd  


	################################################################################
	# test single part end
	################################################################################
################################################################################
# test Writing a decorator for R functions
################################################################################
Compose(cdr, car)
Hi all (especially R-core) I suppose,

With the introduction of the new functional programming functions into
base I thought I'd ask for a Curry() function. I use a simple one that
looks this:

Curry = function(FUN,...) { .orig = list(...);function(...)
do.call(FUN,c(.orig,list(...))) }

This comes in really handy when using say, heatmap():

heatmap(mydata,hclustfun=Curry(hclust,method="average"))

or other functions where there are ... arguments, but it's not clear
where they should end up.

-- 
Byron Ellis (byron.ellis at gmail.com)
"Oook" -- The Librarian
https://stat.ethz.ch/pipermail/r-devel/2007-November/047318.html

instrument=function(z){
  force(z) 
  n=deparse(substitute(z)) # get the name
  f=function(...){
   cat("calling ", n,"\n")
   x=z(...)
   cat("done\n")
   return(x)
   }
  return(f)
}

foo=function(x,y){x+y}
foo(1,2)
foo=instrument(foo)
foo(1,2)

instrument(paste)(1,2)


format_input <- function(x){
    x[x<0] <- NA
    return(x)
}

format_output <- function(x){
    return(-x)
}

wrapper <- function(f){
    force(f)
    g = function(bad_input){
        good_input = format_input(bad_input)
        bad_output = f(good_input)
        good_output = format_output(bad_output)
        return(good_output)
    }
    g
}
wrapper(sqrt)(c(-2,2))



wrapper <- function(f, fi=format_input, fo=format_output){
    force(f) ; force(fi); force(fo)
    g = function(bad_input){
        good_input = fi(bad_input)
        bad_output = f(good_input)
        good_output = fo(bad_output)
        return(good_output)
    }
    g
}

make_pos = function(x){abs(x)}
wrapper(sqrt,fo=make_pos)(c(-2,2))

require(functional)

w = Compose(format_input, sqrt, format_output)
w(c(-2,2))

add <- function(x) Reduce("+", x)
add(list(1, 2, 3))
# > union <- function(x) Reduce("&", x)
# > union(list(T,F,F))

# all.vars(formula(lm.object))
# variable.names(lm.object))
# ls( pattern = "pr" )
# names(coef(lm.object))
# labels(terms(lm.object))

xts_obj[step2_summary_TF_xts] %>% length
# Check result
xts_obj[step2_ret[[1]] &step2_ret[[2]],] %>% length
# step2_ret_sample[[5]] %>% head

step2_ret_sample %>% l_ply( cbind)

xts_obj[step2_ret_sample[[4]],][,4]


# sample
indicator_bb(xts_obj %>% Cl)
indicator_bb(xts_obj %>%to.monthly%>% Cl)
#####################################################
stock_filename_list %>% llply(frm_gen_xts_step1)
# show dygraph
# step 1 compute indicator
  s<-df_spec_stock_xts %>% Cl %>% frm_syr_bpctB
  l<-s$pctB
# step 2 get date line list for dyEvent 
  eventline <- l < 0
  buy_line<-eventline[eventline] %>% index

  eventline <- l > 100
  sell_line<-eventline[eventline] %>% index

# using frm_stock_from_tdx_file to extract stock data
df_spec_stock_xts %>% tail(n=500) %>% chartSeries()
df_spec_stock_xts  %>% chartSeries()
