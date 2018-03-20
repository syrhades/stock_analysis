require(stringr)
require(dplyr)
require(plyr)
require(jsonlite)
test_str="{
text: 'Highest 2639.15',
style: {
color: '#898989'
}
}"


test_str="
[{
value: 2606.01,
width: 2,
color: '#821740',
label: {
text: 'Lowest 2606.01',
style: {
color: '#898989'
}
}
},

{
value: 2639.15,
width: 2,
color: '#4A9338',
label: {
text: 'Highest 2639.15',
style: {
color: '#898989'
}
}
}]"

test_str="[{
from: 2606.01,
to: 2615.98,
label: {
text: '▲ 9.97 (0.38%)',
align: 'center',
style: {
color: '#007A3D'
}
},
zIndex: 1,
color: {
linearGradient: {
x1: 0, y1: 1,
x2: 1, y2: 1
},
stops: [ [0, '#EBFAEB' ],
[0.5, '#C2F0C2'] ,
[0.8, '#ADEBAD'] ,
[1, '#99E699']
]
}
}]
"

test_str="{
name: 'Ages 0 to 14',
 type: 'scatter',
 data: [ [ 1982, 23 ], [ 1989, 19 ],
 [ 2007, 14 ], [ 2004, 14 ],
 [ 1997, 15 ], [ 2002, 14 ],
 [ 2009, 13 ], [ 2010, 13 ] ]
}"
# paste(step3)
frm_json_cov <-function(json_str){

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



test_str="{
 scatter: {
 marker: {
 symbol: 'circle'
 },
 dataLabels: {
 enabled: true
 }
 }
 }"

 color = "{
 linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
 stops: [ [ 0, '#FF944D' ],
 [ 1, '#FFC299' ] ]
 }"
color %>% frm_json_cov %>%str





test_fun <-function(hc,...){
	local1 <-hc
	print(substitute(local1)%>%ls)
	ls(environment())
	# all.names(quote(hc))
	# all.names(hc)
}

test_fun(my_series)

# frm_hc_set_opr<-function(...){
# 	# envir_out = as.environment(-1L)
# 	# hc,property,change_content
# 	# print("output")
# 	# print(environment() %>% environmentName)
# 	# print(parent.frame() %>% environmentName)
# 	dots <- list(...)
# 	return(dots)
# 	ls(environment())
# 	# envir_out <- parent.env(environment())
# 	# substitute(hc,envir_out) %>% print
# 	envir_out$cmdstring <- sprintf("hc$x$hc_opts$%s <- %s",property,change_content)
# 	# print(envir_out %>% environmentName)
# 	# print(cmdstring)
# 	# eval(parse(text=cmdstring),envir = globalenv())
# 	eval(parse(text=cmdstring),envir = envir_out)
# }

# frm_hc_set_opr(hc,property='eee$dd',change_content="''xxx")
########################
lstest<-function (name, pos = -1L, envir = as.environment(pos), all.names = FALSE, 
    pattern, sorted = TRUE) 
{
    if (!missing(name)) {
        pos <- tryCatch(name, error = function(e) e)
        if (inherits(pos, "error")) {
            name <- substitute(name)
            if (!is.character(name)) 
                name <- deparse(name)
            warning(gettextf("%s converted to character string", 
                sQuote(name)), domain = NA)
            pos <- name
        }
    }
    all.names <- .Internal(ls(envir, all.names, sorted))
    if (!missing(pattern)) {
        if ((ll <- length(grep("[", pattern, fixed = TRUE))) && 
            ll != length(grep("]", pattern, fixed = TRUE))) {
            if (pattern == "[") {
                pattern <- "\\["
                warning("replaced regular expression pattern '[' by  '\\\\['")
            }
            else if (length(grep("[^\\\\]\\[<-", pattern))) {
                pattern <- sub("\\[<-", "\\\\\\[<-", pattern)
                warning("replaced '[<-' by '\\\\[<-' in regular expression pattern")
            }
        }
        grep(pattern, all.names, value = TRUE)
    }
    else all.names
    # print(envir)
}
