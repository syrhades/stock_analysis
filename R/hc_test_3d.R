# http://api.highcharts.com/highcharts/title
source("e:/R/shiny_dashboard_stock_report_v1/cl_part_function.R")
require(highcharter)
require(dplyr)
require(plyr)
require(stringr)
require(jsonlite)
		ds <- lapply(seq(5), function(x){
		       list(data = cumsum(rnorm(100, 2, 5)), name = x)
		     })

		plotLines_json ="

{
from: 80.01,
to: 160.98,
# value: 80.15,
# width: 2,
color: '#D6EBFF',
label: {
text: '▲ 9.97 (0.38%)',
align: 'center',
style: {
color: '#007A3D'
}},
zIndex: 1

}"


frm_hc_set_opr<-function(hc,property,change_content){
	# hc <- hc
	# envir_out = as.environment(-1L)
	# print("output")
	# print(environment() %>% environmentName)
	# print(parent.frame() %>% environmentName)
	# ls(environment())
	envir_out <- parent.env(environment())
	# substitute(hc,envir_out) %>% print
	# envir_out$cmdstring <- sprintf("hc$x$hc_opts$%s <- %s",property,change_content %>% sQuote)
	envir_out$cmdstring <- sprintf("hc$x$hc_opts$%s <- %s",property,change_content)
	# print(envir_out %>% environmentName)
	# print(cmdstring)
	# eval(parse(text=cmdstring),envir = globalenv())
	eval(parse(text=cmdstring),envir = envir_out)
	# envir_out$hc <<- 
}

frm_hc_get_opr<-function(hc,property,...){
	eval(parse(text=paste("hc$x$hc_opts",property,sep="$")))
}


frm_json_cov <-function(json_str)

{

	step1<-strsplit(json_str,"\n")
	step2<-step1 %>%llply(function(x) gsub("'",'"',x))
	# step2 %>%llply(function(x) str_count(x,"^.*:"))
	# stringr::str_replace("testxx:123","(^.*)(:)",'"\\1""\\2"')
	step2 <- step2 %>%llply(function(x) str_trim(x,"both"))
	step3<-step2 %>%llply(function(x) str_replace(x,"(^.*):(.*)",'"\\1":\\2'))
	# return(step3)
	Reduce("str_c",step3 %>% unlist) %>% fromJSON %>% return
# step3 %>% laply(paste)
}

hc<- 	highchart() %>%
		# hc_chart(type="bar")%>%
		hc_yAxis(lineWidth= 2,
				lineColor= '#92A8CD',
				tickWidth= 3,
				tickLength= 6,
				tickColor= '#92A8CD',
				plotBands = plotLines_json %>% frm_json_cov
						)#%>%
		# 		  hc_series(
  #   list(
  #     name = "Allocated Budget",
  #     data = c(43000, 19000, 60000, 35000, 17000, 10000),
  #     pointPlacement = 'on'
  #   ),
  #   list(
  #     name = "Actual Spending",
  #     data = c(50000, 39000, 42000, 31000, 26000, 14000),
  #    pointPlacement = 'on'
  #   )
  # )

				# hc_add_series_xts(df_spec_stock_xts()%>%Cl)
# add data
# my_series<-  hc_series(hc,
#     list(
#       name = "Allocated Budget",
#       data = c(43000, 19000, 60000, 35000, 17000, 10000),
#       pointPlacement = 'on'
#     )
#     )
# # my_series

# hc2<-hc %>% hc_series(
# "{
#  type: 'columnrange',
#  name: 'High & Low',
#  data: [ [ 2237.73, 2336.04 ],
#  [ 2285.44, 2403.52 ],
#  [ 2217.43, 2359.98 ]]
#  }" %>%frm_json_cov# %>%unlist


# # "[ 50000,44444,66666,77777,88888]"%>%frm_json_cov
# # 	) %>% hc_add_series(
# # {
# #  type: 'areasplinerange',
# #  name: 'Open & Close',
# #  data: [[ 2238.66, 2336.04 ],
# #  [ 2298.37, 2350.99 ],
# #  [ 2338.99, 2359.78 ]]}
# 	)
# # hc2%>% hc_yAxis()
# #########################################################
# ##  hc_yAxis_multiples data set
# #########################################################
# hc2$x$hc_opts$series[[2]]<-hc2$x$hc_opts$series[[1]]
# hc2$x$hc_opts$series[[2]]$type<-"line"
# hc2$x$hc_opts$series[[2]]$name<-"Volume"
# hc2$x$hc_opts$series[[2]]$data<-"[ 5000,4444,6666,7777]"%>%frm_json_cov
# hc2$x$hc_opts$series[[2]]$yAxis <- 1
# hc2$x$hc_opts$series[[1]]$yAxis <- 0

# hc2$x$hc_opts$series[[3]]<-hc2$x$hc_opts$series[[1]]
# hc2$x$hc_opts$series[[3]]$type<-"areasplinerange"
# hc2$x$hc_opts$series[[3]]$name<-"Open & Close"
# hc2$x$hc_opts$series[[3]]$data<-" [ [ 2337.73, 2436.04 ],
#  [ 2245.44, 2453.52 ],
#  [ 2227.43, 2309.98 ]]"%>%frm_json_cov
# hc2$x$hc_opts$series[[3]]$yAxis <- 0
# hc2$x$hc_opts$plotOptions$line <- list(dashStyle="ShortDash",
# 											color = "red")

# hc2$x$hc_opts$plotOptions$series <- list(minSize= 8,
#  												maxSize= 40)

# hc2%>%hc_rm_series
# plotOptions: {
# series: {
# borderWidth: 0,
# dataLabels: {
# enabled: true,
# style: {
# fontWeight: 'bold'
# },
# color: 'white',
# formatter: function() {
# return Highcharts.numberFormat(this.y / 1000, 1,
# '.') + ' k';
# }
# }
# }
# },


hc2 <- hc
# hc2$x$hc_opts$plotOptions$series <- list(type= 'column',
# 												borderWidth=1,
# 												options3d = list(
# 													alpha=10,
# 													beta = 0,
# 													enabled =TRUE)
#  												)
hc3<-hc2 %>% 
	# hc_plotOptions(
	# 	column=list(stacking= 'normal')
	# 	)%>%
	hc_chart(type= 'column',
				borderWidth=1,
				options3d = list(
							alpha=20,
							beta = 30,
							enabled =TRUE,
							frame = "{
										 back: {
										 color: '#A3A3C2',
										 size: 4
										 },
										 bottom: {
											 color: '#DBB8FF',
											 size: 10
											 },
											 side: {
										color: '#8099E6',
										 size: 2
										 }
										 }" %>%frm_json_cov
								)
				)
# hc3 %>% hc_rm_series()
		# ) %>%
  #     hc_add_series(
		# 		color = "#E64545",
		# 		data = c(100),
		# 		depth = 5
		# 		) %>%
	 # hc_add_series( name = "s2",
		# 			color = "#FF45FF",
		# 			depth = 15
		# 			data = c(150)
		# 			) #%>%
# # hc3$x$hc_opts$series[[1]]$groupZPadding=95
# hc3$x$hc_opts$series[[1]]$depth=5
# # hc3$x$hc_opts$series[[2]]$groupZPadding=80
# hc3$x$hc_opts$series[[2]]$depth=20
# data.frame(value=list(1,2,3,4,5),depth=seq(10, 50, by = 10))

# > frm_gen_xts_step1(49) %>% str
# An 'xts' object on 1995-03-20/2016-12-09 containing:
#   Data: num [1:5105, 1:7] 0.74 0.42 0.4 0.47 0.4 0.42 0.42 0.39 0.41 0.37 ...
#  - attr(*, "dimnames")=List of 2
#   ..$ : NULL
#   ..$ : chr [1:7] "Open" "High" "Low" "Close" ...
#   Indexed by objects of class: [Date] TZ: UTC
#   xts Attributes:  
#  NULL
# > frm_stock_from_tdx_file(49) %>% str
# 'data.frame':   5105 obs. of  8 variables:
#  $ date  : Date, format: "1995-03-20" "1995-03-21" "1995-03-22" ...
#  $ open  : num  0.74 0.42 0.4 0.47 0.4 0.42 0.42 0.39 0.41 0.37 ...
#  $ high  : num  0.76 0.44 0.46 0.48 0.44 0.44 0.42 0.41 0.43 0.41 ...
#  $ low   : num  0.47 0.35 0.37 0.41 0.39 0.4 0.38 0.37 0.37 0.37 ...
#  $ close : num  0.48 0.4 0.46 0.42 0.43 0.42 0.39 0.41 0.38 0.39 ...
#  $ vol   : int  7272400 2520100 2991300 1621800 869700 1072400 749000 568900 815400 426500 ...
#  $ amount: num  67138800 20936990 25294434 13791787 7308959 ...
#  $ avg   : num  0.613 0.402 0.422 0.445 0.415 ...
# > 
hc3$x$hc_opts$plotOptions$column <-"{
											 pointPadding: 0,
											 groupPadding: 0,
											 color: '#C5542D',
											 edgeColor: '#953A20'
											 }" %>% frm_json_cov

frm_stock_from_tdx_file(49) %>% str

# test_df<-data.frame(value=seq(1, 10, by = 1),depth=seq(10, 100, by = 10))
test_df<-frm_stock_from_tdx_file(49)[,c("close","vol")]
colnames(test_df) <-c("value","depth")

# lapply(test_df,function(x){print(x$depth)})


# mapply(rep, 1:4, 4:1)
# mapply(function(x, y) seq_len(x) + y,
#        c(a =  1, b = 2, c = 3),  # names from first
#        c(A = 10, B = 0, C = -10))
# word <- function(C, k) paste(rep.int(C, k), collapse = "")
# utils::str(mapply(word, LETTERS[1:6], 6:1, SIMPLIFY = FALSE))
# # mapply(rep,test_df$value,test_df$depth)
# mapply(rep,test_df$value,test_df$depth)
# transform(test_df,depth=depth/mean(depth))
test_df<-test_df%>%head(n=100)
test_df<-transform(test_df,depth=depth/mean(depth))
width<- max(test_df$depth)*0.5
step_t1<- 	mapply(function(x,y) sprintf("hc_add_series(data= %s,depth=%s,groupZPadding=%s)",x,y,width-y),test_df$value,test_df$depth)%>% 
			llply(function(x) x)
step_t1<-  append(step_t1,"hc4<-hc3",after=0)
frm_paste_pipe<- function(...){paste(...,sep="%>%")}
char_str<-Reduce("frm_paste_pipe",step_t1 )
eval(parse(text=char_str))
hc4

hc3$x$hc_opts$plotOptions$column <-NULL
hc3$x$hc_opts$plotOptions$column <-"{
											 pointPadding: 0,
											 groupPadding: 0,
											 color: '#C5542D',
											 edgeColor: '#953A20'
											 }" %>% frm_json_cov


eval(parse(text=char_str))
hc3

# 3D columns in stacked and multiple series
 #      hc_add_series(
	# data = "[ [1, 1, 1], [2, 2, 2], [3, 3, 3], [4, 4, 4], [5, 5, 5] ]" %>% frm_json_cov,
	# sizeBy = "width",
	# names = "Size by width") 

 page 200
hc_carlos_set<-function(hc,...){  
  .hc_opt(hc, "series", ...)
}
###自定义一个hc属性函数 then set environment  environment(hc_carlos_set) <- environment(hc_add_series)
hc_carlos_set<-function(hc,...){  
  .hc_opt(hc, "series", ...)
}

environment(hc_carlos_set) <- environment(hc_add_series)
# 就可以用了

ls(envir= environment(hc_add_series),all.names =TRUE) %>% 
	llply(function(x) grep(pattern="hc_opt", x, value = TRUE)) %>% unlist

path.package() %>% llply(function(x) grep(pattern="chart", x, value = TRUE)) %>% unlist
"hc_carlos_set2<-" <- function(hc,attr,...){
	.hc_opt(hc, attr, ...)
}
environment(`hc_carlos_set2<-`) <- environment(hc_add_series)

# .Ob <- 1
# ls(pattern = "O")
# ls(pattern= "O", all.names = TRUE)    # also shows ".[foo]"

# # shows an empty list because inside myfunc no variables are defined
# myfunc <- function() {ls()}
# myfunc()

# # define a local variable inside myfunc
# myfunc <- function() {y <- 1; ls()}
# myfunc()                # shows "y"

