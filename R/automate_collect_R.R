library(XML)

url <- "http://www.r-datacollection.com/materials/html/fortunes.html"
# Discarding nodes
h1 <- list("body" = function(x){NULL})
parsed_fortunes <- htmlTreeParse(url, handlers = h1, asTree = TRUE)

# When using handler functions,
# one needs to set the asTree argument to TRUE to indicate that the DOM should be returned
# and not the handler function itself.


# Table 2.3 Generic handlers for DOM-style parsing
# Function name Node type
# s t a r t E l e m e n t ( ) XML element
# t e x t ( ) Text node
# c o m m e n t ( ) Comment node
# c d a t a ( ) <CDATA> node
# p r o c e s s i n g I n s t r u c t i o n ( ) Processing instruction
# n a m e s p a c e ( ) XML namespace
# e n t i t y ( ) Entity reference
# Source: Adapted from Nolan and Temple Lang (2014, p. 153).

# We start again by creating a list of handler functions.
# Inside this list, the fist handler element specifis a function for all XML nodes in the document
# (startElement). Handlers of that name allow describing functions that are executed on all
# nodes in the document. The function specifis a request for a node’s name (xmlName) and
# implements a control structure that returns the NULL object if the node’s name is either div
# or title (meaning we discard this node) or else includes the full node in the DOM tree. The
# second handler element (comment) specifis a function for discarding any


h2 <- list(
startElement = function(node, ...){
name <- xmlName(node)
if(name %in% c("div", "title")){NULL}else{node}
},
comment = function(node){NULL}

parsed_fortunes <- htmlTreeParse(file = url, handlers = h2, asTree = TRUE)

# The resulting
# vector then overwrites the existing container object by using the super assignment operator
# << − , which allows making an assignment to nonlocal variables. Lastly, we create a function
# called returnI() with the purpose of returning the container object just created:

getItalics = function() {
	i_container = character()
	list(i = function(node, ...) {
	i_container <<- c(i_container, xmlValue(node))
	}, returnI = function() i_container)
}

# Next, we execute getItalics() and route its return values into a new object h3.
# Essentially, h3 now contains our handler function, but additionally, the function can access
# i_container and returnI() as these two objects were created in the same environment
# as the handler function:
h3 <- getItalics()

invisible(htmlTreeParse(url, handlers = h3))


# For clarity, we employ the invisible() function to suppress printing of the DOM to the
# screen. To take a look at the fetched information we can make a call to h3() ’s returnI()
# function to print all the occurrences of <i> nodes in the document to the screen:
# 
h3$returnI()
# [1] "'What we have is nice, but we need something very different'"
# [2] "'R is wonderful, but it cannot work magic'"
# [3] "The book homepage"


# Table 3.1 Predefied entities in XML
# Character Entity reference Description
# < &lt; Less than
# > &gt; Greater than
# & &amp; Ampersand
# " &quot; Double quotation mark
# ' &apos; Single quotation mar

# Atom web feeds .atom
# RSS web feeds .rss
# EPUB open e-book .epub
# SVG vector graphics .svg
# KML geographic visualization .kml, .kmz
# GPX GPS data (waypoint, tracks, routes) .gpx
# Offie Open XML Microsoft Offie documents .docx, .pptx, .xlsx
# OpenDocument Apache OpenOffie documents .odt, .odp, .ods, .odg
# XHTML HTML extension and standardization .xhtml

# allowed structure, elements, attributes, and content. Table 3.2 lists some of the most popular
# XML derivations. Among them are languages for geographic applications like KML or GPX
# as well as for web feeds and widely used offie document formats. You might be surprised
# to fid that MS Word makes heavy use of XML. To gain basic insight into XML extensions
# that are ubiquitous on the Web, we focus on two popular XML markup languages—RSS
# and SVG.

# Really Simple Syndication

# Table 3.3 List of common RSS 2.0 elements and their meaning
# Element name Meaning
# root elements
# rss The feed’s root element
# channel A channel’s root element
# channel elements
# description* Short statement describing the feed
# link* URL of the feed’s website
# title* Name of the feed
# item The core information element: each item contains an entry of the feed
# item elements
# link* URL of the item
# title* Title of the item
# description* Short description of the item
# author Email address of the item’s author
# category Classifiation of item’s content
# enclosure Additional content, for example, audio
# guid Unique identifir of the item
# image Display of image (with children <url>, <title>, and <link>)
# language Language of the feed
# pubDate Publishing date of item
# source RSS source of the item
# ttl “Time-to-live,” number of minutes until the feed is refreshed from the
# RSS
# Elements marked with “*” are mandatory. For more information on RSS 2.0 specifiation, see
# http://www.rssboard.org/rss-specifiation

 # scalable vector graphics (SVG)
#  <html>
# <body>
# < s v g> < r e c t width="300" height="100"/> </svg>
# </body>
# </html>

library(XML)
parsed_stocks <- xmlParse(file = "stocks/technology.xml")

parsed_stocks <- xmlParse(file = "stocks/technology.xml", validate = TRUE)

stocks <- xmlParse(file = "stocks/technology-manip.xml", validate = TRUE)


# The XML package provides a set of other XML parsing functions, namely xmlTreeParse() ,
# xmlInternalTreeParse() , xmlNativeTreeParse() , and xmlEventParse() . As their names suggest, they
# differ in the way how the XML tree is parsed. xmlInternalTreeParse() and xmlNativeTreeParse() are
# equivalent to xmlParse() . Further, all are almost equivalent to xmlTreeParse() , except that the parser automatically relies on the internal nodes (the useInternalNodes parameter is set TRUE).

b o n d < - x m l P a r s e ( " b o n d . x m l " )
c l a s s ( b o n d )

# The top-level node is extracted with
# the xmlRoot() function; xmlName() and xmlSize() return the root element’s name and
# the number of children:

root <- xmlRoot(bond)
xmlName(root)
xmlSize(root)

x m l P a r s e ( " r s s c o d e . r s s " )

xmlSApply()

 xmlSApply(root[[1]], xmlValue)

 xmlSApply(root, xmlAttrs)
 xmlSApply(root, xmlGetAttr, "id")


 (movie.df <- xmlToDataFrame(root))

#  Note, however, that this function already runs into trouble with the <actoelement,
# which is itself empty except for two attributes. The corresponding variable in the data.frame
# object is left empty with a shrug.
# Similarly, a conversion into a list is possible with xmlToList() :

movie.list <- xmlToList(bond)

# SAX parsing (Simple API for XML).

branchFun <- function(){
container_close <- numeric()
container_date <- numeric()
"Apple" = function(node,...) {
date <- xmlValue(xmlChildren(node)[[c("date")]])
container_date <<- c(container_date, date)
close <- xmlValue(xmlChildren(node)[[c("close")]])
container_close <<- c(container_close, close)
#print(c(close, date));Sys.sleep(0.5)
}
getContainer <- function() data.frame(date=container_date,
close=container_close)
list(Apple=Apple, getStore=getContainer)
}

(h5 <- branchFun())
# We are now ready to run the SAX parser over our technology.xml fie using XML’s
# xmlEventParse() function. Instead of the handlers argument we will pass the handler function to the branches argument. The branches is a more general version of the
# handlers argument, which allows to specify functions over the entire node content, including its children. This is exactly what we need for this task since in our handler function h5
# we have been making use of the xmlChildren function for retrieving child information.
# Additionally, for the handlers argument we need to pass an empty list:
# 
invisible(xmlEventParse(file = "stocks/technology.xml",
branches = h5, handlers = list()))

To get an idea about the iterative traversal through the document, remove the commented
line in the handler and rerun the SAX parser. Finally, to fetch the information from the local
environment we employ the getStore() function and route the contents into a new object:
apple.stock <- h5$getStore()
To verify parsing success, we display the fist fie rows of the returned data frame:
head(apple.stock, 5)
# date close 1 2013/11/13 520.634 2 2013/11/12 520.01 3 2013/11/
11 519.048 4
# 2013/11/08 520.56 5 2013/11/07 512.492

# As we have seen, the event-driving parsing works and returns the correct information.
# Nonetheless, we do not recommend users to resort to this style of parsing as their preferred
# means to obtain data from XML documents. Although event-style parsing exceeds the DOMstyle parsing approach with respect to speed and may, in case of really large XML fies, be the
# only practical method, it necessitates a lot of code overhead as well as background knowledge
# on R functions and environments. Therefore, for the small- to medium-sized documents that
# we deal with in this book, in the coming chapters we will focus on the DOM-style parsing
# and extraction methods provided through the XPath query language (Chapter 4).


3.7 JSON syntax rules
JSON syntax is easy to learn. We only have to know (a) how brackets are used to structure
the data, (b) how keys and values are identifid and separated, and (c) which data types exist
and how they are used.
Brackets play a crucial role in structuring the document. As we see in the example data in
Figure 3.9, the whole document is enclosed in curly brackets. This is because indy movies
is the fist object that holds the three movie records in an array, that is, an ordered sequence.
Arrays are framed by square brackets. The movies, in turn, are also objects and therefore
enclosed by curly brackets. In general, brackets work as follows:
1. Curly brackets, “{ ” and “} ,” embrace objects. Objects work much like elements in
XML and can contain collections of key/value pairs, other objects, or arrays.

2. Square brackets, “ [” and “ ] ,” enclose arrays. An array is an ordered sequence of
objects or values.
Actual data are stored in key/value pairs. The rules for keys and values are
1. Keys are placed in double quotes, data are only placed in double quotes if they are
string data
1 "name" : "Indiana Jones and the Temple of Doom"
2 "year" : 1984
2. Keys and values are always separated by a colon
1 "year" : 1981
3. Key/value pairs are separated by commas
1 {"Indiana Jones": "Harrison Ford",
2 "Dr. Rene Belloq": "Paul Freeman"}
4. Values in an array are separated by commas
1 ["Frank Marshall", "George Lucas", "Howard Kazanjian"]
JSON allows a set of different data types for the value part of key/value pairs. They are
listed in Table 3.4.
Table 3.4 Data types in JSON
Data type Meaning
Number integer, real, or flating point (e.g., 1.3E10)
String white space, zero, or more Unicode characters (except " or \; \ introduces
some escape sequences)
Boolean true or false
Null null, an unknown value
Object content in curly brackets
Array ordered content in square brackets


unlist(options())
unlist(options(), use.names = FALSE)

l.ex <- list(a = list(1:5, LETTERS[1:5]), b = "Z", c = NA)
unlist(l.ex, recursive = FALSE)
unlist(l.ex, recursive = TRUE)

l1 <- list(a = "a", b = 2, c = pi+2i)
unlist(l1) # a character vector
l2 <- list(a = "a", b = as.name("b"), c = pi+2i)
unlist(l2) # remains a list

ll <- list(as.name("sinc"), quote( a + b ), 1:10, letters, expression(1+x))
utils::str(ll)
for(x in ll)
  stopifnot(identical(x, unlist(x)))




isValidJSON("indy.json")

indy <- fromJSON(content = "indy.json")


library(plyr)
indy.unlist <- sapply(indy[[1]], unlist)
indy.df <- do.call("rbind.fill", lapply(lapply(indy.unlist, t),
data.frame, stringsAsFactors = FALSE))

names(indy.df)



peanuts.json <- toJSON(peanuts.df, pretty = TRUE)
file.output <- file("peanuts_out.json")
writeLines(peanuts.json, file.output)
close(file.output)


library(XML)
parsed_doc <- htmlParse(file = "fortunes.html")


xpathSApply(doc = parsed_doc, path = "/html/body/div/p/i")
xpathSApply(parsed_doc, "//body//p/i")

xpathSApply(parsed_doc, "//p/i")
xpathSApply(parsed_doc, "/html/body/div/*/i")
xpathSApply(parsed_doc, "//title/..")	

Two further elements that we repeatedly make use of are the . and the .. operator. Selection
expressions
The . operator selects the current nodes (or self-axis) in a selected node set. This operation
is occasionally useful when using predicates. We postpone a detailed exploration of the .
operatortoSection4.2.3,wherewediscusspredicates.The.. operatorselectsthenodeone
levelupthehierarchyfromthecurrentnode.Thus,ifwewishtoselectthe<head> nodewe
could irstlocate itschild<title> and then goone level up thehierarchy:
xpathSApply(parsed_doc, "//title/..")

Lastly, we sometimes want to conduct multiple queries at once to extract elements that Multiple paths
lie at different paths. There are two principal methods to do this. The irst method is to use
the pipe operator ∣ to indicate several paths, which are evaluated individually and returned
together. For example, to select the <address> and the <title> nodes, we can use the
following statement:
xpathSApply(parsed_doc, "//address | //title")

AnotheroptionistostoretheXPathqueriesinavectorandpassthisvectortoxpathSAp-
ply(). Here, we irst generate a named vector twoQueries where the elements represent
the distinct XPath queries. Passing twoQueries toxpathSApply() we get
twoQueries <- c(address = "//address", title = "//title")
xpathSApply(parsed_doc, twoQueries)
node1/relation::node2,
xpathSApply(parsed_doc, "//a/ancestor::div")
xpathSApply(parsed_doc, "//a/ancestor::div//i")
xpathSApply(parsed_doc, "//p/preceding-sibling::h1")
xpathSApply(parsed_doc, "//title/parent::*")

Table 4.1 XPath axes
Axis name Result
ancestor Selects allancestors (parent, grandparent, etc.) of the
current node
ancestor-or-self Selects allancestors (parent, grandparent, etc.) of the
current node and the current node itself
attribute Selects allattributes of thecurrent node
child Selects allchildren of thecurrent node
descendant Selects alldescendants (children, grandchildren, etc.) of the
current node
descendant-or-self Selects alldescendants (children, grandchildren, etc.) of the
current node and the current node itself
following Selects everything inthedocument afterthe closing tagof
thecurrent node
following-sibling Selects allsiblings after thecurrent node
namespace Selects allnamespace nodes of thecurrent node
parent Selects theparent of the current node
preceding Selects allnodes that appear before thecurrent node inthe
document except ancestors, attributenodes, and
namespace nodes
preceding-sibling Selects allsiblings before thecurrent node
self Selects thecurrent node

//*[name()'title']
//*[text()='the book homepage']
//div[@id='R inv']
//h1[string-length()>11]
//div[translate(./@date,'203','205') = 'june/2005']
contains(@id,'eee')
substring-before
substring-after
not
//*[local-name() = 'address']
//div[count(.//a)=0]

//div/p[position()=1]
//div/p[last()]


∣ Computes two node sets //i | //b
+ Addition 5+3
- Subtraction 8-2
* Multiplication 8*5
div Division 8 div 5
= Equal count = 27
!= Not equal count != 27
< Less than count < 27
≤ Less than orequal to count <= 27
> Greater than count > 27
≥ Greater than or equal to count >= 27
or Or count = 27 or count = 28
and And count > 26 and count < 30
mod Modulo (division remainder) 7 mod 2

xpathSApply(parsed_doc, "//div/p[position()=1]")

xpathSApply(parsed_doc, "//div/p[last()]")

xpathSApply(parsed_doc, "//div/p[last()-1]")

xpathSApply(parsed_doc, "//div[count(.//a)>0]")

 xpathSApply(parsed_doc, "//div[count(./@*)>2]")
 xpathSApply(parsed_doc, "//*[string-length(text())>50]")
 xpathSApply(parsed_doc, "//div[not(count(./@*)>2)]")
 
 xpathSApply(parsed_doc, "//div[@date='October/2011']")
 xpathSApply(parsed_doc, "//*[contains(text(), 'magic')]")
 
 xpathSApply(parsed_doc, "//div[starts-with(./@id, 'R')]")
 xpathSApply(parsed_doc, "//div[substring-after(./@date, '/')='2003']//i")
 xpathSApply(parsed_doc, "//title", fun = xmlValue)
 
 xpathSApply(parsed_doc, "//div", xmlAttrs)
 
  xpathSApply(parsed_doc, "//div", xmlGetAttr, "lang")
  xmlName Node name
xmlValue Node value
xmlGetAttr name Node attribute
xmlAttrs (All)node attributes
xmlChildren Node children
xmlSize Node size

Extendingthefun argument

lowerCaseFun <- function(x) {
x <- tolower(xmlValue(x))
x}
xpathSApply(parsed_doc, "//div//i", fun = lowerCaseFun)



dateFun <- function(x) {
require(stringr)
date <- xmlGetAttr(node = x, name = "date")
year <- str_extract(date, "[0-9]{4}")
year
}
xpathSApply(parsed_doc, "//div", dateFun)

idFun <- function(x) {
id <- xmlGetAttr(x, "id")
id <- ifelse(is.null(id), "not specified", id)
return(id)
}

xpathSApply(parsed_doc, "//div", idFun)

parsed_stocks <- xmlParse(file = "technology.xml")
companies <- c("Apple", "IBM", "Google")
(expQuery <- sprintf("//%s/close", companies))

getClose <- function(node) {
value <- xmlValue(node)
company <- xmlName(xmlParent(node))
mat <- c(company = company, value = value)
}

stocks <- as.data.frame(t(xpathSApply(parsed_stocks, expQuery, getClose)))
stocks$value <- as.numeric(as.character(stocks$value))
head(stocks, 3)

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE presidents SYSTEM "presidents.dtd">
<root xmlns:h="http://www.w3.org/1999/xhtml" xmlns:t="http://
funnybooknames.com/crockford">
<h:head>
<h:title>Basic HTML Sample Page</h:title>
</h:head>
<t:book id="1">
<t:author>Douglas Crockford</t:author>
<t:title>JavaScript: The Good Parts</t:title>
</t:book>
</root>

parsed_xml <- xmlParse("titles.xml")

xpathSApply(parsed_xml, "//title", fun = xmlValue)

xpathSApply(parsed_xml, "//*[local-name()='title']", xmlValue)

xpathSApply(parsed_xml, "//x:title", namespaces = c(x = "http://
funnybooknames.com/crockford"),
fun = xmlValue)

xpathSApply(parsed_xml, "//x:title", namespaces = c(x = "http://
www.w3.org/1999/xhtml"),
fun = xmlValue)

nsDefs <- xmlNamespaceDefinitions(parsed_xml)[[2]]
ns <- nsDefs$uri
ns
[1] "http://funnybooknames.com/crockford"

xpathSApply(parsed_xml, "//x:title", namespaces = c(x = ns), xmlValue)
[1] "JavaScript: The Good Parts"

http://selectorgadget.com/

follows:
scheme://hostname:port/path?querystring#fragment
A corresponding real-life example would be
http://www.w3.org:80/People/Berners-Lee/#Bio

https://www.google.com/search?q=RCurl+filetype%3Ap

q=RCurl+filetype%3Apdf

actual request written in the search form as “RCurl filetype:pdf,” a compact syntax to search
for PDF files that include the term “RCurl.” One could easily extend the request with further
search parameters such as tbs=qdr:y . This would limit the results to hits that are younger
than one year. 8

RCurl filetype:pdf” is converted to
q=RCurl+filetype%3Apdf .

URLencode()
and URLdecode() in R . The reserved argument in the former function ensures that non-
alphanumeric characters are encoded with their percent-encoding representation:

t <- "I'm Eddie! How are you & you? 1 + 1 = 2"
(url <- URLencode(t, reserve = TRUE))
URLdecode(url)


[method] [path] [version] [CRLF] Start line
[header name:] [CRLF]
[CRLF] Header
[header value]
[body]
107
Body
POST /greetings.html HTTP/1.1
Host:
www.r-datacollection.com
Hi, there.
How are you?
Figure 5.2 HTTP request schema
Schema
Example
[version] [status] [phrase] [CRLF] Start line
[header name:] [CRLF]
[CRLF] Header
[body]
[header value]
Body
HTTP/1.1 200 OK
Content-type:
text/plain
I am fine, thank you very much.
What else might I help you with?

MIME type specification (Multipurpose Internet Mail Extensions).
types tell the client or server which type of data it should expect. They follow a scheme of
main-type/sub-type. Main types are, for example, application, audio, image, text, and video
with subtypes like application/pdf, audio/mpg, audio/ogg, image/gif, image/jpeg, image/png,
text/plain, text/html, text/xml, video/mp4, video/quicktime, and many more. 1

108
AUTOMATED DATA COLLECTION WITH R
Table 5.1 Common HTTP request methods
Method Description
GET
POST Retrieves resource from server
Retrieves resource from server using the message body to
send data or files to the server
Works like GET, but server responds only with start line
and header, no body
Stores the body of the request message on the server
Deletes a resource from the server
Traces the route of the message along its way to the server
Returns list of supported HTTP methods
Establishes a network connection


5.1.4
Request methods
When initiating HTTP client requests, we can choose among several request methods—see
Table 5.1 for an overview. The two most important HTTP methods are GET and POST. Both
methods request a resource from the server, but differ in the usage of the body. Whereas
GET does not send anything in the body of the request, POST uses the body to send data. In
practice, simple requests for HTML documents and other files are usually executed with the
GET method. Conversely, POST is used to send data to the server, like a file or inputs from
an HTML form.
If we are not interested in content from the server we can use the HEAD method. HEAD
tells the server to only send the start line and the headers but not transfer the requested
resource, which might be convenient to test if our requests are accepted. Two more handy
methods for testing are OPTIONS, which asks the server to send back the methods it supports
and TRACE, which requests the list of proxy servers (see Section 5.2.3) the request message
has passed on its way to the server.
Last but not least there are two methods for uploading files to and deleting files from
a server—PUT and DELETE—as well as CONNECT, a method for establishing an HTTP
connection that might be used, for example, for SSL tunneling (see Section 5.3.1).
We will elaborate the methods GET and POST, the two most important methods for web
scraping, when we discuss HTTP in action (see Section 5.4).

5.1.5
Status codes
When a server responds to a request, it will always send back a status code in the start line
of the response. The most famous response that nearly everybody knows from browsing the
Web is 404, stating that the server could not find the requested document. Status codes can
range from 100 up to 599 and follow a specific scheme: the leading digit signifies the status
category—1xx for informations, 2xx for success, 3xx for redirection, 4xx for client errors
and 5xx for server errors—see Table 5.2 for a list of common status codes.


Table 5.2 Common HTTP status codes
Code Phrase Description
200
202 OK
Accepted 204 No Content Everything is fine
The request was understood and accepted but no
further actions have yet taken place
The request was understood and accepted but no
further data needs to be returned except for
potentially updated header information
300 Multiple Choices 301 Moved Permanently 302
303
304 Found
See Other
Not Modified 305 Use Proxy 400
401
403 Bad Request
Unauthorized
Forbidden 404
405 Not Found
Method Not Allowed 406 Not Acceptable 500 Internal Server Error 501
502 Not Implemented
Bad Gateway 503
504 Service Unavailable
Gateway Timeout 505 HTTP Version Not
Supported
The request was understood and accepted but the
request applies to more than one resource
The requested resource has moved, the new location is
included in the response header Location
Similar to Moved Permanently but temporarily
Redirection to the location of the requested resource
Response to a conditional request stating that the
requested resource has not been changed
To access the requested resource a specific proxy
server found in the Location header should be used
The request has syntax errors
The client should authenticate itself before progressing
The server refuses to provide the requested resource
and does not give any further reasons
The server could not find the resource
The method in the request is not allowed for the
specific resource
The server has found no resource that conforms to the
resources accepted by the client
The server has encountered some internal error and
cannot provide the requested resource
The server does not support the request method
The server acting as intermediate proxy or gateway got
a negative response forwarding the request
The server can temporarily not fulfill the request
The server acting as intermediate proxy or gateway got
no response to its forwarded request
The server cannot or refuses to support the HTTP
version used in the request




We can use this string to configure a GET request that we conduct with the getURL()
function of the RCurl package:
cat(getURL("http://httpbin.org/headers",
useragent = str_c(R.version$platform,
R.version$version.string,
sep=", ")))

{
"headers": {
"X-Request-Id": "0726a0cf-a26a-43b9-b5a4-9578d0be712b",
"User-Agent": "x86_64-w64-mingw32, R version 3.0.2 (2013-09-25)",
"Connection": "close",
"Accept": "*/*",
"Host": "httpbin.org"
}
}

getURL("http://httpbin.org/headers", httpheader = c(From =
"eddie@r-collection.com"))

(secret <- base64("This is a secret message"))
[1] "VGhpcyBpcyBhIHNlY3JldCBtZXNzYWdl"
attr(,"class")
[1] "base64"
base64Decode(secret)
[1] "This is a secret message"


to the request command. In the following, we choose a fictional proxy from Poland that has
the IP address 109.205.54.112 and is on call on port 8080:
getURL("http://httpbin.org/headers",
R>
proxy = "109.205.54.112:8080",
R>
followlocation = TRUE)
IP address and port of the proxy are specified in the proxy option. Further, we set
the followlocation argument to TRUE to ensure that we are redirected to the desired
resource.

5.3
Protocols beyond HTTP
HTTP is far from the only protocol for data transfer over the Internet. To get an overview of
the protocols that are currently supported by the RCurl package, we call
library(RCurl)
curlVersion()$protocols
[1] "tftp"
"ftp"
"telnet" "dict"
[8] "file"
"https" "ftps"
"scp"
"ldap"
"sftp"
"ldaps"
"http"
Not all of them are relevant for web scraping purposes. In the following, we will high-
light two protocols that we often encounter when browsing and scraping the Web: HTTPS
and FTP.
5.3.1
HTTP Secure
Strictly speaking, the Hypertext Transfer Protocol Secure (HTTPS) is not a protocol of
its own, but the result of a combination of HTTP with the SSL/TLS (Secure Sockets
Layer/Transport Security Layer) protocol. HTTPS is indispensable when it comes to the
transfer of sensitive data, as is the case in banking or online shopping. To transfer money or
credit card information we need to ensure that the information is inaccessible to third parties.
HTTPS encrypts all the client–server communication (see Figure 5.5). HTTPS URLs have
the scheme https and use the port 443 by default. 1

1. The client establishes a TCP connection to the server via port 443 and sends information
about the SSL version and cipher settings.
2. The server sends back information about the SSL and cipher settings. The server also
proves his identity by sending a certificate. This certificate includes information about
the authority that issued the certificate, for whom it was issued and its period of validity.
As anybody can create his or her own certificates without much effort, the signature of
a trusted certificate authority (CA) is of great importance. There are many commercial
CAs, but some providers also issue certificates for free.
3. The client checks if it trusts the certificate. Browsers and operating systems are shipped
with lists of certificate authorities that are automatically trusted. If one of these author-
ities has signed the server’s certificate, the client trusts the server. If this is not the
case, the browser asks the user whether she finds the server trustworthy and wants to
continue, or if communication should be stopped.
4. By using the public key of the HTTPS server, the client generates a session key that
only the server can read, and sends it to the server.
5. The server decrypts the session key.
6. Both client and server now possess a session key. Thus, knowledge about the key is not
asymmetric anymore but symmetric. This reduces computational costs that are needed
for encryption. Future data transfers from server to client and vice versa are encrypted
and decrypted through this symmetric SSL tunnel.
It is important to note that what is protected is the content of communication. This
includes HTTP headers, cookies, and the message body. What is not protected, however, are
IP addresses, that is, websites a client communicates with.
We will address how connections via HTTPS are established in R and how much of the
technical details are hidden deeply in the respective functions in Section 9.1.7—using HTTPS
with R is not difficult at all.


Base R already comes with basic functionality for downloading web resources. The
download.file() function handles many download procedures where we do not need
complex modifications of the HTTP request. Further, there is a set of basic functions to set
up and manipulate connections. For an overview, type ?connections in R . However, using
these functions is anything but convenient. Regarding download.file() , there are two
major drawbacks for sophisticated web scraping. First, it is not very flexible. We cannot use
it to connect with a server via HTTPS, for example, or to specify additional headers. Second,
it is difficult to adhere to our standards of friendly web scraping with download.file() ,
as it lacks basic identification facilities. However, if we just want to download single files,
download.file() works perfectly fine. For more complex tasks, we can apply the func-
tionality of the RCurl and the httr package.

names(getCurlOptionsConstants())

5.4.2.1 The GET method
High-level In order to perform a basic GET request to retrieve a resource from a web server, the
functions RCurl package provides some high-level functions— getURL() , getBinaryURL() , and
getURLContent() . The basic function is getURL() ; getBinaryURL() is convenient when
the expected content is binary, and getURLContent() tries to identify the type of content
in advance by inspecting the Content-Type field in the response header and proceeding
adequately. While this seems preferable, the configuration of getURLContent() is some-
times more sophisticated, so we continue to use getURL() by default except when we expect
binary content.
The function automatically identifies the host, port, and requested resource. If the call
succeeds, that is, if the server gives a 2XX response along with the body, the function
returns the content of the response. Note that if everything works fine, all of the negotia-
tion between R /libcurl and the server is hidden from us. We just have to pass the desired
URL to the high-level function. For example, if we try to fetch helloworld.html from
www.r-datacollection.com/materials/http, we type
getURL("http://www.r-datacollection.com/materials/http/helloworld.html")
[1] "<html> \ n<head><title>Hello World</title></head> \ n<body><h3>Hello World
</h3> \ n</body> \ n</html>"

pngfile <- getBinaryURL("http://www.r-datacollection.com/materials/http/
sky.png")
It depends on the format how we can actually process it; in our case we use the
writeBin() function to locally store the file:
writeBin(pngfile, "sky.png")


specify the arguments of an HTML form. The first is to construct the URL manually using
paste() and to pass it to the getURL() function:
R>
R>
R>
R>
url <- "http://www.r-datacollection.com/materials/http/GETexample.php"
namepar <- "Eddie"
agepar <- "32"
url_get <- str_c(url, "?", "name=", namepar, "&", "age=", agepar)
cat(getURL(url_get))
Hello Eddie!
You are 32 years old.

An easier way than using getURL() and constructing the GET form request manually is
to use getForm() , which allows specifying the parameters as separate values in the function.
This is our preferred procedure as it simplifies modifying the call and does not require manual
URL encoding (see Section 5.1.2). In order to get the same result as above, we write
url <- "http://www.r-datacollection.com/materials/http/GETexample.php"
cat(getForm(url, name = "Eddie", age = 32))
Hello Eddie!
You are 32 years old.


<form action="GETexample.php" method="get">
Name: <input type="text" name="name" value="Anny Omous"><br>
Age: <input type="number" name="age" value="23"><br><br>
<input type="submit" value="Send Form and Evaluate"><br><br>
<input type="submit" value="Send Form and Return Request" name="return">
</form>
</body>
</html>

url <- "http://www.r-datacollection.com/materials/http/POSTexample.php"
cat(postForm(url, name = "Eddie", age = 32, style = "post"))
Hello Eddie!
You are 32 years old.

<!DOCTYPE HTML>
<html>
<head>
<title>HTTP POST Example</title></head>
<body>
<h3>HTTP POST Example</h3>
<form action="POSTexample.php" method="post">
Name: <input type="text" name="name" value="Anny Omous"><br>
Age: <input type="number" name="age" value="23"><br><br>
<input type="submit" value="Send Form and Evaluate" name="send"><br><br>
<input type="submit" value="Send Form and Return Request" name="return">
</form>
</body>
</html>


url <- "r-datacollection.com/materials/http/helloworld.html"
res <- getURL(url = url, customrequest = "HEAD", header = TRUE)
cat(str_split(res, " \ r")[[1]])
HTTP/1.1 200 OK
Date: Wed, 26 Mar 2014 00:20:07 GMT
Server: Apache
Vary: Accept-Encoding
Content-Type: text/html

url <- "www.r-datacollection.com/materials/http/helloworld.html"
(pres <- curlPerform(url = url))


pres <- NULL
performOptions <- curlOptions(url = url,
writefunc = function(con) pres <<- con )
curlPerform(.opts = performOptions)
OK
0
pres
[1] "<html> \ n<head><title>Hello World</title></head> \ n<body><h3>Hello
World</h3> \ n</body> \ n</html>"


Task
RCurl function/option
httr function
HTTP methods (verbs)
Specify GET request
getURL(),
getURLContent(),
getForm()
postForm()
httpHEAD()
httpPUT()
Specify POST request
Specify HEAD request
Specify PUT request
GET()
POST()
HEAD()
PUT()
Content extraction
Extract raw or character content
from response
content <-
getURLContent()
content()
Curl handle specification
Specify curl handle
getCurlHandle() , curl
handle()

Request configuration
Specify curl options
Specify glocal curl options
.opts
options(RCUrlOptions =
list()) , .opts
Execute code with curl options
Add headers to request
Authenticate via one type of
HTTP authentication
Specify proxy connection
Specify User-Agent header field
Specify cookies
config()
set_config()
httpheaders
userpwd with_config()
add_headers()
authenticate()
proxy
useragent
cookiefile use_proxy()
user_agent()
set_cookies()
Error and exception handling
Display HTTP status code
getCurlInfo(handle)
$response.code
Display R error if request fails
Display R warning if request fails
Return TRUE if returned status
code is exactly 200
Return TRUE if returned status
url.exists()
code is in the 200s
Set maximum request time
timeout
Provide more information about
verbose
client–server communication
http_status()
stop_for_status()
warn_for_status()
url_ok()
url_success
timeout()
verbose()
Table 5.4 (Continued)
Task
RCurl function/option
httr function
URL modification
Parse URL into constituent
components
Replace components in parsed
URL
Build URL string from parsed
URL
parse_url()
modify_url()
build_url()
OAuth registration
Retrieve OAuth 1.0 access token
Retrieve OAuth 2.0 access token
Register OAuth application
Describe Oauth endpoint
Sign Oauth 1.0 request
Sign Oauth 2.0 request
oauth1.0_token()
oauth2.0_token()
oauth_app()
oauth_endpoint()
sign_oauth1.0()
sign_oauth2.0()


# loading package
library(RSQLite)
# establish connection
sqlite <- dbDriver("SQLite")
con <- dbConnect(sqlite, "birthdays.db")
# 'plain' SQL
sql <- "SELECT * FROM birthdays"
res <- dbGetQuery(con, sql)
res
nameid firstname lastname
birthday
1
1
Peter
Pascal 1991-02-01
2
2
Paul
Panini 1992-03-02
3
3
Mary
Meyer 1993-04-03
res <- dbSendQuery(con, sql)
fetch(res)
nameid firstname lastname
birthday
1
1
Peter
Pascal 1991-02-01
2
2
Paul
Panini 1992-03-02
3
3
Mary
Meyer 1993-04-03

functions for getting an overview of the database properties— dbGetInfo() —and the tables
that are provided— dbListTables() :
# general information
dbGetInfo(con)[2]
$serverVersion
[1] "3.7.17"
# listing tables
dbListTables(con)
[1] "birthdays"
"foodranking"
"foodtypes"
"sqlite_sequence"
There are also functions for reading, writing, and removing tables, which are as convenient
as they are self-explanatory: dbReadTable() , dbWriteTable() , dbExistsTable() , and
dbRemoveTable() .
# reading tables
res <- dbReadTable(con,
res
nameid firstname lastname
1
1
Peter
Pascal
2
2
Paul
Panini
3
3
Mary
Meyer
"birthdays")
birthday
1991-02-01
1992-03-02
1993-04-03
# writing tables
dbWriteTable(con, "test", res)
[1] TRUE
# table exists?
dbExistsTable(con, "test")
[1] TRUE
# remove table
dbRemoveTable(con, "test")
[1] TRUE
To check the data type an R object would be assigned if stored in a database, we use
dbDataType() :
# checking data
dbDataType(con,
[1] "INTEGER"
dbDataType(con,
[1] "TEXT"
dbDataType(con,
[1] "TEXT"
type
res$nameid)
res$firstname)
res$birthday)
We can also start, revert, and commit transactions as well as close a connection to a
DBMS:
# transaction management
dbBeginTransaction(con)
[1] TRUE
dbRollback(con)

[1] TRUE
dbBeginTransaction(con)
[1] TRUE
dbCommit(con)
[1] TRUE
# closing connection
dbDisconnect(con)
[1] TRUE

# reading package
require(RODBC)
# establishing connection
con <- odbcConnect("db1")
# 'plain' SQL
sql <- "SELECT * FROM birthdays ;"
res <- sqlQuery(con, sql)
res
nameid firstname lastname
birthday
1
1
Peter
Pascal 1991-02-01
2
2
Paul
Panini 1992-03-02
3
3
Mary
Meyer 1993-04-03

Besides the direct execution of SQL statements, there are numerous convenience functions
similar to those found in the DBI -based packages. To get general information on the connection
and the drivers used or to list all tables in the database, we can use odbcGetInfo() and
sqlTables() :
# general information
odbcGetInfo(con)[3]
Driver_ODBC_Ver
"03.51"

# listing tables
sqlTables(con)[, 3:5]
TABLE_NAME TABLE_TYPE REMARKS
1
birthdays
TABLE
2 foodranking
TABLE
3
foodtypes
TABLE
To get an overview of the ODBC driver connections that are currently specified in our
ODBC manager, we can use odbcDataSources() . The function reveals that db1 to which
we are connected is based on MySQL drivers version 5.2:
odbcDataSources()
db1
"MySQL ODBC 5.2 ANSI Driver"
We can also ask for whole tables without specifying the SQL statement by a simple call
to sqlFetch() :
# 'plain' SQL
res <- sqlFetch(con, "birthdays")
res
nameid firstname lastname
birthday
1
1
Peter
Pascal 1991-02-01
2
2
Paul
Panini 1992-03-02
3
3
Mary
Meyer 1993-04-03
Similarly, we can write R data frames to SQL tables with convenience functions. We can
also empty tables or delete them altogether:
# writing tables
test <- data.frame(x = 1:3, y = letters[7:9])
sqlSave(con, test, "test")
sqlFetch(con, "test")
x y
1 1 g
2 2 h
3 3 i
# empty table
sqlClear(con, "test")
sqlFetch(con, "test")
[1] x y
<0 rows> (or 0-length row.names)
# drop table
sqlDrop(con, "test")

library(stringr)
name <- unlist(str_extract_all(raw.data, "[[:alpha:]., ]{2,}"))
name
[1] "Moe Szyslak"
"Burns, C. Montgomery" "Rev. Timothy Lovejoy"
[4] "Ned Flanders"
"Simpson, Homer"
"Dr. Julius Hibbert"
phone <- unlist(str_extract_all(raw.data, " \\ (?( \\ d{3})? \\ )?
(-| )? \\ d{3}(-| )? \\ d{4}"))
phone
[1] "555-1239"
"(636) 555-0113" "555-6542"
"555 8904"
[5] "636-555-3226"
"5553642"

data.frame(name = name, phone = phone)
name
phone
1
Moe Szyslak
555-1239
2 Burns, C. Montgomery (636) 555-0113
3 Rev. Timothy Lovejoy
555-6542
4
Ned Flanders
555 8904
5
Simpson, Homer
636-555-3226
6
Dr. Julius Hibbert
5553642


8.1 Regular expressions
Regular expressions are generalizable text patterns for searching and manipulating text data.
Strictly speaking, they are not so much a tool as they are a convention on how to query strings
across a wide range of functions. In this section, we will introduce the basic building blocks
of extended regular expressions as implemented in R . The following string will serve as a
running example:
example.obj <- "1. A small sentence. - 2. Another tiny sentence."
8.1.1
Exact character matching
At the most basic level characters match characters—even in regular expressions. Thus,
extracting a substring of a string will yield itself if present:
str_extract(example.obj, "small")
[1] "small"
Otherwise, the function would return a missing value:
str_extract(example.obj, "banana")
[1] NA
The function we use here and in the remainder of this section is str_extract() from
the stringr package, which we assume is loaded in all subsequent examples. It is defined as
str_extract(string, pattern) such that we first input the string that is to be operated
upon and second the expression we are looking for. Note that this differs from most base
functions, like grep() or grepl() , where the regular expression is typically input first. 1 The
function will return the first instance of a match to the regular expression in a given string.
We can also ask R to extract every match by calling the function str_extract_all() :

unlist(str_extract_all(example.obj, "sentence"))
[1] "sentence" "sentence"
The stringr package offers both str_whatever() and str_whatever_all() in many
instances. The former addresses the first instance of a matching string while the latter
accesses all instances. The syntax of all these functions is such that the character vector in
question is the first element, the regular expression the second, and all possible additional
values come after that. The functions’ consistency is the main reason why we prefer to use
the stringr package by Hadley Wickham (2010). We introduce the package in more detail
in Section 8.2. See Table 8.5 for an overview of the counterparts of the stringr functions in
base R .
As str_extract_all() is ordinarily called on multiple strings, the results are returned
as a list, with each list element providing the results for one string. Our input string in the
call above is a character vector of length one; hence, the function returns a list of length
one, which we unlist() for convenience of exposition. Compare this to the behavior of the
function when we call it upon multiple strings at the same time. We create a vector containing

the strings text , manipulation , and basics . We use the function str_extract_all()
to extract all instances of the pattern a :
out <- str_extract_all(c("text", "manipulation", "basics"), "a")
out
[[1]]
character(0)
[[2]]
[1] "a" "a"
[[3]]
[1] "a"
The function returns a list of the same length as our input vector—three—where each
element in the list contains the result for one string. As there is no a in the first string, the first
element is an empty character vector. String two contains two a s, string three one occurrence.
By default, character matching is case sensitive. Thus, capital letters in regular expressions
are different from lowercase letters.
str_extract(example.obj, "small")
[1] "small"
small is contained in the example string while SMALL is not.
str_extract(example.obj, "SMALL")
[1] NA
Consequently, the function extracts no matching value. We can change this behavior by
enclosing a string with ignore.case() . 2
str_extract(example.obj, ignore.case("SMALL"))
[1] "small"
We are not limited to using regular expressions on words. A string is simply a sequence
of characters. Hence, we can just as well match particles of words ...
unlist(str_extract_all(example.obj, "en"))
[1] "en" "en" "en" "en"
... or mixtures of alphabetic characters and blank spaces.
str_extract(example.obj, "mall sent")
[1] "mall sent"
Searching for the pattern en in the example string returns every instance of the pattern,
that is, both occurrences in the word sentence , which is contained twice in the example
object. Sometimes we do not simply care about finding a match anywhere in a string but are
2 This behavior is a property of the stringr package. For case-insensitive matching in base functions, set the
ignore.case argument to TRUE . Incidentally, if you have never worked with strings before, tolower() and
toupper() will convert your string to lower/upper case.





raw.data <- "555-1239Moe Szyslak(636) 555-0113Burns, C. Montgomery555
-6542Rev. Timothy Lovejoy555 8904Ned Flanders636-555-3226Simpson,
Homer5553642Dr. Julius Hibbert"


library(stringr)
name <- unlist(str_extract_all(raw.data, "[[:alpha:]., ]{2,}"))
name
# [1] "Moe Szyslak" "Burns, C. Montgomery" "Rev. Timothy Lovejoy"
# [4] "Ned Flanders" "Simpson, Homer" "Dr. Julius Hibbert"
phone <- unlist(str_extract_all(raw.data, " \\(?( \\d{3})?\\)?(-| )?\\d{3}(-| )?\\d{4}"))
phone
# [1] "555-1239" "(636) 555-0113" "555-6542" "555 8904"
# [5] "636-555-3226" "5553642"
data.frame(name = name, phone = phone)


str_extract(example.obj, "small")

str_extract(example.obj, "banana")
unlist(str_extract_all(example.obj, "sentence"))

out <- str_extract_all(c("text", "manipulation", "basics"), "a")
out

str_extract(example.obj, ignore.case("SMALL"))

unlist(str_extract_all(example.obj, "en"))
 str_extract(example.obj, "mall sent")

 unlist(str_extract_all(example.obj, "sentence$"))
 unlist(str_extract_all(example.obj, "tiny|sentence"))

 str_extract(example.obj, "sm.ll")
 str_extract(example.obj, "sm[abc]ll")
 str_extract(example.obj, "sm[a-p]ll")


connections {base}	R Documentation
Functions to Manipulate Connections (Files, URLs, ...)
Description

Functions to create, open and close connections, i.e., “generalized files”, such as possibly compressed files, URLs, pipes, etc.
Usage

file(description = "", open = "", blocking = TRUE,
     encoding = getOption("encoding"), raw = FALSE,
     method = getOption("url.method", "default"))

url(description, open = "", blocking = TRUE,
    encoding = getOption("encoding"),
    method = getOption("url.method", "default"))

gzfile(description, open = "", encoding = getOption("encoding"),
       compression = 6)

bzfile(description, open = "", encoding = getOption("encoding"),
       compression = 9)

xzfile(description, open = "", encoding = getOption("encoding"),
       compression = 6)

unz(description, filename, open = "", encoding = getOption("encoding"))

pipe(description, open = "", encoding = getOption("encoding"))

fifo(description, open = "", blocking = FALSE,
     encoding = getOption("encoding"))

socketConnection(host = "localhost", port, server = FALSE,
                 blocking = FALSE, open = "a+",
                 encoding = getOption("encoding"),
                 timeout = getOption("timeout"))

open(con, ...)
## S3 method for class 'connection'
open(con, open = "r", blocking = TRUE, ...)

close(con, ...)
## S3 method for class 'connection'
close(con, type = "rw", ...)

flush(con)

isOpen(con, rw = "")
isIncomplete(con)

Arguments
description 	

character string. A description of the connection: see ‘Details’.
open 	

character string. A description of how to open the connection (if it should be opened initially). See section ‘Modes’ for possible values.
blocking 	

logical. See the ‘Blocking’ section.
encoding 	

The name of the encoding to be assumed. See the ‘Encoding’ section.
raw 	

logical. If true, a ‘raw’ interface is used which will be more suitable for arguments which are not regular files, e.g. character devices. This suppresses the check for a compressed file when opening for text-mode reading, and asserts that the ‘file’ may not be seekable.
method 	

character string, partially matched to c("default", "internal", "wininet", "libcurl"): see ‘Details’.
compression 	

integer in 0–9. The amount of compression to be applied when writing, from none to maximal available. For xzfile can also be negative: see the ‘Compression’ section.
timeout 	

numeric: the timeout (in seconds) to be used for this connection. Beware that some OSes may treat very large values as zero: however the POSIX standard requires values up to 31 days to be supported.
filename 	

a filename within a zip file.
host 	

character string. Host name for the port.
port 	

integer. The TCP port number.
server 	

logical. Should the socket be a client or a server?
con 	

a connection.
type 	

character string. Currently ignored.
rw 	

character string. Empty or "read" or "write", partial matches allowed.
... 	

arguments passed to or from other methods.
Details

The first nine functions create connections. By default the connection is not opened (except for a socketConnection), but may be opened by setting a non-empty value of argument open.

For file the description is a path to the file to be opened or a complete URL (when it is the same as calling url), or "" (the default) or "clipboard" (see the ‘Clipboard’ section). Use "stdin" to refer to the C-level ‘standard input’ of the process (which need not be connected to anything in a console or embedded version of R, and is not in RGui on Windows). See also stdin() for the subtly different R-level concept of stdin.

For url the description is a complete URL including scheme (such as http://, https://, ftp:// or file://). Method "internal" is that available since connections were introduced, method "wininet" is only available on Windows (it uses the WinINet functions of that OS) and method "libcurl" (using the library of that name: http://curl.haxx.se/libcurl/) is required on a Unix-alike but optional on Windows. Method "default" uses method "internal" for file: URLs and "libcurl" for ftps: URLs. On a Unix-alike it uses "internal" for http: and ftp: URLs and "libcurl" for https: URLs; on Windows "wininet" for http:, ftp: and https: URLs. Proxies can be specified: see download.file.

For gzfile the description is the path to a file compressed by gzip: it can also open for reading uncompressed files and those compressed by bzip2, xz or lzma.

For bzfile the description is the path to a file compressed by bzip2.

For xzfile the description is the path to a file compressed by xz (https://en.wikipedia.org/wiki/Xz) or (for reading only) lzma (https://en.wikipedia.org/wiki/LZMA).

unz reads (only) single files within zip files, in binary mode. The description is the full path to the zip file, with ‘.zip’ extension if required.

For pipe the description is the command line to be piped to or from. This is run in a shell, on Windows that specified by the COMSPEC environment variable.

For fifo the description is the path of the fifo. (Support for fifo connections is optional but they are available on most Unix platforms and on Windows.)

The intention is that file and gzfile can be used generally for text input (from files, http:// and https:// URLs) and binary input respectively.

open, close and seek are generic functions: the following applies to the methods relevant to connections.

open opens a connection. In general functions using connections will open them if they are not open, but then close them again, so to leave a connection open call open explicitly.

close closes and destroys a connection. This will happen automatically in due course (with a warning) if there is no longer an R object referring to the connection.

A maximum of 128 connections can be allocated (not necessarily open) at any one time. Three of these are pre-allocated (see stdout). The OS will impose limits on the numbers of connections of various types, but these are usually larger than 125.

flush flushes the output stream of a connection open for write/append (where implemented, currently for file and clipboard connections, stdout and stderr).

If for a file or (on most platforms) a fifo connection the description is "", the file/fifo is immediately opened (in "w+" mode unless open = "w+b" is specified) and unlinked from the file system. This provides a temporary file/fifo to write to and then read from.
Value

file, pipe, fifo, url, gzfile, bzfile, xzfile, unz and socketConnection return a connection object which inherits from class "connection" and has a first more specific class.

open and flush return NULL, invisibly.

close returns either NULL or an integer status, invisibly. The status is from when the connection was last closed and is available only for some types of connections (e.g., pipes, files and fifos): typically zero values indicate success.

isOpen returns a logical value, whether the connection is currently open.

isIncomplete returns a logical value, whether the last read attempt was blocked, or for an output text connection whether there is unflushed output.
URLs

url and file support URL schemes file://, http://, https:// and ftp://.

method = "libcurl" allows more schemes: exactly which schemes is platform-dependent (see libcurlVersion), but all Unix-alike platforms will support https:// and most platforms will support ftps://.

Most methods do not percent-encode special characters such as spaces in http:// URLs (see URLencode), but it seems the "wininet" method does.

A note on file:// URLs. The most general form (from RFC1738) is file://host/path/to/file, but R only accepts the form with an empty host field referring to the local machine.

On a Unix-alike, this is then file:///path/to/file, where path/to/file is relative to ‘/’. So although the third slash is strictly part of the specification not part of the path, this can be regarded as a way to specify the file ‘/path/to/file’. It is not possible to specify a relative path using a file URL.

In this form the path is relative to the root of the filesystem, not a Windows concept. The standard form on Windows is file:///d:/R/repos: for compatibility with earlier versions of R and Unix versions, any other form is parsed as R as file:// plus path_to_file. Also, backslashes are accepted within the path even though RFC1738 does not allow them.

No attempt is made to decode a percent-encoded file: URL: call URLdecode if necessary.

The "internal" method does not follow re-directed HTTP URLs: both methods "wininet" (the default on Windows) and "libcurl" do (including for HTTPS URLs).

Server-side cached data is always accepted.

Function download.file and contributed package RCurl provide more comprehensive facilities to download from URLs.
Modes

Possible values for the argument open are

"r" or "rt"

    Open for reading in text mode.
"w" or "wt"

    Open for writing in text mode.
"a" or "at"

    Open for appending in text mode.
"rb"

    Open for reading in binary mode.
"wb"

    Open for writing in binary mode.
"ab"

    Open for appending in binary mode.
"r+", "r+b"

    Open for reading and writing.
"w+", "w+b"

    Open for reading and writing, truncating file initially.
"a+", "a+b"

    Open for reading and appending.

Not all modes are applicable to all connections: for example URLs can only be opened for reading. Only file and socket connections can be opened for both reading and writing. An unsupported mode is usually silently substituted.

If a file or fifo is created on a Unix-alike, its permissions will be the maximal allowed by the current setting of umask (see Sys.umask).

For many connections there is little or no difference between text and binary modes. For file-like connections on Windows, translation of line endings (between LF and CRLF) is done in text mode only (but text read operations on connections such as readLines, scan and source work for any form of line ending). Various R operations are possible in only one of the modes: for example pushBack is text-oriented and is only allowed on connections open for reading in text mode, and binary operations such as readBin, load and save can only be done on binary-mode connections.

The mode of a connection is determined when actually opened, which is deferred if open = "" is given (the default for all but socket connections). An explicit call to open can specify the mode, but otherwise the mode will be "r". (gzfile, bzfile and xzfile connections are exceptions, as the compressed file always has to be opened in binary mode and no conversion of line-endings is done even on Windows, so the default mode is interpreted as "rb".) Most operations that need write access or text-only or binary-only mode will override the default mode of a non-yet-open connection.

Append modes need to be considered carefully for compressed-file connections. They do not produce a single compressed stream on the file, but rather append a new compressed stream to the file. Readers may or may not read beyond end of the first stream: currently R does so for gzfile, bzfile and xzfile connections.
Compression

R supports gzip, bzip2 and xz compression (added in R 2.10.0: also read-only support for its precursor lzma compression).

For reading, the type of compression (if any) can be determined from the first few bytes of the file. Thus for file(raw = FALSE) connections, if open is "", "r" or "rt" the connection can read any of the compressed file types as well as uncompressed files. (Using "rb" will allow compressed files to be read byte-by-byte.) Similarly, gzfile connections can read any of the forms of compression and uncompressed files in any read mode.

(The type of compression is determined when the connection is created if open is unspecified and a file of that name exists. If the intention is to open the connection to write a file with a different form of compression under that name, specify open = "w" when the connection is created or unlink the file before creating the connection.)

For write-mode connections, compress specifies how hard the compressor works to minimize the file size, and higher values need more CPU time and more working memory (up to ca 800Mb for xzfile(compress = 9)). For xzfile negative values of compress correspond to adding the xz argument -e: this takes more time (double?) to compress but may achieve (slightly) better compression. The default (6) has good compression and modest (100Mb memory) usage: but if you are using xz compression you are probably looking for high compression.

Choosing the type of compression involves tradeoffs: gzip, bzip2 and xz are successively less widely supported, need more resources for both compression and decompression, and achieve more compression (although individual files may buck the general trend). Typical experience is that bzip2 compression is 15% better on text files than gzip compression, and xz with maximal compression 30% better. The experience with R save files is similar, but on some large ‘.rda’ files xz compression is much better than the other two. With current computers decompression times even with compress = 9 are typically modest and reading compressed files is usually faster than uncompressed ones because of the reduction in disc activity.
Encoding

The encoding of the input/output stream of a connection can be specified by name in the same way as it would be given to iconv: see that help page for how to find out what encoding names are recognized on your platform. Additionally, "" and "native.enc" both mean the ‘native’ encoding, that is the internal encoding of the current locale and hence no translation is done.

Re-encoding only works for connections in text mode: reading from a connection with re-encoding specified in binary mode will read the stream of bytes, but mixing text and binary mode reads (e.g., mixing calls to readLines and readChar) is likely to lead to incorrect results.

The encodings "UCS-2LE" and "UTF-16LE" are treated specially, as they are appropriate values for Windows ‘Unicode’ text files. If the first two bytes are the Byte Order Mark 0xFEFF then these are removed as some implementations of iconv do not accept BOMs. Note that whereas most implementations will handle BOMs using encoding "UCS-2" and choose the appropriate byte order, some (including earlier versions of glibc) will not. There is a subtle distinction between "UTF-16" and "UCS-2" (see https://en.wikipedia.org/wiki/UTF-16: the use of characters in the ‘Supplementary Planes’ which need surrogate pairs is very rare so "UCS-2LE" is an appropriate first choice (as it is more widely implemented).

One caveat: R's implementation of "UCS-2LE" and similar for output does not currently work on Windows, and on Unix it will default to Unix-style line endings. We recommend use of UTF-8 instead.

As from R 3.0.0 the encoding "UTF-8-BOM" is accepted for reading and will remove a Byte Order Mark if present (which it often is for files and webpages generated by Microsoft applications). If a BOM is required (it is not recommended) when writing it should be written explicitly, e.g. by writeChar("\ufeff", con, eos = NULL) or writeBin(as.raw(c(0xef, 0xbb, 0xbf)), binary_con)

Encoding names "utf8", "mac" and "macroman" are not portable, and not supported on all current R platforms. "UTF-8" is portable and "macintosh" is the official (and most widely supported) name for ‘Mac Roman’.

Requesting a conversion that is not supported is an error, reported when the connection is opened. Exactly what happens when the requested translation cannot be done for invalid input is in general undocumented. On output the result is likely to be that up to the error, with a warning. On input, it will most likely be all or some of the input up to the error.

It may be possible to deduce the current native encoding from Sys.getlocale("LC_CTYPE"), but not all OSes record it.
Blocking

Whether or not the connection blocks can be specified for file, url (default yes), fifo and socket connections (default not).

In blocking mode, functions using the connection do not return to the R evaluator until the read/write is complete. In non-blocking mode, operations return as soon as possible, so on input they will return with whatever input is available (possibly none) and for output they will return whether or not the write succeeded.

The function readLines behaves differently in respect of incomplete last lines in the two modes: see its help page.

Even when a connection is in blocking mode, attempts are made to ensure that it does not block the event loop and hence the operation of GUI parts of R. These do not always succeed, and the whole R process will be blocked during a DNS lookup on Unix, for example.

Most blocking operations on HTTP/FTP URLs and on sockets are subject to the timeout set by options("timeout"). Note that this is a timeout for no response, not for the whole operation. The timeout is set at the time the connection is opened (more precisely, when the last connection of that type – http:, ftp: or socket – was opened).
Fifos

Fifos default to non-blocking. That follows S version 4 and is probably most natural, but it does have some implications. In particular, opening a non-blocking fifo connection for writing (only) will fail unless some other process is reading on the fifo.

Opening a fifo for both reading and writing (in any mode: one can only append to fifos) connects both sides of the fifo to the R process, and provides an similar facility to file().
Clipboard

file can be used with description = "clipboard" in modes "r" and "w" only.

When a clipboard is opened for reading, the contents are immediately copied to internal storage in the connection.

When writing to the clipboard, the output is copied to the clipboard only when the connection is closed or flushed. There is a 32Kb limit on the text to be written to the clipboard. This can be raised by using e.g. file("clipboard-128") to give 128Kb.

The clipboard works in Unicode wide characters, so encodings might not work as one might expect.
Note

R's connections are modelled on those in S version 4 (see Chambers, 1998). However R goes well beyond the S model, for example in output text connections and URL, compressed and socket connections.

The default open mode in R is "r" except for socket connections. This differs from S, where it is the equivalent of "r+", known as "*".

On (rare) platforms where vsnprintf does not return the needed length of output there is a 100,000 byte output limit on the length of a line for text output on fifo, gzfile, bzfile and xzfile connections: longer lines will be truncated with a warning.
References

Chambers, J. M. (1998) Programming with Data. A Guide to the S Language. Springer.

Ripley, B. D. (2001) Connections. R News, 1/1, 16–7. https://www.r-project.org/doc/Rnews/Rnews_2001-1.pdf
See Also

textConnection, seek, showConnections, pushBack.

Functions making direct use of connections are (text-mode) readLines, writeLines, cat, sink, scan, parse, read.dcf, dput, dump and (binary-mode) readBin, readChar, writeBin, writeChar, load and save.

capabilities to see if fifo connections are supported by this build of R.

gzcon to wrap gzip (de)compression around a connection.

options HTTPUserAgent, internet.info and timeout are used by some of the methods for URL connections.

memCompress for more ways to (de)compress and references on data compression.

To flush output to the console, see flush.console.
Examples

zz <- file("ex.data", "w")  # open an output file connection
cat("TITLE extra line", "2 3 5 7", "", "11 13 17", file = zz, sep = "\n")
cat("One more line\n", file = zz)
close(zz)
readLines("ex.data")
unlink("ex.data")

zz <- gzfile("ex.gz", "w")  # compressed file
cat("TITLE extra line", "2 3 5 7", "", "11 13 17", file = zz, sep = "\n")
close(zz)
readLines(zz <- gzfile("ex.gz"))
close(zz)
unlink("ex.gz")

zz <- bzfile("ex.bz2", "w")  # bzip2-ed file
cat("TITLE extra line", "2 3 5 7", "", "11 13 17", file = zz, sep = "\n")
close(zz)
print(readLines(zz <- bzfile("ex.bz2")))
close(zz)
unlink("ex.bz2")

## An example of a file open for reading and writing
Tfile <- file("test1", "w+")
c(isOpen(Tfile, "r"), isOpen(Tfile, "w")) # both TRUE
cat("abc\ndef\n", file = Tfile)
readLines(Tfile)
seek(Tfile, 0, rw = "r") # reset to beginning
readLines(Tfile)
cat("ghi\n", file = Tfile)
readLines(Tfile)
close(Tfile)
unlink("test1")

## We can do the same thing with an anonymous file.
Tfile <- file()
cat("abc\ndef\n", file = Tfile)
readLines(Tfile)
close(Tfile)

## Not run: ## fifo example -- may hang even with OS support for fifos
if(capabilities("fifo")) {
  zz <- fifo("foo-fifo", "w+")
  writeLines("abc", zz)
  print(readLines(zz))
  close(zz)
  unlink("foo-fifo")
}
## End(Not run)

## Not run: 
## Two R processes communicating via non-blocking sockets
# R process 1
con1 <- socketConnection(port = 6011, server = TRUE)
writeLines(LETTERS, con1)
close(con1)

# R process 2
con2 <- socketConnection(Sys.info()["nodename"], port = 6011)
# as non-blocking, may need to loop for input
readLines(con2)
while(isIncomplete(con2)) {
   Sys.sleep(1)
   z <- readLines(con2)
   if(length(z)) print(z)
}
close(con2)

## examples of use of encodings
# write a file in UTF-8
cat(x, file = (con <- file("foo", "w", encoding = "UTF-8"))); close(con)
# read a 'Windows Unicode' file
A <- read.table(con <- file("students", encoding = "UCS-2LE")); close(con)

## End(Not run)

[Package base version 3.3.2 Index]




 [:digit:] Digits: 0 1 2 3 4 5 6 7 8 9
[:lower:] Lowercase characters: a–z
[:upper:] Uppercase characters: A–Z
[:alpha:] Alphabetic characters: a–z and A–Z
[:alnum:] Digits and alphabetic characters
[:punct:] Punctuation characters: . , ; etc.
[:graph:] Graphical characters: [:alnum:] and [:punct:]
[:blank:] Blank characters: Space and tab
[:space:] Space characters: Space, tab, newline, and other space characters
[:print:] Printable characters: [:alnum:] , [:punct:] and [:space:]


Examples

cat("TITLE extra line", "2 3 5 7", "", "11 13 17", file = "ex.data",
    sep = "\n")
readLines("ex.data", n = -1)
unlink("ex.data") # tidy up

## difference in blocking
cat("123\nabc", file = "test1")
readLines("test1") # line with a warning

con <- file("test1", "r", blocking = FALSE)
readLines(con) # empty
cat(" def\n", file = "test1", append = TRUE)
readLines(con) # gets both
close(con)

unlink("test1") # tidy up

## Not run: 
# read a 'Windows Unicode' file
A <- readLines(con <- file("Unicode.txt", encoding = "UCS-2LE"))
close(con)
unique(Encoding(A)) # will most likely be UTF-8

con <-file("e:/deleted_files2.csv")
close(con)

con <-file("e:/download.txt")
readLines(con)
close(con)

unlist(str_extract_all(example.obj, "[uvw. ]"))

unlist(str_extract_all(example.obj, "[[:punct:]]"))
unlist(str_extract_all(example.obj, "[:punct:]"))

unlist(str_extract_all(example.obj, "[AAAAAA]"))
str_extract("Franc¸ois Hollande", "Fran[a-z]ois")
str_extract("Franc¸ois Hollande", "Fran[[:alpha:]]ois")
unlist(str_extract_all(example.obj, "[[:punct:]ABC]"))
unlist(str_extract_all(example.obj, "[ˆ[:alnum:]]"))

str_extract(example.obj, "s[[:alpha:]][[:alpha:]][[:alpha:]]l")

str_extract(example.obj, "s[[:alpha:]]{3}l")

? The preceding item is optional and will be matched at most once
* The preceding item will be matched zero or more times
+ The preceding item will be matched one or more times
{n} The preceding item is matched exactly n times
{n,} The preceding item is matched n or more times
{n,m} The preceding item is matched at least n times, but not more than m times

str_extract(example.obj, "A.+sentence")
str_extract(example.obj, "A.+?sentence")
unlist(str_extract_all(example.obj, "(.en){1,5}"))

unlist(str_extract_all(example.obj, ".en{1,5}"))
Table 8.3 Selected symbols with special meaning
\w Word characters: [[:alnum:]_]
\W No word characters: [ˆ[:alnum:]_]
\s Space characters: [[:blank:]]
\S No space characters: [ˆ[:blank:]]
\d Digits: [[:digit:]]
\D No digits: [ˆ[:digit:]]
\b Word edge
\B No word edge
\< Word beginning
\> Word end

unlist(str_extract_all(example.obj, " \\."))

unlist(str_extract_all(example.obj, fixed(".")))
unlist(str_extract_all(example.obj, " \\w+"))

unlist(str_extract_all(example.obj, "e \\>"))

unlist(str_extract_all(example.obj, "e \\b"))

str_extract(example.obj, "([[:alpha:]]).+? \\1")

str_extract(example.obj, "( \\<[b-z]+ \\>).+? \\1")

name <- unlist(str_extract_all(raw.data, "[[:alpha:]., ]{2,}"))

phone <- unlist(str_extract_all(raw.data, " \ \(?( \ \d{3})? \ \)?(-| )? \ \d
{3}(-| )? \ \d{4}"))
str_extract(example.obj, "tiny")

str_extract_all(example.obj, "[[:digit:]]")
Functions using regular expressions
str_extract() Extracts fist string that matches
pattern
Character vector
str_extract_all() Extracts all strings that match
pattern
List of character vectors
str_locate() Returns position of fist pattern
match
Matrix of start/end
positions
str_locate_all() Returns positions of all pattern
matches
List of matrices
str_replace() Replaces fist pattern match Character vector
str_replace_all() Replaces all pattern matches Character vector
str_split() Splits string at pattern List of character vectors
str_split_fixed() Splits string at pattern into fied
number of pieces
Matrix of character vectors
str_detect() Detects patterns in string Boolean vector
str_count() Counts number of pattern
occurrences in string
Numeric vector
Further functions
str_sub() Extracts strings by position Character vector
str_dup() Duplicates strings Character vector
str_length() Returns length of string Numeric vector
str_pad() Pads a string Character vector
str_trim() Discards string padding Character vector
str_c() Concatenates strings Character vector

str_locate(example.obj, "tiny")

str_sub(example.obj, start = 35, end = 38)
str_sub(example.obj, 35, 38) <- "huge"
str_replace(example.obj, pattern = "huge", replacement = "giant")
unlist(str_split(example.obj, "-"))
as.character(str_split_fixed(example.obj, "[[:blank:]]", 5))

char.vec <- c("this", "and this", "and that")
str_detect(char.vec, "this")
str_count(char.vec, "this")
str_count(char.vec, " \\w+")
dup.obj <- str_dup(char.vec, 3)

str_length(char.vec)

str_pad(char.vec, width = max(length.char.vec),
side = "both", pad = " ")

char.vec <- str_trim(char.vec)
cat(str_c(char.vec, collapse = " \n"))
str_c("text", "manipulation", sep = " ")
str_c("text", c("manipulation", "basics"), sep = " ")
str_extract() regmatches()
str_extract_all() regmatches()
str_locate() regexpr()
str_locate_all() gregexpr()
str_replace() sub()
str_replace_all() gsub()
str_split() strsplit()
str_split_fixed() –
str_detect() grepl()
str_count() –
Further functions
str_sub() regmatches()
str_dup() –
str_length() nchar()
str_pad() –
str_trim() –
str_c() paste() , paste0()

agrep("Barack Obama", "Barack H. Obama", max.distance = list(all = 3))

agrep("Barack Obama", "Michelle Obama", max.distance = list(all = 3))
pmatch(c("and this", "and that", "and these", "and those"), char.vec)

make.unique(c("a", "b", "a", "c", "b", "a"))

R> grep("Homer",episodes$title[1:10], value=T)
[1] "Homer's Odyssey" "Homer's Night Out"
R> grepl("Homer",episodes$title[1:10])
[1] FALSE FALSE TRUE FALSE FALSE FALSE FALSE FALSE FALSE TRUE
R> iffer1 <- grepl("Homer",episodes$title)
R> iffer2 <- grepl("Lisa",episodes$title)
R> iffer <- iffer1 & iffer2
R> episodes$title[iffer]


grepall <- function(pattern, x,
ignore.case = FALSE, perl = FALSE,
fixed = FALSE, useBytes = FALSE,
value=FALSE, logic=FALSE){
	# error and exception handling
if(length(pattern)==0 | length(x)==0){
warning("Length of pattern or data equals zero.")
return(NULL)
}
# apply grepl() and all()
indicies <- sapply(pattern, grepl, x,
ignore.case, perl, fixed, useBytes)
index <- apply(indicies, 1, all)
# indexation and return of results
if(logic==T) return(index)
if(value==F) return((1:length(x))[index])
if(value==T) return(x[index])
}

R> grepall(c("Lisa","Homer"), episodes$title)
[1] 26
R> grepall(c("Lisa","Homer"), episodes$title, value=T)
[1] "Homer vs. Lisa and the 8th Commandment"


Sys.getlocale()

Using the function encodings
iconv() , we can translate a string from one encoding scheme to another:
R> small.frogs.utf8 <- iconv(small.frogs, from = "windows-1252",
to = "UTF-8")
R> Encoding(small.frogs.utf8)
[1] "UTF-8"
R> small.frogs.utf8
[1] "Sm˚a grodorna, sm˚a grodorna ¨ar lustiga att se."

R> Encoding(small.frogs.utf8) <- "windows-1252"
R> small.frogs.utf8
[1] "Sm˜A¥ grodorna, sm˜A¥ grodorna ˜A¤r lustiga att se."

There are currently 350 conversion schemes available, which can be accessed
using the iconvlist() function.

R> sample(iconvlist(), 10)
[1] "PT154" "latin7" "UTF-16BE" "CP51932"
[5] "IBM860" "CP50221" "IBM424" "CP1257"
[9] "WINDOWS-50221" "IBM864"

R> library(RCurl)
R> enc.test <- getURL(" http://www.sciencemag.org/")
R> unlist(str_extract_all(enc.test, "<meta.+?>"))


[1] "<meta http-equiv= \"Content-Type \" content= \"text/html;
charset=UTF-8 \" />"
[2] "<meta name= \"googlebot \" content= \"NOODP \" />"
[3] "<meta name= \"HW.ad-path \" content= \"/ \" />"

R> library(tau)
R> is.locale(small.frogs)
[1] TRUE
R> is.ascii(small.frogs)
[1] FALSE

l i b r a r y ( R C u r l )
l i b r a r y ( X M L )
l i b r a r y ( s t r i n g r )
g e t H T M L L i n k s ( )

R> url <- " http://www.elections.state.md.us/elections/2012/election_
data/index.html"
R> links <- getHTMLLinks(url)
R> filenames <- links[str_detect(links, "_General.csv")]
R> filenames_list <- as.list(filenames)
R> filenames_list[1:3]
[[1]]

Let us use another HTML table
to demonstrate this feature. The fist table of the article gives an overview of Machiavelli’s
personal information and, in the seventh and eighth rows, lists persons and schools of thought
that have inflenced him in his thinking as well as those that were inflenced by him.
R> readHTMLTable(mac_source, stringsAsFactors = F)[[1]][7:8, 1]


R> influential <- readHTMLTable(mac_source,
elFun = getHTMLLinks,
stringsAsFactors = FALSE)[[1]][7,]
R> as.character(influential)[1:3]
[1] "/wiki/Xenophon" "/wiki/Plutarch" "/wiki/Tacitus"

R > i n f l u e n c e d < - r e a d H T M L T a b l e ( m a c _ s o u r c e ,
e l F u n = g e t H T M L L i n k s ,
s t r i n g s A s F a c t o r s = F A L S E ) [ [ 1 ] ] [ 8 , ]
R > a s . c h a r a c t e r ( i n f l u e n c e d ) [ 1 : 3 ]
[ 1 ] " / w i k i / P o l i t i c a l _ R e a l i s m " " / w i k i / F r a n c i s _ B a c o n "
[ 3 ] " / w i k i / T h o m a s _ H o b b e s "


info <- debugGatherer()
handle <- getCurlHandle(cookiejar = "",
followlocation = TRUE,
autoreferer = TRUE,
debugfunc = info$update,
verbose = TRUE,
httpheader = list(
from = "eddie@r-datacollection.com",
'user-agent' = str_c(R.version$version.string
", ", R.version$platform)
))
xmlAttrsToDF <- function(parsedHTML, xpath) {
x <- xpathApply(parsedHTML, xpath, xmlAttrs)
x <- lapply(x, function(x) as.data.frame(t(x)))
do.call(rbind.fill, x)
}

url <- " http://wordnetweb.princeton.edu/perl/webwn"
html_form <- getURL(url, curl = handle)
parsed_form <- htmlParse(html_form)


R> xmlAttrsToDF(parsed_form, "//form")
method action enctype name
1 get webwn multipart/form-data f
2 get webwn multipart/form-data change

xmlAttrsToDF(parsed_form, "//form[1]/input")
R> html_form_res <- getForm(uri = url, curl = handle, s = "data")
R> parsed_form_res <- htmlParse(html_form_res)
R> xpathApply(parsed_form_res, "//li", xmlValue)
[[1]]
[1] "S: (n) data, information (a collection of facts from which
conclusions may be drawn) \"statistical data \""
[[2]]
[1] "S: (n) datum, data point (an item of factual information
derived from measurement or research) "

R> cat(str_split(info$value()["headerOut"], " \r")[[1]])
GET /perl/webwn HTTP/1.1
Host: wordnetweb.princeton.edu
Accept: */*
from: eddie@r-datacollection.com
user-agent: R version 3.0.2 (2013-09-25), x86_64-w64-mingw32
GET /perl/webwn?s=data HTTP/1.1
Host: wordnetweb.princeton.edu
Accept: */*
from: eddie@r-datacollection.com
user-agent: R version 3.0.2 (2013-09-25), x86_64-w64-mingw32
R> info$reset()

R> install.packages("RHTMLForms", repos = " http://www.omegahat.org/R",
type = "source")
R> library(RHTMLForms)

1. We use getHTMLFormDescription() on the URL where the HTML form is located
and save its results in an object—let us call it forms.
2. We use createFunction() on the fist item of the forms object and save the results
in another object, say form_function.
3. formFunction() takes input filds as options to send them to the server and return
the result.

R > u r l < - " http://wordnetweb.princeton.edu/perl/webwn"
R> forms <- getHTMLFormDescription(url)
R> formFunction <- createFunction(forms[[1]])
Having created formFunction() , we use it to send form data to the server and retrieve
the results.
R> html_form_res <- formFunction(s = "data", .curl = handle)
R> parsed_form_res <- htmlParse(html_form_res)
R> xpathApply(parsed_form_res,"//li", xmlValue)
[[1]]
[1] "S: (n) data, information (a collection of facts from which
conclusions may be drawn) \"statistical data \""
[[2]]
[1] "S: (n) datum, data point (an item of factual information
derived from measurement or research) "
Let us have a look at the function we just created.
R> args(formFunction)
function ( s = "",
.url = " http://wordnetweb.princeton.edu/perl/webwn",
...,
.reader = NULL,
.formDescription = list(formAttributes = c(
"get",
" http://wordnetweb.princeton.edu/perl/webwn",
"multipart/form-data",
"f"),
elements = list(
s = list(name = "s",
nodeAttributes = c("text", "s", "500"),
defaultValue = ""),
o2 = list(name = "o2", value = "" ),
o0 = list(name = "o0", value = "1"),
o8 = list(name = "o8", value = "1"),
o1 = list(name = "o1", value = "1"),
o7 = list(name = "o7", value = "" ),
o5 = list(name = "o5", value = "" ),
o9 = list(name = "o9", value = "" ),
o6 = list(name = "o6", value = "" ),
o3 = list(name = "o3", value = "" ),
o4 = list(name = "o4", value = "" ),
h = list(name = "h" , value = "" )),
url = " http://wordnetweb.princeton.edu/perl/webwn"),
.opts = structure(list(
referer = " http://wordnetweb.princeton.edu/perl/webwn"),
.Names = "referer"),
.curl = getCurlHandle(),
.cleanArgs = NULL)

Stack Exchange Inbox Reputation and Badges sign up log in tour help  


Stack Overflow
Questions
 
Jobs
 
Documentation 
 
Tags
 
Users
 
Badges
 
Ask Question
x Dismiss
Join the Stack Overflow Community
Stack Overflow is a community of 6.4 million programmers, just like you, helping each other. 
Join them; it only takes a minute: 
Sign up
Named List To/From Data.Frame


up vote
13
down vote
favorite
6
I'm looking for a quick way to get back and forth between a list of the following format:

$`a`
  [1] 1 2 3
$`b`
  [1] 4 5 6
to/from a data.frame of the following format:

   name x
 1    a 1
 2    a 2
 3    a 3
 4    b 4
 5    b 5
 6    b 6
(Don't really care what the names of the columns are, in this case.)

Here's the data frame used above in R-format:

df <- data.frame(name=c(rep("a",3),rep("b",3)), x=c(1:3,4:6))
Again, I'm looking for two separate operations: one to convert the above data.frame to a list, and another to convert it back to a data.frame.

r dataframe
shareimprove this question
edited May 3 '12 at 14:06
asked May 3 '12 at 14:00

Jeff Allen
7,41442755
add a comment
3 Answers
active oldest votes
up vote
18
down vote
accepted
Use stack and unstack in base R:

x <- data.frame(a=1:3, b=4:6)

x
  a b
1 1 4
2 2 5
3 3 6
Use stack to from wide to tall, i.e. stack the vectors on top of one another.

y <- stack(x)
y
  values ind
1      1   a
2      2   a
3      3   a
4      4   b
5      5   b
6      6   b
Use unstack to do the reverse.

unstack(y)
  a b
1 1 4
2 2 5
3 3 6
If your data structure is more complicated than you described, stack and unstack may no longer be suitable. In that case you'll have to use reshape in base R, or melt and dcast in package reshape2.

shareimprove this answer
answered May 3 '12 at 15:11

Andrie
105k20260338
add a comment
up vote
5
down vote
Maybe something like:

X <- split(df$x, df$name)
data.frame(name = rep(names(X), sapply(X, length)), 
    x=do.call('c', X))
EDIT: I decided to combine Andrie and I's solution into one that appears to be exactly what the OP asked for fairly simple. That being said I don't quite understand a situation where I would treat the data this way instead of how Andrie did it since a data frame is a list of equal length vectors anyway.

# Your data set
df <- data.frame(name=c(rep("a",3),rep("b",3)), x=c(1:3,4:6))

# converting it to list of vectors
X <- split(df[, 2], df[, 1])
# converting it to a dataframe
Y <- stack(X)[, 2:1]; names(Y) <- names(df)

# Take Y and feed it back to these lines to show it 
# switches back and forth
(X <- split(Y[, 2], Y[, 1]))
Y <- stack(X)[, 2:1]; names(Y) <- names(df);Y
shareimprove this answer
edited May 3 '12 at 15:30
answered May 3 '12 at 14:14

Tyler Rinker
46.9k18149296
  	 	
+1 I was thinking maybe melt(as.data.frame(...),value.name = 'x',variable.name = 'name') to go back to the data frame. – joran May 3 '12 at 14:20
  	 	
One should note that split reorders the data frame as it builds a factor of the second vector. See also Creating a named list from two vectors (names, values) for a solution using mapply. – jnas Nov 27 '14 at 7:39 
add a comment
up vote
2
down vote
I wish to make the hopefully non-trivial remark that @Tyler Rinker's suggestion

X <- split(df$x, df$name)
can be done more generally with

X <- split(df, df$name)
@Tyler Rinker's split() explanation matches the R cookbook

http://my.safaribooksonline.com/book/programming/r/9780596809287/6dot1dot-splitting-a-vector-into-groups/id3392005

specifying that a vector can be grouped, while in fact the entire dataframe can be grouped. I would think that grouping the dataframe, not the vector, would be the more valuable tool (and in fact what brought me to this post).

(df <- data.frame(name=c(rep("a",3),rep("b",3), rep("c",3)), x=c(1:3,4:6, 7:9)))
(X <- split(df, df$name))
HTH.

shareimprove this answer
answered Feb 10 '13 at 2:00

Jack Ryan
1,240822
add a comment
Your Answer


 
Sign up or log in

Sign up using Google
Sign up using Facebook
Sign up using Email and Password
Post as a guest

Name

Email

 
By posting your answer, you agree to the privacy policy and terms of service.

Not the answer you're looking for?	Browse other questions tagged r dataframe or ask your own question.

asked

4 years ago

viewed

4512 times

active

3 years ago

BLOG
Stack Overflow Podcast #96 - A Face Full of Code

Looking for a job?
Senior Data Engineer
Restless BanditSan Francisco, CA
REMOTERELOCATION
sparkelasticsearch
Technical Account Manager
FoursquareShanghai, China
$40,000 - $100,000REMOTE
javascala
C++ Developer
Akuna CapitalShanghai, China
c++11c++
Java/Spring Technical Editor (remote, part-time)
BaeldungNo office location
REMOTE
springspring-security
51 People Chatting

JavaScript
5 hours ago - little pootis
little pootis: 5 hours agoAbhishrek: 5 hours agoDsafds: 5 hours agoJoel: 5 hours agodavid: 6 hours agoMosho: 6 hours agoKendall Frey: 6 hours ago
SO Close Vote Reviewers
5 hours ago - QPaysTaxes
QPaysTaxes: 5 hours agoBaum mit Augen: 5 hours agoRob: 5 hours agoMachavity: 5 hours agoAndrew Li: 5 hours agoHovercraft Full Of Eels: 6 hours agoFOX 9000: 6 hours ago
Linked

11
Creating a named list from two vectors (names, values)
2
list of character vectors of unequal length to data.frame
Related

63
How to get row from R data.frame
190
Convert data.frame columns from factors to characters
440
Drop data frame columns by name
402
Remove rows with NAs (missing values) in data.frame
137
Remove an entire column from a data.frame in R
216
Create an empty data.frame
82
Call apply-like function on each row of dataframe with multiple arguments from each row
16
Convert Mixed-Length named List to data.frame
2
Transpose list of vectors to from data.frame
7
Changing Column Names in a List of Data Frames in R
Hot Network Questions

How to print values in a text file to columnated file using shell script
Why would you short two pins of a potentiometer?
What is a manifold?
Why is Latinum pressed in Gold?
3 phase (delta) power to single phase space heater
Logistic regression for data from Poisson distributions
Plausible Original Concept For High-Fidelity Apocalypse? (Research For TV Drama)
Basic software to install on computers to be donated
Is this Tic-Tac-Toe board valid?
How do you transport a locomotive without tracks?
Fermat Near Misses
Academic Misconduct with alternate exam? Minimizing damage?
Why isn't MacTripleDes algorithm output in PowerShell stable?
Parallel MOSFETs
How to find the mod of this large number
Draw Clock to help learn time
Does a 709 ride mean the end of my career?
characterization of subalgebras of universal enveloping algebra coming from Lie subalgebras
Which inorganic tool can never work when 3D printed?
How do you get users to think aloud?
Is there an elegant way to set a shell variable to the contents of a file?
Diddling an alien, is it even possible?
How to be hidden from world for a year
How to select only the lines that has points at at least one end?
question feed
about us tour help blog chat data legal privacy policy work here advertising info mobile contact us feedback
TECHNOLOGY	LIFE / ARTS	CULTURE / RECREATION	SCIENCE	OTHER
Stack Overflow
Server Fault
Super User
Web Applications
Ask Ubuntu
Webmasters
Game Development
TeX - LaTeX
Software Engineering
Unix & Linux
Ask Different (Apple)
WordPress Development
Geographic Information Systems
Electrical Engineering
Android Enthusiasts
Information Security
Database Administrators
Drupal Answers
SharePoint
User Experience
Mathematica
Salesforce
ExpressionEngine® Answers
Cryptography
Code Review
Magento
Signal Processing
Raspberry Pi
Programming Puzzles & Code Golf
more (7)
Photography
Science Fiction & Fantasy
Graphic Design
Movies & TV
Music: Practice & Theory
Seasoned Advice (cooking)
Home Improvement
Personal Finance & Money
Academia
more (8)
English Language & Usage
Skeptics
Mi Yodeya (Judaism)
Travel
Christianity
English Language Learners
Japanese Language
Arqade (gaming)
Bicycles
Role-playing Games
Anime & Manga
Motor Vehicle Maintenance & Repair
more (17)
MathOverflow
Mathematics
Cross Validated (stats)
Theoretical Computer Science
Physics
Chemistry
Biology
Computer Science
Philosophy
more (3)
Meta Stack Exchange
Stack Apps
Area 51
Stack Overflow Talent
site design / logo © 2016 Stack Exchange Inc; user contributions licensed under cc by-sa 3.0 with attribution required
rev 2016.12.12.4321