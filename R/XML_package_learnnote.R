> library(XML)
> readHTMLTable
standardGeneric for "readHTMLTable" defined from package "XML"

function (doc, header = NA, colClasses = NULL, skip.rows = integer(), 
    trim = TRUE, elFun = xmlValue, as.data.frame = TRUE, which = integer(), 
    ...) 
standardGeneric("readHTMLTable")
<environment: 0x000000000d04c958>
Methods may be defined for arguments: doc, header, colClasses, skip.rows, trim, elFun, as.data.frame, which
Use  showMethods("readHTMLTable")  for currently available ones.
> showMethods("readHTMLTable")
Function: readHTMLTable (package XML)
doc="character"
doc="HTMLInternalDocument"
doc="XMLInternalElementNode"




## Not run: 
## This changed to using https: in June 2015, and that is unsupported.
# u = "http://en.wikipedia.org/wiki/World_population"
 u = "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population"

 tables = readHTMLTable(u)
 names(tables)

 tables[[2]]
  # Print the table. Note that the values are all characters
  # not numbers. Also the column names have a preceding X since
  # R doesn't allow the variable names to start with digits.
 tmp = tables[[2]]


   # Let's just read the second table directly by itself.
 doc = htmlParse(u)
 tableNodes = getNodeSet(doc, "//table")
 tb = readHTMLTable(tableNodes[[2]])

  # Let's try to adapt the values on the fly.
  # We'll create a function that turns a th/td node into a val
 tryAsInteger = function(node) {
                  val = xmlValue(node)
                  ans = as.integer(gsub(",", "", val))
                  if(is.na(ans))
                      val
                  else
                      ans
                }

 tb = readHTMLTable(tableNodes[[2]], elFun = tryAsInteger)

 tb = readHTMLTable(tableNodes[[2]], elFun = tryAsInteger,
                       colClasses = c("character", rep("integer", 9)))

## End(Not run)

zz =
  readHTMLTable("http://www.inflationdata.com/Inflation/Consumer_Price_Index/HistoricalCPI.aspx")
if(any(i <- sapply(zz, function(x) if(is.null(x)) 0 else ncol(x)) == 14)) {
  # guard against the structure of the page changing.
    zz = zz[[which(i)[1]]]  # 4th table
    # convert columns to numeric.  Could use colClasses in the call to readHTMLTable()
    zz[-1] = lapply(zz[-1], function(x) as.numeric(gsub(".* ", "", as.character(x))))
    matplot(1:12, t(zz[-c(1, 14)]), type = "l")
}


# From Marsh Feldman on R-help, possibly
# https://stat.ethz.ch/pipermail/r-help/2010-March/232586.html
# That site was non-responsive in June 2015,
# and this does not do a good job on the current table.

doc <- "http://www.nber.org/cycles/cyclesmain.html"
# The  main table is the second one because it's embedded in the page table.
tables <- getNodeSet(htmlParse(doc), "//table")
xt <- readHTMLTable(tables[[2]],
                    header = c("peak","trough","contraction",
                               "expansion","trough2trough","peak2peak"),
                    colClasses = c("character","character","character",
                                   "character","character","character"),
                    trim = TRUE, stringsAsFactors = FALSE
                   )

if(FALSE) {
 # Here is a totally different way of reading tables from HTML documents.
 # The data are formatted using PRE and so can be read via read.table
 u = "http://tidesonline.nos.noaa.gov/data_read.shtml?station_info=9414290+San+Francisco,+CA"
 h = htmlParse(u)
 p = getNodeSet(h, "//pre")
 con = textConnection(xmlValue(p[[2]]))
 tides = read.table(con)
}

## Not run: 
## This is not accessible without authentication ...
u = "http://www.omegahat.net/RCurl/testPassword/table.html"
if(require(RCurl) && url.exists(u)) {
  tt =  getURL(u, userpwd = "bob:duncantl")
  readHTMLTable(tt)
}
## End(Not run)



doc = xmlParse("<foo><bar>Some text</bar></foo>", asText = TRUE)

nodes = getNodeSet(doc, "//bar")



makeRow = 
function(tbl = newXMLNode("table"))
{
  newXMLNode("tr", parent = tbl)
}



xmlTreeParse {XML}	R Documentation
XML Parser

Description

Parses an XML or HTML file or string containing XML/HTML content, and generates an R structure representing the XML/HTML tree. Use htmlTreeParse when the content is known to be (potentially malformed) HTML. This function has numerous parameters/options and operates quite differently based on their values. It can create trees in R or using internal C-level nodes, both of which are useful in different contexts. It can perform conversion of the nodes into R objects using caller-specified handler functions and this can be used to map the XML document directly into R data structures, by-passing the conversion to an R-level tree which would then be processed recursively or with multiple descents to extract the information of interest.

xmlParse and htmlParse are equivalent to the xmlTreeParse and htmlTreeParse respectively, except they both use a default value for the useInternalNodes parameter of TRUE, i.e. they working with and return internal nodes/C-level nodes. These can then be searched using XPath expressions via xpathApply and getNodeSet.

xmlSchemaParse is a convenience function for parsing an XML schema.

Usage

xmlTreeParse(file, ignoreBlanks=TRUE, handlers=NULL, replaceEntities=FALSE,
             asText=FALSE, trim=TRUE, validate=FALSE, getDTD=TRUE,
             isURL=FALSE, asTree = FALSE, addAttributeNamespaces = FALSE,
             useInternalNodes = FALSE, isSchema = FALSE,
             fullNamespaceInfo = FALSE, encoding = character(),
             useDotNames = length(grep("^\\.", names(handlers))) > 0,
             xinclude = TRUE, addFinalizer = TRUE, error = xmlErrorCumulator(),
             isHTML = FALSE, options = integer(), parentFirst = FALSE)

xmlInternalTreeParse(file, ignoreBlanks=TRUE, handlers=NULL, replaceEntities=FALSE,
             asText=FALSE, trim=TRUE, validate=FALSE, getDTD=TRUE,
             isURL=FALSE, asTree = FALSE, addAttributeNamespaces = FALSE,
             useInternalNodes = TRUE, isSchema = FALSE,
             fullNamespaceInfo = FALSE, encoding = character(),
             useDotNames = length(grep("^\\.", names(handlers))) > 0,
             xinclude = TRUE, addFinalizer = TRUE, error = xmlErrorCumulator(),
             isHTML = FALSE, options = integer(), parentFirst = FALSE)

xmlNativeTreeParse(file, ignoreBlanks=TRUE, handlers=NULL, replaceEntities=FALSE,
             asText=FALSE, trim=TRUE, validate=FALSE, getDTD=TRUE,
             isURL=FALSE, asTree = FALSE, addAttributeNamespaces = FALSE,
             useInternalNodes = TRUE, isSchema = FALSE,
             fullNamespaceInfo = FALSE, encoding = character(),
             useDotNames = length(grep("^\\.", names(handlers))) > 0,
             xinclude = TRUE, addFinalizer = TRUE, error = xmlErrorCumulator(),
             isHTML = FALSE, options = integer(), parentFirst = FALSE)


htmlTreeParse(file, ignoreBlanks=TRUE, handlers=NULL, replaceEntities=FALSE,
             asText=FALSE, trim=TRUE, validate=FALSE, getDTD=TRUE,
             isURL=FALSE, asTree = FALSE, addAttributeNamespaces = FALSE,
             useInternalNodes = FALSE, isSchema = FALSE,
             fullNamespaceInfo = FALSE, encoding = character(),
             useDotNames = length(grep("^\\.", names(handlers))) > 0,
             xinclude = TRUE, addFinalizer = TRUE, error = htmlErrorHandler,
             isHTML = TRUE, options = integer(), parentFirst = FALSE)

htmlParse(file, ignoreBlanks = TRUE, handlers = NULL, replaceEntities = FALSE, 
          asText = FALSE, trim = TRUE, validate = FALSE, getDTD = TRUE, 
           isURL = FALSE, asTree = FALSE, addAttributeNamespaces = FALSE, 
            useInternalNodes = TRUE, isSchema = FALSE, fullNamespaceInfo = FALSE, 
             encoding = character(), 
             useDotNames = length(grep("^\\.", names(handlers))) > 0, 
              xinclude = TRUE, addFinalizer = TRUE, 
               error = htmlErrorHandler, isHTML = TRUE,
                options = integer(), parentFirst = FALSE) 

xmlSchemaParse(file, asText = FALSE, xinclude = TRUE, error = xmlErrorCumulator())
Arguments

file	
The name of the file containing the XML contents. This can contain \~ which is expanded to the user's home directory. It can also be a URL. See isURL. Additionally, the file can be compressed (gzip) and is read directly without the user having to de-compress (gunzip) it.

ignoreBlanks	
logical value indicating whether text elements made up entirely of white space should be included in the resulting ‘tree’.

handlers	
Optional collection of functions used to map the different XML nodes to R objects. Typically, this is a named list of functions, and a closure can be used to provide local data. This provides a way of filtering the tree as it is being created in R, adding or removing nodes, and generally processing them as they are constructed in the C code.

In a recent addition to the package (version 0.99-8), if this is specified as a single function object, we call that function for each node (of any type) in the underlying DOM tree. It is invoked with the new node and its parent node. This applies to regular nodes and also comments, processing instructions, CDATA nodes, etc. So this function must be sufficiently general to handle them all.

replaceEntities	
logical value indicating whether to substitute entity references with their text directly. This should be left as False. The text still appears as the value of the node, but there is more information about its source, allowing the parse to be reversed with full reference information.

asText	
logical value indicating that the first argument, ‘file’, should be treated as the XML text to parse, not the name of a file. This allows the contents of documents to be retrieved from different sources (e.g. HTTP servers, XML-RPC, etc.) and still use this parser.

trim	
whether to strip white space from the beginning and end of text strings.

validate	
logical indicating whether to use a validating parser or not, or in other words check the contents against the DTD specification. If this is true, warning messages will be displayed about errors in the DTD and/or document, but the parsing will proceed except for the presence of terminal errors. This is ignored when parsing an HTML document.

getDTD	
logical flag indicating whether the DTD (both internal and external) should be returned along with the document nodes. This changes the return type. This is ignored when parsing an HTML document.

isURL	
indicates whether the file argument refers to a URL (accessible via ftp or http) or a regular file on the system. If asText is TRUE, this should not be specified. The function attempts to determine whether the data source is a URL by using grep to look for http or ftp at the start of the string. The libxml parser handles the connection to servers, not the R facilities (e.g. scan).

asTree	
this only applies when on passes a value for the handlers argument and is used then to determine whether the DOM tree should be returned or the handlers object.

addAttributeNamespaces	
a logical value indicating whether to return the namespace in the names of the attributes within a node or to omit them. If this is TRUE, an attribute such as xsi:type="xsd:string" is reported with the name xsi:type. If it is FALSE, the name of the attribute is type.

useInternalNodes	
a logical value indicating whether to call the converter functions with objects of class XMLInternalNode rather than XMLNode. This should make things faster as we do not convert the contents of the internal nodes to R explicit objects. Also, it allows one to access the parent and ancestor nodes. However, since the objects refer to volatile C-level objects, one cannot store these nodes for use in further computations within R. They “disappear” after the processing the XML document is completed.

If this argument is TRUE and no handlers are provided, the return value is a reference to the internal C-level document pointer. This can be used to do post-processing via XPath expressions using getNodeSet.

This is ignored when parsing an HTML document.

isSchema	
a logical value indicating whether the document is an XML schema (TRUE) and should be parsed as such using the built-in schema parser in libxml.

fullNamespaceInfo	
a logical value indicating whether to provide the namespace URI and prefix on each node or just the prefix. The latter (FALSE) is currently the default as that was the original way the package behaved. However, using TRUE is more informative and we will make this the default in the future.

This is ignored when parsing an HTML document.

encoding	
a character string (scalar) giving the encoding for the document. This is optional as the document should contain its own encoding information. However, if it doesn't, the caller can specify this for the parser. If the XML/HTML document does specify its own encoding that value is used regardless of any value specified by the caller. (That's just the way it goes!) So this is to be used as a safety net in case the document does not have an encoding and the caller happens to know theactual encoding.

useDotNames	
a logical value indicating whether to use the newer format for identifying general element function handlers with the '.' prefix, e.g. .text, .comment, .startElement. If this is FALSE, then the older format text, comment, startElement, ... are used. This causes problems when there are indeed nodes named text or comment or startElement as a node-specific handler are confused with the corresponding general handler of the same name. Using TRUE means that your list of handlers should have names that use the '.' prefix for these general element handlers. This is the preferred way to write new code.

xinclude	
a logical value indicating whether to process nodes of the form <xi:include xmlns:xi="http://www.w3.org/2001/XInclude"> to insert content from other parts of (potentially different) documents. TRUE means resolve the external references; FALSE means leave the node as is. Of course, one can process these nodes oneself after document has been parse using handler functions or working on the DOM. Please note that the syntax for inclusion using XPointer is not the same as XPath and the results can be a little unexpected and confusing. See the libxml2 documentation for more details.

addFinalizer	
a logical value indicating whether the default finalizer routine should be registered to free the internal xmlDoc when R no longer has a reference to this external pointer object. This is only relevant when useInternalNodes is TRUE.

error	
a function that is invoked when the XML parser reports an error. When an error is encountered, this is called with 7 arguments. See xmlStructuredStop for information about these

If parsing completes and no document is generated, this function is called again with only argument which is a character vector of length 0. This gives the function an opportunity to report all the errors and raise an exception rather than doing this when it sees th first one.

This function can do what it likes with the information. It can raise an R error or let parser continue and potentially find further errors.

The default value of this argument supplies a function that cumulates the errors

If this is NULL, the default error handler function in the package xmlStructuredStop is invoked and this will raise an error in R at that time in R.

isHTML	
a logical value that allows this function to be used for parsing HTML documents. This causes validation and processing of a DTD to be turned off. This is currently experimental so that we can implement htmlParse with this same function.

options	
an integer value or vector of values that are combined (OR'ed) together to specify options for the XML parser. This is the same as the options parameter for xmlParseDoc.

parentFirst	
a logical value for use when we have handler functions and are traversing the tree. This controls whether we process the node before processing its children, or process the children before their parent node.

Details

The handlers argument is used similarly to those specified in xmlEventParse. When an XML tag (element) is processed, we look for a function in this collection with the same name as the tag's name. If this is not found, we look for one named startElement. If this is not found, we use the default built in converter. The same works for comments, entity references, cdata, processing instructions, etc. The default entries should be named comment, startElement, externalEntity, processingInstruction, text, cdata and namespace. All but the last should take the XMLnode as their first argument. In the future, other information may be passed via ..., for example, the depth in the tree, etc. Specifically, the second argument will be the parent node into which they are being added, but this is not currently implemented, so should have a default value (NULL).

The namespace function is called with a single argument which is an object of class XMLNameSpace. This contains

id
the namespace identifier as used to qualify tag names;

uri
the value of the namespace identifier, i.e. the URI identifying the namespace.

local
a logical value indicating whether the definition is local to the document being parsed.

One should note that the namespace handler is called before the node in which the namespace definition occurs and its children are processed. This is different than the other handlers which are called after the child nodes have been processed.

Each of these functions can return arbitrary values that are then entered into the tree in place of the default node passed to the function as the first argument. This allows the caller to generate the nodes of the resulting document tree exactly as they wish. If the function returns NULL, the node is dropped from the resulting tree. This is a convenient way to discard nodes having processed their contents.

Value

By default ( when useInternalNodes is FALSE, getDTD is TRUE, and no handler functions are provided), the return value is, an object of (S3) class XMLDocument. This has two fields named doc and dtd and are of class DTDList and XMLDocumentContent respectively.

If getDTD is FALSE, only the doc object is returned.

The doc object has three fields of its own: file, version and children.

file	
The (expanded) name of the file containing the XML.

version	
A string identifying the version of XML used by the document.

children	
A list of the XML nodes at the top of the document. Each of these is of class XMLNode. These are made up of 4 fields.

nameThe name of the element.

attributesFor regular elements, a named list of XML attributes converted from the <tag x="1" y="abc">

childrenList of sub-nodes.

valueUsed only for text entries.

Some nodes specializations of XMLNode, such as XMLComment, XMLProcessingInstruction, XMLEntityRef are used.

If the value of the argument getDTD is TRUE and the document refers to a DTD via a top-level DOCTYPE element, the DTD and its information will be available in the dtd field. The second element is a list containing the external and internal DTDs. Each of these contains 2 lists - one for element definitions and another for entities. See parseDTD.

If a list of functions is given via handlers, this list is returned. Typically, these handler functions share state via a closure and the resulting updated data structures which contain the extracted and processed values from the XML document can be retrieved via a function in this handler list.

If asTree is TRUE, then the converted tree is returned. What form this takes depends on what the handler functions have done to process the XML tree.

If useInternalNodes is TRUE and no handlers are specified, an object of S3 class XMLInternalDocument is returned. This can be used in much the same ways as an XMLDocument, e.g. with xmlRoot, docName and so on to traverse the tree. It can also be used with XPath queries via getNodeSet, xpathApply and doc["xpath-expression"].

If internal nodes are used and the internal tree returned directly, all the nodes are returned as-is and no attempt to trim white space, remove “empty” nodes (i.e. containing only white space), etc. is done. This is potentially quite expensive and so is not done generally, but should be done during the processing of the nodes. When using XPath queries, such nodes are easily identified and/or ignored and so do not cause any difficulties. They do become an issue when dealing with a node's chidren directly and so one can use simple filtering techniques such as xmlChildren(node)[ ! xmlSApply(node, inherits, "XMLInternalTextNode")] and even check the xmlValue to determine if it contains only white space. xmlChildren(node)[ ! xmlSApply(node, function(x) inherit(x, "XMLInternalTextNode")] && trim(xmlValue(x)) == "")

Note

Make sure that the necessary 3rd party libraries are available.

Author(s)

Duncan Temple Lang <duncan@wald.ucdavis.edu>

References

http://xmlsoft.org, http://www.w3.org/xml

See Also

xmlEventParse, free for releasing the memory when an XMLInternalDocument object is returned.

Examples

 fileName <- system.file("exampleData", "test.xml", package="XML")
   # parse the document and return it in its standard format.

 xmlTreeParse(fileName)

   # parse the document, discarding comments.
  
 xmlTreeParse(fileName, handlers=list("comment"=function(x,...){NULL}), asTree = TRUE)

   # print the entities
 invisible(xmlTreeParse(fileName,
            handlers=list(entity=function(x) {
                                    cat("In entity",x$name, x$value,"\n")
                                    x}
                                  ), asTree = TRUE
                          )
          )

 # Parse some XML text.
 # Read the text from the file
 xmlText <- paste(readLines(fileName), "\n", collapse="")

 print(xmlText)
 xmlTreeParse(xmlText, asText=TRUE)


    # with version 1.4.2 we can pass the contents of an XML
    # stream without pasting them.
 xmlTreeParse(readLines(fileName), asText=TRUE)


 # Read a MathML document and convert each node
 # so that the primary class is 
 #   <name of tag>MathML
 # so that we can use method  dispatching when processing
 # it rather than conditional statements on the tag name.
 # See plotMathML() in examples/.
 fileName <- system.file("exampleData", "mathml.xml",package="XML")
m <- xmlTreeParse(fileName, 
                  handlers=list(
                   startElement = function(node){
                   cname <- paste(xmlName(node),"MathML", sep="",collapse="")
                   class(node) <- c(cname, class(node)); 
                   node
                }))



  # In this example, we extract _just_ the names of the
  # variables in the mtcars.xml file. 
  # The names are the contents of the <variable>
  # tags. We discard all other tags by returning NULL
  # from the startElement handler.
  #
  # We cumulate the names of variables in a character
  # vector named `vars'.
  # We define this within a closure and define the 
  # variable function within that closure so that it
  # will be invoked when the parser encounters a <variable>
  # tag.
  # This is called with 2 arguments: the XMLNode object (containing
  # its children) and the list of attributes.
  # We get the variable name via call to xmlValue().

  # Note that we define the closure function in the call and then 
  # create an instance of it by calling it directly as
  #   (function() {...})()

  # Note that we can get the names by parsing
  # in the usual manner and the entire document and then executing
  # xmlSApply(xmlRoot(doc)[[1]], function(x) xmlValue(x[[1]]))
  # which is simpler but is more costly in terms of memory.
 fileName <- system.file("exampleData", "mtcars.xml", package="XML")
 doc <- xmlTreeParse(fileName,  handlers = (function() { 
                                 vars <- character(0) ;
                                list(variable=function(x, attrs) { 
                                                vars <<- c(vars, xmlValue(x[[1]])); 
                                                NULL}, 
                                     startElement=function(x,attr){
                                                   NULL
                                                  }, 
                                     names = function() {
                                                 vars
                                             }
                                    )
                               })()
                     )

  # Here we just print the variable names to the console
  # with a special handler.
 doc <- xmlTreeParse(fileName, handlers = list(
                                  variable=function(x, attrs) {
                                             print(xmlValue(x[[1]])); TRUE
                                           }), asTree=TRUE)


  # This should raise an error.
  try(xmlTreeParse(
            system.file("exampleData", "TestInvalid.xml", package="XML"),
            validate=TRUE))

## Not run: 
 # Parse an XML document directly from a URL.
 # Requires Internet access.
 xmlTreeParse("http://www.omegahat.net/Scripts/Data/mtcars.xml", asText=TRUE)

## End(Not run)

  counter = function() {
              counts = integer(0)
              list(startElement = function(node) {
                                     name = xmlName(node)
                                     if(name %in% names(counts))
                                          counts[name] <<- counts[name] + 1
                                     else
                                          counts[name] <<- 1
                                  },
                    counts = function() counts)
            }

   h = counter()
   xmlParse(system.file("exampleData", "mtcars.xml", package="XML"),  handlers = h)
   h$counts()



 f = system.file("examples", "index.html", package = "XML")
 htmlTreeParse(readLines(f), asText = TRUE)
 htmlTreeParse(readLines(f))

  # Same as 
 htmlTreeParse(paste(readLines(f), collapse = "\n"), asText = TRUE)


 getLinks = function() { 
       links = character() 
       list(a = function(node, ...) { 
                   links <<- c(links, xmlGetAttr(node, "href"))
                   node 
                }, 
            links = function()links)
     }

 h1 = getLinks()
 htmlTreeParse(system.file("examples", "index.html", package = "XML"),
               handlers = h1)
 h1$links()

 h2 = getLinks()
 htmlTreeParse(system.file("examples", "index.html", package = "XML"),
              handlers = h2, useInternalNodes = TRUE)
 all(h1$links() == h2$links())

  # Using flat trees
 tt = xmlHashTree()
 f = system.file("exampleData", "mtcars.xml", package="XML")
 xmlTreeParse(f, handlers = list(.startElement = tt[[".addNode"]]))
 xmlRoot(tt)



 doc = xmlTreeParse(f, useInternalNodes = TRUE)

 sapply(getNodeSet(doc, "//variable"), xmlValue)
         
 #free(doc) 


  # character set encoding for HTML
 f = system.file("exampleData", "9003.html", package = "XML")
   # we specify the encoding
 d = htmlTreeParse(f, encoding = "UTF-8")
   # get a different result if we do not specify any encoding
 d.no = htmlTreeParse(f)
   # document with its encoding in the HEAD of the document.
 d.self = htmlTreeParse(system.file("exampleData", "9003-en.html",package = "XML"))
   # XXX want to do a test here to see the similarities between d and
   # d.self and differences between d.no


  # include
 f = system.file("exampleData", "nodes1.xml", package = "XML")
 xmlRoot(xmlTreeParse(f, xinclude = FALSE))
 xmlRoot(xmlTreeParse(f, xinclude = TRUE))

 f = system.file("exampleData", "nodes2.xml", package = "XML")
 xmlRoot(xmlTreeParse(f, xinclude = TRUE))

  # Errors
  try(xmlTreeParse("<doc><a> & < <?pi > </doc>"))

    # catch the error by type.
 tryCatch(xmlTreeParse("<doc><a> & < <?pi > </doc>"),
                "XMLParserErrorList" = function(e) {
                     cat("Errors in XML document\n", e$message, "\n")
                                                    })

    #  terminate on first error            
  try(xmlTreeParse("<doc><a> & < <?pi > </doc>", error = NULL))

    #  see xmlErrorCumulator in the XML package 


  f = system.file("exampleData", "book.xml", package = "XML")
  doc.trim = xmlInternalTreeParse(f, trim = TRUE)
  doc = xmlInternalTreeParse(f, trim = FALSE)
  xmlSApply(xmlRoot(doc.trim), class)
      # note the additional XMLInternalTextNode objects
  xmlSApply(xmlRoot(doc), class)


  top = xmlRoot(doc)
  textNodes = xmlSApply(top, inherits, "XMLInternalTextNode")
  sapply(xmlChildren(top)[textNodes], xmlValue)


     # Storing nodes
   f = system.file("exampleData", "book.xml", package = "XML")
   titles = list()
   xmlTreeParse(f, handlers = list(title = function(x)
                                  titles[[length(titles) + 1]] <<- x))
   sapply(titles, xmlValue)
   rm(titles)
[Package XML version 3.98-1.4 Index]


makeRow()


library(XML)
doc = xmlParse("data/mtcars.xml")  # finalizer registered.
nodes1 = getNodeSet(doc, "//record[@id='Mazda RX4']") # get one node - finalizer registered
.Call("R_getXMLRefCount", nodes1[[1]])  # ask for its reference count
nodes2 = getNodeSet(doc, "//record[@id='Mazda RX4']") # get the same node again, finalizer registered on new object
.Call("R_getXMLRefCount", nodes2[[1]])
.Call("R_getXMLRefCount", nodes1[[1]])

rm(doc)
gc()
rm(nodes1)
gc()
.Call("R_getXMLRefCount", nodes2[[1]])
rm(nodes2)
gc()

rm(nodes2)
gc()

src = xpathApply(doc, "//a[@href]", xmlGetAttr, "href")


doc = xmlInternalTreeParse("http://stockdata.stock.hexun.com/2008en/zxcwzb.aspx?stockid=600016")

doc = xmlInternalTreeParse("/tmp/test.xml")
> xpathApply(doc, "//h1")
[[1]]
<h1>Why I like Monkeys</h1> 

attr(,"class")
[1] "XMLNodeSet"
> xpathApply(doc, "//h1",xmlValue)
[[1]]
[1] "Why I like Monkeys"

xmlName() , xmlAttrs() , xmlGetAttr() , xmlChildren() and xmlValue() . xmlName() gets the name of the node/element. xmlAttrs() returns all the attribute name-value pairs as a character vector while xmlGetAttr() is used to query the value of a single attribute with facilities for providing a default value if it is not present and converting it if it is. We tend to use xmlGetAttr() as we typically know which attributes we are looking for. xmlAttrs() is used when doing general/meta- computations.

The XPath functions in the XML package are getNodeSet() and xpathApply() . Basically, you specify the document returned from xmlInternalTreeParse() and the XPath expression to identify the nodes. getNodeSet() returns a list of the matching nodes. xpathApply() is used to apply a function to each of those nodes, e.g. find nodes named "a anywhere in the tree that have an "href" attribute and get the value of that attribute 
 getNodeSet()


 doc = xmlParse(system.file("exampleData", "tagnames.xml", package = "XML")
)
      
      els = getNodeSet(doc, "/doc//a[@status]")
      sapply(els, function(el) xmlGetAttr(el, "status"))





Abstract

The idea here is to provide simple examples of how to get started with processing XML in R using some reasonably straightforward "flat" XML files and not worrying about efficiency.
An Example: Grades

Here is an example of a simple file in XML containing grades for students for three different tests.

<?xml version="1.0" ?>
<TABLE>
   <GRADES>
      <STUDENT> Fred </STUDENT>
      <TEST1> 66 </TEST1>
      <TEST2> 80 </TEST2>
      <FINAL> 70 </FINAL>
   </GRADES>
   <GRADES>
      <STUDENT> Wilma </STUDENT>
      <TEST1> 97 </TEST1>
      <TEST2> 91 </TEST2>
      <FINAL> 98 </FINAL>
   </GRADES>
</TABLE>

We might want to turn this into a data frame in R with a row for each student and four variables, the name and the scores on the three tests.

Since this is a small file, let's not worry about efficiency in any way. We can read the entire document tree into memory and make multiple passes over it to get the information. Our first approach will be to read the XML into an R tree, i.e. R-level XML node objects. We do this with a simple call to xmlTreeParse() .

doc = xmlRoot(xmlTreeParse("generic_file.xml"))

We use xmlRoot() to get the top-level node of the tree rather than holding onto the general document information since we won't need it.

Since the structure of this file is just a list of elements under the root node, we need only process each of those nodes and turn them into something we want. The "easiest" way to apply the same function to each child of an XML node is with the xmlApply() function. What do we want to do for each of the <GRADES> node? We want to get the value, i.e. the simple text within the node, of each of its children. Since this is the same for each of the child nodes in <GRADES>, this is again another call to xmlApply() . And since this is all text, we can simplify the result and get back a character vector rather than a list by using xmlSApply() which will perform this extra simplication step.

So a function to do the initial processing of an individual <GRADES> node might be

 function(node) 
     xmlSApply(node, xmlValue)

since xmlValue() returns the text content within an XML node. Let's check that this does what we want by calling it on the first child of the root node.

 xmlSApply(doc[[1]], xmlValue)

And indeed it does.

So we can process all the <GRADES> nodes with the command

 tmp = xmlSApply(doc, function(x) xmlSApply(x, xmlValue))

The result is a character matrix in which the rows are the variables and the columns are the records. So let's transpose this.

 tmp = t(tmp)

Now, we have finished working with the XML; the rest is regular R programming.

 grades = as.data.frame(matrix(as.numeric(tmp[,-1]), 2))
 names(grades) = names(doc[[1]])[-1]
 grades$Student = tmp[,1]

There seems to be more messing about after we have got the values out of the XML file. There are several things that might seem more complex but that actually just move the work to different places, i.e. when we are traversing the XML tree.

Here's another alternative using XPath.

doc = xmlTreeParse("generic_file.xml", useInternal = TRUE)

ans = lapply(c("STUDENT", "TEST1", "TEST2", "FINAL"),
             function(var)
               unlist(xpathApply(doc, paste("//", var, sep = ""), xmlValue)))

And this gives us a list containing the variables with the values as character vectors.

as.data.frame(lapply(names(ans), 
                     function(x) if(x != "STUDENT") as.integer(x) else x ))

Another Example: Customer Information List

The second example is another list, this time of description of customers. The first two nodes in the document are shown below:


<dataroot xmlns:od="urn:schemas-microsoft-com:officedata">
<Customers>
<CustomerID>ALFKI</CustomerID>
<CompanyName>Alfreds Futterkiste</CompanyName>
<ContactName>Maria Anders</ContactName>
<ContactTitle>Sales Representative</ContactTitle>
<Address>Obere Str. 57</Address>
<City>Berlin</City>
<PostalCode>12209</PostalCode>
<Country>Germany</Country>
<Phone>030-0074321</Phone>
<Fax>030-0076545</Fax>
</Customers>
<Customers>
<CustomerID>ANATR</CustomerID>
<CompanyName>Ana Trujillo Emparedados y helados</CompanyName>
<ContactName>Ana Trujillo</ContactName>
<ContactTitle>Owner</ContactTitle>
<Address>Avda. de la Constitución 2222</Address>
<City>México D.F.</City>
<PostalCode>05021</PostalCode>
<Country>Mexico</Country>
<Phone>(5) 555-4729</Phone>
<Fax>(5) 555-3745</Fax>
</Customers>
</dataroot>

We can quickly verify that all the nodes under the root are customers with the command

 doc = xmlRoot(xmlTreeParse("Cust-List.xml"))
 table(names(doc))

We see that these are all "Customers". We could further explore to see if each of these nodes has the same fields.

fields = xmlApply(doc, names)
table(sapply(fields, identical, fields[[1]]))

And the result indicates that about half of them are the same. Let's see how many unique field names there are:

 unique(unlist(fields))

This gives 10. And we can see how may fields are in each of the Customers nodes with

xmlSApply(doc, xmlSize)

So most of the nodes have most of the fields.

So let's think about a data frame. What we can do is treat each of the fields as having a simple string value. Then we can create a data frame with the 10 character columns and with NA values for each of the records. Thne we will fill this in record at a time.

ans = as.data.frame(replicate(10, character(xmlSize(doc))), 
                      stringsAsFactors = FALSE)
names(ans) = unique(unlist(fields))

Now that we have the skeleton of the answer, we can process each of the Customers nodes.

sapply(1:xmlSize(doc),
          function(i) {
             customer = doc[[i]] 
             ans[i, names(customer)] <<- xmlSApply(customer, xmlValue)
          })

Note that we used a global assignemnt in the function to change the ans in the global environment rather than the local version within the function call. Also, we loop over the indices of the nodes in the tree, i.e. use sapply(1:xmlSize(doc), ) rather than xmlSApply(doc, ) simply because we need to know which row to put the results for each node.

There are various other ways to process these two XML files. One is to use handler functions to process the internal nodes as they are being converted from C-level data structures to R objects in a call to xmlTreeParse() . This avoids multiple traversal of the tree but can seem a little indirect until you get the hang of it. And some transformations can be cumbersome using this approach as it is a bottom up transformation.

The event-driven parsing provided by xmlEventParse() is a SAX style approach. This is quite low level and used when reading the entire XML document into memory and then processing it is prohibitive, i.e. when the XML file is very, very large.

The use of XPath to perform queries and get subsets of nodes involves a) learning XPath and b) potentially multiple passes over the tree. If one has to do many queries, this can be slow overall eventhough each is very fast. However, if you know XPath or are happy to learn the basics, this can be quite convenient, avoiding having to write recursive functions to search for the nodes of interests. Using the internal nodes (as you must for XPath) also gives you the ability to go up the tree, i.e. find parent, ancestor and sibling nodes, and not just down to children. So we have more flexibility in how we traverse the tree.



Abstract

The idea here is to provide simple examples of how to get started with processing XML in R using some reasonably straightforward "flat" XML files and not worrying about efficiency.
An Example: Grades

Here is an example of a simple file in XML containing grades for students for three different tests.

<?xml version="1.0" ?>
<TABLE>
   <GRADES>
      <STUDENT> Fred </STUDENT>
      <TEST1> 66 </TEST1>
      <TEST2> 80 </TEST2>
      <FINAL> 70 </FINAL>
   </GRADES>
   <GRADES>
      <STUDENT> Wilma </STUDENT>
      <TEST1> 97 </TEST1>
      <TEST2> 91 </TEST2>
      <FINAL> 98 </FINAL>
   </GRADES>
</TABLE>

We might want to turn this into a data frame in R with a row for each student and four variables, the name and the scores on the three tests.

Since this is a small file, let's not worry about efficiency in any way. We can read the entire document tree into memory and make multiple passes over it to get the information. Our first approach will be to read the XML into an R tree, i.e. R-level XML node objects. We do this with a simple call to xmlTreeParse() .

doc = xmlRoot(xmlTreeParse("generic_file.xml"))

We use xmlRoot() to get the top-level node of the tree rather than holding onto the general document information since we won't need it.

Since the structure of this file is just a list of elements under the root node, we need only process each of those nodes and turn them into something we want. The "easiest" way to apply the same function to each child of an XML node is with the xmlApply() function. What do we want to do for each of the <GRADES> node? We want to get the value, i.e. the simple text within the node, of each of its children. Since this is the same for each of the child nodes in <GRADES>, this is again another call to xmlApply() . And since this is all text, we can simplify the result and get back a character vector rather than a list by using xmlSApply() which will perform this extra simplication step.

So a function to do the initial processing of an individual <GRADES> node might be

 function(node) 
     xmlSApply(node, xmlValue)

since xmlValue() returns the text content within an XML node. Let's check that this does what we want by calling it on the first child of the root node.

 xmlSApply(doc[[1]], xmlValue)

And indeed it does.

So we can process all the <GRADES> nodes with the command

 tmp = xmlSApply(doc, function(x) xmlSApply(x, xmlValue))

The result is a character matrix in which the rows are the variables and the columns are the records. So let's transpose this.

 tmp = t(tmp)

Now, we have finished working with the XML; the rest is regular R programming.

 grades = as.data.frame(matrix(as.numeric(tmp[,-1]), 2))
 names(grades) = names(doc[[1]])[-1]
 grades$Student = tmp[,1]

There seems to be more messing about after we have got the values out of the XML file. There are several things that might seem more complex but that actually just move the work to different places, i.e. when we are traversing the XML tree.

Here's another alternative using XPath.

doc = xmlTreeParse("generic_file.xml", useInternal = TRUE)

ans = lapply(c("STUDENT", "TEST1", "TEST2", "FINAL"),
             function(var)
               unlist(xpathApply(doc, paste("//", var, sep = ""), xmlValue)))

And this gives us a list containing the variables with the values as character vectors.

as.data.frame(lapply(names(ans), 
                     function(x) if(x != "STUDENT") as.integer(x) else x ))

Another Example: Customer Information List

The second example is another list, this time of description of customers. The first two nodes in the document are shown below:


<dataroot xmlns:od="urn:schemas-microsoft-com:officedata">
<Customers>
<CustomerID>ALFKI</CustomerID>
<CompanyName>Alfreds Futterkiste</CompanyName>
<ContactName>Maria Anders</ContactName>
<ContactTitle>Sales Representative</ContactTitle>
<Address>Obere Str. 57</Address>
<City>Berlin</City>
<PostalCode>12209</PostalCode>
<Country>Germany</Country>
<Phone>030-0074321</Phone>
<Fax>030-0076545</Fax>
</Customers>
<Customers>
<CustomerID>ANATR</CustomerID>
<CompanyName>Ana Trujillo Emparedados y helados</CompanyName>
<ContactName>Ana Trujillo</ContactName>
<ContactTitle>Owner</ContactTitle>
<Address>Avda. de la Constitución 2222</Address>
<City>México D.F.</City>
<PostalCode>05021</PostalCode>
<Country>Mexico</Country>
<Phone>(5) 555-4729</Phone>
<Fax>(5) 555-3745</Fax>
</Customers>
</dataroot>

We can quickly verify that all the nodes under the root are customers with the command

 doc = xmlRoot(xmlTreeParse("Cust-List.xml"))
 table(names(doc))

We see that these are all "Customers". We could further explore to see if each of these nodes has the same fields.

fields = xmlApply(doc, names)
table(sapply(fields, identical, fields[[1]]))

And the result indicates that about half of them are the same. Let's see how many unique field names there are:

 unique(unlist(fields))

This gives 10. And we can see how may fields are in each of the Customers nodes with

xmlSApply(doc, xmlSize)

So most of the nodes have most of the fields.

So let's think about a data frame. What we can do is treat each of the fields as having a simple string value. Then we can create a data frame with the 10 character columns and with NA values for each of the records. Thne we will fill this in record at a time.

ans = as.data.frame(replicate(10, character(xmlSize(doc))), 
                      stringsAsFactors = FALSE)
names(ans) = unique(unlist(fields))

Now that we have the skeleton of the answer, we can process each of the Customers nodes.

sapply(1:xmlSize(doc),
          function(i) {
             customer = doc[[i]] 
             ans[i, names(customer)] <<- xmlSApply(customer, xmlValue)
          })

Note that we used a global assignemnt in the function to change the ans in the global environment rather than the local version within the function call. Also, we loop over the indices of the nodes in the tree, i.e. use sapply(1:xmlSize(doc), ) rather than xmlSApply(doc, ) simply because we need to know which row to put the results for each node.

There are various other ways to process these two XML files. One is to use handler functions to process the internal nodes as they are being converted from C-level data structures to R objects in a call to xmlTreeParse() . This avoids multiple traversal of the tree but can seem a little indirect until you get the hang of it. And some transformations can be cumbersome using this approach as it is a bottom up transformation.

The event-driven parsing provided by xmlEventParse() is a SAX style approach. This is quite low level and used when reading the entire XML document into memory and then processing it is prohibitive, i.e. when the XML file is very, very large.

The use of XPath to perform queries and get subsets of nodes involves a) learning XPath and b) potentially multiple passes over the tree. If one has to do many queries, this can be slow overall eventhough each is very fast. However, if you know XPath or are happy to learn the basics, this can be quite convenient, avoiding having to write recursive functions to search for the nodes of interests. Using the internal nodes (as you must for XPath) also gives you the ability to go up the tree, i.e. find parent, ancestor and sibling nodes, and not just down to children. So we have more flexibility in how we traverse the tree.

