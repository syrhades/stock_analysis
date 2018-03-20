# http://api.highcharts.com/highcharts/title

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
my_series<-  hc_series(hc,
    list(
      name = "Allocated Budget",
      data = c(43000, 19000, 60000, 35000, 17000, 10000),
      pointPlacement = 'on'
    )
    )
# my_series

hc2<-hc %>% hc_series(
"{
 type: 'columnrange',
 name: 'High & Low',
 data: [ [ 2237.73, 2336.04 ],
 [ 2285.44, 2403.52 ],
 [ 2217.43, 2359.98 ]]
 }" %>%frm_json_cov# %>%unlist


# "[ 50000,44444,66666,77777,88888]"%>%frm_json_cov
# 	) %>% hc_add_series(
# {
#  type: 'areasplinerange',
#  name: 'Open & Close',
#  data: [[ 2238.66, 2336.04 ],
#  [ 2298.37, 2350.99 ],
#  [ 2338.99, 2359.78 ]]}
	)
# hc2%>% hc_yAxis()
#########################################################
##  hc_yAxis_multiples data set
#########################################################
hc2$x$hc_opts$series[[2]]<-hc2$x$hc_opts$series[[1]]
hc2$x$hc_opts$series[[2]]$type<-"line"
hc2$x$hc_opts$series[[2]]$name<-"Volume"
hc2$x$hc_opts$series[[2]]$data<-"[ 5000,4444,6666,7777]"%>%frm_json_cov
hc2$x$hc_opts$series[[2]]$yAxis <- 1
hc2$x$hc_opts$series[[1]]$yAxis <- 0

hc2$x$hc_opts$series[[3]]<-hc2$x$hc_opts$series[[1]]
hc2$x$hc_opts$series[[3]]$type<-"areasplinerange"
hc2$x$hc_opts$series[[3]]$name<-"Open & Close"
hc2$x$hc_opts$series[[3]]$data<-" [ [ 2337.73, 2436.04 ],
 [ 2245.44, 2453.52 ],
 [ 2227.43, 2309.98 ]]"%>%frm_json_cov
hc2$x$hc_opts$series[[3]]$yAxis <- 0
hc2$x$hc_opts$plotOptions$line <- list(dashStyle="ShortDash",
											color = "red")


#########################################################
##  hc_yAxis_multiples yAxis  method1
#########################################################
   hc2%>% hc_yAxis_multiples(
     list( title=list(text = "open close"),lineWidth = 3,lineColor="#aad6eb"),
     list(title=list(text = "Volume"),offset = 0,opposite= TRUE,
          # showFirstLabel = FALSE, showLastLabel = FALSE,
          lineColor="#ffd6eb")
   )



#########################################################
##  hc_yAxis_multiples yAxis  method1
#########################################################
hc2%>% hc_yAxis_multiples(
     list(top = "0%", height = "30%", lineWidth = 3),
     list(top = "30%", height = "70%", offset = 0,
          showFirstLabel = FALSE, showLastLabel = FALSE)
   )


hc2
my_series

"[{  
                    min: 0,
                    title:{  
                        text :'eeee'
                    }
                    
                },{
                    title:{  
                        text :'xxxx'
                    },
                    opposite:true
                }]"%>% frm_json_cov




step2<-teststr %>% frm_json_cov

teststr = "
{
 borderColor: '#7070B8',
 borderRadius: 3,
 borderWidth: 1,

 data: [ 48.9 ,50,100,80]
 }
 "


#  str_fun="
# {
# formatter: function() {
# var str = this.point.name + ': ' +
# Highcharts.numberFormat(this.y, 0);
# return str;
# }
# }
# "
# str_fun %>% frm_json_cov

my_series<-hc%>% hc_series(teststr %>% frm_json_cov)

###########################################################
# 手工附加content 到 my_series$x$hc_opts$series[[1]]$color
###########################################################
frm_update_hc <-function(){


}
# my_series$x$hc_opts$series[[1]]$borderColor
linearGradient <- "{ 
x1: 0,
y1: 0,
x2: 1,
y2: 0
 }"
stops <-"[ [ 0, '#D6D6EB' ],
 [ 0.3, '#5C5CAD' ],
 [ 0.45, '#5C5C9C' ],
 [ 0.55, '#5C5C9C' ],
 [ 0.7, '#5C5CAD' ],
 [ 1, '#D6D6EB'] ]"
my_series$x$hc_opts$series[[1]]$color<-list(linearGradient =linearGradient%>% frm_json_cov,
											 stops = stops %>% frm_json_cov)
my_series$x$hc_opts$series[[1]]$color
###########################################################
################pie#####################
#  Plotting multiple pies
###########################################################

my_series<-  hc_series(hc,
    list(
      name = "Allocated Budget",
      data = c(43000, 19000, 60000, 35000, 17000, 10000),
      pointPlacement = 'on'
    )
    )
hc <- my_series
hc %>% frm_hc_set_opr("chart$type","'column'")
# my_series %>% frm_hc_get_opr("chart$type")
# my_series$x$hc_opts$chart$type <- "pie"
"{size: '75%'}"%>% frm_json_cov
hc %>% frm_hc_set_opr("chart$type","'column'")
# hc %>% frm_hc_set_opr("plotOptions$pie","'column'")
my_series$x$hc_opts$plotOptions$pie<-list(size= '75%')
my_series$x$hc_opts$series[[1]]$center <- c('25%', '50%')
my_series$x$hc_opts$series[[2]] <-my_series$x$hc_opts$series[[1]]
my_series$x$hc_opts$series[[2]]$center <- "[ '75%', '50%' ]" %>% frm_json_cov
# my_series<-  hc%>% hc_series(teststr %>% frm_json_cov,type="bar")
# frm_json_cov(teststr)[5]
	# teststr %>% frm_json_cov %>%unlist

    # list(
    #   name = "Allocated Budget",
    #   data = c(43000, 19000, 60000, 35000, 17000, 10000),
    #   pointPlacement = 'on'
    # )
    # )
my_series
pie_set <-"{
dataLabels: {
style: {
width: '140px'
}
 }"
my_series$x$hc_opts$plotOptions$pie <-list(pie_set %>% frm_json_cov)
my_series

#######################################################
##  hc function 
#######################################################

fn <- "function(){
  console.log('Category: ' + this.category);
  alert('Category: ' + this.category);
}"

hc <- highcharts_demo() %>% 
  hc_plotOptions(
    series = list(
      cursor = "pointer",
        point = list(
          events = list(
            click = JS(fn)
         )
       )
   )
 )

 library("viridisLite")

cols <- viridis(3)
cols <- substr(cols, 0, 7)

highcharts_demo() %>% 
  hc_colors(cols)

  # http://www.investorsintelligence.co.uk/wheel/
  #########################333
  # pane
  ##############################3
hc$x$hc_opts$pane <- "[{
  startAngle: -120,
  endAngle: 120,
  size: 300,
  backgroundColor: '#E4E3DF'
  }]"  %>% frm_json_cov
hc$x$hc_opts$title$text = "speedometer"
hc$x$hc_opts$yAxis = "[{
  min: 0,
  max: 140}]" %>% frm_json_cov
hc$x$hc_opts$series = "[{
  type: 'gauge',
  data: [ 0 ]
  }]" %>% frm_json_cov
hc

  chart: {
  renderTo: 'container'
  },
  title: { text: 'Fiat 500 Speedometer' },
  ,
  yAxis: [{
  min: 0,
  max: 140,
  labels: {
  rotation: 'auto'
  }
  }],
  series: 

  ########################
  		ds <- lapply(seq(5), function(x){
		       list(data = cumsum(rnorm(100, 2, 5)), name = x)
		     })
  hc<- 	highchart()
  hc %>%
  	hc_chart(polar = TRUE,type="column") %>%
  	hc_plotOptions(column = list(
  	 								stacking =  'normal'
									# stacking =  'percent'
									)
  		) %>%
  	hc_xAxis(labels = list(rotation = 'auto'),
  		tickmarkPlacement= 'on',
  			lineWidth = 0,
  			plotBands = "[{
						from: 500,
						to: 1000,
						color: '#FF0000'
						}]" %>% frm_json_cov
  		)%>%
  	hc_yAxis(gridLineInterpolation= 'polygon',
			lineWidth= 0,
			min= 0

  		)%>%
  	hc_add_series_list(ds)
####################################################
# hc research
####################################################

> hc_add_series
function (hc, ...) 
{
    validate_args("add_series", eval(substitute(alist(...))))
    dots <- list(...)
    if (is.numeric(dots$data) & length(dots$data) == 1) {
        dots$data <- list(dots$data)
    }
    lst <- do.call(list, dots)
    hc$x$hc_opts$series <- append(hc$x$hc_opts$series, list(lst))
    hc
}

frm_hc_update_opr<-function(hc,property,...){
	dots <- list(...)
	if (is.numeric(dots$data) & length(dots$data) == 1) {
        dots$data <- list(dots$data)
    }
	lst <- do.call(list, dots)
	hc$x$hc_opts$property <- append(hc$x$hc_opts$property,list(lst))

}



hc %>% frm_hc_get_opr("yAxis$title$text")
hc %>% frm_hc_set_opr("yAxis$title$text","'test_title5'")
hc %>% frm_hc_get_opr("yAxis$title$text")
# frm_hc_display_opr<-function(hc,property,...){

# 	hc$x$hc_opts[[property]] %>% str

# }

frm_hc_display_opr<-function(hc,property,...){
	eval(parse(text=paste("hc$x$hc_opts",property,sep="$"))) %>% str
	# eval(hc$x$hc_opts$property) %>% str

}
hc %>% frm_hc_display_opr("yAxis$plotBands")


frm_wrap_sample<-
function (a=1, ...) 
{
    # validate_args("add_series", eval(substitute(alist(...))))
    dots <- list(...)
    if (is.numeric(dots$data) & length(dots$data) == 1) {
        dots$data <- list(dots$data)
    }
    lst <- do.call(list, dots)
    return(lst)
}

frm_wrap_sample2<-
function (a=1, ...) 
{
    # validate_args("add_series", eval(substitute(alist(...))))
    dots <- list(...)
    # if (is.numeric(dots$data) & length(dots$data) == 1) {
    #     dots$data <- list(dots$data)
    # }
    # lst <- do.call(list, dots)
    return(dots)
}
frm_wrap_sample2(b=1,f=3)
 page 200
