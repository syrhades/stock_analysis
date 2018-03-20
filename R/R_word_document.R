####################
library(ReporteRs)
# Create a word document to contain R outputs
doc <- docx()
# Add a title to the document
doc <- addTitle(doc, "Simple Word document", level=1)
# Add a paragraph of text into the Word document 
doc <- addParagraph(doc, "This simple Word document is created using R software and ReporteRs package. It contains just a simple text.")
# Add a sub title
doc <- addTitle(doc, "What is R language?", level = 2) 
doc <- addParagraph(doc, "R is a language and environment for statistical computing and graphics. R provides a wide variety of statistical and graphical techniques, and is highly extensible.")
doc <- addTitle(doc, "What is ReporteRs", level = 2)
doc <- addParagraph(doc, "ReporteRs is a package to write and format easily a Word document from R software.")
# Write the Word document to a file 
writeDoc(doc, file = "f:/r-reporters-simple-word-document.docx")



# Formatted text
my_text <- 'This is a ' + 
         pot('formatted text', textProperties(color="blue")) + 
        ' created using' + pot('ReporteRs', textBold()) + 'package'
# Create a hyperlynk
my_link <- pot( 'Click here to visit STHDA website!', 
          hyperlink = 'http://www.sthda.com/english',
          format=textBoldItalic(color = '#428BCA', underline = TRUE ))
###################################################
doc <- docx() 
# Change the default font size and font family
options('ReporteRs-fontsize'=12, 'ReporteRs-default-font'='Arial')
# Add a formatted paragraph of texts
#++++++++++++++++++++++++++++++
doc <- addTitle(doc, "Formatted text", level=1)
# Define a style to highlight a text
highlight_style <- textProperties(color='#1163A5',font.size = 20,
                font.weight = 'bold', font.family = 'Courier New' )
my_text = 'This ' + pot('Word document', highlight_style) +
  ' is created using' +
  pot(' R software', textProperties(color="red", font.size=18)) +
  ' and'+
  pot(' ReporteRs', textBoldItalic(color="#F0A91B", underlined=TRUE)) + ' package.'
doc <- addParagraph(doc, my_text)
# Add a hyperlink
doc <- addTitle(doc, "STHDA Web site", level=1)
my_link <- pot('Click here to visit STHDA web site!', 
          hyperlink = 'http://www.sthda.com/english',
          format=textBoldItalic(color = 'blue', underline = TRUE ))
doc <- addParagraph(doc, my_link)
# Write the Word document to a file 
writeDoc(doc, file = "f:/r-reporters-formatted-word-document.docx")

####################################

doc <- docx() # Create a Word document
# Add a title
doc <- addTitle(doc, "Word document with plots and Images", 
                level = 1)
# Add an introduction
doc <- addTitle(doc, "Introduction", level = 2)
doc = addParagraph(doc, value ="This Word document is created using R software and ReporteRs package. The goal of this section is to show you how to add plots and images into a Word document. This can be done easily using the functions addPlot() and addImages().")
# Add a box plot
doc <- addTitle(doc, "Box plot using R software", level = 2)
boxplotFunc<-function(){
  boxplot(len ~ dose, data = ToothGrowth,
      col = rainbow(3), main = "Guinea Pigs' Tooth Growth",
      xlab = "Vitamin C dose mg", ylab = "tooth length")
}
doc <- addPlot(doc, boxplotFunc)
 
doc <- addPageBreak(doc) # Go to the next page
# Add a histogram
doc <- addTitle(doc, "Histogram plot", level = 2)
doc <- addPlot(doc, function() hist(iris$Sepal.Width, col="lightblue"))
# Change point size of plotted text (in pixels, default = 12)
doc <- addTitle(doc, "Histogram with pointsize = 18", level = 2)
doc <- addPlot(doc, function() hist(iris$Sepal.Width,col="lightblue"), pointsize=18)
# Add an image
# +++++++++++++++++++++++++++
# download an image from STHDA web site
download.file(url="http://www.sthda.com/sthda/RDoc/figure/easy-ggplot2/ggplot2-histogram-demo.png",
              destfile="ggplot2-histogram-demo.png", quiet=TRUE)
doc <- addTitle(doc, "Image from STHDA web site", level = 2)
doc <- addImage(doc, "ggplot2-histogram-demo.png")
# Write the Word document to a file 
writeDoc(doc, file = "f:/r-reporters-word-document-with-plot.docx")


Add a simple table
#####################


doc <- docx()
data<-iris[1:5, ]
# Add a first table : Default table
doc <- addTitle(doc, "Default table")
doc <- addFlexTable( doc, FlexTable(data))
doc <- addParagraph(doc, c("", "")) # 2 line breaks
# Add a second table, theme : vanilla table
doc <- addTitle(doc, "Vanilla table")
doc <- addFlexTable( doc, vanilla.table(data))
writeDoc(doc, file = "f:/r-reporters-word-document-add-table.docx")


Add a zebra striped table

setZebraStyle() function can be used to color odd and even rows differently; for example, odd rows in gray color and even rows in white color.

doc <- docx()
data<-iris[1:5, ]
# Zebra striped tables
doc <- addTitle(doc, "Zebra striped tables")
MyFTable <- vanilla.table(data)
MyFTable <- setZebraStyle(MyFTable, odd = '#eeeeee', even = 'white')
doc <- addFlexTable( doc, MyFTable)
writeDoc(doc, file = "f:/r-reporters-word-document-zebra.docx")


Add lists : ordered and unordered lists
Ordered and unordered lists can be added using addParagraph() function as follow :

doc = addParagraph(doc, 
  value = c('Item 1', "Item 2", "Item 3")
  par.properties = parProperties(list.style = 'ordered', level = 1 )

value : a set of texts to be added as a list
par.properties : the paragraph formatting properties
list.style : possible values are ‘unordered’ and ‘ordered’
level : a numeric value indicating the level of the item to be added in the list


Add simple lists

doc <- docx()
# Ordered list
doc <- addTitle(doc, "Ordered List")
doc <- addParagraph(doc, value= c("Item 1", "Item 2", "Item 3"),
          par.properties =  parProperties(list.style = 'ordered'))
# Unordered list
doc <- addTitle(doc, "Unordered List")
doc <- addParagraph(doc, value= c("Item 1", "Item 2", "Item 3"),
          par.properties =  parProperties(list.style = 'unordered'))
writeDoc(doc, file = "r-reporters-word-document-lists.docx")

Add multi-level lists

To simplify the code, we’ll first define some levels to be used for creating multi-level lists.

doc <- docx()
# Define some levels for ordered lists (ol)
ol1 = parProperties(list.style = "ordered", level = 1)
ol2 = parProperties(list.style = "ordered", level = 2)
# Define some levels for unordered lists (ul)
ul1 = parProperties(list.style = "unordered", level = 1)
ul2 = parProperties(list.style = "unordered", level = 2)
# Multi-lvel ordered list
doc <- addTitle(doc, "Ordered List")
doc <- addParagraph(doc, value= "Item 1", par.properties =  ol1)
doc <- addParagraph(doc, value= "Item 1.1", par.properties =  ol2)
doc <- addParagraph(doc, value= "Item 1.2", par.properties =  ol2)
doc <- addParagraph(doc, value= "Item 2", par.properties =  ol1)
# Multi-lvel unordered list
doc <- addTitle(doc, "Unordered List")
doc <- addParagraph(doc, value= "Item 1", par.properties =  ul1)
doc <- addParagraph(doc, value= "Item 1.1", par.properties =  ul2)
doc <- addParagraph(doc, value= "Item 1.2", par.properties =  ul2)
doc <- addParagraph(doc, value= "Item 2", par.properties =  ul1)
writeDoc(doc, file = "r-reporters-word-document-multilevel-lists.docx")


library(ReporteRs)
doc <- docx()
# create footnotes
footnote1 <- Footnote( ) # footnote1 about R
footnote1 <- addParagraph(footnote1, "R is a free software for statistical computing and graphics.")
footnote2 <- Footnote( ) # footnote2 about ReporteRs package
footnote2 <- addParagraph(footnote2, "ReporteRs is an R package to write and format easily a Word document.")
# Use the footnotes when writing a paragraph into the document
doc <- addTitle(doc, "Word document with a footnote", level=1)
doc <- addParagraph(doc, 
      "This Word document is created using " + 
      pot("R software", footnote=footnote1)+ " and "+
      pot("ReporteRs", footnote=footnote2) +" package."
      )
writeDoc(doc, file = "r-reporters-word-document-footnote.docx")

Add R scripts
The function addRScript() can be used as follow :

doc <- docx()
r_code <- 'summary(cars$dist)
x <- rnorm(100)
hist(x)
'
# Change the backgroud-color
doc <- addRScript(doc, text = r_code,
    par.properties= parProperties(shading.color = 'gray90'))
writeDoc(doc, file = "r-reporters-word-add-r-code.docx")


doc <- docx() # Create a Word document
# Add a title
doc <- addTitle(doc, "Create a Word document with TOC", level = 1)
# Add a table of contents
doc <- addTOC(doc)
doc <- addPageBreak(doc) # go to the next page
# Add an introduction
doc <- addTitle(doc, "Introduction", level = 2)
doc = addParagraph(doc, value ="This Word document is created using R software and ReporteRs package. The goal of this section is to show you how to add a table of contents into a Word document. This can be done easily using the function addTOC.")
# Add a box plot
doc <- addTitle(doc, "Box plot using R software", level = 2)
boxplotFunc<-function(){
  boxplot(len ~ dose, data = ToothGrowth,
      col = rainbow(3), main = "Guinea Pigs' Tooth Growth",
      xlab = "Vitamin C dose mg", ylab = "tooth length")
}
doc <- addPlot(doc, boxplotFunc)
 
doc <- addPageBreak(doc) # go to the next page
# Add plots
#+++++++++++++++++++++
doc <- addTitle(doc, "Basic plots using R software", level = 2)
doc <- addParagraph(doc, "R is a free software for plotting and data analysis. This chapter contains examples of graphs generated using R.")
# Add a histogram
doc <- addTitle(doc, "Histogram", level = 3)
doc <- addPlot(doc, function() hist(iris$Sepal.Width,
                                  col="lightblue"))
doc <- addPageBreak(doc) # go to the next page
# Add a bar plot
doc <- addTitle(doc, "Bar plot", level = 3)
doc <- addPlot(doc, function() barplot(VADeaths))

frm_gg <-function(){
	ggplot(df157) + 
          # geom_line(aes(x=date,y=close%>%scale ))+
          geom_line(aes(x=date,y=close))
}
doc <- addPlot(doc, frm_gg)
# Write the Word document to a file 
writeDoc(doc, file = "f:/r-reporters-word-document-toc.docx")

ggplot(df157) + 
          # geom_line(aes(x=date,y=close%>%scale ))+
          geom_line(aes(x=date,y=close))


###################################
# Download a Word document template from STHDA website
# download.file(url="http://www.sthda.com/sthda/RDoc/example-files/r-reporters-word-document-template.docx",
#     destfile="r-reporters-word-document-template.docx", quiet=TRUE)
# Create a Word document using the downloaded template
doc <- docx(title="R software and ReporteRs package",
            template="f:/r-reporters-word-document-template.docx")
# Add titles
doc <- addTitle(doc, "Word document created from a template",
                level=1) 
# Add an introduction
doc <- addTitle(doc, "Introduction", level=2) # Add a sub title
doc <- addParagraph(doc, "This Word document is created from a template using R software and ReporteRs package.")
# Add  a table
doc <- addTitle(doc, "Iris data sets", level=2)
doc <- addFlexTable(doc, FlexTable(iris[1:10,]))
doc <- addTitle(doc, "Description of iris data sets", level=2)
doc <- addParagraph(doc, "iris data set gives the measurements in centimeters of the variables sepal length and width and petal length and width, respectively, for 50 flowers from each of 3 species of iris. The species are Iris setosa, versicolor, and virginica.")
# Add a page break : go to next page
doc <- addPageBreak(doc)
# Add a plot into the Word document
doc <- addTitle(doc, "Nice bar plot")
doc <- addPlot(doc, function() barplot(1:5, col=1:5))
# Write the Word document to a file 
writeDoc(doc, file = "f:/r-reporters-word-document-from-template.docx")
# Remove the downloaded template file
ok <- file.remove("r-reporters-word-document-template.docx")


##################
library(ReporteRs)
doc <- docx()
data<-iris[1:5, ]
# Add a first table : Default table
doc <- addTitle(doc, "Default table")
doc <- addFlexTable( doc, FlexTable(data))
doc <- addParagraph(doc, c("", "")) # 2 line breaks
# Add a second table, theme : vanilla table
doc <- addTitle(doc, "Vanilla table")
doc <- addFlexTable( doc, vanilla.table(data))
writeDoc(doc, file = "r-reporters-word-document-add-table.docx")

library(ReporteRs)
doc <- docx()
data<-iris[1:5, ]
# Zebra striped tables
doc <- addTitle(doc, "Zebra striped tables")
MyFTable <- vanilla.table(data)
MyFTable <- setZebraStyle(MyFTable, odd = '#eeeeee', even = 'white')
doc <- addFlexTable( doc, MyFTable)
# Change columns and rows background colors
doc <- addTitle(doc, "Change columns and rows background colors")
MyFTable = FlexTable(data = data )
# i : row index; j : column index
MyFTable = setRowsColors(MyFTable, i=2:3, colors = 'lightblue')
MyFTable = setColumnsColors(MyFTable, j=3, colors = 'pink' )
doc <- addFlexTable(doc, MyFTable)
writeDoc(doc, file = "r-reporters-word-document-formatted-table1.docx")


Change cell background and text colors
We can change the background colors of some cells according to their values using the function setFlexTableBackgroundColors().

As an example, We’ll set up the background color of column 2 according to the value of the Sepal.Width variable (iris data sets) :

Cells with Sepal.Width < 3.2 are colored in gray (“#DDDDDD”)
Cells with Sepal.Width > = 3.2 are colored in “orange”
The text values of the table cells can be also customized as demonstrated in the example below :

library(ReporteRs)
doc <- docx()
data<-iris[1:5, ]
# Change the background colors of column 2 according to Sepal.Width
#++++++++++++++++++++++++++++
doc <- addTitle(doc, "Change the background color of cells")
MyFTable <- FlexTable(data)
MyFTable <- setFlexTableBackgroundColors(MyFTable, j = 2,
  colors = ifelse(data$Sepal.Width < 3.2, '#DDDDDD', 'orange'))
doc <- addFlexTable( doc, MyFTable)
# Format the text of some cells (column 3:4)
#++++++++++++++++++++++++++++
doc <- addTitle(doc, "Format cell text values")
MyFTable = FlexTable(data)
MyFTable[, 3:4] = textProperties(color = 'blue')
doc <- addFlexTable( doc, MyFTable)
writeDoc(doc, file = "r-reporters-word-document-format-cells.docx")

Insert content into a table : header and footer rows
Additional rows, such as header and footer, can be easily added into a table as illustrated in the example hereafter. Contents can be also added in a particular cell.

The functions addHeaderRow() and addFooterRow() are used to add a header and a footer.

A simplified format of these functions are :

addHeaderRow(x, value, colspan, text.properties)
addFooterRow(x, value, colspan, text.properties)

x : a FlexTable object
value : character vector to add as a header or a footer
colspan : a numeric vector (optional) specifying the number of columns to span for each corresponding value
text.properties : the text properties to apply to each cell (optional).


library(ReporteRs)
doc <- docx()
data<-iris[1:5, ]
# Insert a content into a table
doc <- addTitle(doc, "Insert a content")
MyFTable = FlexTable(data, header.columns= FALSE )
# Add first header row
MyFTable <- addHeaderRow( MyFTable, 
            value = c('Sepal', 'Petal', 'Species'), 
            text.properties = textBold(color="orange"), 
            colspan = c( 2, 2, 1))
# Add second header row
MyFTable = addHeaderRow(MyFTable, value = names(data),
  text.properties = textBold())
     
# Add footer row
MyFTable <- addFooterRow(MyFTable, 
              value = 'This data is from iris data sets',
              colspan = 5, 
              text.properties = textBoldItalic(color ="blue"))
# Add symbol
MyFTable[data$Petal.Length!=1.4, 'Species',
  text.properties = textBold(vertical.align = 'superscript',
                             color = "red")] = '(1)'
doc <- addFlexTable( doc, MyFTable)
writeDoc(doc, file = "r-reporters-word-document-add-header-footer.docx")


Analyze, format and export a correlation matrix into a Word document

library(ReporteRs)
doc <- docx()
data( mtcars )
cormatrix = cor(mtcars)
col =c("#B2182B", "#D6604D", "#F4A582", "#FDDBC7",
       "#D1E5F0", "#92C5DE", "#4393C3", "#2166AC")
mycut = cut(cormatrix,
        breaks = c(-1,-0.75,-0.5,-0.25,0,0.25,0.5,0.75,1),
        include.lowest = TRUE, label = FALSE )
color_palettes = col[mycut]
corrFT = FlexTable( round(cormatrix, 2), add.rownames = TRUE )
corrFT = setFlexTableBackgroundColors(corrFT,
        j = seq_len(ncol(cormatrix)) + 1,
        colors = color_palettes )
corrFT = setFlexTableBorders( corrFT
        , inner.vertical = borderProperties( style = "dashed", color = "white" )
        , inner.horizontal = borderProperties( style = "dashed", color = "white"  )
        , outer.vertical = borderProperties( width = 2, color = "white"  )
        , outer.horizontal = borderProperties( width = 2, color = "white"  )
)
doc <- addFlexTable( doc, corrFT)
writeDoc(doc, file = "r-reporters-word-document-correlation.docx")

parProperties



library(ReporteRs)
doc = pptx()
slide.layouts(doc)


doc <- pptx()
layouts <-slide.layouts(doc) # All available layout
#  plot each slide style
for(i in layouts ){
  par(mar=c(0.5,0.5,2,0.5), cex=0.7)
  slide.layouts(doc, i )
    title(main = paste0("'", i, "'" ))
  if(interactive()) readline(prompt = "Show next slide layout")
}


######################################

library( ReporteRs )
# Create a PowerPoint document
doc = pptx( )
# Slide 1 : Title slide
#+++++++++++++++++++++++
doc <- addSlide(doc, "Title Slide")
doc <- addTitle(doc,"Create a PowerPoint document from R software")
doc <- addSubtitle(doc, "R and ReporteRs package")
doc <- addDate(doc)
doc <- addFooter(doc, "Isaac Newton")
doc <- addPageNumber(doc, "1/4")
# Slide 2 : Add plot
#+++++++++++++++++++++++
doc <- addSlide(doc, "Title and Content")
doc <- addTitle(doc, "Bar plot")
plotFunc<- function(){
  barplot(VADeaths, beside = TRUE,
          col = c("lightblue", "mistyrose", "lightcyan",
                  "lavender", "cornsilk"),
  legend = rownames(VADeaths), ylim = c(0, 100))
  title(main = "Death Rates in Virginia", font.main = 4)
}
doc <- addPlot(doc, plotFunc )

doc <- addPageNumber(doc, "2/4")
# Slide 3 : Add table 
#+++++++++++++++++++++++
doc <- addSlide(doc, "Two Content")
doc <- addTitle(doc,"iris data sets")
doc <- addFlexTable(doc, FlexTable(iris[1:10,] ))
doc <- addParagraph(doc, "iris data set gives the measurements in centimeters of the variables sepal length and width and petal length and width, respectively, for 50 flowers from each of 3 species of iris. The species are Iris setosa, versicolor, and virginica.")
doc <- addPageNumber(doc, "3/4")
# Silde 4 : Add R script
#+++++++++++++++++++++
doc <- addSlide(doc, "Content with Caption")
doc <- addTitle(doc, "R Script for histogram plot")
doc <- addPlot(doc, function() hist(iris$Sepal.Width, col=4))
r_code ="data(iris)
hist(iris$Sepal.Width, col = 4)"
doc <- addRScript(doc, text=r_code)
# write the document 

doc = pptx( )
doc <- addSlide(doc, "Content with ggplot2")
frm_x <- function() {
	   plot1 <- ggplot(df157) +  geom_line(aes(x=date,y=close))
          print(plot1)
          }
doc <- addPlot(doc, frm_x  )
writeDoc(doc, "f:/r-reporters-powerpoint.pptx" )

library( ReporteRs )
# Change the default font size and font family
options('ReporteRs-fontsize'= 18, 'ReporteRs-default-font'='Arial')
doc = pptx( )
doc <- addSlide(doc, "Two Content")
doc <- addTitle(doc,"Document with formatted texts")
doc <- addFlexTable(doc, FlexTable(iris[1:10,] ))
my_text <- pot("iris data set", textBold(color = "blue"))+
          " contains the measurements of " + 
          pot("sepal length", textBold(color="red"))+ 
        " and width and petal length and width"
  
my_link <- pot('Click here to visit STHDA web site!', 
    hyperlink = 'http://www.sthda.com/english',
    format=textBoldItalic(color = 'blue', underline = TRUE ))
doc <- addParagraph(doc, 
      value = set_of_paragraphs(my_text, " ",  my_link),
     par.properties=parProperties(text.align="justify")
    )
writeDoc(doc, "r-reporters-powerpoint-formatted.pptx" )


library( ReporteRs )
doc = pptx()
# Slide 1 : Title slide
doc <- addSlide(doc, "Title Slide")
doc <- addTitle(doc,"Document containing plots and images")
doc <- addSubtitle(doc, "R and ReporteRs package")
# Slide 2 : Add plot
doc <- addSlide(doc, "Two Content")
doc <- addTitle(doc,"Histogram plot")
doc <- addPlot(doc, function() hist(iris$Sepal.Width, col="lightblue"))
doc <- addParagraph(doc, "This histogram is generated using iris data sets")
# Slide 3 : Add  an image
# download an image from R website
download.file(url="http://www.r-project.org/hpgraphic.png",
              destfile="r-home-image.png", quiet=TRUE)
doc <- addSlide(doc, "Two Content")
doc <- addTitle(doc,"Image from R website")
doc <- addImage(doc, "r-home-image.png")
doc <- addParagraph(doc, "This image has been downloaded from R website")
 
writeDoc(doc, "r-reporters-powerpoint-plot-image.pptx")

doc = pptx()
data<-iris[1:5, ]
# Slide 1 : Simple table
doc <- addSlide(doc, "Title and Content")
doc <- addTitle(doc,"Simple table")
doc <- addFlexTable(doc, FlexTable(data))
# Slide 2 : vanilla table
doc <- addSlide(doc, "Title and Content")
doc <- addTitle(doc,"Vanilla table")
doc <- addFlexTable(doc, vanilla.table(data))
# Slide 3 : Zebra striped table
doc <- addSlide(doc, "Title and Content")
doc <- addTitle(doc,"Zebra striped table")
MyFTable <- vanilla.table(data)
MyFTable <- setZebraStyle(MyFTable, odd = '#eeeeee', even = 'white')
doc <- addFlexTable( doc, MyFTable)
writeDoc(doc, "r-reporters-powerpoint-add-table.pptx")


library( ReporteRs )
# Download a PowerPoint template file from STHDA website
download.file(url="http://www.sthda.com/sthda/RDoc/example-files/r-reporters-powerpoint-template.pptx",
    destfile="r-reporters-powerpoint-template.pptx", quiet=TRUE)
options('ReporteRs-fontsize'= 18, 'ReporteRs-default-font'='Arial')
doc <- pptx(template="r-reporters-powerpoint-template.pptx" )
# Slide 1 : Title slide
#+++++++++++++++++++++++
doc <- addSlide(doc, "Title Slide")
doc <- addTitle(doc,"Create a PowerPoint from template using R software")
doc <- addSubtitle(doc, "R and ReporteRs package")
doc <- addDate(doc)
doc <- addFooter(doc, "Isaac Newton")
doc <- addPageNumber(doc, "1/4")
# Slide 2 : Add plot
#+++++++++++++++++++++++
doc <- addSlide(doc, "Title and Content")
doc <- addTitle(doc, "Bar plot")
plotFunc<- function(){
  barplot(VADeaths, beside = TRUE,
          col = c("lightblue", "mistyrose", "lightcyan",
                  "lavender", "cornsilk"),
  legend = rownames(VADeaths), ylim = c(0, 100))
  title(main = "Death Rates in Virginia", font.main = 4)
}
doc <- addPlot(doc, plotFunc )
doc <- addPageNumber(doc, "2/4")
# Slide 3 : Add table 
#+++++++++++++++++++++++
doc <- addSlide(doc, "Two Content")
doc <- addTitle(doc,"iris data sets")
doc <- addFlexTable(doc, FlexTable(iris[1:4,] ))
doc <- addParagraph(doc, "iris data set gives the measurements in centimeters of the variables sepal length and width and petal length and width, respectively, for 50 flowers from each of 3 species of iris. The species are Iris setosa, versicolor, and virginica.")
doc <- addPageNumber(doc, "3/4")
# Silde 4 : Add R script
#+++++++++++++++++++++
doc <- addSlide(doc, "Content with Caption")
doc <- addTitle(doc, "R Script for histogram plot")
doc <- addPlot(doc, function() hist(iris$Sepal.Width, col=4))
r_code ="data(iris)
hist(iris$Sepal.Width, col = 4)"
doc <- addRScript(doc, text=r_code)
# write the document 
writeDoc(doc, "r-reporters-powerpoint-from-template.pptx" )




doc = pptx( )
doc <- addSlide(doc, "Content with ggplot2")
frm_x <- function() {
	   plot1 <- ggplot(df157) +  geom_line(aes(x=date,y=close))
          print(plot1)
          }
doc <- addPlot(doc, frm_x  )
writeDoc(doc, "f:/r-reporters-powerpoint.pptx" )





###############




doc <- docx() # Create a Word document
# Add a title
doc <- addTitle(doc, "Word document with plots and Images", 
                level = 1)
# Add an introduction
doc <- addTitle(doc, "Introduction", level = 2)
doc = addParagraph(doc, value ="This Word document is created using R software and ReporteRs package. The goal of this section is to show you how to add plots and images into a Word document. This can be done easily using the functions addPlot() and addImages().")
# add ggplot2 
frm_x <- function() {
	   plot1 <- ggplot(df157) +  geom_line(aes(x=date,y=close))
          print(plot1)
          }
doc <- addPlot(doc, frm_x  )

writeDoc(doc, file = "f:/r-reporters-word-document-with-plot.docx")

$(concat('000/', seeutil:getCurrentDate('yyyy-MM-dd'), '/', $TRACKID, '-'))

2.7.4.4 seeutil:getCurrentDate(string formatPattern, string timeZone)
seeutil:getCurrentDate(string formatPattern, string timeZone)
Returns the current date using a format pattern and timeZone. See the JDK docu of SimpleDateFormat for
possible patterns.
If using 'Y' or 'x' as a pointer for a year in the format pattern, the given date will be calculated according to
the week.
'Y'/'x' is needed in order to properly calculate for the combination of year and year's week in the given format
pattern.
If giving a format pattern without a week in it, it is not proper to use 'Y'/'x'. In this case it should be 'y'
Returns: String
Example: expression="seeutil:getCurrentDate('h:mm a', 'Sofia')" 


library('ReporteRs')
library(ggplot2)
# Create a new powerpoint document
doc <- pptx()
# Add a new slide into the ppt document 
doc <- addSlide(doc, "Two Content" )
# add a slide title
doc<- addTitle(doc, "Editable vector graphics format versus raster format" )
# A function for creating a box plot
bp <- ggplot(data=PlantGrowth, aes(x=group, y=weight, fill=group))+
        geom_boxplot()
# Add an editable box plot
doc <- addPlot(doc, function() print(bp), vector.graphic = TRUE )
# Add a raster box plot
doc <- addPlot(doc, function() print(bp), vector.graphic = FALSE )
# write the document to a file
writeDoc(doc, file = "editable-ggplot2.pptx")


The simplified format of these functions are, as follow:

# Read tabular data into R
read.table(file, header = FALSE, sep = "", dec = ".")
# Read "comma separated value" files (".csv")
read.csv(file, header = TRUE, sep = ",", dec = ".", ...)
# Or use read.csv2: variant used in countries that 
# use a comma as decimal point and a semicolon as field separator.
read.csv2(file, header = TRUE, sep = ";", dec = ",", ...)
# Read TAB delimited files
read.delim(file, header = TRUE, sep = "\t", dec = ".", ...)
read.delim2(file, header = TRUE, sep = "\t", dec = ",", ...)


    To import a local .txt or a .csv file, the syntax would be:

# Read a txt file, named "mtcars.txt"
my_data <- read.delim("mtcars.txt")
# Read a csv file, named "mtcars.csv"
my_data <- read.csv("mtcars.csv")

# Read a txt file
my_data <- read.delim(file.choose())
# Read a csv file
my_data <- read.csv(file.choose())

my_data <- read.delim(file.choose(), 
                      stringsAsFactor = FALSE)

my_data <- read.delim(file.choose(), 
                      stringsAsFactor = FALSE)
my_data <- read.table(file.choose(), 
                      sep ="|", header = TRUE, dec =".")
my_data <- read.delim("http://www.sthda.com/upload/boxplot_format.txt")
head(my_data)

# Loading
library("readr")



    read_csv(): to read a comma (“,”) separated values
    read_csv2(): to read a semicolon (“;”) separated values
    read_tsv(): to read a tab separated (“\t”) values

# General function
read_delim(file, delim, col_names = TRUE)
# Read comma (",") separated values
read_csv(file, col_names = TRUE)
# Read semicolon (";") separated values
# (this is common in European countries)
read_csv2(file, col_names = TRUE)
    
# Read tab separated values
read_tsv(file, col_names = TRUE)


    file: file path, connexion or raw vector. Files ending in .gz, .bz2, .xz, or .zip will be automatically uncompressed. Files starting with “http://”, “https://”, “ftp://”, or “ftps://” will be automatically downloaded. Remote gz files can also be automatically downloaded & decompressed.
    delim: the character that separates the values in the data file.
    col_names: Either TRUE, FALSE or a character vector specifying column names. If TRUE, the first row of the input will be used as the column names.


read_csv() and read_tsv() are special case of the general function read_delim(). They’re useful for reading the most common types of flat file data, comma separated values and tab separated values, respectively.

The above mentioned functions return an object of class tbl_df which is data frame providing a nicer printing method, useful when working with large data sets.

Reading a file
Reading a local file

    To import a local .txt or .csv files, the syntax would be:

# Read a txt file, named "mtcars.txt"
my_data <- read_tsv("mtcars.txt")
# Read a csv file, named "mtcars.csv"
my_data <- read_csv("mtcars.csv")
my_data <- read_delim(file.choose(), sep = "|")
my_data <- read_tsv("http://www.sthda.com/upload/boxplot_format.txt")
head(my_data)

If there are parsing problems, a warning tells you how many, and you can retrieve the details with the function problems().

my_data <- read_csv(file.choose())
problems(my_data)

Specify column types

There are different types of data: numeric, character, logical, …

readr tries to guess automatically the type of data contained in each column. You might see a lot of warnings in a situation where readr has guessed the column type incorrectly. To fix these problems you can use the additional arguments col_type() to specify the data type of each column.

The following column types are available:

    col_integer(): to specify integer (alias = “i”)
    col_double(): to specify double (alias = “d”).
    col_logical(): to specify logical variable (alias = “l”)
    col_character(): leaves strings as is. Don’t convert it to a factor (alias = “c”).
    col_factor(): to specify a factor (or grouping) variable (alias = “f”)
    col_skip(): to ignore a column (alias = “-” or “_“)
    col_date() (alias = “D”), col_datetime() (alias = “T”) and col_time() (“t”) to specify dates, date times, and times.


An example is as follow (column x is an integer (i) and column treatment = “character” (c):

read_csv("my_file.csv", col_types = cols(
  x = "i", # integer column
  treatment = "c" # character column
))



http://www.sthda.com/english/wiki/ggplot2-essentials
http://www.sthda.com/english/wiki/descriptive-statistics-and-graphics

Reading lines from a file

Function: read_lines().

    Simplified format:

read_lines(file, skip = 0, n_max = -1L)


    file: file path
    skip: Number of lines to skip before reading data
    n_max: Numbers of lines to read. If n is -1, all lines in file will be read.



    Example of usage

# Demo file
my_file <- system.file("extdata/mtcars.csv", package = "readr")
# Read lines
my_data <- read_lines(my_file)
head(my_data)


    Example of usage

# Demo file
my_file <- system.file("extdata/mtcars.csv", package = "readr")
# Read lines
my_data <- read_lines(my_file)
head(my_data)

[1] "\"mpg\",\"cyl\",\"disp\",\"hp\",\"drat\",\"wt\",\"qsec\",\"vs\",\"am\",\"gear\",\"carb\""
[2] "21,6,160,110,3.9,2.62,16.46,0,1,4,4"                                                     
[3] "21,6,160,110,3.9,2.875,17.02,0,1,4,4"                                                    
[4] "22.8,4,108,93,3.85,2.32,18.61,1,1,4,1"                                                   
[5] "21.4,6,258,110,3.08,3.215,19.44,1,0,3,1"                                                 
[6] "18.7,8,360,175,3.15,3.44,17.02,0,0,3,2"                                                  

Read whole file

    Simplified format

read_file(file)

    Example of usage

# Demo file
my_file <- system.file("extdata/mtcars.csv", package = "readr")
# Read whole file
read_file(my_file)


require(R2HTML)
tmpfic=HTMLInitFile(tempdir(),CSSFile=system.file("samples", "R2HTML.css", package="R2HTML"))
data(iris)
HTML(as.title("Fisher Iris dataset"),file=tmpfic)
HTML(iris, file=paste("file://",tmpfic,sep=""))
browseURL(tmpfic)


 .HTML.file = HTMLInitFile()
 HTML.title("sample page",1,file=.HTML.file)
 HTML(as.title("Sample equation"),HR=3)
 cat("Some text and then a math mode:",file=.HTML.file,append=TRUE)
 HTML(as.latex("[[a,b],[c,d]]((n),(k))") ,file=.HTML.file)
 cat(". Nice isn't it?",file=.HTML.file,append=TRUE)
 HTML(as.latex("\\int_{-\\infty}^{1}f(x)dx",inline=FALSE,count=TRUE) ,file=.HTML.file)
 HTML(as.title("Labelled equations"),HR=3)
 HTML(as.latex("x+b/(2a)=+-sqrt((b^2)/(4a^2)-c/a)",inline=FALSE,label="Label of this equation"))
 cat("file:", .HTML.file, "is created")
 browseURL(paste("file://",.HTML.file,sep=""))


  data(iris)
 data <- iris[sample(1:nrow(iris),size=30),]

 .HTML.file = HTMLInitFile(useGrid=TRUE,useLaTeX=FALSE)
 HTML.title("Iris dataset (again)",1,file=.HTML.file)  
 HTML(as.title("20 random observations displayed with HTMLgrid"),HR=3)
 HTML("Try to click on columns headers to sort them")
 HTMLgrid_inline(data)
 HTML(as.title("A summary of those observations displayed with HTMLgrid"),HR=3)
 
 HTMLgrid_summary(data,file=.HTML.file)
 cat("file:", .HTML.file, "is created")
 browseURL(paste("file://",.HTML.file,sep=""))
 
 
 
 
 Rstudio默认编码utf-8 含中文文件导入指定编码gbk 含中文数据库连接指定编码gbk 字符串通过iconv转化不同编码
 #设定编码
 options(encoding="UTF-8")
 #csv 设定gbk编码
 read.csv("...",fileEncoding="gbk")
 
 odbcConnect("",DBMSencoding="gbk")
 
 iconv("...","UTF-8","gbk")
 
 