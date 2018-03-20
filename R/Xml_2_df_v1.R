require(XML)
require(htmlTable)

xml_file <- "E:/13c9e1a1-539c-11e6-85f7-16c3ac1d322a_PMDump/ATTACHMENTS_DUMP_13c9e1a1-539c-11e6-85f7-16c3ac1d322a.xml"
xml_file <- "E:/ac5167a0-a7c9-11e6-9f0b-6e8ec0a812fd_PMDump/ATTACHMENTS_DUMP_ac5167a0-a7c9-11e6-9f0b-6e8ec0a812fd.xml"
xml_file <- "E:/ac5167a0-a7c9-11e6-9f0b-6e8ec0a812fd_PMDump/ATTACHMENTS_DUMP_ac5167a0-a7c9-11e6-9f0b-6e8ec0a812fd.xml"
xml_file <-"E:\\a91660e0-a7c9-11e6-9f0b-6e8ec0a812fd_PMDump\\ATTACHMENTS_DUMP_a91660e0-a7c9-11e6-9f0b-6e8ec0a812fd.xml"

frm_xml2df<-function(xml_file){
	doc <- xmlParse(xml_file) 
	df_attach<-doc %>% xmlRoot %>% xmlToDataFrame(stringsAsFactors=FALSE)
	return(df_attach)
}


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
df_attach_timeformat<-transform(df_attach,createTime=as.POSIXct(as.double(createTime)/1000,origin = "1970-01-01 08:00:00"))
df_attach_timeformat<-transform(df_attach_timeformat,createTime_ms=format(createTime, format="%Y-%m-%d %H-%M-%OS3"),stringsAsFactors=FALSE)
df_attach_timeformat %>% str

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
# frm_xmlattr_flat_func(doc %>%xmlRoot )
doc %>%xmlRoot %>%frm_show_xml_node


doc %>%xmlRoot %>%xmlAncestors
doc %>%xmlRoot %>%getNodeSet("//variable") %>% llply( xmlAncestors)


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

fileName <- system.file("exampleData", "mtcars.xml", package="XML") 
fileName <- "/media/syrhades/DAA4BB34A4BB11CD/catalog.xml"
frm_show_all_xpath(fileName)
frm_show_all_xpath(fileName,ldply)
frm_show_all_xpath(fileName,laply)
frm_show_all_xpath(fileName,llply)

doc <- xmlParse(fileName)
nodeRoot<-doc %>%xmlRoot
node_v<-nodeRoot%>%getNodeSet("//variable")
node_v<-nodeRoot%>%getNodeSet("//record ")
node_v %>% frm_show_xpath


doc <- xmlParse(fileName)
xmlElementsByTagName(doc$children[[1]], "variable")

doc%>%xmlRoot %>%xmlChildren %>%laply(xmlName)

#递归 children
doc%>%xmlRoot %>%xmlChildren
doc%>%xmlRoot %>%getChildrenStrings
doc%>%xmlRoot %>%xmlSApply(xmlName)

frm_check_xmlleaf <- function(xmlnode){
	# check leaf xml node(without child node)
	nodelist<-xmlnode %>% sapply(xmlChildren) %>% names %>% unique
	if ( length(nodelist) > 1 ) {return(FALSE) 
		}else{
		nodelist %in% "text" %>%any %>% return # using names only has text attr
	}
}

doc %>% xmlRoot %>%xmlChildren %>% frm_check_xmlleaf

####################################################
####################################################
####################################################
####################################################
xmlnode<-doc %>% xmlRoot
parentName<-xmlnode %>% xmlName()
child_list<-xmlnode %>% xmlChildren
child_listName<-child_list %>% sapply(xmlName)
child_list %>%llply(xmlName)



doctree <- xmlTreeParse(fileName)

doctree %>% inherits("XMLDocument")

XML:::getXMLPath(xmlChildren(doc%>%xmlRoot)[[1]])

getNodePosition(xmlnode%>%xmlChildren())
xmlElementsByTagName(xmlnode,"variable",recursive = T)

xmlElementSummary(fileName)
> xmlElementsByTagName
function (el, name, recursive = FALSE) 
{
    kids = xmlChildren(el)
    idx = (names(kids) == name)
    els = kids[idx]
    if (!recursive || xmlSize(el) == 0) 
        return(els)
    subs = xmlApply(el, xmlElementsByTagName, name, TRUE)
    subs = unlist(subs, recursive = FALSE)
    append(els, subs[!sapply(subs, is.null)])
}


file.info(fileName) %>% str()
'data.frame':	1 obs. of  10 variables:
 $ size  : num 3799
 $ isdir : logi FALSE
 $ mode  :Class 'octmode'  int 436
 $ mtime : POSIXct, format: "2016-11-13 09:09:41"
 $ ctime : POSIXct, format: "2016-11-13 09:09:44"
 $ atime : POSIXct, format: "2016-11-13 09:21:49"
 $ uid   : int 0
 $ gid   : int 0
 $ uname : chr "root"
 $ grname: chr "root"

 xmlElementSummary
function (url, handlers = xmlElementSummaryHandlers(url)) 
{
    handlers
    if (file.exists(url) && file.info(url)[1, "isdir"]) 
        url = list.files(url, pattern = "\\.xml$", full.names = TRUE)
    if (length(url) > 1) 
        lapply(url, xmlElementSummary, handlers)
    else xmlEventParse(url, handlers, replaceEntities = FALSE)
    handlers$result()
}


> XML:::xmlElementSummaryHandlers
function (file = character(), countAttributes = TRUE) 
{
    tags = list()
    counts = integer()
    start = function(name, attrs, ...) {
        if (name == "xi:include") {
            href = getRelativeURL(attrs["href"], dirname(file), 
                sep = .Platform$file.sep)
            xmlElementSummary(href, funs)
        }
        if (!countAttributes) 
            tags[[name]] <<- unique(c(names(attrs), tags[[name]]))
        else {
            x = tags[[name]]
            i = match(names(attrs), names(x))
            if (any(!is.na(i))) 
                x[i[!is.na(i)]] = x[i[!is.na(i)]] + 1
            if (any(is.na(i))) 
                x[names(attrs)[is.na(i)]] = 1
            tags[[name]] <<- x
        }
        counts[name] <<- if (is.na(counts[name])) 
            1
        else counts[name] + 1
    }
    funs = list(.startElement = start, .getEntity = function(x, 
        ...) "xxx", .getParameterEntity = function(x, ...) "xxx", 
        result = function() list(nodeCounts = sort(counts, decreasing = TRUE), 
            attributes = tags))
}


df_sub<- data.frame(parent = parentName,child = child_listName) %>%unique
####################################################





require(XML)
require(dplyr)
require(plyr)

fileName <- system.file("exampleData", "mtcars.xml", package="XML") 
doc <- xmlParse(fileName)
rev_test <- function(xmlnode,df_obj){
  if (!frm_check_xmlleaf(xmlnode %>% xmlChildren)){
  	child_list <- xmlnode %>% xmlChildren
  	parentName<-xmlnode %>% xmlName()
  	child_listName<-child_list %>% sapply(xmlName)
    df_sub<- data.frame(parent = parentName,child = child_listName) %>% unique
    # child_list %>% l_ply(rev_test(df_sub))
    return(child_list %>% l_ply(rev_test(rbind(df_obj,df_sub))) )
	}

}

dftest <-data.frame(parent = "",child = "")
rev_test(doc %>% xmlRoot,dftest)


rev <- function(xmlnode){
  if (!frm_check_xmlleaf(xmlnode)){
    xml_list<- xmlnode %>%xmlChildren   
  } else {
    out = xmlnode    
  }
  return(out)
}

node_v%>%xmlChildren
Fubini <- function(n){
  if ((n == 0) | (n == 1)){
    out = 1   
  } else {
    out = Fubini(n-1)+Fubini(n-2)    
  }
  return(out)
}
Fubini(5)
sapply(0:30,Fubini)

http://blog.163.com/zhoulili1987619@126/blog/static/35308201201531511273389/

xpathApply(doc,"//variable",xmlValue)

###########################################################

dom <- xmlTreeParse(system.file("exampleData","mtcars.xml", package="XML"))
 tagNames <- function() {
    tags <- character(0)
    add <- function(x) {
      if(inherits(x, "XMLNode")) {
        if(is.na(match(xmlName(x), tags)))
           tags <<- c(tags, xmlName(x))
      }

      NULL
    }

    return(list(add=add, tagNames = function() {return(tags)}))
 }

 h <- tagNames()
 xmlDOMApply(xmlRoot(dom), h$add) 
 h$tagNames()



 



 fileName <- system.file("exampleData", "mtcars.xml", package="XML")

   # Print the name of each XML tag encountered at the beginning of each
   # tag.
   # Uses the libxml SAX parser.
 xmlEventParse(fileName,
                list(startElement=function(name, attrs){
                                    cat(name,attrs,"\n")
                                  }),
                useTagName=FALSE, addContext = FALSE)

 xmlEventParse(fileName,
                list(startElement=function(name, attrs){
                                    cat(attrs,"\n")
                                  }),
                useTagName=FALSE, addContext = FALSE)


xmlEventParse(fileName, asText=TRUE)


f <- system.file("exampleData", "gnumeric.xml", package = "XML")
zz <- xmlEventParse(f,
                    handlers = list(startElement=function(name, atts, .state) {
                                                     .state = .state + 1
                                                     print(.state)
                                                     .state
                                                 }), state = 0)
print(zz)

xmlElementSummary(f)$nodeCounts %>% sum

a closure object that contains functions which will be invoked as the XML components in the document are encountered by the parser. The standard function or handler names are 
startElement()
, endElement()
 comment()
, getEntity, entityDeclaration()
, processingInstruction()
, text()
, cdata()
, startDocument()
, endDocument
and endDocument()
, or alternatively and preferrably, these names prefixed with a '.', i.e. .startElement, .comment, ... 

test_ep<-xmlEventParse(fileName,
               handlers = list(startDocument = function() {
                                                 cat("Starting document\n")
                                               },
                               endDocument = function() {
                                                 cat("ending document\n")
                                             }),
               saxVersion = 2)


startElement2 = function(x, ...) cat(">>>>",x, "\n")

 xmlEventParse(fileName, handlers = list(startElement = startElement2))


 h = list(startElement = function(name, attrs, namespace, allNamespaces){ 
                                 cat("Starting", name,"\n")
                                 if(length(attrs))
                                     print(attrs)
                                 print(namespace)
                                 print(allNamespaces)
                         },
          endElement = function(name, uri) {
                          cat("Finishing", name, "\n")
            }) 
 syr<-xmlEventParse(system.file("exampleData", "namespaces.xml", package="XML"),
               handlers = h, saxVersion = 2)


h2 = list(startElement = function(name,attrs ){ 
                                 paste("Starting", name,"\n")
                                 if(length(attrs))
                                     print(attrs)
                         },
          endElement = function(name) {
                          paste("Finishing", name, "\n")
            }) 

 syr<-xmlEventParse(fileName,
               handlers = h2)

 xmlElementSummary(fileName, handlers = syr)


 b.counter = function() {
                nodes <- character()
                f = function(node) { nodes <<- c(nodes, xmlGetAttr(node, "id"))}
                list(b = f, nodes = function() nodes)
             }

  b = b.counter()


############################################
  # Stopping the parser mid-way and an example of using XMLParserContextFunction.

  startElement =
  function(ctxt, name, attrs, ...)  {
    print(ctxt)
      print(name)
      if(name == "rewriteURI") {
           cat("Terminating parser\n")
     xmlStopParser(ctxt)
      }
  }
  class(startElement) = "XMLParserContextFunction"  
  endElement =
  function(name, ...) 
    cat("ending", name, "\n")

  fileName = system.file("exampleData", "catalog.xml", package = "XML")
    syroutput<-xmlEventParse(fileName, handlers = list(startElement = startElement,
                                            endElement = endElement))


     xmlEventParse(system.file("exampleData", "mtcars.xml", package="XML"),
               handlers=xmlEventHandler())

     xmlEventParse(fileName, handlers = NULL, asText=TRUE)


f = system.file("exampleData", "dataframe.xml", package = "XML")
tr  = xmlHashTree()
xmlTreeParse(f, handlers = list(.startElement = tr[[".addNode"]]))
xmlTreeParse(f, handlers = list(.startElement = tr[[".children "]]))


f = system.file("exampleData", "dataframe.xml", package = "XML")
 tr  = xmlHashTree()
 xmlTreeParse(f, handlers = list(.startElement = tr[[".addNode"]]))

 tr # print the tree on the screen


 xmlTreeParse(file, ignoreBlanks=TRUE,  handlers=NULL,  replaceEntities=FALSE,
                          asText=FALSE, trim=TRUE,  validate=FALSE, getDTD=TRUE,
                          isURL=FALSE,  asTree  = FALSE,  addAttributeNamespaces  = FALSE,
                          useInternalNodes  = FALSE,  isSchema  = FALSE,
                          fullNamespaceInfo = FALSE,  encoding  = character(),
                          useDotNames = length(grep("^\\.", names(handlers))) > 0,
                          xinclude  = TRUE, addFinalizer  = TRUE, error = xmlErrorCumulator(),
                          isHTML  = FALSE,  options = integer(),  parentFirst = FALSE)

 xmlTreeParse(fileName,handler=h2)

startElement,externalEntity,processingInstruction,text,cdataandnamespace.

 xmlTreeParse(fileName, handlers=list("startElement"=function(x,...){NULL}), asTree  = TRUE)


 ret_res<- xmlTreeParse(fileName,
                        handlers=list(entity=function(x)  {
                                                                        cat("In entity",x$name, x$value,"\n")
                                                                        x}
                                                                    ),  asTree  = TRUE
                                                    )

 invisible(xmlTreeParse(fileName,
                        handlers=list(element=function(x)  {
                                                                        cat("In element",x$name, x$value,x$attributes"\n")
                                                                        x}
                                                                    ),  asTree  = TRUE
                                                    )
                    )


fileName  <-  system.file("exampleData",  "mathml.xml",package="XML")
m <-  xmlTreeParse(fileName,  
                                    handlers=list(
                                      startElement  = function(node){
                                      cname <-  paste(xmlName(node),"MathML", sep="",collapse="")
                                      class(node) <-  c(cname,  class(node)); 
                                      node
                                }))



xmlTreeParse(fileName,  handlers  = list(
                                                                    variable=function(x,  attrs)  {
                                                                                          print(xmlValue(x[[1]]));  TRUE
                                                                                      }), asTree=TRUE)

# In  this  example,  we  extract _just_  the names of  the
    # variables in  the mtcars.xml  file. 
    # The names are the contents  of  the <variable>
    # tags. We  discard all other tags  by  returning NULL
    # from  the startElement  handler.
    #
    # We  cumulate  the names of  variables in  a character
    # vector  named `vars'.
    # We  define  this  within  a closure and define  the 
    # variable  function  within  that  closure so  that  it
    # will  be  invoked when  the parser  encounters  a <variable>
    # tag.
    # This  is  called  with  2 arguments:  the XMLNode object  (containing
    # its children) and the list  of  attributes.
    # We  get the variable  name  via call  to  xmlValue().
    # Note  that  we  define  the closure function  in  the call  and then  
    # create  an  instance  of  it  by  calling it  directly  as
    #     (function() {...})()
    # Note  that  we  can get the names by  parsing
    # in  the usual manner  and the entire  document  and then  executing
    # xmlSApply(xmlRoot(doc)[[1]],  function(x) xmlValue(x[[1]]))
    # which is  simpler but is  more  costly  in  terms of  memory.
  fileName  <-  system.file("exampleData",  "mtcars.xml", package="XML")
  doc <-  xmlTreeParse(fileName,    handlers  = (function() { 
                                                                  vars  <-  character(0)  ;
                                                                list(variable=function(x, attrs)  { 
                                                                                                vars  <<- c(vars, xmlValue(x[[1]]));  
                                                                                                NULL},  
                                                                          startElement=function(x,attr){
                                                                                                      NULL
                                                                                                    },  
                                                                          names = function()  {
                                                                                                  vars
                                                                                          }
                                                                        )
                                                              })()
                                          
getLinks  = function()  { 
              links = character() 
              list(a  = function(node,  ...)  { 
                                      links <<- c(links,  xmlGetAttr(node,  "href"))
                                      node  
                                },  
                        links = function()links)
          }
  h1  = getLinks()
  htmlTreeParse(system.file("examples", "index.html", package = "XML"),
                              handlers  = h1)
  h1$links()


    tt  = xmlHashTree()
  f = system.file("exampleData",  "mtcars.xml", package="XML")
  xmlTreeParse(f, handlers  = list(.startElement  = tt[[".addNode"]]))
  xmlRoot(tt) 


    doc = xmlTreeParse(f, useInternalNodes  = TRUE)
  sapply(getNodeSet(doc,  "//variable"),  xmlValue)

  f = system.file("exampleData",  "book.xml", package = "XML")
      titles  = list()
      xmlTreeParse(f, handlers  = list(title  = function(x)
                                                                    titles[[length(titles)  + 1]] <<- x))
      sapply(titles,  xmlValue)
      rm(titles)


f = system.file("exampleData", "eurofxref-hist.xml.gz", package = "XML") 
 e = xmlParse(f)
 ans = getNodeSet(e, "//o:Cube[@currency='USD']", "o")
 sapply(ans, xmlGetAttr, "rate")

  # or equivalently
 ans = xpathApply(e, "//o:Cube[@currency='USD']", xmlGetAttr, "rate", namespaces = "o")



 你说的几种情况都有可能，也可能是包从CRAN转移的别的地方了，比如 github
这时候需要找到包，手动下载到本地，从本地安装，比如
https://github.com/R-Finance/quantstrat
install.packages("path/to/pack", repos=NULL, type="source")

install.packages("d:/quantstrat-master.zip", repos=NULL, type="source")