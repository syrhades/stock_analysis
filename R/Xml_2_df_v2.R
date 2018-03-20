require(XML)
require(htmlTable)
require(dplyr)
require(plyr)
require(stringr)
require(DiagrammeR)
####################################################################
# function part
####################################################################
frm_xml2df<-function(xml_file){
	doc <- xmlParse(xml_file) 
	df_attach<-doc %>% xmlRoot %>% xmlToDataFrame(stringsAsFactors=FALSE)
	return(df_attach)
}

frm_show_xml_node<-function(xml_node){
	d <- data.frame(	xmlName = xml_node %>% xmlName,
						xmlValue = xml_node %>% xmlValue, 
						xmlAttrs = xml_node %>% frm_xmlattr_flat_func
						)
	return(d)
	# xml_node %>% xmlName %>% print
	# xml_node %>% xmlValue %>% print
	# xml_node %>% xmlAttrs   %>% print
}

frm_xmlattr_flat_func<- function(xmlnode){
	ttt<- xmlnode%>% xmlAttrs
	str_list<-names(ttt) %>% laply(function(x) {paste(x,ttt[x],sep="=")})
	str_list %>% frm_vector2_str %>% return
	# attributes(ttt)
}

frm_vector2_str<-function(vec_obj,...){
	combine_str<-""
	for (n in vec_obj) {combine_str<-paste(combine_str,n,...)}
	return(combine_str)
}

frm_node_xpath<-function(node_obj){
	node_obj%>%xmlAncestors %>% laply(xmlName) %>%frm_vector2_str(sep="/")
}

frm_show_xpath<-function(nodes_obj){
	nodes_obj %>% laply(frm_node_xpath) %>% unique
}

frm_show_all_xpath<-function(filename,show_func=llply){
	tagnames<-xmlElementSummary(fileName)$nodeCounts %>% names
	doc<-xmlParse(filename)
	show_func(tagnames,function(x){getNodeSet(doc,paste0("//",x))%>% frm_show_xpath})
}

frm_check_xmlleaf <- function(xmlnode){
	# check leaf xml node(without child node)
	nodelist<-xmlnode %>% sapply(xmlChildren) %>% names %>% unique
	if ( length(nodelist) > 1 ) {return(FALSE) 
		}else{
		nodelist %in% "text" %>%any %>% return # using names only has text attr
	}
}

frm_setName<-function(df_obj,cname=c("from","to")){
	names(df_obj)<-cname
	return(df_obj)
}


frm_gen_dot_xml_graph <- function(xml_filename){
	#  frm_gen_dot_xml_graph(fileName) 
	# show xml all xpath in html dot graph
	result_list<-frm_show_all_xpath(xml_filename) %>%unlist %>%unique %>% sort
	result_list<-result_list %>% str_split(pattern="/", n = Inf, simplify = T) %>% as.data.frame(stringsAsFactors=FALSE)
	result_list <- result_list[,-1]
	# generate a data frame (from ,to )
	seqlist<-seq(ncol(result_list)-1) %>% sapply(function(x)paste(x,x+1,sep=":"))
	# seqlist %>% llply(function(x) {result_list[,eval(parse(text=x))]%>%frm_setName}) %>%rbind
	graph_df<-seqlist %>% ldply(function(x) {result_list[,eval(parse(text=x))]%>%frm_setName})  
	# result_list[,eval(parse(text=seqlist[1]))]
	# graph_df <- rbind(result_list[,1:2] %>%frm_setName ,result_list[,2:3] %>%frm_setName,result_list[,3:4]%>%frm_setName)
	graph_df <- graph_df %>% arrange(from, to) %>% unique
	## delete field to = blank
	graph_df<-subset(graph_df,to!="")
	# graph_df<-graph_df[graph_df$to != "",]

	## filter from
	# graph_df<-graph_df[grep("pro",graph_df$from),]
	# graph_df<-subset(graph_df,from=="product")
	# return(graph_df) 
	#  display a dot grapht
	graph <- create_graph() %>%
		add_edges_from_table(
		graph_df,
		from_col = "from",
		to_col = "to")
	render_graph(graph)
}


# ftable(result_list)

xml_file <- "E:/13c9e1a1-539c-11e6-85f7-16c3ac1d322a_PMDump/ATTACHMENTS_DUMP_13c9e1a1-539c-11e6-85f7-16c3ac1d322a.xml"
xml_file <- "E:/ac5167a0-a7c9-11e6-9f0b-6e8ec0a812fd_PMDump/ATTACHMENTS_DUMP_ac5167a0-a7c9-11e6-9f0b-6e8ec0a812fd.xml"
xml_file <- "E:/ac5167a0-a7c9-11e6-9f0b-6e8ec0a812fd_PMDump/ATTACHMENTS_DUMP_ac5167a0-a7c9-11e6-9f0b-6e8ec0a812fd.xml"
xml_file <-"E:\\a91660e0-a7c9-11e6-9f0b-6e8ec0a812fd_PMDump\\ATTACHMENTS_DUMP_a91660e0-a7c9-11e6-9f0b-6e8ec0a812fd.xml"
xml_file <-"E:\\a91660e0-a7c9-11e6-9f0b-6e8ec0a812fd_PMDump\\WHOLE_DUMP_a91660e0-a7c9-11e6-9f0b-6e8ec0a812fd.xml"

df_entryBPELObj <- xmlParse(xml_file) %>% getNodeSet(paste0("//","entryBPELObj")) %>% xmlToDataFrame(stringsAsFactors=FALSE)
df_entryBPELObj %>%names
df_entryVar <- xmlParse(xml_file) %>% getNodeSet(paste0("//","entryVar")) %>% xmlToDataFrame(stringsAsFactors=FALSE)
df_entryVar %>%names

# startDate
# endDate
##################process dump anlysis sample1 #####################
df_entryBPELObj<-transform(df_entryBPELObj,startDate=as.POSIXct(as.double(startDate)/1000,origin = "1970-01-01 08:00:00"))
df_entryBPELObj<-transform(df_entryBPELObj,startDate=format(startDate, format="%Y-%m-%d %H-%M-%OS3"),stringsAsFactors=FALSE)
df_entryBPELObj<-transform(df_entryBPELObj,endDate=as.POSIXct(as.double(endDate)/1000,origin = "1970-01-01 08:00:00"))
df_entryBPELObj<-transform(df_entryBPELObj,endDate=format(endDate, format="%Y-%m-%d %H-%M-%OS3"),stringsAsFactors=FALSE)
df_in_v <- merge(df_entryBPELObj,df_entryVar,by.x = "inputVariable", by.y = "locationPath")
df_out_v <- merge(df_entryBPELObj,df_entryVar,by.x = "outputVariable", by.y = "locationPath")


##################process dump anlysis sample1 #####################
##################show xml all xpath #####################
# show xml all xpath
frm_show_all_xpath(xml_file)
frm_show_all_xpath(xml_file) %>%unlist %>%unique %>% sort

xmlElementSummary(xml_file)$nodeCounts %>% names


fileName <- "e:/1c6bc030-5225-11e6-bb56-c51fc0a83801_PMDump/WHOLE_DUMP_1c6bc030-5225-11e6-bb56-c51fc0a83801.xml"
fileName <- "e:/catalog.xml"
frm_gen_dot_xml_graph(fileName)

######gengerate componet for delivery note#####
fileName <- "e:/fdjlicenseRequest.xml"
e = xmlParse(fileName)
ans = getNodeSet(e, "//component/name")
ldply(ans, xmlValue) %>% arrange(V1)



xpathApply(e, "//component/name", xmlValue)


 sapply(ans, xmlValue)

  # or equivalently
 ans = xpathApply(e, "//o:Cube[@currency='USD']", xmlGetAttr, "rate", namespaces = "o")

 
# rbind(seq(4),seq(4) %>% shift(1,type="lead"))

# >>>>>>>show xml all xpath in html dot graph^^^^^^^^^^^^^^^^^^^^^^^^^^^


##################show xml all xpath #####################

tagnames<-xmlElementSummary(xml_file)$nodeCounts %>% names
doc<-xmlParse(xml_file)
llply(tagnames,function(x){getNodeSet(doc,paste0("//",x))%>% frm_show_xpath}) 

# show xml to DateFrame 
# doc %>% xmlRoot %>% xmlToDataFrame %>% htmlTable

# doc %>% xmlRoot %>% xmlToList %>% htmlTable
df_attach<-frm_xml2df(xml_file)
df_attach %>% str

# xmlRoot(doc)[["attachmentEntry"]] %>% xmlChildren %>% xmlToDataFrame


# zh = timeDate("1970-01-01 08:00:00", zone = "GMT")
# zh+as.double(df_attach$createTime[1])/1000

# df_attach<-transform(df_attach,createTime=as.double(createTime)/1000+zh)
# change time based origin = "1970-01-01 00:00:00"
frm_time_convert<-function(df_attach){
	df_attach_timeformat<-transform(df_attach,createTime=as.POSIXct(as.double(createTime)/1000,origin = "1970-01-01 08:00:00"))
	df_attach_timeformat<-transform(df_attach_timeformat,createTime_ms=format(createTime, format="%Y-%m-%d %H-%M-%OS3"),stringsAsFactors=FALSE)
	df_attach_timeformat %>% str
}
#转化
mydate=as.POSIXct(1400906973173/1000, origin = "1970-01-01 00:00:00")
#显示
format(mydate, format="%Y-%m-%d %H-%M-%OS3")
# xmlToDataFrame(nodes = xmlChildren(xmlRoot(doc)[["data"]]))



###############################################
#          process xml part                ##################
###############################################
prcess_xml<-"E:\\a91660e0-a7c9-11e6-9f0b-6e8ec0a812fd_PMDump\\WHOLE_DUMP_a91660e0-a7c9-11e6-9f0b-6e8ec0a812fd.xml"
doc <- xmlParse(prcess_xml)  %>% xmlRoot
# dft<-xmlToDataFrame(nodes = getNodeSet(doc, "//entryVar/locationPath"))
dft_entry<-xmlToDataFrame(nodes = getNodeSet(doc, "//entryVar"),stringsAsFactors=FALSE)

# dft<-xmlToDataFrame(nodes = getNodeSet(doc, "//variables"))
dft %>% head


 xmlAttrs(xmlRoot(doc))

 xmlAttrsToDataFrame(xmlRoot(doc))
#########test#########################

> doc <- xmlParse(prcess_xml)  %>% xmlRoot
> doc %>%names
    processID   processName   partnerLink      portType     operation   bpelObjects     variables 
  "processID" "processName" "partnerLink"    "portType"   "operation" "bpelObjects"   "variables" 
> doc %>% class
[1] "XMLInternalElementNode" "XMLInternalNode"        "XMLAbstractNode"       
> doc <- xmlParse(prcess_xml) 
> doc %>% class
[1] "XMLInternalDocument" "XMLAbstractDocument"

xmlParse(prcess_xml)  %>% xmlRoot %>% frm_inspect


xmlName(xmlRoot(doc)[[1]])
xmlRoot(doc) %>% xmlChildren %>%sapply(xmlName)
xmlRoot(doc) %>% xmlChildren %>%lapply(xmlName)



<dataset name="mtcars" numRecords="32" source="R Project">
 xmlAttrs(xmlRoot(doc))
        name  numRecords      source 
   "mtcars"        "32" "R Project" 

# df_process<-frm_xml2df(prcess_xml)
# # example

#  f = system.file("exampleData", "size.xml", package = "XML")
#  xmlToDataFrame(f, c("integer", "integer", "numeric"))

#    # Drop the middle variable.
#  z = xmlToDataFrame(f, colClasses = list("integer", NULL, "numeric"))


#    #  This illustrates how we can get a subset of nodes and process
#    #  those as the "data nodes", ignoring the others.
#   f = system.file("exampleData", "tides.xml", package = "XML")
#   doc = xmlParse(f)
#   xmlToDataFrame(nodes = xmlChildren(xmlRoot(doc)[["data"]]))

#     # or, alternatively
#   xmlToDataFrame(nodes = getNodeSet(doc, "//data/item"))


#   f = system.file("exampleData", "kiva_lender.xml", package = "XML")
#   doc = xmlParse(f)
#   dd = xmlToDataFrame(getNodeSet(doc, "//lender"))


 fileName <- system.file("exampleData", "mtcars.xml", package="XML") 
 doc <- xmlParse(fileName)
 doc %>%xmlRoot %>%getNodeSet("//variable") %>% llply( frm_show_xml_node)

 


# frm_xmlattr_flat_func(doc %>%xmlRoot )
doc %>%xmlRoot %>%frm_show_xml_node


doc %>%xmlRoot %>%xmlAncestors
doc %>%xmlRoot %>%getNodeSet("//variable") %>% llply( xmlAncestors)




fileName <- system.file("exampleData", "mtcars.xml", package="XML") 
fileName <- "/media/syrhades/DAA4BB34A4BB11CD/catalog.xml"
fileName <- "/media/syrhades/DAA4BB34A4BB11CD/1c6bc030-5225-11e6-bb56-c51fc0a83801_PMDump/WHOLE_DUMP_1c6bc030-5225-11e6-bb56-c51fc0a83801.xml"
fileName <- "e:/1c6bc030-5225-11e6-bb56-c51fc0a83801_PMDump/WHOLE_DUMP_1c6bc030-5225-11e6-bb56-c51fc0a83801.xml"
# show xml all xpath
frm_show_all_xpath(fileName)
frm_show_all_xpath(fileName) %>%unlist %>%unique %>% sort

[1] "/processInstance"                                        
 [2] "/processInstance/bpelObjects"                            
 [3] "/processInstance/bpelObjects/entryBPELObj"               
 [4] "/processInstance/bpelObjects/entryBPELObj/endDate"       
 [5] "/processInstance/bpelObjects/entryBPELObj/inputVariable" 
 [6] "/processInstance/bpelObjects/entryBPELObj/locationPath"  
 [7] "/processInstance/bpelObjects/entryBPELObj/outputVariable"
 [8] "/processInstance/bpelObjects/entryBPELObj/startDate"     
 [9] "/processInstance/bpelObjects/entryBPELObj/stateCode"     
[10] "/processInstance/bpelObjects/entryBPELObj/stateName"     
[11] "/processInstance/operation"                              
[12] "/processInstance/partnerLink"                            
[13] "/processInstance/portType"                               
[14] "/processInstance/processID"                              
[15] "/processInstance/processName"                            
[16] "/processInstance/variables"                              
[17] "/processInstance/variables/entryVar"                     
[18] "/processInstance/variables/entryVar/locationPath"        
[19] "/processInstance/variables/entryVar/typeQName"           
[20] "/processInstance/variables/entryVar/value"               
[21] "/processInstance/variables/entryVar/varName"             
[22] "/processInstance/variables/entryVar/whilesIterations"    


xmlElementSummary(fileName)


df_entryBPELObj <- xmlParse(fileName) %>% getNodeSet(paste0("//","entryBPELObj")) %>% xmlToDataFrame(stringsAsFactors=FALSE)
df_entryBPELObj %>%names
df_entryVar <- xmlParse(fileName) %>% getNodeSet(paste0("//","entryVar")) %>% xmlToDataFrame(stringsAsFactors=FALSE)
df_entryVar %>%names

# merge two df 
outputVariable    locationPath
inputVariable      locationPath
<entryBPELObj>
            <locationPath>process/se[1]/sc[23]/se[1]/sw[9]/oth/se[1]/sw[6]/cs[1]/se[1]/i[3]</locationPath>
            <startDate>1469423002770</startDate>
            <endDate>1469423002931</endDate>
            <stateName>Finished</stateName>
            <stateCode>8</stateCode>
            <outputVariable>process/se[1]/sc[23]/variables/variable[40]</outputVariable>
            <inputVariable>process/se[1]/sc[23]/variables/variable[39]</inputVariable>


  <entryVar>
            <locationPath>process/se[1]/sc[23]/variables/variable[40]</locationPath>
            <varName>vrStoreResponse</varName>
            <typeQName>{http://uri.seeburger.com/bisas/storeservice/node/definition}StoreResponse</typeQName>
            <value>&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;root&gt;
    &lt;storeResponse seeMessagePartName="storeResponse" seeMessagePartType="3" seeMessagePartTypeQName="{http://www.w3.org/2001/XMLSchema}string"&gt;Store attachment was successful. Target location(s): ..\..\..\..\folderroot\errlog\000\Process.0000000025.err.zip&lt;/storeResponse&gt;
&lt;/root&gt;
</value>
        </entryVar>



frm_show_all_xpath(fileName,ldply)
frm_show_all_xpath(fileName,laply)
frm_show_all_xpath(fileName,llply)





 


