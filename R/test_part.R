#############################
##test part
#############################
range(BS_table2$Date)

per_jz<-c(1,3,5,7)
## quarters
test_date2000<-seq(as.Date("2000/1/1"), as.Date("2001/1/1"), by = "quarter")


BS_table2_xts<-as.xts(BS_table2,,dateFormat='Date')
close_plot<-ggplot(tail(BS_table2_xts,1000), aes(Date, close)) + geom_point(aes(colour = ind_type))

#close_plot+geom_line(aes(Date,close_mean_roll_50,color=1))+geom_line(aes(Date,close,color=2))
close_plot+
geom_line(aes(Date,close_mean_roll_50,colour="blue"))
close_plot<-ggplot(tail(BS_table2,1000), aes(Date, close)) + geom_point(aes(colour = ind_type))



#close_plot+geom_line(aes(Date,close_mean_roll_50,color=1))+geom_line(aes(Date,close,color=2))
close_plot+
geom_line(aes(Date,close_mean_roll_50,colour="blue"))



##link multi year report

seq(3,20)
ctable<-cbind(all_reports_en[[3]]$cwbl[[2]])

frm_merge_f_report <- function (year_id,START_REPORT,REPORT_SET){
 START_REPORT%>%cbind(REPORT_SET[[year_id]]$cwbl[[2]][,-1]) 

}
sapply(seq(3,20),)
ctable %>% htmlTable
ctable %>% cbind(all_reports_en[[19]]$cwbl[[2]][,-1]) %>% htmlTable
ctable %>% cbind(all_reports_en[[19]]$cwbl[[2]][,-1]) %>% htmlTable

frm_hexun_fin_table(600016,"cn",2005)
url<-"http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid=600016&type=1&date=2015.12.31"
#using htmlParse get url html content
url_html<-htmlParse(url)  
######################################################################################
# Then using getNodeSet or xpathApply to extract detail content
#####
# f = system.file("exampleData", "eurofxref-hist.xml.gz", package = "XML") 
# e = xmlParse(f)
# ans = getNodeSet(e, "//o:Cube[@currency='USD']", "o")
# sapply(ans, xmlGetAttr, "rate")
# # or equivalently
#xmlName() , xmlAttrs() , xmlGetAttr() , xmlChildren() and xmlValue() . xmlName()
# ans = xpathApply(e, "//o:Cube[@currency='USD']", xmlGetAttr, "rate", namespaces = "o")
# free(e)
######################################################################################

ans = getNodeSet(url_html , "//table//ul[1]/li")
sapply(ans, xmlValue)
#or
# get stock finance report peroid 


xpathApply(url_html , "//table//ul[1]/li",xmlValue)
#url_xml<-xmlTreeParse(url)




 #####
 f = system.file("exampleData", "eurofxref-hist.xml.gz", package = "XML") 
 e = xmlParse(f)
 ans = getNodeSet(e, "//o:Cube[@currency='USD']", "o")
 sapply(ans, xmlGetAttr, "rate")

  # or equivalently
 ans = xpathApply(e, "//o:Cube[@currency='USD']", xmlGetAttr, "rate", namespaces = "o")
 # free(e)

##sample html parse
 u = "http://tidesonline.nos.noaa.gov/data_read.shtml?station_info=9414290+San+Francisco,+CA"
 h = htmlParse(u)
 p = getNodeSet(h, "//pre")
 con = textConnection(xmlValue(p[[2]]))
 tides = read.table(con)


http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid=600016
http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid=600016&type=1&date=2015.12.31


http://stockdata.stock.hexun.com/2008/zxcwzb.aspx?stockid=600016&accountdate=2016.03.15
http://stockdata.stock.hexun.com/2008/zxcwzb.aspx?stockid=600016&accountdate=2015.12.31
http://stockdata.stock.hexun.com/2008/zxcwzb.aspx?stockid=600016&accountdate=2014.12.31

baby_gender_report <- function(gender)
{
 switch(
 gender,
 male = "It's a boy!" ,
 female = "It's a girl!" ,
 "Um..."
 )
}


Latest Financial
http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid
"http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx"

"http://stockdata.stock.hexun.com/2008/zxcwzb.aspx"


Financial Ratios
http://stockdata.stock.hexun.com/2008en/cwbl.aspx?stockid=600016&type=1&date=2002.12.31

http://stockdata.stock.hexun.com/2008/cwbl.aspx?stockid=600016&accountdate=2014.12.31

Balance sheet
http://stockdata.stock.hexun.com/2008en/zcfz.aspx?stockid=600016&type=1&date=2015.12.31
http://stockdata.stock.hexun.com/2008/zcfz.aspx?stockid=600016&accountdate=2015.12.31

Income Statement
http://stockdata.stock.hexun.com/2008en/lr.aspx?stockid=600016&type=1&date=2015.12.31
http://stockdata.stock.hexun.com/2008/lr.aspx?stockid=600016&accountdate=2015.12.31
Cash Flow
http://stockdata.stock.hexun.com/2008en/xjll.aspx?stockid=600016&type=1&date=2015.12.31
http://stockdata.stock.hexun.com/2008/xjll.aspx?stockid=600016&accountdate=2015.12.31




#combine data
alltable<-rbind(tb2016$xjll,tb2015$xjll[-1,])



url<-"http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid=600016"
tb<-readHTMLTable(url)
htmlTable(tb)


htmlTable(alltable)
library(htmlTable)


# A simple output
htmlTable(tb2016$xjll)

#
htmlTable(tb2016$xjll[-1,])


#lapply(dfxjl[1,],function(x) attr(x,"levels"))
#attr(dfxjl[1,]$V60,"levels")[2]

url <- 'http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid=600016&type=1&date=2015.12.31'
finance_tb_en<-t(tbls[[2]])

tbls <- readHTMLTable(url)
url <- 'http://stockdata.stock.hexun.com/2009_zxcwzb_600016.shtml'
finance_tb_cn<-t(tbls[[3]])


######################################

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


recursive_report<- function(n,all_reports_en){
	if ((n == 0) | (n == 1)){
		n=1
		out = cbind(all_reports_en[[n]]$cwbl[[2]])  
	  } else {
		out = cbind(recursive_report(n,all_reports_en),recursive_report(n-1,all_reports_en))   
	  }
	  return(out)
}

recursive_report(3,all_reports_en)%>% htmlTable 


recursive_test<- function(n){
	if ((n == 0) | (n == 1)){
		out = cbind(1)  
	  } else {
		out = cbind(recursive_test(n-1),recursive_test(n))   
	  }
	  return(out)
}
recursive_test(1)

recursive_test(20)



recursive <- function(n){
	sum = 0
	if (0 == n)
		return (1)
	else
		sum = n * recursive(n-1)
	return (sum)
}
recursive(3)



recursive <- function(n){
	if (0 == n){
		sum =cbind(all_reports_en[[1]]$cwbl[[2]])
		return (sum)
		}
	else
		sum = cbind(recursive(n-1),all_reports_en[[n]]$cwbl[[2]])
	return (sum)
}
recursive(6)%>% htmlTable 




############################################################

fileName <- system.file("exampleData", "test.xml", package="XML")
doc <- xmlTreeParse(fileName)
xmlElementsByTagName(doc$children[[1]], "variable")



>  doc <- xmlTreeParse(system.file("exampleData", "mtcars.xml", package="XML"))
>  xmlElementsByTagName(xmlRoot(doc)[[1]], "variable")
$variable
<variable unit="Miles/gallon">mpg</variable>

$variable
<variable>cyl</variable>

$variable
<variable>disp</variable>

$variable
<variable>hp</variable>

$variable
<variable>drat</variable>

$variable
<variable>wt</variable>

$variable
<variable>qsec</variable>

$variable
<variable>vs</variable>

$variable
<variable type="FactorVariable" levels="automatic,manual">am</variable>

$variable
<variable>gear</variable>

$variable
<variable>carb</variable>

> xmlRoot(doc)[[1]]
<variables count="11">
 <variable unit="Miles/gallon">mpg</variable>
 <variable>cyl</variable>
 <variable>disp</variable>
 <variable>hp</variable>
 <variable>drat</variable>
 <variable>wt</variable>
 <variable>qsec</variable>
 <variable>vs</variable>
 <variable type="FactorVariable" levels="automatic,manual">am</variable>
 <variable>gear</variable>
 <variable>carb</variable>
</variables>
> doc
$doc
$file
[1] "C:/Users/carlos/Documents/R/win-library/3.3/XML/exampleData/mtcars.xml"

$version
[1] "1.0"

$children
$children$comment
<!--Taken from the R distribution, in turn taken from Henderson and Velleman 1981, 
     Building multiple regression models interactively, Biometrics 37 391-411 .-->

$children$dataset
<dataset name="mtcars" numRecords="32" source="R Project">
 <variables count="11">
  <variable unit="Miles/gallon">mpg</variable>
  <variable>cyl</variable>
  <variable>disp</variable>
  <variable>hp</variable>
  <variable>drat</variable>
  <variable>wt</variable>
  <variable>qsec</variable>
  <variable>vs</variable>
  <variable type="FactorVariable" levels="automatic,manual">am</variable>
  <variable>gear</variable>
  <variable>carb</variable>
 </variables>
 <record id="Mazda RX4">21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4</record>
 <record id="Mazda RX4 Wag">21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4</record>
 <record id="Datsun 710">22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1</record>
 <record id="Hornet 4 Drive">21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1</record>
 <record id="Hornet Sportabout">18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2</record>
 <record id="Valiant">18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1</record>
 <record id="Duster 360">14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4</record>
 <record id="Merc 240D">24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2</record>
 <record id="Merc 230">22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2</record>
 <record id="Merc 280">19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4</record>
 <record id="Merc 280C">17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4</record>
 <record id="Merc 450SE">16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3</record>
 <record id="Merc 450SL">17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3</record>
 <record id="Merc 450SLC">15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3</record>
 <record id="Cadillac Fleetwood">10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4</record>
 <record id="Lincoln Continental">10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4</record>
 <record id="Chrysler Imperial">14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4</record>
 <record id="Fiat 128">32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1</record>
 <record id="Honda Civic">30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2</record>
 <record id="Toyota Corolla">33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1</record>
 <record id="Toyota Corona">21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1</record>
 <record id="Dodge Challenger">15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2</record>
 <record id="AMC Javelin">15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2</record>
 <record id="Camaro Z28">13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4</record>
 <record id="Pontiac Firebird">19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2</record>
 <record id="Fiat X1-9">27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1</record>
 <record id="Porsche 914-2">26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2</record>
 <record id="Lotus Europa">30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2</record>
 <record id="Ford Pantera L">15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4</record>
 <record id="Ferrari Dino">19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6</record>
 <record id="Maserati Bora">15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8</record>
 <record id="Volvo 142E">21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2</record>
</dataset>


attr(,"class")
[1] "XMLDocumentContent"

$dtd
$external
NULL

$internal
$elements
NULL

$entities
NULL

attr(,"class")
[1] "InternalDTD"

attr(,"class")
[1] "DTDList"

attr(,"class")
[1] "XMLDocument"         "XMLAbstractDocument"
> 
xmlElementSummary(fileName)
xmlElementSummary("C:/Users/carlos/Documents/R/win-library/3.3/XML/exampleData/mtcars.xml")


########################################

fileName <- system.file("exampleData", "mtcars.xml", package="XML")

   # Print the name of each XML tag encountered at the beginning of each
   # tag.
   # Uses the libxml SAX parser.
 xmlEventParse(fileName,
                list(startElement=function(name, attrs){
                                    cat(name,"\n")
                                  }),
                useTagName=FALSE, addContext = FALSE)


## Not run: 
  # Parse the text rather than a file or URL by reading the URL's contents
  # and making it a single string. Then call xmlEventParse
xmlURL <- "http://www.omegahat.net/Scripts/Data/mtcars.xml"
xmlText <- paste(scan(xmlURL, what="",sep="\n"),"\n",collapse="\n")
xmlEventParse(xmlText, asText=TRUE)

## End(Not run)

    # Using a state object to share mutable data across callbacks
f <- system.file("exampleData", "gnumeric.xml", package = "XML")
zz <- xmlEventParse(f,
                    handlers = list(startElement=function(name, atts, .state) {
                                                     .state = .state + 1
                                                     print(.state)
                                                     .state
                                                 }), state = 0)
print(zz)




    # Illustrate the startDocument and endDocument handlers.
xmlEventParse(fileName,
               handlers = list(startDocument = function() {
                                                 cat("Starting document\n")
                                               },
                               endDocument = function() {
                                                 cat("ending document\n")
                                             }),
               saxVersion = 2)




if(libxmlVersion()$major >= 2) {


 startElement = function(x, ...) cat(x, "\n")

 xmlEventParse(file(f), handlers = list(startElement = startElement))


 # Parse with a function providing the input as needed.
 xmlConnection = 
  function(con) {

   if(is.character(con))
     con = file(con, "r")
  
   if(isOpen(con, "r"))
     open(con, "r")

   function(len) {

     if(len < 0) {
        close(con)
        return(character(0))
     }

      x = character(0)
      tmp = ""
    while(length(tmp) > 0 && nchar(tmp) == 0) {
      tmp = readLines(con, 1)
      if(length(tmp) == 0)
        break
      if(nchar(tmp) == 0)
        x = append(x, "\n")
      else
        x = tmp
    }
    if(length(tmp) == 0)
      return(tmp)
  
    x = paste(x, collapse="")

    x
  }
 }

 ff = xmlConnection(f)
 xmlEventParse(ff, handlers = list(startElement = startElement))

  # Parse from a connection. Each time the parser needs more input, it
  # calls readLines(<con>, 1)
 xmlEventParse(file(f),  handlers = list(startElement = startElement))


  # using SAX 2
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
 xmlEventParse(system.file("exampleData", "namespaces.xml", package="XML"),
               handlers = h, saxVersion = 2)


 # This example is not very realistic but illustrates how to use the
 # branches argument. It forces the creation of complete nodes for
 # elements named <b> and extracts the id attribute.
 # This could be done directly on the startElement, but this just
 # illustrates the mechanism.
 filename = system.file("exampleData", "branch.xml", package="XML")
 b.counter = function() {
                nodes <- character()
                f = function(node) { nodes <<- c(nodes, xmlGetAttr(node, "id"))}
                list(b = f, nodes = function() nodes)
             }

  b = b.counter()
  invisible(xmlEventParse(filename, branches = b["b"]))
  b$nodes()


  filename = system.file("exampleData", "branch.xml", package="XML")
   
  invisible(xmlEventParse(filename, branches = list(b = function(node) {
                          print(names(node))})))
  invisible(xmlEventParse(filename, branches = list(b = function(node) {
                          print(xmlName(xmlChildren(node)[[1]]))})))
}

  
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
  xmlEventParse(fileName, handlers = list(startElement = startElement,
                                          endElement = endElement))
										  
										  

										  
xmlParseString("<a><b>c</b></a>")


doc <- xmlParse(system.file("exampleData", "mtcars.xml", package="XML"))
  n = xmlRoot(doc, skip = FALSE)
     # skip over the DTD and the comment
  d = getSibling(getSibling(n))
  
  
doc <- xmlTreeParse(system.file("exampleData", "mtcars.xml", package="XML"))
 r <- xmlRoot(doc)
 xmlSApply(r[[2]], xmlName)

 xmlApply(r[[2]], xmlAttrs)

 xmlSApply(r[[2]], xmlSize)

  xmlSource(system.file("exampleData", "Rsource.xml", package="XML"))
  
  
f = system.file("exampleData", "size.xml", package = "XML")
 xmlToDataFrame(f, c("integer", "integer", "numeric"))

   # Drop the middle variable.
 z = xmlToDataFrame(f, colClasses = list("integer", NULL, "numeric"))


   #  This illustrates how we can get a subset of nodes and process
   #  those as the "data nodes", ignoring the others.
  f = system.file("exampleData", "tides.xml", package = "XML")
  doc = xmlParse(f)
  xmlToDataFrame(nodes = xmlChildren(xmlRoot(doc)[["data"]]))

    # or, alternatively
  xmlToDataFrame(nodes = getNodeSet(doc, "//data/item"))


  f = system.file("exampleData", "kiva_lender.xml", package = "XML")
  doc = xmlParse(f)
  dd = xmlToDataFrame(getNodeSet(doc, "//lender"))
  
  tt = 
 '<x>
     <a>text</a>
     <b foo="1"/>
     <c bar="me">
        <d>a phrase</d>
     </c>
  </x>'

  doc = xmlParse(tt)
  xmlToList(doc)

   # use an R-level node representation
  doc = xmlTreeParse(tt)
  xmlToList(doc)

getNodeSet {XML}	R Documentation
Find matching nodes in an internal XML tree/DOM

Description

These functions provide a way to find XML nodes that match a particular criterion. It uses the XPath syntax and allows very powerful expressions to identify nodes of interest within a document both clearly and efficiently. The XPath language requires some knowledge, but tutorials are available on the Web and in books. XPath queries can result in different types of values such as numbers, strings, and node sets. It allows simple identification of nodes by name, by path (i.e. hierarchies or sequences of node-child-child...), with a particular attribute or matching a particular attribute with a given value. It also supports functionality for navigating nodes in the tree within a query (e.g. ancestor(), child(), self()), and also for manipulating the content of one or more nodes (e.g. text). And it allows for criteria identifying nodes by position, etc. using some counting operations. Combining XPath with R allows for quite flexible node identification and manipulation. XPath offers an alternative way to find nodes of interest than recursively or iteratively navigating the entire tree in R and performing the navigation explicitly.

One can search an entire document or start the search from a particular node. Such node-based searches can even search up the tree as well as within the sub-tree that the node parents. Node specific XPath expressions are typically started with a "." to indicate the search is relative to that node.

The set of matching nodes corresponding to an XPath expression are returned in R as a list. One can then iterate over these elements to process the nodes in whatever way one wants. Unfortunately, this involves two loops - one in the XPath query over the entire tree, and another in R. Typically, this is fine as the number of matching nodes is reasonably small. However, if repeating this on numerous files, speed may become an issue. We can avoid the second loop (i.e. the one in R) by applying a function to each node before it is returned to R as part of the node set. The result of the function call is then returned, rather than the node itself.

One can provide an R expression rather than an R function for fun. This is expected to be a call and the first argument of the call will be replaced with the node.

Dealing with expressions that relate to the default namespaces in the XML document can be confusing.

xpathSApply is a version of xpathApply which attempts to simplify the result if it can be converted to a vector or matrix rather than left as a list. In this way, it has the same relationship to xpathApply as sapply has to lapply.

matchNamespaces is a separate function that is used to facilitate specifying the mappings from namespace prefix used in the XPath expression and their definitions, i.e. URIs, and connecting these with the namespace definitions in the target XML document in which the XPath expression will be evaluated.

matchNamespaces uses rules that are very slightly awkard or specifically involve a special case. This is because this mapping of namespaces from XPath to XML targets is difficult, involving prefixes in the XPath expression, definitions in the XPath evaluation context and matches of URIs with those in the XML document. The function aims to avoid having to specify all the prefix=uri pairs by using "sensible" defaults and also matching the prefixes in the XPath expression to the corresponding definitions in the XML document.

The rules are as follows. namespaces is a character vector. Any element that has a non-trivial name (i.e. other than "") is left as is and the name and value define the prefix = uri mapping. Any elements that have a trivial name (i.e. no name at all or "") are resolved by first matching the prefix to those of the defined namespaces anywhere within the target document, i.e. in any node and not just the root one. If there is no match for the first element of the namespaces vector, this is treated specially and is mapped to the default namespace of the target document. If there is no default namespace defined, an error occurs.

It is best to give explicit the argument in the form c(prefix = uri, prefix = uri). However, one can use the same namespace prefixes as in the document if one wants. And one can use an arbitrary namespace prefix for the default namespace URI of the target document provided it is the first element of namespaces.

See the 'Details' section below for some more information.

Usage

getNodeSet(doc, path, namespaces = xmlNamespaceDefinitions(doc, simplify = TRUE), 
                    fun = NULL, sessionEncoding = CE_NATIVE, addFinalizer = NA, ...)
xpathApply(doc, path, fun, ... ,
            namespaces =  xmlNamespaceDefinitions(doc, simplify = TRUE),
              resolveNamespaces = TRUE, addFinalizer = NA)
xpathSApply(doc, path, fun = NULL, ... ,
             namespaces = xmlNamespaceDefinitions(doc, simplify = TRUE),
               resolveNamespaces = TRUE, simplify = TRUE, addFinalizer = NA)
matchNamespaces(doc, namespaces,
      nsDefs = xmlNamespaceDefinitions(doc, recursive = TRUE, simplify = FALSE),
      defaultNs = getDefaultNamespace(doc, simplify = TRUE))
Arguments

doc	
an object of class XMLInternalDocument

path	
a string (character vector of length 1) giving the XPath expression to evaluate.

namespaces	
a named character vector giving the namespace prefix and URI pairs that are to be used in the XPath expression and matching of nodes. The prefix is just a simple string that acts as a short-hand or alias for the URI that is the unique identifier for the namespace. The URI is the element in this vector and the prefix is the corresponding element name. One only needs to specify the namespaces in the XPath expression and for the nodes of interest rather than requiring all the namespaces for the entire document. Also note that the prefix used in this vector is local only to the path. It does not have to be the same as the prefix used in the document to identify the namespace. However, the URI in this argument must be identical to the target namespace URI in the document. It is the namespace URIs that are matched (exactly) to find correspondence. The prefixes are used only to refer to that URI.

fun	
a function object, or an expression or call, which is used when the result is a node set and evaluated for each node element in the node set. If this is a call, the first argument is replaced with the current node.

...	
any additional arguments to be passed to fun for each node in the node set.

resolveNamespaces	
a logical value indicating whether to process the collection of namespaces and resolve those that have no name by looking in the default namespace and the namespace definitions within the target document to match by prefix.

nsDefs	
a list giving the namespace definitions in which to match any prefixes. This is typically computed directly from the target document and the default value is most appropriate.

defaultNs	
the default namespace prefix-URI mapping given as a named character vector. This is not a namespace definition object. This is used when matching a simple prefix that has no corresponding entry in nsDefs and is the first element in the namespaces vector.

simplify	
a logical value indicating whether the function should attempt to perform the simplification of the result into a vector rather than leaving it as a list. This is the same as sapply does in comparison to lapply.

sessionEncoding	
experimental functionality and parameter related to encoding.

addFinalizer	
a logical value or identifier for a C routine that controls whether we register finalizers on the intenal node.

Details

When a namespace is defined on a node in the XML document, an XPath expressions must use a namespace, even if it is the default namespace for the XML document/node. For example, suppose we have an XML document <help xmlns="http://www.r-project.org/Rd"><topic>...</topic></help> To find all the topic nodes, we might want to use the XPath expression "/help/topic". However, we must use an explicit namespace prefix that is associated with the URI http://www.r-project.org/Rd corresponding to the one in the XML document. So we would use getNodeSet(doc, "/r:help/r:topic", c(r = "http://www.r-project.org/Rd")).

As described above, the functions attempt to allow the namespaces to be specified easily by the R user and matched to the namespace definitions in the target document.

This calls the libxml routine xmlXPathEval.

Value

The results can currently be different based on the returned value from the XPath expression evaluation:

list	
a node set

numeric	
a number

logical	
a boolean

character	
a string, i.e. a single character element.

If fun is supplied and the result of the XPath query is a node set, the result in R is a list.

Note

In order to match nodes in the default name space for documents with a non-trivial default namespace, e.g. given as xmlns="http://www.omegahat.net", you will need to use a prefix for the default namespace in this call. When specifying the namespaces, give a name - any name - to the default namespace URI and then use this as the prefix in the XPath expression, e.g. getNodeSet(d, "//d:myNode", c(d = "http://www.omegahat.net")) to match myNode in the default name space http://www.omegahat.net.

This default namespace of the document is now computed for us and is the default value for the namespaces argument. It can be referenced using the prefix 'd', standing for default but sufficiently short to be easily used within the XPath expression.

More of the XPath functionality provided by libxml can and may be made available to the R package. Facilities such as compiled XPath expressions, functions, ordered node information are examples.

Please send requests to the package maintainer.

Author(s)

Duncan Temple Lang <duncan@wald.ucdavis.edu>

References

http://xmlsoft.org, http://www.w3.org/xml http://www.w3.org/TR/xpath http://www.omegahat.net/RSXML

See Also

xmlTreeParse with useInternalNodes as TRUE.

Examples

 doc = xmlParse(system.file("exampleData", "tagnames.xml", package = "XML"))
 
 els = getNodeSet(doc, "/doc//a[@status]")
 sapply(els, function(el) xmlGetAttr(el, "status"))

   # use of namespaces on an attribute.
 getNodeSet(doc, "/doc//b[@x:status]", c(x = "http://www.omegahat.net"))
 getNodeSet(doc, "/doc//b[@x:status='foo']", c(x = "http://www.omegahat.net"))

   # Because we know the namespace definitions are on /doc/a
   # we can compute them directly and use them.
 nsDefs = xmlNamespaceDefinitions(getNodeSet(doc, "/doc/a")[[1]])
 ns = structure(sapply(nsDefs, function(x) x$uri), names = names(nsDefs))
 getNodeSet(doc, "/doc//b[@omegahat:status='foo']", ns)[[1]]

 # free(doc) 

 #####
 f = system.file("exampleData", "eurofxref-hist.xml.gz", package = "XML") 
 e = xmlParse(f)
 ans = getNodeSet(e, "//o:Cube[@currency='USD']", "o")
 sapply(ans, xmlGetAttr, "rate")

  # or equivalently
 ans = xpathApply(e, "//o:Cube[@currency='USD']", xmlGetAttr, "rate", namespaces = "o")
 # free(e)



  # Using a namespace
 f = system.file("exampleData", "SOAPNamespaces.xml", package = "XML") 
 z = xmlParse(f)
 getNodeSet(z, "/a:Envelope/a:Body", c("a" = "http://schemas.xmlsoap.org/soap/envelope/"))
 getNodeSet(z, "//a:Body", c("a" = "http://schemas.xmlsoap.org/soap/envelope/"))
 # free(z)


  # Get two items back with namespaces
 f = system.file("exampleData", "gnumeric.xml", package = "XML") 
 z = xmlParse(f)
 getNodeSet(z, "//gmr:Item/gmr:name", c(gmr="http://www.gnome.org/gnumeric/v2"))

 #free(z)

 #####
 # European Central Bank (ECB) exchange rate data

  # Data is available from "http://www.ecb.int/stats/eurofxref/eurofxref-hist.xml"
  # or locally.

 uri = system.file("exampleData", "eurofxref-hist.xml.gz", package = "XML")
 doc = xmlParse(uri)

   # The default namespace for all elements is given by
 namespaces <- c(ns="http://www.ecb.int/vocabulary/2002-08-01/eurofxref")


     # Get the data for Slovenian currency for all time periods.
     # Find all the nodes of the form <Cube currency="SIT"...>

 slovenia = getNodeSet(doc, "//ns:Cube[@currency='SIT']", namespaces )

    # Now we have a list of such nodes, loop over them 
    # and get the rate attribute
 rates = as.numeric( sapply(slovenia, xmlGetAttr, "rate") )
    # Now put the date on each element
    # find nodes of the form <Cube time=".." ... >
    # and extract the time attribute
 names(rates) = sapply(getNodeSet(doc, "//ns:Cube[@time]", namespaces ), 
                      xmlGetAttr, "time")

    #  Or we could turn these into dates with strptime()
 strptime(names(rates), "%Y-%m-%d")


   #  Using xpathApply, we can do
 rates = xpathApply(doc, "//ns:Cube[@currency='SIT']", xmlGetAttr, "rate", namespaces = namespaces )
 rates = as.numeric(unlist(rates))

   # Using an expression rather than  a function and ...
 rates = xpathApply(doc, "//ns:Cube[@currency='SIT']",
                   quote(xmlGetAttr(x, "rate")), namespaces = namespaces )

 #free(doc)

   #
  uri = system.file("exampleData", "namespaces.xml", package = "XML")
  d = xmlParse(uri)
  getNodeSet(d, "//c:c", c(c="http://www.c.org"))

  getNodeSet(d, "/o:a//c:c", c("o" = "http://www.omegahat.net", "c" = "http://www.c.org"))

   # since http://www.omegahat.net is the default namespace, we can
   # just the prefix "o" to map to that.
  getNodeSet(d, "/o:a//c:c", c("o", "c" = "http://www.c.org"))


   # the following, perhaps unexpectedly but correctly, returns an empty
   # with no matches
   
  getNodeSet(d, "//defaultNs", "http://www.omegahat.net")

   # But if we create our own prefix for the evaluation of the XPath
   # expression and use this in the expression, things work as one
   # might hope.
  getNodeSet(d, "//dummy:defaultNs", c(dummy = "http://www.omegahat.net"))

   # And since the default value for the namespaces argument is the
   # default namespace of the document, we can refer to it with our own
   # prefix given as 
  getNodeSet(d, "//d:defaultNs", "d")

   # And the syntactic sugar is 
  d["//d:defaultNs", namespace = "d"]


   # this illustrates how we can use the prefixes in the XML document
   # in our query and let getNodeSet() and friends map them to the
   # actual namespace definitions.
   # "o" is used to represent the default namespace for the document
   # i.e. http://www.omegahat.net, and "r" is mapped to the same
   # definition that has the prefix "r" in the XML document.

  tmp = getNodeSet(d, "/o:a/r:b/o:defaultNs", c("o", "r"))
  xmlName(tmp[[1]])


  #free(d)


   # Work with the nodes and their content (not just attributes) from the node set.
   # From bondsTables.R in examples/

  doc =
 htmlTreeParse("http://finance.yahoo.com/bonds/composite_bond_rates",
               useInternalNodes = TRUE)
  if(is.null(xmlRoot(doc))) 
     doc = htmlTreeParse("http://finance.yahoo.com/bonds", useInternalNodes = TRUE)

     # Use XPath expression to find the nodes 
     #  <div><table class="yfirttbl">..
     # as these are the ones we want.

  if(!is.null(xmlRoot(doc))) {

   o = getNodeSet(doc, "//div/table[@class='yfirttbl']")

    # Write a function that will extract the information out of a given table node.
   readHTMLTable =
   function(tb)
    {
          # get the header information.
      colNames = sapply(tb[["thead"]][["tr"]]["th"], xmlValue)
      vals = sapply(tb[["tbody"]]["tr"],  function(x) sapply(x["td"], xmlValue))
      matrix(as.numeric(vals[-1,]),
              nrow = ncol(vals),
              dimnames = list(vals[1,], colNames[-1]),
              byrow = TRUE
            )
    }  


     # Now process each of the table nodes in the o list.
    tables = lapply(o, readHTMLTable)
    names(tables) = lapply(o, function(x) xmlValue(x[["caption"]]))
  }


     # this illustrates an approach to doing queries on a sub tree
     # within the document.
     # Note that there is a memory leak incurred here as we create a new
     # XMLInternalDocument in the getNodeSet().

    f = system.file("exampleData", "book.xml", package = "XML")
    doc = xmlParse(f)
    ch = getNodeSet(doc, "//chapter")
    xpathApply(ch[[2]], "//section/title", xmlValue)

      # To fix the memory leak, we explicitly create a new document for
      # the subtree, perform the query and then free it _when_ we are done
      # with the resulting nodes.
    subDoc = xmlDoc(ch[[2]])
    xpathApply(subDoc, "//section/title", xmlValue)
    free(subDoc)


    txt =
'<top xmlns="http://www.r-project.org" xmlns:r="http://www.r-project.org"><r:a><b/></r:a></top>'
    doc = xmlInternalTreeParse(txt, asText = TRUE)

## Not run: 
     # Will fail because it doesn't know what the namespace x is
     # and we have to have one eventhough it has no prefix in the document.
    xpathApply(doc, "//x:b")

## End(Not run)    
      # So this is how we do it - just  say x is to be mapped to the
      # default unprefixed namespace which we shall call x!
    xpathApply(doc, "//x:b", namespaces = "x")

       # Here r is mapped to the the corresponding definition in the document.
    xpathApply(doc, "//r:a", namespaces = "r")
       # Here, xpathApply figures this out for us, but will raise a warning.
    xpathApply(doc, "//r:a")

       # And here we use our own binding.
    xpathApply(doc, "//x:a", namespaces = c(x = "http://www.r-project.org"))



       # Get all the nodes in the entire tree.
    table(unlist(sapply(doc["//*|//text()|//comment()|//processing-instruction()"],
    class)))




[Package XML version 3.98-1.4 Index]
 
 
 ##############################################
 x <- 1:50
case_when(
  x %% 35 == 0 ~ "fizz buzz",
  x %% 5 == 0 ~ "fizz",
  x %% 7 == 0 ~ "buzz",
  TRUE ~ as.character(x)
)

# Like an if statement, the arguments are evaluated in order, so you must
# proceed from the most specific to the most general. This won't work:
case_when(
  TRUE ~ as.character(x),
  x %%  5 == 0 ~ "fizz",
  x %%  7 == 0 ~ "buzz",
  x %% 35 == 0 ~ "fizz buzz"
)

####################

y <- c(1, 2, NA, NA, 5)
z <- c(NA, NA, 3, 4, 5)
coalesce(y, z)




select_helpers {dplyr}	R Documentation
Select helpers

Description

These functions allow you to select variables based on their names.

starts_with(): starts with a prefix

ends_with(): ends with a prefix

contains(): contains a literal string

matches(): matches a regular expression

num_range(): a numerical range like x01, x02, x03.

one_of(): variables in character vector.

everything(): all variables.

Usage

current_vars()

starts_with(match, ignore.case = TRUE, vars = current_vars())

ends_with(match, ignore.case = TRUE, vars = current_vars())

contains(match, ignore.case = TRUE, vars = current_vars())

matches(match, ignore.case = TRUE, vars = current_vars())

num_range(prefix, range, width = NULL, vars = current_vars())

one_of(..., vars = current_vars())

everything(vars = current_vars())
Arguments

match	
A string.

ignore.case	
If TRUE, the default, ignores case when matching names.

vars	
A character vector of variable names. When called from inside select() these are automatically set to the names of the table.

prefix	
A prefix that starts the numeric range.

range	
A sequence of integers, like 1:5

width	
Optionally, the "width" of the numeric range. For example, a range of 2 gives "01", a range of three "001", etc.

...	
One or more character vectors.

Value

An integer vector given the position of the matched variables.

Examples

iris <- tbl_df(iris) # so it prints a little nicer
select(iris, starts_with("Petal"))
select(iris, ends_with("Width"))
select(iris, contains("etal"))
select(iris, matches(".t."))
select(iris, Petal.Length, Petal.Width)
select(iris, everything())
vars <- c("Petal.Length", "Petal.Width")
select(iris, one_of(vars))
[Package dplyr version 0.5.0 Index]

if (require("RSQLite") && has_lahman("sqlite")) {

lahman_s <- lahman_sqlite()
batting <- tbl(lahman_s, "Batting")
batting %>% show_query()
batting %>% explain()

# The batting database has indices on all ID variables:
# SQLite automatically picks the most restrictive index
batting %>% filter(lgID == "NL" & yearID == 2000L) %>% explain()

# OR's will use multiple indexes
batting %>% filter(lgID == "NL" | yearID == 2000) %>% explain()

# Joins will use indexes in both tables
teams <- tbl(lahman_s, "Teams")
batting %>% left_join(teams, c("yearID", "teamID")) %>% explain()
}


filter(mtcars, cyl == 8)
filter(mtcars, cyl < 6)

# Multiple criteria
filter(mtcars, cyl < 6 & vs == 1)
filter(mtcars, cyl < 6 | vs == 1)

# Multiple arguments are equivalent to and
filter(mtcars, cyl < 6, vs == 1)



nth {dplyr}	R Documentation
Extract the first, last or nth value from a vector.

Description

These are straightforward wrappers around [[. The main advantage is that you can provide an optional secondary vector that defines the ordering, and provide a default value to use when the input is shorter than expected.

Usage

nth(x, n, order_by = NULL, default = default_missing(x))

first(x, order_by = NULL, default = default_missing(x))

last(x, order_by = NULL, default = default_missing(x))
Arguments

x	
A vector

n	
For nth_value, a single integer specifying the position. Negative integers index from the end (i.e. -1L will return the last value in the vector).

If a double is supplied, it will be silently truncated.

order_by	
An optional vector used to determine the order

default	
A default value to use if the position does not exist in the input. This is guessed by default for atomic vectors, where a missing value of the appropriate type is return, and for lists, where a NULL is return. For more complicated objects, you'll need to supply this value.

Value

A single value. [[ is used to do the subsetting.

Examples

x <- 1:10
y <- 10:1

nth(x, 1)
nth(x, 5)
nth(x, -2)
nth(x, 11)

last(x)
last(x, y)
[Package dplyr version 0.5.0 Index]


Create a list of functions calls.

Description

funs provides a flexible way to generate a named list of functions for input to other functions like summarise_each.

Usage

funs(...)

funs_(dots, args = list(), env = baseenv())
Arguments

dots, ...	
A list of functions specified by:

Their name, "mean"

The function itself, mean

A call to the function with . as a dummy parameter, mean(., na.rm = TRUE)

args	
A named list of additional arguments to be added to all function calls.

env	
The environment in which functions should be evaluated.

Examples

funs(mean, "mean", mean(., na.rm = TRUE))

# Overide default names
funs(m1 = mean, m2 = "mean", m3 = mean(., na.rm = TRUE))

# If you have function names in a vector, use funs_
fs <- c("min", "max")
funs_(fs)

x <- c(-5:5, NA)
if_else(x < 0, NA_integer_, x)
if_else(x < 0, "negative", "positive", "missing")

# Unlike ifelse, if_else preserves types
x <- factor(sample(letters[1:5], 10, replace = TRUE))
ifelse(x %in% c("a", "b", "c"), x, factor(NA))
if_else(x %in% c("a", "b", "c"), x, factor(NA))
# Attributes are taken from the `true` vector,


lead(1:10, 1)
lead(1:10, 2)

lag(1:10, 1)
lead(1:10, 1)

x <- runif(5)
cbind(ahead = lead(x), x, behind = lag(x))

# Use order_by if data not already ordered
df <- data.frame(year = 2000:2005, value = (0:5) ^ 2)
scrambled <- df[sample(nrow(df)), ]

wrong <- mutate(scrambled, prev = lag(value))
arrange(wrong, year)

right <- mutate(scrambled, prev = lag(value, order_by = year))
arrange(right, year)



mutate(mtcars, displ_l = disp / 61.0237)
transmute(mtcars, displ_l = disp / 61.0237)

mutate(mtcars, cyl = NULL)



############################################################
Description

summarise_all() and mutate_all() apply the functions to all (non-grouping) columns. summarise_at() and mutate_at() allow you to select columns using the same name-based select_helpers as with select(). summarise_if() and mutate_if() operate on columns for which a predicate returns TRUE. Finally, summarise_each() and mutate_each() are older variants that will be deprecated in the future.

Usage

summarise_all(.tbl, .funs, ...)

mutate_all(.tbl, .funs, ...)

summarise_if(.tbl, .predicate, .funs, ...)

mutate_if(.tbl, .predicate, .funs, ...)

summarise_at(.tbl, .cols, .funs, ...)

mutate_at(.tbl, .cols, .funs, ...)

summarize_all(.tbl, .funs, ...)

summarize_at(.tbl, .cols, .funs, ...)

summarize_if(.tbl, .predicate, .funs, ...)
Arguments

.tbl	
a tbl

.funs	
List of function calls generated by funs(), or a character vector of function names, or simply a function (only for local sources).

...	
Additional arguments for the function calls. These are evaluated only once.

.predicate	
A predicate function to be applied to the columns or a logical vector. The columns for which .predicate is or returns TRUE will be summarised or mutated.

.cols	
A list of columns generated by vars(), or a character vector of column names, or a numeric vector of column positions.

Value

A data frame. By default, the newly created columns have the shortest names needed to distinguish the output. To force inclusion of a name, even when not needed, name the input (see examples for details).

See Also

vars(), funs()

Examples

by_species <- iris %>% group_by(Species)

# One function
by_species %>% summarise_all(n_distinct)
by_species %>% summarise_all(mean)

# Use the _at and _if variants for conditional mapping.
by_species %>% summarise_if(is.numeric, mean)

# summarise_at() can use select() helpers with the vars() function:
by_species %>% summarise_at(vars(Petal.Width), mean)
by_species %>% summarise_at(vars(matches("Width")), mean)

# You can also specify columns with column names or column positions:
by_species %>% summarise_at(c("Sepal.Width", "Petal.Width"), mean)
by_species %>% summarise_at(c(1, 3), mean)

# You can provide additional arguments. Those are evaluated only once:
by_species %>% summarise_all(mean, trim = 1)
by_species %>% summarise_at(vars(Petal.Width), mean, trim = 1)

# You can provide an expression or multiple functions with the funs() helper.
by_species %>% mutate_all(funs(. * 0.4))
by_species %>% summarise_all(funs(min, max))
# Note that output variable name must now include function name, in order to
# keep things distinct.

# Function names will be included if .funs has names or whenever multiple
# functions are used.
by_species %>% mutate_all(funs("in" = . / 2.54))
by_species %>% mutate_all(funs(rg = diff(range(.))))
by_species %>% summarise_all(funs(med = median))
by_species %>% summarise_all(funs(Q3 = quantile), probs = 0.75)
by_species %>% summarise_all(c("min", "max"))

# Two functions, continued
by_species %>% summarise_at(vars(Petal.Width, Sepal.Width), funs(min, max))
by_species %>% summarise_at(vars(matches("Width")), funs(min, max))


 
 
 Windowed rank functions.

Description

Six variations on ranking functions, mimicing the ranking functions described in SQL2003. They are currently implemented using the built in rank function, and are provided mainly as a convenience when converting between R and SQL. All ranking functions map smallest inputs to smallest outputs. Use desc to reverse the direction..

Usage

row_number(x)

ntile(x, n)

min_rank(x)

dense_rank(x)

percent_rank(x)

cume_dist(x)
Arguments

x	
a vector of values to rank. Missing values are left as is. If you want to treat them as the smallest or largest values, replace with Inf or -Inf before ranking.

n	
number of groups to split up into.

Details

row_number: equivalent to rank(ties.method = "first")

min_rank: equivalent to rank(ties.method = "min")

dense_rank: like min_rank, but with no gaps between ranks

percent_rank: a number between 0 and 1 computed by rescaling min_rank to [0, 1]

cume_dist: a cumulative distribution function. Proportion of all values less than or equal to the current rank.

ntile: a rough rank, which breaks the input vector into n buckets.

Examples

x <- c(5, 1, 3, 2, 2, NA)
row_number(x)
min_rank(x)
dense_rank(x)
percent_rank(x)
cume_dist(x)

ntile(x, 2)
ntile(runif(100), 10)



group_by {dplyr}	R Documentation
Group a tbl by one or more variables.

Description

Most data operations are useful done on groups defined by variables in the the dataset. The group_by function takes an existing tbl and converts it into a grouped tbl where operations are performed "by group".

Usage

group_by(.data, ..., add = FALSE)

group_by_(.data, ..., .dots, add = FALSE)
Arguments

.data	
a tbl

...	
variables to group by. All tbls accept variable names, some will also accept functions of variables. Duplicated groups will be silently dropped.

add	
By default, when add = FALSE, group_by will override existing groups. To instead add to the existing groups, use add = TRUE

.dots	
Used to work around non-standard evaluation. See vignette("nse") for details.

Tbl types

group_by is an S3 generic with methods for the three built-in tbls. See the help for the corresponding classes and their manip methods for more details:

data.frame: grouped_df

data.table: grouped_dt

SQLite: src_sqlite

PostgreSQL: src_postgres

MySQL: src_mysql

See Also

ungroup for the inverse operation, groups for accessors that don't do special evaluation.

Examples

by_cyl <- group_by(mtcars, cyl)
summarise(by_cyl, mean(disp), mean(hp))
filter(by_cyl, disp == max(disp))

# summarise peels off a single layer of grouping
by_vs_am <- group_by(mtcars, vs, am)
by_vs <- summarise(by_vs_am, n = n())
by_vs
summarise(by_vs, n = sum(n))
# use ungroup() to remove if not wanted
summarise(ungroup(by_vs), n = sum(n))

# You can group by expressions: this is just short-hand for
# a mutate/rename followed by a simple group_by
group_by(mtcars, vsam = vs + am)
group_by(mtcars, vs2 = vs)

# You can also group by a constant, but it's not very useful
group_by(mtcars, "vs")

# By default, group_by sets groups. Use add = TRUE to add groups
groups(group_by(by_cyl, vs, am))
groups(group_by(by_cyl, vs, am, add = TRUE))

# Duplicate groups are silently dropped
groups(group_by(by_cyl, cyl, cyl))
[Package dplyr version 0.5.0 Index]



iris %>% select_if(is.factor)
iris %>% select_if(is.numeric)
iris %>% select_if(function(col) is.numeric(col) && mean(col) > 3.5)


select_if {dplyr}	R Documentation
Select columns using a predicate

Description

This verb is analogous to summarise_if() and mutate_if() in that it lets you use a predicate on the columns of a data frame. Only those columns for which the predicate returns TRUE will be selected.

Usage

select_if(.data, .predicate, ...)
Arguments

.data	
A local tbl source.

.predicate	
A predicate function to be applied to the columns or a logical vector. The columns for which .predicate is or returns TRUE will be summarised or mutated.

...	
Additional arguments passed to .predicate.

Details

Predicates can only be used with local sources like a data frame.

Examples

iris %>% select_if(is.factor)
iris %>% select_if(is.numeric)
iris %>% select_if(function(col) is.numeric(col) && mean(col) > 3.5)
[Package dplyr version 0.5.0 Index]



setops {dplyr}	R Documentation
Set operations.

Description

These functions override the set functions provided in base to make them generic so that efficient versions for data frames and other tables can be provided. The default methods call the base versions.

Usage

intersect(x, y, ...)

union(x, y, ...)

union_all(x, y, ...)

setdiff(x, y, ...)

setequal(x, y, ...)
Arguments

x, y	
objects to perform set function on (ignoring order)

...	
other arguments passed on to methods

Examples

mtcars$model <- rownames(mtcars)
first <- mtcars[1:20, ]
second <- mtcars[10:32, ]

intersect(first, second)
union(first, second)
setdiff(first, second)
setdiff(second, first)

union_all(first, second)
setequal(mtcars, mtcars[32:1, ])
[Package dplyr version 0.5.0 Index]


summarise {dplyr}	R Documentation
Summarise multiple values to a single value.

Description

Summarise multiple values to a single value.

Usage

summarise(.data, ...)

summarise_(.data, ..., .dots)

summarize(.data, ...)

summarize_(.data, ..., .dots)
Arguments

.data	
A tbl. All main verbs are S3 generics and provide methods for tbl_df, tbl_dt and tbl_sql.

...	
Name-value pairs of summary functions like min(), mean(), max() etc.

.dots	
Used to work around non-standard evaluation. See vignette("nse") for details.

Value

An object of the same class as .data. One grouping level will be dropped.

Data frame row names are silently dropped. To preserve, convert to an explicit variable.

Backend variations

Data frames are the only backend that supports creating a variable and using it in the same summary. See examples for more details.

See Also

Other single.table.verbs: arrange, filter, mutate, select, slice

Examples

summarise(mtcars, mean(disp))
summarise(group_by(mtcars, cyl), mean(disp))
summarise(group_by(mtcars, cyl), m = mean(disp), sd = sd(disp))

# With data frames, you can create and immediately use summaries
by_cyl <- mtcars %>% group_by(cyl)
by_cyl %>% summarise(a = n(), b = a + 1)

## Not run: 
# You can't with data tables or databases
by_cyl_dt <- mtcars %>% dtplyr::tbl_dt() %>% group_by(cyl)
by_cyl_dt %>% summarise(a = n(), b = a + 1)

by_cyl_db <- src_sqlite(":memory:", create = TRUE) %>%
  copy_to(mtcars) %>% group_by(cyl)
by_cyl_db %>% summarise(a = n(), b = a + 1)

## End(Not run)
[Package dplyr version 0.5.0 Index]


translate_sql {dplyr}	R Documentation
Translate an expression to sql.

Description

Translate an expression to sql.

Usage

translate_sql(..., con = NULL, vars = character(), vars_group = NULL,
  vars_order = NULL, window = TRUE)

translate_sql_(dots, con = NULL, vars = character(), vars_group = NULL,
  vars_order = NULL, window = TRUE)
Arguments

..., dots	
Expressions to translate. sql_translate automatically quotes them for you. sql_translate_ expects a list of already quoted objects.

con	
An optional database connection to control the details of the translation. The default, NULL, generates ANSI SQL.

vars	
A character vector giving variable names in the remote data source. If this is supplied, translate_sql will call partial_eval to interpolate in the values from local variables.

vars_group, vars_order	
Grouping and ordering variables used for windowed functions.

window	
Use FALSE to suppress generation of the OVER statement used for window functions. This is necessary when generating SQL for a grouped summary.

Base translation

The base translator, base_sql, provides custom mappings for ! (to NOT), && and & to AND, || and | to OR, ^ to POWER, %>% to %, ceiling to CEIL, mean to AVG, var to VARIANCE, tolower to LOWER, toupper to UPPER and nchar to length.

c and : keep their usual R behaviour so you can easily create vectors that are passed to sql.

All other functions will be preserved as is. R's infix functions (e.g. %like%) will be converted to their sql equivalents (e.g. LIKE). You can use this to access SQL string concatenation: || is mapped to OR, but %||% is mapped to ||. To suppress this behaviour, and force errors immediately when dplyr doesn't know how to translate a function it encounters, using set the dplyr.strict_sql option to TRUE.

You can also use sql to insert a raw sql string.

SQLite translation

The SQLite variant currently only adds one additional function: a mapping from sd to the SQL aggregation function stdev.

Examples

# Regular maths is translated in a very straightforward way
translate_sql(x + 1)
translate_sql(sin(x) + tan(y))

# Note that all variable names are escaped
translate_sql(like == "x")
# In ANSI SQL: "" quotes variable _names_, '' quotes strings

# Logical operators are converted to their sql equivalents
translate_sql(x < 5 & !(y >= 5))
# xor() doesn't have a direct SQL equivalent
translate_sql(xor(x, y))

# If is translated into case when
translate_sql(if (x > 5) "big" else "small")

# Infix functions are passed onto SQL with % removed
translate_sql(first %like% "Had*")
translate_sql(first %is% NULL)
translate_sql(first %in% c("John", "Roger", "Robert"))


# And be careful if you really want integers
translate_sql(x == 1)
translate_sql(x == 1L)

# If you have an already quoted object, use translate_sql_:
x <- quote(y + 1 / sin(t))
translate_sql_(list(x))

# Translation with known variables ------------------------------------------

# If the variables in the dataset are known, translate_sql will interpolate
# in literal values from the current environment
x <- 10
translate_sql(mpg > x)
translate_sql(mpg > x, vars = names(mtcars))

# By default all computations happens in sql
translate_sql(cyl == 2 + 2, vars = names(mtcars))
# Use local to force local evaluation
translate_sql(cyl == local(2 + 2), vars = names(mtcars))

# This is also needed if you call a local function:
inc <- function(x) x + 1
translate_sql(mpg > inc(x), vars = names(mtcars))
translate_sql(mpg > local(inc(x)), vars = names(mtcars))

# Windowed translation --------------------------------------------
# Known window functions automatically get OVER()
translate_sql(mpg > mean(mpg))

# Suppress this with window = FALSE
translate_sql(mpg > mean(mpg), window = FALSE)

# vars_group controls partition:
translate_sql(mpg > mean(mpg), vars_group = "cyl")

# and vars_order controls ordering for those functions that need it
translate_sql(cumsum(mpg))
translate_sql(cumsum(mpg), vars_order = "mpg")
[Package dplyr version 0.5.0 Index]


top_n {dplyr}	R Documentation
Select top (or bottom) n rows (by value).

Description

This is a convenient wrapper that uses filter and min_rank to select the top or bottom entries in each group, ordered by wt.

Usage

top_n(x, n, wt)
Arguments

x	
a tbl to filter

n	
number of rows to return. If x is grouped, this is the number of rows per group. Will include more than n rows if there are ties.

If n is positive, selects the top n rows. If negative, selects the bottom n rows.

wt	
(Optional). The variable to use for ordering. If not specified, defaults to the last variable in the tbl.

Examples

df <- data.frame(x = c(10, 4, 1, 6, 3, 1, 1))
df %>% top_n(2)

# Negative values select bottom from group. Note that we get more
# than 2 values here because there's a tie: top_n() either takes
# all rows with a value, or none.
df %>% top_n(-2)

if (require("Lahman")) {
# Find 10 players with most games
# A little nicer with %>%
tbl_df(Batting) %>%
  group_by(playerID) %>%
  tally(G) %>%
  top_n(10)

# Find year with most games for each player
tbl_df(Batting) %>% group_by(playerID) %>% top_n(1, G)
}
[Package dplyr version 0.5.0 Index]


# Set the seed
set.seed(100)
X <- rnorm(1000000, mean = 2.33, sd = 0.5)
mu <- mean(X)
sd <- sd(X)
hist(X, breaks = 100)
abline(v = mu, lwd = 3, lty = 2)

s a m p l e 5 < - s a m p l e ( X , 5 , r e p l a c e = T R U E )
s a m p l e 1 0 < - s a m p l e ( X , 1 0 , r e p l a c e = T R U E )
s a m p l e 5 0 < - s a m p l e ( X , 5 0 , r e p l a c e = T R U E )
s a m p l e 5
# # [ 1 ] 2 . 4 9 7 9 2 1 2 . 6 3 5 9 2 7 2 . 2 9 1 8 4 8 2 . 1 2 7 9 7 4 2 . 2 6 8 2 6 8
s a m p l e 1 0
# # [ 1 ] 2 . 0 6 4 4 5 1 2 . 2 7 4 4 6 4 2 . 4 6 8 9 3 8 1 . 8 0 0 0 0 7 2 . 5 5 7 6 6 9
# # [ 6 ] 2 . 5 3 5 2 4 1 1 . 3 3 1 0 2 0 1 . 1 5 9 1 5 1 1 . 6 6 1 7 6 2 2 . 2 8 5 8 8 9
s a m p l e 5 0
# # [ 1 ] 2 . 5 8 1 8 4 4 2 . 1 3 8 3 3 1 3 . 0 0 3 6 7 0 1 . 8 6 4 1 4 8 2 . 0 4 9 1 4 1
# # [ 6 ] 2 . 8 0 8 9 7 1 1 . 4 0 0 0 5 7 2 . 5 2 7 6 4 0 3 . 6 3 9 2 1 6 3 . 3 1 1 8 7 3
m e a n ( s a m p l e 5 )
# # [ 1 ] 2 . 3 6 4 3 8 8
m e a n ( s a m p l e 1 0 )
# # 2 . 0 1 3 8 5 9
m e a n ( s a m p l e 5 0 )
# # 2 . 4 4 7 0 0 3
m e a n ( s a m p l e ( X , 1 0 0 0 , r e p l a c e = T R U E ) )
# # 2 . 3 2 3 1 2 4
m e a n ( s a m p l e ( X , 1 0 0 0 0 , r e p l a c e = T R U E ) )
# # [ 1 ] 2 . 3 3 4 1 0 9


m e a n _ l i s t < - l i s t ( )
f o r ( i i n 1 : 1 0 0 0 0 ) {
m e a n _ l i s t [ [ i ] ] < - m e a n ( s a m p l e ( X , 1 0 , r e p l a c e = T R U E ) )
}
h i s t ( u n l i s t ( m e a n _l is t ), b r e a k s = 5 0 0 ,

x l a b = " M e a n o f 1 0 s a m p l e s f r o m X " ,
m a i n = " C o n v e r g e n c e o f s a m p l e d i s t r i b u t i o n " ,
c e x . m a i n = 0 . 8 )
a b l i n e ( v = m u , l w d = 3 , c o l = " w h i t e " , l t y = 2 )


population <- sample(c(0, 1), 100000, replace = TRUE)
hist(population, main = "Non-normal", cex.main = 0.8)
abline(v = mean(population), lwd = 3, lty = 3)
mean_list <- list()
for(i in 1:10000) {

m e a n _ l i s t [ [ i ] ] < - m e a n ( s a m p l e ( p o p ul a ti on , 1 0 , r e p l a c e = T R U E ) )
}
h i s t ( u n l i s t ( m e a n _l is t ), m a i n = " D i s t r i b u t i o n o f a v e r a g e s " ,
c e x . m a i n = 0 . 8 ,
x l a b = " A v e r a g e o f 1 0 s a m p l e s " )
a b l i n e ( v = 0 . 5 , l w d = 3 )