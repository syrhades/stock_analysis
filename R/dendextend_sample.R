# http://extjs.org.cn/

require(dplyr)
require(plyr)
# require(tidyverse)
require(XML)
require(rCharts)
require(quantmod)
require(plotly)
require(foreach)
require(stats)
require(forecast)

frm_modify_path <- function(filename){
  ## check OS R_PLATFORM
  R_PLATFORM <- Sys.getenv(c("R_PLATFORM"))
  if(stringr::str_detect(R_PLATFORM, "linux")) path <- "~/sdcard"
  else path <- "e:"
  return (paste(path,filename,sep="/") )
  }


source("R/stock_trade_syrhades_steps/stock_common.R" %>% frm_modify_path )
source("R/stock_trade_syrhades_steps/stock_model1.R" %>% frm_modify_path )


stockid <-157
scope <-"2010/"

width <- 20
cor_width <- 10
cor_width_by <-1
percent_rank_width <-100

df157  <- frm_read_stock(stockid)
xts157 <- frm_df2xts(df157)[scope]
df157 <- xts157 %>% frm_xts2df(NA)

df_plot3d <- df157 %>% subset(select=c(date,close,vol))
names(df_plot3d) <- c("x","y","z")
df_plot3d$id <- index(df_plot3d)%>%seq_along %>% as.double 
df_plot3d$x <- index(df_plot3d)%>%seq_along %>% as.double 
options <- list(
    # style="surface",
    # style="bar",
    style="bar-size",
    # style="line",
        width=  '100%',
        height= '100%',
        showPerspective= T,
        showGrid =T,
        showShadow =T,
        keepAspectRatio =T,
        verticalRatio = 0.5
        ) 


vis3d::vis3d_line(df_plot3d%>% head,options)

# http://www.jqplot.com/
# https://www.rgraph.net/canvas/index.html
# http://visjs.org/docs/graph2d/
# http://www.jscharts.com/



  library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-stacked1-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-stacked1-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    axisAlgorithm="rPretty",
    colorBy="GNI",
    decorations=list(marker=list(list(align="center", baseline="middle", color="red", sample="Norway", text="Norway is the country\nwith the largest GNI\naccording to 2014 census", variable="population", x=0.65, y=0.7), list(align="center", baseline="middle", color="red", sample="China", text="China is the country with\nthe largest population\naccording to 2014 census", variable="population", x=0.15, y=0.1))),
    graphOrientation="vertical",
    graphType="Stacked",
    legendInside=TRUE,
    legendPosition="top",
    showTransition=TRUE,
    smpLabelRotate=45,
    subtitle="2014 Census",
    title="Country Population colored by Gross National Income",
    treemapBy=list("ISO3"),
    widthFactor=4,
    xAxisMinorTicks=FALSE,
    afterRender=list(list("groupSamples", list("continent")))
  )



library(canvasXpress)
  nodes=read.table("http://www.canvasxpress.org/data/cX-lesmiserable-nodes.txt", header=TRUE, sep="\t", quote="", fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  edges=read.table("http://www.canvasxpress.org/data/cX-lesmiserable-edges.txt", header=TRUE, sep="\t", quote="", fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    nodeData=nodes,
    edgeData=edges,
    colorNodeBy="group",
    colorSpectrum=list("purple", "blue", "cyan", "green", "yellow", "orange", "red"),
    edgeWidth=2,
    graphType="Network",
    nodeFontColor="rgb(29,34,43)",
    nodeSize=30,
    showAnimation=TRUE,
    title="Les Miserable"
  )


library(canvasXpress)
  nodes=read.table("http://www.canvasxpress.org/data/cX-networkradial-nodes.txt", header=TRUE, sep="\t", quote="", fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  edges=read.table("http://www.canvasxpress.org/data/cX-networkradial-edges.txt", header=TRUE, sep="\t", quote="", fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    nodeData=nodes,
    edgeData=edges,
    edgeWidth=5,
    graphType="Network",
    networkLayoutType="radial",
    nodeFontColor="rgb(29,34,43)",
    nodeScaleFontFactor=2,
    nodeSize=40,
    showAnimation=TRUE,
    title="Radial Network"
  )


####chord
library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-chord-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    circularArc=360,
    circularRotate=0,
    circularType="chord",
    colors=list("#000000", "#FFDD89", "#957244", "#F26223"),
    graphType="Circular",
    higlightGreyOut=TRUE,
    rAxisTickFormat=list("%sK", "val / 1000"),
    showTransition=TRUE,
    title="Simple Chord Graph",
    transitionStep=50,
    transitionTime=1500
  )

 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-chord-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    circularArc=360,
    circularRotate=180,
    circularType="chord",
    colors=list("#000000", "#FFDD89", "#957244", "#F26223"),
    graphType="Circular",
    higlightGreyOut=TRUE,
    rAxisTickFormat=list("%sK", "val / 1000"),
    showTransition=TRUE,
    title="Rotated Chord Graph",
    transitionStep=50,
    transitionTime=1500
  )


  library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-chord-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
 y2<- cor(mtcars[,1:4]) %>% as.data.frame(stringsAsFactors=F)
  canvasXpress(
    data=y2,
    circularArc=180,
    circularRotate=-90,
    circularType="chord",
    colors=list("#000000", "#FFDD89", "#957244", "#F26223"),
    graphType="Circular",
    higlightGreyOut=TRUE,
    # rAxisTickFormat=list("%sK", "val / 1000"),
    showLegend=FALSE,
    showTransition=TRUE,
    title="Rotated Half Chord Graph",
    transitionStep=50,
    transitionTime=1500
  )





#Bubble
  library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-tree-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-tree-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    circularType="bubble",
    graphType="Circular",
    showTransition=TRUE,
    title="Simple Bubble Graph"
  )

######BarLine
library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    backgroundGradient1Color="rgb(226,236,248)",
    backgroundGradient2Color="rgb(112,179,222)",
    backgroundType="gradient",
    graphOrientation="vertical",
    graphType="BarLine",
    legendBackgroundColor=FALSE,
    legendBox=FALSE,
    legendColumns=2,
    legendPosition="bottom",
    lineThickness=2,
    lineType="spline",
    showShadow=TRUE,
    showTransition=TRUE,
    smpLabelRotate=45,
    smpTitle="Collection of Samples",
    smpTitleFontStyle="italic",
    subtitle="Random Data",
    title="Bar-Line Graphs",
    xAxis=list("Variable1", "Variable2"),
    xAxis2=list("Variable3", "Variable4"),
    xAxis2TickFormat="%.0f T",
    xAxisTickColor="rgb(0,0,0)",
    xAxisTickFormat="%.0f M"
  )

############circular
 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-circular-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-circular-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-circular-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    colorScheme="basic",
    connections=list(list("rgb(255,0,0)", "s1", "s15"), list("rgb(0,255,0)", "s25", "s120"), list("rgb(255,0,0)", "s34", "s2"), list("rgb(255,0,0)", "s47", "s69"), list("rgb(255,0,0)", "s15", "s74"), list("rgb(0,120,0)", "s57", "s87"), list("rgb(255,34,0)", "s54", "s118"), list("rgb(255,0,100)", "s78", "s18"), list("rgb(255,134,0)", "s90", "s48"), list("rgb(120,0,0)", "s120", "s68"), list("rgb(255,0,0)", "s131", "s92"), list("rgb(0,255,0)", "s148", "s119"), list("rgb(0,0,255)", "s10", "s14"), list("rgb(255,0,0)", "s56", "s6"), list("rgb(255,0,0)", "s98", "s90"), list("rgb(255,0,0)", "s113", "s20")),
    graphType="Circular",
    ringsType=list("dot", "heatmap", "bar"),
    ringsWeight=list(50, 25, 25),
    segregateSamplesBy=list("Species"),
    segregateVariablesBy=list("Ring"),
    showTransition=TRUE,
    smpOverlays=list("Species"),
    title="Iris flower data set (1D Circular Plot)",
    transitionStep=50,
    transitionTime=1500
  )

#correlation plot
library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    correlationAxis="samples",
    gradient=TRUE,
    graphType="Correlation",
    showTransition=TRUE,
    title="Correlation Plot",
    yAxisTitle="Correlation Title"
  )

#sunburst
 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-sunburst-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-sunburst-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    circularArc=360,
    circularRotate=0,
    circularType="sunburst",
    colorBy="Mont",
    colorScheme="Bootstrap",
    graphType="Circular",
    hierarchy=list("Month"),
    showTransition=TRUE,
    title="Simple Donnut",
    transitionStep=50,
    transitionTime=1500
  )

 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-sunburst-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-sunburst-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    circularArc=360,
    circularRotate=0,
    circularType="sunburst",
    colorBy="Quarter",
    colorScheme="RdYlBu",
    graphType="Circular",
    hierarchy=list("Quarter", "Month"),
    showTransition=TRUE,
    title="Donnut with two levels",
    transitionStep=50,
    transitionTime=1500
  )

#################
  library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    backgroundGradient1Color="rgb(226,236,248)",
    backgroundGradient2Color="rgb(112,179,222)",
    backgroundType="gradient",
    graphOrientation="vertical",
    graphType="DotLine",
    legendBackgroundColor=FALSE,
    legendBox=FALSE,
    legendColumns=2,
    legendPosition="bottom",
    lineThickness=2,
    lineType="spline",
    showShadow=TRUE,
    smpLabelRotate=45,
    smpTitle="Collection of Samples",
    smpTitleFontStyle="italic",
    subtitle="Random Data",
    title="Dot-Line Graphs",
    xAxis=list("Variable1", "Variable2"),
    xAxis2=list("Variable3", "Variable4"),
    xAxisTickColor="rgb(0,0,0)"
  )
  https://www.sencha.com/products/extjs/#overview

  library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    colorScheme="basic",
    graphOrientation="vertical",
    graphType="Dotplot",
    legendColumns=2,
    lineType="spline",
    showAnimation=FALSE,
    showShadow=TRUE,
    showTransition=TRUE,
    smpLabelRotate=45,
    smpOverlays=list("Factor1", "Factor2", "Factor3"),
    smpTitle="Collection of Samples",
    smpTitleFontStyle="italic",
    subtitle="Random Data",
    title="Dotplot Graph",
    xAxisTickFormat="%.0f Mil."
  )

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    colorScheme="basic",
    graphOrientation="vertical",
    graphType="Dotplot",
    legendColumns=2,
    lineType="spline",
    showAnimation=FALSE,
    showShadow=TRUE,
    showTransition=TRUE,
    smpLabelRotate=45,
    smpOverlays=list("Factor1", "Factor2", "Factor3"),
    smpTitle="Collection of Samples",
    smpTitleFontStyle="italic",
    subtitle="Random Data",
    title="Dotplot Graph",
    xAxisTickFormat="%.0f Mil."
  )


  y <- read.table("http://www.canvasxpress.org/data/cX-irist-dat.txt", header=TRUE, sep="\t", 
                quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
z <- read.table("http://www.canvasxpress.org/data/cX-irist-var.txt", header=TRUE, sep= "\t", 
                quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
               
canvasXpress(data      = y,
             varAnnot  = z,
             colorBy   = "Species",
             ellipseBy = "Species",
             graphType = "Scatter3D",
             title     = "Iris Data Set",
             xAxis     = list("Sepal.Length"),
             yAxis     = list("Petal.Width"),
             zAxis     = list("Petal.Length"))

# heatmap

 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-heatmapR-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-heatmapR-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-heatmapR-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    colorSpectrum=list("blue", "white", "red"),
    graphType="Heatmap",
    title="Simple Heatmap"
  )


# hist
library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-cancersurvivalt-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-cancersurvivalt-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-cancersurvivalt-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    axisTitleFontStyle="italic",
    citation="Cameron, E. and Pauling, L. (1978). Proceedings of the National Academy of Science USA, 75.",
    graphType="Scatter2D",
    histogramBins=50,
    showShadow=TRUE,
    showTransition=TRUE,
    title="Patients with advanced cancers of the stomach,
bronchus, colon, ovary or breast treated with ascorbate.",
    xAxisTitle="Survival (days)",
    yAxisTitle="Number of Subjects",
    afterRender=list(list("createHistogram"))
  )


  library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-irist-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-irist-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    broadcast=TRUE,
    colorBy="Species",
    graphType="Scatter2D",
    layoutAdjust=TRUE,
    scatterPlotMatrix=TRUE,
    showTransition=TRUE,
    transitionStep=50,
    transitionTime=1500,
    afterRender=list(list("addRegressionLine"))
  )


library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-irist-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-irist-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    broadcast=TRUE,
    colorBy="Species",
    graphType="Scatter2D",
    layoutAdjust=FALSE,
    scatterPlotMatrix=TRUE,
    showTransition=TRUE
  )

#########

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-irist-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-irist-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    broadcast=TRUE,
    colorBy="Species",
    graphType="Scatter2D",
    layoutAdjust=FALSE,
    scatterPlotMatrix=TRUE,
    scatterPlotMatrixType="first",
    afterRender=list(list("addRegressionLine"))
  )

###########
library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-iris-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-iris-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    axisTickFontStyle="bold",
    axisTitleFontStyle="italic",
    citation="R. A. Fisher (1936). The use of multiple measurements in taxonomic problems. Annals of Eugenics 7 (2) => 179-188.",
    citationFontStyle="italic",
    fontStyle="italic",
    graphOrientation="vertical",
    graphType="Boxplot",
    legendBox=FALSE,
    showShadow=TRUE,
    showTransition=TRUE,
    smpLabelFontStyle="italic",
    smpLabelRotate=90,
    smpTitle="Species",
    title="Iris flower data set",
    xAxis2Show=FALSE,
    afterRender=list(list("groupSamples", list("Species")), list("segregateSamples", list("Species")))
  )

###############
 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    graphOrientation="vertical",
    graphType="Bar",
    showTransition=TRUE,
    afterRender=list(list("groupSamples", list("Factor1")), list("segregateSamples", list("Factor1")))
  )

   library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    graphOrientation="horizontal",
    graphType="Bar",
    showTransition=TRUE,
    afterRender=list(list("segregateSamples", list("Factor1")), list("segregateVariables", list("Annt2")))
  )


   library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-scents-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-scents-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    graphOrientation="vertical",
    graphType="Boxplot",
    showTransition=TRUE,
    smpLabelRotate=90,
    smpTitle="Smoking Status",
    afterRender=list(list("groupSamples", list("Smoker")), list("createDOE"))
  )


  canvasXpress(
    data=FALSE,
    colorBy="variable",
    graphType="Map",
    leafletConfig=list(attributionControl=FALSE, center=list(38, -100), zoom=3),
    leafletId="states",
    showLegend=FALSE,
    topoJSON=list(states="https://canvasxpress.org/json/usa-states.json")
  )



library(canvasXpress)
  nodes=read.table("http://www.canvasxpress.org/data/cX-lesmiserable-nodes.txt", header=TRUE, sep="\t", quote="", fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  edges=read.table("http://www.canvasxpress.org/data/cX-lesmiserable-edges.txt", header=TRUE, sep="\t", quote="", fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    nodeData=nodes,
    edgeData=edges,
    colorNodeBy="group",
    colorSpectrum=list("purple", "blue", "cyan", "green", "yellow", "orange", "red"),
    edgeWidth=2,
    graphType="Network",
    nodeFontColor="rgb(29,34,43)",
    nodeSize=30,
    showAnimation=TRUE,
    title="Les Miserable"
  )

library(canvasXpress)
  nodes=read.table("http://www.canvasxpress.org/data/cX-networkbasic-nodes.txt", header=TRUE, sep="\t", quote="", fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  edges=read.table("http://www.canvasxpress.org/data/cX-networkbasic-edges.txt", header=TRUE, sep="\t", quote="", fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    nodeData=nodes,
    edgeData=edges,
    calculateLayout=FALSE,
    decorations=list("exp1", "exp2", "exp3"),
    decorationsPosition="top",
    decorationsType="bar",
    graphType="Network",
    networkFreezeOnLoad=TRUE,
    nodeFontColor="rgb(29,34,43)",
    showAnimation=TRUE,
    showDecorations=TRUE
  )
 library(canvasXpress)
  nodes=read.table("http://www.canvasxpress.org/data/cX-networkkarate-nodes.txt", header=TRUE, sep="\t", quote="", fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  edges=read.table("http://www.canvasxpress.org/data/cX-networkkarate-edges.txt", header=TRUE, sep="\t", quote="", fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    nodeData=nodes,
    edgeData=edges,
    edgeWidth=2,
    graphType="Network",
    isNetworkCommunities=TRUE,
    nodeFontColor="rgb(29,34,43)",
    nodeSize=30,
    showAnimation=TRUE,
    title="Zachary's famous Karate Club"
  )


library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-oncoprint-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  y2=read.table("http://www.canvasxpress.org/data/cX-oncoprint-dat2.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  y3=read.table("http://www.canvasxpress.org/data/cX-oncoprint-dat3.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  y4=read.table("http://www.canvasxpress.org/data/cX-oncoprint-dat4.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  y5=read.table("http://www.canvasxpress.org/data/cX-oncoprint-dat5.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-oncoprint-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-oncoprint-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=list(y=y, data2=y2, data3=y3, data4=y4, data5=y5),
    smpAnnot=x,
    varAnnot=z,
    graphType="Heatmap",
    isOncoprint="data2",
    showTransition=TRUE
  )




library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-oncoprint-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  y2=read.table("http://www.canvasxpress.org/data/cX-oncoprint-dat2.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  y3=read.table("http://www.canvasxpress.org/data/cX-oncoprint-dat3.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  y4=read.table("http://www.canvasxpress.org/data/cX-oncoprint-dat4.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  y5=read.table("http://www.canvasxpress.org/data/cX-oncoprint-dat5.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-oncoprint-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-oncoprint-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=list(y=y, data2=y2, data3=y3, data4=y4, data5=y5),
    smpAnnot=x,
    varAnnot=z,
    graphType="Heatmap",
    isOncoprint="data2",
    outlineBy="Color",
    outlineByData="data3",
    patternBy="Pattern",
    patternByData="data4",
    shapeBy="Shape",
    shapeByData="data5",
    smpOverlayProperties=list(Annt2=list(position="right", type="Bar"), Annt3=list(type="Stacked"), Annt4=list(type="Stacked"), Annt5=list(type="Stacked")),
    smpOverlays=list("Annt1", "-", "Annt2", "Annt3", "Annt4", "Annt5")
  )


canvasXpress
Home
Documentation
Examples
API Reference
Download
Social
About
Login
ParallelCoordinates
EconomistGGPlotGreyExcelPaul TolSolarizedStataTableauWall StreetCanvasXpress  Close
  library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-irist-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-irist-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    colorBy="Species",
    graphOrientation="vertical",
    graphType="ParallelCoordinates",
    lineDecoration=FALSE,
    showTransition=TRUE,
    smpLabelRotate=90,
    title="Iris flower data set"
  )
 JS Code
R Code
 Data 
Properties used: colorBy, graphOrientation, graphType, lineDecoration, showTransition, smpLabelRotate, title 
Click for Interactive
Area
AreaLine
Bar
BarLine
Boxplot
Bubble
Candlestick
Chord
Circular
Contour
Correlation
Donnut
DotLine
Dotplot
Genome
Heatmap
Histogram
Kaplan-Meier
Layout
Line
Map
Network
NonLinear-Fit
Oncoprint
ParallelCoordinates
Pie
Radar
Remote-Graphs
Sankey
Scatter2D
Scatter3D
ScatterBubble2D
Stacked
StackedLine
StackedPercent
StackedPercentLine
Sunburst
TagCloud
Tree
Treemap
Venn
Video
 Back to Top
Copyright © 2009-2017 canvasXpress.org | Isaac Neuhaus
PayPal - The safer, easier way to pay online!  



###########################################

canvasXpress
Home
Documentation
Examples
API Reference
Download
Social
About
Login
ParallelCoordinates
EconomistGGPlotGreyExcelPaul TolSolarizedStataTableauWall StreetCanvasXpress  Close
  library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-irist-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-irist-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    colorBy="Species",
    graphOrientation="vertical",
    graphType="ParallelCoordinates",
    lineDecoration=FALSE,
    showTransition=TRUE,
    smpLabelRotate=90,
    title="Iris flower data set"
  )
 JS Code
R Code
 Data 
Properties used: colorBy, graphOrientation, graphType, lineDecoration, showTransition, smpLabelRotate, title 
Click for Interactive
Area
AreaLine
Bar
BarLine
Boxplot
Bubble
Candlestick
Chord
Circular
Contour
Correlation
Donnut
DotLine
Dotplot
Genome
Heatmap
Histogram
Kaplan-Meier
Layout
Line
Map
Network
NonLinear-Fit
Oncoprint
ParallelCoordinates
Pie
Radar
Remote-Graphs
Sankey
Scatter2D
Scatter3D
ScatterBubble2D
Stacked
StackedLine
StackedPercent
StackedPercentLine
Sunburst
TagCloud
Tree
Treemap
Venn
Video
 Back to Top
Copyright © 2009-2017 canvasXpress.org | Isaac Neuhaus
PayPal - The safer, easier way to pay online!  
#####################################################
 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-irist-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-irist-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    colorBy="Species",
    graphOrientation="vertical",
    graphType="ParallelCoordinates",
    lineDecoration=FALSE,
    showTransition=TRUE,
    smpLabelRotate=90,
    title="Iris flower data set"
  )



  canvasXpress(
    data=iris[,-5],
    varAnnot=iris[,5,drop = FALSE],
    colorBy="Species",
    graphOrientation="vertical",
    graphType="ParallelCoordinates",
    lineDecoration=FALSE,
    showTransition=TRUE,
    smpLabelRotate=90,
    title="Iris flower data set"
  )

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-irist-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-irist-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    colorBy="Species",
    graphOrientation="vertical",
    graphType="ParallelCoordinates",
    lineDecoration=FALSE,
    smpLabelRotate=90,
    title="Iris flower data set",
    afterRender=list(list("switchAnnotationToSmp", list("Species")))
  )


library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    graphType="Pie",
    layout="2X3",
    pieSegmentLabels="inside",
    pieSegmentPrecision=0,
    pieSegmentSeparation=1,
    showPieGrid=TRUE,
    showPieSampleLabel=TRUE,
    showTransition=TRUE,
    xAxis=list("Sample1", "Sample2", "Sample3", "Sample4", "Sample5", "Sample6")
  )

  Close
  library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    graphType="Pie",
    pieSegmentLabels="outside",
    pieSegmentPrecision=1,
    pieSegmentSeparation=2,
    pieType="solid",
    showTransition=TRUE
  )


library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    circularArc=360,
    circularRotate=0,
    circularType="radar",
    colorScheme="Bootstrap",
    graphType="Circular",
    ringsType=list("line"),
    showTransition=TRUE,
    title="Radar - Line",
    transitionStep=50,
    transitionTime=1500
  )



 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    circularArc=360,
    circularRotate=0,
    circularType="radar",
    colorScheme="Bootstrap",
    graphType="Circular",
    legendPosition="top",
    ringsType=list("area"),
    showTransition=TRUE,
    title="Radar - Area",
    transitionStep=50,
    transitionTime=1500
  )


  library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    circularArc=360,
    circularRotate=0,
    circularType="radar",
    colorScheme="Bootstrap",
    graphType="Circular",
    ringsType=list("bar"),
    showTransition=TRUE,
    title="Radar - Bar",
    transitionStep=50,
    transitionTime=1500
  )

 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    circularArc=360,
    circularRotate=0,
    circularType="radar",
    colorScheme="Bootstrap",
    graphType="Circular",
    legendPosition="top",
    ringsType=list("dot"),
    showTransition=TRUE,
    title="Radar - Scatter",
    transitionStep=50,
    transitionTime=1500
  )


 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    circularArc=360,
    circularRotate=0,
    circularType="radar",
    colorScheme="Bootstrap",
    graphType="Circular",
    legendPosition="top",
    ringsType=list("stacked"),
    showTransition=TRUE,
    title="Radar - Stacked",
    transitionStep=50,
    transitionTime=1500
  )

 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    circularArc=180,
    circularRotate=0,
    circularType="radar",
    colorScheme="Bootstrap",
    graphType="Circular",
    ringsType=list("line"),
    showTransition=TRUE,
    title="Half Radar",
    transitionStep=50,
    transitionTime=1500
  )


  library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    circularArc=180,
    circularRotate=-90,
    circularType="radar",
    colorScheme="Bootstrap",
    graphType="Circular",
    legendPosition="top",
    ringsType=list("line"),
    showTransition=TRUE,
    title="Rotated Half Radar",
    transitionStep=50,
    transitionTime=1500
  )


library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    circularArc=360,
    circularRotate=0,
    circularType="radar",
    colorScheme="Bootstrap",
    graphType="Circular",
    ringsType=list("line"),
    showTransition=TRUE,
    smpOverlays=list("Factor3", "-", "Factor1", "Factor2"),
    title="Radar with Overlays",
    transitionStep=50,
    transitionTime=1500
  )


library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-sankey-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-sankey-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    graphOrientation="vertical",
    graphType="Sankey",
    sankeySource="Source",
    sankeyTarget="Target",
    showTransition=TRUE,
    title="Single Level Sankey"
  )


   library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-sankey-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-sankey-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    colorBy="Weight",
    graphOrientation="vertical",
    graphType="Sankey",
    sankeySource="Source",
    sankeyTarget="Target",
    title="Single Level Sankey"
  )
 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-sankey2-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-sankey2-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    graphOrientation="vertical",
    graphType="Sankey",
    sankeySource="Source",
    sankeyTarget="Target",
    title="Multilevel Sankey"
  )

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-sankey2-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-sankey2-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    colorBy="Weight",
    graphOrientation="vertical",
    graphType="Sankey",
    sankeySource="Source",
    sankeyTarget="Target",
    title="Multilevel Sankey"
  )

 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-alcoholtobaccot-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-alcoholtobaccot-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    citation="Moore, David S., and George P. McCabe (1989). Introduction to the Practice of Statistics, p. 179.",
    decorations=list(marker=list(list(sample=list("Alcohol", "Tobacco"), text="Maybe an Outlier?", variable="Northern Ireland", x=0.45, y=0.18))),
    graphType="Scatter2D",
    showTransition=TRUE,
    title="Average weekly household spending, in British pounds, on tobacco products\nand alcoholic beverages for each of the 11 regions of Great Britain.",
    xAxis=list("Alcohol"),
    yAxis=list("Tobacco")
  )

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-scentst-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-scentst-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    citation="Hirsch, A. R., and Johnston, L. H. Odors and Learning, Smell & Taste Treatment and Research Foundation, Chicago.",
    graphType="Scatter2D",
    setMaxX=100,
    setMaxY=150,
    setMinX=0,
    setMinY=0,
    shapeBy="Smoker",
    showTransition=TRUE,
    sizeBy="Age",
    title="Data on the time subjects required to complete a pencil and paper maze\nwhen they were smelling a floral scent and when they were not.",
    xAxis=list("U-Trial 1", "U-Trial 2", "U-Trial 3"),
    xAxisExact=TRUE,
    xAxisHistogramShow=TRUE,
    yAxis=list("S-Trial 1", "S-Trial 2", "S-Trial 3"),
    yAxisExact=TRUE,
    yAxisHistogramShow=TRUE
  )

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-scentst-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-scentst-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    citation="Hirsch, A. R., and Johnston, L. H. Odors and Learning, Smell & Taste Treatment and Research Foundation, Chicago.",
    colorScheme="White",
    graphType="Scatter2D",
    setMaxX=100,
    setMaxY=150,
    setMinX=0,
    setMinY=0,
    shapeBy="Smoker",
    sizeBy="Age",
    title="Data on the time subjects required to complete a pencil and paper maze\nwhen they were smelling a floral scent and when they were not.",
    xAxis=list("U-Trial 1", "U-Trial 2", "U-Trial 3"),
    xAxisExact=TRUE,
    xAxisHistogramShow=TRUE,
    yAxis=list("S-Trial 1", "S-Trial 2", "S-Trial 3"),
    yAxisExact=TRUE,
    yAxisHistogramShow=TRUE
  )

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-ageheightt-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-ageheightt-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    citation="Moore, David S., and George P. McCabe (1989)",
    graphType="Scatter2D",
    title="Mean heights of a group of children in Kalama",
    xAxis=list("Age"),
    yAxis=list("Height"),
    afterRender=list(list("addRegressionLine"))
  )

 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-breastcancert-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-breastcancert-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    backgroundType="window",
    backgroundWindow="rgb(238,238,238)",
    citation="Velleman, P. F. and Hoaglin, D. C. (1981).
Applications, Basics, and Computing of Exploratory Data Analysis. Belmont. CA: Wadsworth, Inc., pp. 127-134.",
    colors=list("rgba(64,64,64,0.5)"),
    decorationsBackgroundColor="rgb(238,238,238)",
    decorationsBoxColor="rgb(0,0,0)",
    decorationsPosition="bottomRight",
    graphType="Scatter2D",
    legendInside=TRUE,
    plotBox=FALSE,
    showDecorations=TRUE,
    showTransition=TRUE,
    title="Mean annual temperature (in degrees F) and Mortality Index for neoplasms of the female breast.",
    xAxis=list("Mortality"),
    xAxisTickColor="rgb(255,255,255)",
    yAxis=list("Temperature"),
    yAxisTickColor="rgb(255,255,255)",
    afterRender=list(list("addRegressionLine", list('red')))
  )
library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-nonlinearfit-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    decorations=list(nlfit=list(list(label="Custom Fit", param=list(164, 313, 0.031, -1.5, 1.2e-06, 1.9), type="cst"), list(label="Regular Fit", param=list(164, 313, 0.031, 1.5, 1.2e-06, 1.9), type="reg"))),
    graphType="Scatter2D",
    setMaxY=350,
    setMinY=100,
    showDecorations=TRUE,
    xAxis=list("Concentration"),
    xAxisTransform="log10",
    xAxisTransformTicks=FALSE,
    yAxis=list("Variable1"),
    yAxisExact=TRUE
  )


library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-scatterR-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-scatterR-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    axisAlgorithm="rPretty",
    backgroundType="window",
    backgroundWindow="rgb(238,238,238)",
    colorBy="Group",
    colors=list("rgba(0,104,139,0.5)", "rgba(205,0,0,0.5)", "rgba(64,64,64,0.5)"),
    decorations=list(line=list(list(color="rgba(205,0,0,0.5)", width=2, y=0.5), list(color="rgba(0,104,139,0.5)", width=2, y=-0.5))),
    graphType="Scatter2D",
    legendBackgroundColor="rgb(238,238,238)",
    legendBoxColor="rgb(0,0,0)",
    legendInside=TRUE,
    legendPosition="bottomRight",
    plotBox=FALSE,
    showDecorations=TRUE,
    showLoessFit=TRUE,
    showTransition=TRUE,
    sizeBy="FC",
    sizes=list(4, 14, 16, 18),
    title="Profile plot",
    xAxis=list("AveExpr"),
    xAxisTickColor="rgb(255,255,255)",
    yAxis=list("logFC"),
    yAxisTickColor="rgb(255,255,255)"
  )

  library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-scatterR2-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-scatterR2-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    axisAlgorithm="rPretty",
    backgroundType="window",
    backgroundWindow="rgb(238,238,238)",
    colorBy="Group",
    colors=list("rgba(0,104,139,0.5)", "rgba(205,0,0,0.5)", "rgba(64,64,64,0.5)"),
    decorations=list(line=list(list(color="rgba(205,0,0,0.5)", width=2, x=0.5), list(color="rgba(0,104,139,0.5)", width=2, x=-0.5))),
    graphType="Scatter2D",
    legendBackgroundColor="rgb(238,238,238)",
    legendBoxColor="rgb(0,0,0)",
    plotBox=FALSE,
    showDecorations=TRUE,
    showTransition=TRUE,
    sizeBy="FC",
    sizes=list(4, 14, 16, 18),
    title="Volcano plot",
    xAxis=list("logFC"),
    xAxisTickColor="rgb(255,255,255)",
    yAxis=list("-log-pVal"),
    yAxisTickColor="rgb(255,255,255)"
  )

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-scatterR3-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-scatterR3-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    axisAlgorithm="rPretty",
    backgroundType="window",
    backgroundWindow="rgb(238,238,238)",
    colorBy="Group",
    colors=list("rgba(255,215,0,0.5)", "rgba(64,64,64,0.5)", "rgba(0,104,139,0.5)", "rgba(205,0,0,0.5)"),
    decorations=list(line=list(list(color="rgba(64,64,64,0.5)", width=2, x=0), list(color="rgba(64,64,64,0.5)", width=2, y=0), list(color="rgba(255,215,0,0.5)", width=2, x=-5, x2=5, y=-5, y2=5))),
    graphType="Scatter2D",
    legendBackgroundColor="rgb(238,238,238)",
    legendBoxColor="rgb(0,0,0)",
    legendInside=TRUE,
    legendPosition="bottomRight",
    plotBox=FALSE,
    showDecorations=TRUE,
    showTransition=TRUE,
    sizeBy="Hit",
    sizeByShowLegend=FALSE,
    sizes=list(4, 14),
    title="Contrast plot",
    xAxis=list("logFC-X"),
    xAxisTickColor="rgb(255,255,255)",
    yAxis=list("logFC-Y"),
    yAxisTickColor="rgb(255,255,255)"
  )

 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-scatterR4-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    axisAlgorithm="rPretty",
    backgroundType="window",
    backgroundWindow="rgb(238,238,238)",
    colors=list("rgba(0,104,139,0.5)", "rgba(205,0,0,0.5)"),
    graphType="Scatter2D",
    legendBackgroundColor="rgb(238,238,238)",
    legendBoxColor="rgb(0,0,0)",
    legendInside=TRUE,
    legendPosition="topRight",
    plotBox=FALSE,
    title="Waterfall plot",
    xAxis=list("Row"),
    xAxisTickColor="rgb(255,255,255)",
    yAxis=list("Sample1", "Sample2"),
    yAxisTickColor="rgb(255,255,255)"
  )


library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-irist-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-irist-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    axisTickScaleFontFactor=0.5,
    axisTitleScaleFontFactor=0.5,
    colorBy="Species",
    graphType="Scatter3D",
    title="Iris Data Set",
    xAxis=list("Sepal.Length"),
    yAxis=list("Sepal.Width"),
    zAxis=list("Petal.Length")
  )


library(canvasXpress)
y=read.table("http://www.canvasxpress.org/data/cX-irist-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
z=read.table("http://www.canvasxpress.org/data/cX-irist-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
canvasXpress(
  data=y,
  varAnnot=z,
  axisTickScaleFontFactor=0.5,
  axisTitleScaleFontFactor=0.5,
  colorBy="Species",
  ellipseBy="Species",
  graphType="Scatter3D",
  title="Iris Data Set",
  xAxis=list("Sepal.Length"),
  yAxis=list("Petal.Width"),
  zAxis=list("Petal.Length")
)


 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-scatter3d-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    graphType="Scatter3D",
    xAxis=list("Sample1"),
    yAxis=list("Sample2"),
    zAxis=list("Sample3")
  )

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-scatter3d-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    graphType="Scatter3D",
    scatterType="bar",
    xAxis=list("Sample1"),
    yAxis=list("Sample2"),
    zAxis=list("Sample3")
  )

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic2-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic2-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic2-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    colorBy="Annt2",
    graphType="Scatter3D",
    shapeBy="Annt3",
    sizeBy="Sample4",
    xAxis=list("Sample1"),
    yAxis=list("Sample2"),
    zAxis=list("Sample3")
  )

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-bubble-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-bubble-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    colorBy="Continent",
    graphType="ScatterBubble2D",
    showTransition=TRUE,
    xAxis=list("LifeExpectancy"),
    yAxis=list("GDPPerCapita"),
    yAxisTransform="log2",
    zAxis=list("Population")
  )

 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    graphType="ScatterBubble2D",
    xAxis=list("Sample1", "Sample4"),
    yAxis=list("Sample2", "Sample5"),
    zAxis=list("Sample3", "Sample6")
  )

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-bubble-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-bubble-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    varAnnot=z,
    colorBy="Continent",
    graphType="ScatterBubble2D",
    motionBy="Year",
    xAxis=list("LifeExpectancy"),
    yAxis=list("GDPPerCapita"),
    yAxisTransform="log2",
    zAxis=list("Population")
  )

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-stacked2-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-stacked2-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    colorScheme="Blues",
    foreground="rgb(0,0,0)",
    graphOrientation="vertical",
    graphType="Stacked",
    groupingFactors=list("Factor1"),
    sampleSeparationFactor=1,
    showTransition=TRUE,
    title="Random Data",
    treemapBy=list("Factor2", "Factor3")
  )

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    graphOrientation="horizontal",
    graphType="Stacked",
    legendBackgroundColor=FALSE,
    sampleSeparationFactor=1,
    showShadow=TRUE,
    smpLabelScaleFontFactor=0.8,
    smpTitle="Collection of Samples",
    smpTitleFontStyle="italic",
    title="Random Data"
  )

 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    gradient=TRUE,
    graphOrientation="vertical",
    graphType="Stacked",
    legendBackgroundColor=FALSE,
    showShadow=TRUE,
    smpLabelScaleFontFactor=0.8,
    smpTitle="Collection of Samples",
    smpTitleFontStyle="italic",
    title="Random Data"
  )

 library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    graphOrientation="horizontal",
    graphType="Stacked",
    legendBackgroundColor=FALSE,
    sampleSeparationFactor=1.5,
    showShadow=TRUE,
    smpLabelScaleFontFactor=0.8,
    smpTitle="Collection of Samples",
    smpTitleFontStyle="italic",
    title="Random Data"
  )
library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-diverging-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    axisAlgorithm="wilkinson",
    colorScheme="RdYlBu",
    graphOrientation="horizontal",
    graphType="Stacked",
    legendColumns=3,
    legendPosition="bottom",
    marginRight=20,
    title="Diverging Stacked Graph",
    xAxisTickFormat="%s%%"
  )

library(canvasXpress)
  y=read.table("http://www.canvasxpress.org/data/cX-generic-dat.txt", header=TRUE, sep="\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  x=read.table("http://www.canvasxpress.org/data/cX-generic-smp.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  z=read.table("http://www.canvasxpress.org/data/cX-generic-var.txt", header=TRUE, sep= "\t", quote="", row.names=1, fill=TRUE, check.names=FALSE, stringsAsFactors=FALSE)
  canvasXpress(
    data=y,
    smpAnnot=x,
    varAnnot=z,
    graphOrientation="vertical",
    graphType="StackedLine",
    lineThickness=3,
    lineType="spline",
    showShadow=TRUE,
    showTransition=TRUE,
    smpTitle="Collection of Samples",
    smpTitleFontStyle="italic",
    subtitle="Random Data",
    title="Stacked-Line Graphs",
    xAxis=list("Variable1", "Variable2"),
    xAxis2=list("Variable3", "Variable4")
  )

  

f <- factor(1:10)
res <- eval(debugcall(summary(f))) 

require(stats)
## Extends the example for 'switch'
center <- function(x, type = c("mean", "median", "trimmed")) {
  type <- match.arg(type)
  switch(type,
         mean = mean(x),
         median = median(x),
         trimmed = mean(x, trim = .1))
}
x <- rcauchy(10)
center(x, "t")       # Works
center(x, "med")     # Works
try(center(x, "m"))  # Error
stopifnot(identical(center(x),       center(x, "mean")),
          identical(center(x, NULL), center(x, "mean")) )

## Allowing more than one match:
match.arg(c("gauss", "rect", "ep"),
          c("gaussian", "epanechnikov", "rectangular", "triangular"),
          several.ok = TRUE)

match(x, table, nomatch = NA_integer_, incomparables = NULL)

x %in% table

## The intersection of two sets can be defined via match():
## Simple version:
## intersect <- function(x, y) y[match(x, y, nomatch = 0)]
intersect # the R function in base is slightly more careful
intersect(1:10, 7:20)
match(1:10, 7:20)
1:10 %in% c(1,3,5,9)
sstr <- c("c","ab","B","bba","c",NA,"@","bla","a","Ba","%")
sstr[sstr %in% c(letters, LETTERS)]

"%w/o%" <- function(x, y) x[!x %in% y] #--  x without y
(1:10) %w/o% c(3,7,12)
## Note that setdiff() is very similar and typically makes more sense:
        c(1:6,7:2) %w/o% c(3,7,12)  # -> keeps duplicates
setdiff(c(1:6,7:2),      c(3,7,12)) # -> unique values

## Illuminating example about NA matching
r <- c(1, NA, NaN)
zN <- c(complex(real = NA , imaginary =  r ), complex(real =  r , imaginary = NA ),
        complex(real =  r , imaginary = NaN), complex(real = NaN, imaginary =  r ))
zM <- cbind(Re=Re(zN), Im=Im(zN), match = match(zN, zN))
rownames(zM) <- format(zN)
zM ##--> many "NA's" (= 1) and the four non-NA's (3 different ones, at 7,9,10)

length(zN) # 12
unique(zN) # the "NA" and the 3 different non-NA NaN's
stopifnot(identical(unique(zN), zN[c(1, 7,9,10)]))

## very strict equality would have 4 duplicates (of 12):
symnum(outer(zN, zN, Vectorize(identical,c("x","y")),
                     FALSE,FALSE,FALSE,FALSE))
## removing "(very strictly) duplicates",
i <- c(5,8,11,12)  # we get 8 pairwise non-identicals :
Ixy <- outer(zN[-i], zN[-i], Vectorize(identical,c("x","y")),
                     FALSE,FALSE,FALSE,FALSE)
stopifnot(identical(Ixy, diag(8) == 1))




frm_debug <-function (x, labels = 1L:12L, ylab = deparse(substitute(x)), 
    times = seq_along(x), phase = (times - 1L)%%length(labels) + 
        1L, base = mean, axes = TRUE, type = c("l", "h"), box = TRUE, 
    add = FALSE, col = par("col"), lty = par("lty"), lwd = par("lwd"), 
    col.base = col, lty.base = lty, lwd.base = lwd, ...) 
{
    dots <- list(...)
    nmdots <- names(dots)
    type <- match.arg(type)
    print(type)
    if (is.null(labels) || (missing(labels) && !missing(phase))) {
        labels <- unique(phase)
        phase <- match(phase, labels)
    }
    f <- length(labels)
    if (!is.null(base)) 
        means <- tapply(x, phase, base)
    if (!add) {
        dev.hold()
        on.exit(dev.flush())
        Call <- match.call()
        Call[[1L]] <- quote(graphics::plot)
        Call$x <- NA
        Call$y <- NA
        Call$axes <- FALSE
        Call$xlim <- if ("xlim" %in% nmdots) 
            dots$xlim
        else c(0.55, f + 0.45)
        Call$ylim <- if ("ylim" %in% nmdots) 
            dots$ylim
        else range(x, na.rm = TRUE)
        Call$xlab <- if ("xlab" %in% nmdots) 
            dots$xlab
        else ""
        if (box) 
            Call$frame.plot <- TRUE
        Call$labels <- Call$times <- Call$phase <- Call$base <- Call$type <- Call$box <- Call$add <- Call$col.base <- Call$lty.base <- Call$lwd.base <- NULL
        eval(Call)
        if (axes) {
            axis(1, at = 1L:f, labels = labels, ...)
            axis(2, ...)
        }
        if (!is.null(base)) {
            segments(1L:f - 0.45, means, 1L:f + 0.45, means, 
                col = col.base, lty = lty.base, lwd = lwd.base)
        }
    }
    y <- as.numeric(times)
    scale <- 1/diff(range(y, na.rm = TRUE)) * 0.9
    for (i in 1L:f) {
        sub <- phase == i
        if (type != "h") 
            lines((y[sub] - min(y)) * scale - 0.45 + i, x[sub], 
                type = type, col = col, lty = lty, lwd = lwd, 
                ...)
        else segments((y[sub] - min(y)) * scale - 0.45 + i, means[i], 
            (y[sub] - min(y)) * scale - 0.45 + i, x[sub], col = col, 
            lty = lty, lwd = lwd, ...)
    }
    # invisible()
}
debugonce(frm_debug)
frm_debug(mtcars$mpg)