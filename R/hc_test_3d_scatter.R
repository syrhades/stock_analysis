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
	# 	pie="{
	# 		center: [ '50%', '45%' ],
	# 		size: '120%',
	# 		depth: 50,
	# 		allowPointSelect: true,
	# 		slicedOffset: 40,
	# 		startAngle: 30
	# 		}"%>% frm_json_cov
	# 	)%>%
	hc_chart(
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

hc3 %>% hc_add_series(data="
 [ [ 2000, 23.32, 20.91 ],
 [ 2001, 22.6, 20.48 ],
 [ 1999, 223.6, 120.48 ],
 [ 2002, 25.13, 22.56 ]]"%>%frm_json_cov
 )

# hc4<-hc3 %>% hc_add_series(type="pie",data="[{
#     x: 1,
#     name: 'Point2',
#     color: '#00FF00'
#     }, {
#     x: 7,
#     name: 'Point1',
#     color: '#FF00FF'
# }]"%>%frm_json_cov
#  )




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

