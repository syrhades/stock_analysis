#### packages we need ####
## ----------------------------------------------------------------------- ##
require(stringr)
require(XML)
require(RCurl)
library(Rwebdriver)

# set path
setwd("ListedCompanyAnnouncement")
# base url
BaseUrl<-"http://www.sse.com.cn/disclosure/listedinfo/announcement/"


#start a session
quit_session()
start_session(root = "http://localhost:4444/wd/hub/",browser = "firefox")


# post Base Url
post.url(url = BaseUrl)

# get xpath
StockCodeField<-element_xpath_find(value = '//*[@id="inputCode"]')
ClassificationField<-element_xpath_find(value = '/html/body/div[7]/div[2]/div[2]/div[2]/div/div/div/div/div[2]/div[1]/div[3]/div/button')
StartDateField<-element_xpath_find(value = '//*[@id="start_date"]')
EndDateField<-element_xpath_find(value = '//*[@id="end_date"]')
SearchField<-element_xpath_find(value = '//*[@id="btnQuery"]')


# fill stock code
StockCode<-"600000"

element_click(StockCodeField)
keys(StockCode)

Sys.sleep(2)

#fill classification field 
element_click(ClassificationField)

# get announcement xpath
RegularAnnouncement<-element_xpath_find(value = '/html/body/div[7]/div[2]/div[2]/div[2]/div/div/div/div/div[2]/div[1]/div[3]/div/div/ul/li[2]')
Sys.sleep(2)
element_click(RegularAnnouncement)

# #fill start and end date 
# element_click(StartDateField)

# today's xpath
EndToday<-element_xpath_find(value = '/html/body/div[13]/div[3]/table/tfoot/tr/th')
Sys.sleep(2)
element_click(EndDateField)
Sys.sleep(2)
element_click(EndToday)

#click search
element_click(SearchField)

###################################
####获得所有文件的link           ##
all_links<-character()


#首页链接
pageSource<-page_source()
parsedSourcePage<-htmlParse(pageSource, encoding = 'utf-8')

pdf_links<-'//*[@id="panel-1"]/div[1]/dl/dd/em/a'

all_links<-c(all_links,xpathSApply(doc = parsedSourcePage,path = pdf_links,
                                   xmlGetAttr,"href"))



#############################
##遍历所有link，下载文件
for(i in 1:length(all_links)){
  Sys.sleep(1)
  if(!file.exists(paste0("file/",basename(all_links[i])))){
    download.file(url = all_links[i],destfile = paste0("file/",basename(all_links[i])),mode = 'wb')
    
  }
}


#####################################################
library(Rwebdriver)
library(XML)
start_session(root = "http://localhost:4444/wd/hub/", browser =
"firefox")
post.url(url = "http://www.r-datacollection.com/materials/
selenium/intro.html")

buttonID <- element_xpath_find(value = "/html/body/div/div[2]/
form/input")
element_click(ID = buttonID)


allHandles <- window_handles()

# https://seleniumhq.github.io/selenium/docs/api/py/api.html
