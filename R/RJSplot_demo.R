library(RJSplot)


## Boxplot
# Create a boxplot
boxplot_rjs(attitude, "attitude", "favourable responses")


## Barplot
# Create a barplot
barplot_rjs(USArrests, "states", "arrests")


## Density plot
# Generate test input data
data <- data.frame(Uni05 = (1:100)/21, Norm = rnorm(100), `5T` = rt(100, df = 5), Gam2 = rgamma(100, shape = 2))

# Create a density plot
densityplot_rjs(data, "x", "y")


## Scatter plot
scatterplot_rjs(iris[["Sepal.Width"]], iris[["Sepal.Length"]], abline.x = c(3.4,3.8), abline.y = c(5.8,7), col = iris[["Species"]], pch = as.numeric(iris[["Species"]]), id = iris[["Species"]], xlab = "Sepal Width (cm)", ylab = "Sepal Length (cm)")


## Pie chart
# Create a pie chart
piechart_rjs(VADeaths)


## Bubble Plot
# Create a bubble plot
bubbles_rjs(scale(mtcars[,c("mpg","hp")],FALSE), mtcars[["wt"]])


## Dendrogram
# Create a dendrogram
dendrogram_rjs(dist(USArrests),metadata=USArrests)


## Networks
# Prepare data
x <- 1-cor(t(mtcars))

source <- rep(rownames(x),nrow(x))
target <- rep(rownames(x),rep(ncol(x),nrow(x)))
links <- data.frame(source=source,target=target,value=as.vector(x))

# Create a network graph
network_rjs(links[links[,3]>0.1,], mtcars, group = "cyl", size = "hp", color = "mpg")

# Create a symetric heatmap
symheatmap_rjs(links, mtcars, group = "cyl")

# Create a hive plot
hiveplot_rjs(links, mtcars, group = "cyl", size = "wt", color = "carb")


## Heatmap
# Generation of metadata test
metadata <- data.frame(phenotype1 = sample(c("yes","no"),ncol(mtcars),TRUE), phenotype2 = sample(1:5,ncol(mtcars),TRUE))

# Create a heatmap
heatmap_rjs(data.matrix(mtcars), metadata, scale="column")


## WordCloud
# Format test data
words <- data.frame(word = rownames(USArrests), freq = USArrests[,4])

# Create a wordcloud
wordcloud_rjs(words)


## Genome viewers
# Create test data
chr <- character()
pos <- numeric()

for(i in 1:nrow(GRCh38)){
  chr <- c(chr,as.character(rep(GRCh38[i,"chr"],100)))
  pos <- c(pos,sample(GRCh38[i,"start"]:GRCh38[i,"end"],100))
}

value <- round(rexp(length(pos)),2)

# Create a manhattan plot
data <- data.frame(paste0("ProbeSet_",seq_along(pos)),chr,pos,value)
manhattan_rjs(data, GRCh38, 0, 1, 0, TRUE, "log2Ratio")

# Create a genome map
track <- data.frame(chr,pos,pos+1,NA,value)
genomemap_rjs(GRCh38.bands, track)


## Create a 3D scatter plot
scatter3d_rjs(iris[["Sepal.Width"]], iris[["Sepal.Length"]], iris[["Petal.Width"]], color = iris[["Species"]], xlab = "Sepal Width (cm)", ylab = "Sepal Length (cm)", zlab = "Petal Width (cm)")


## Create a 3D surface
surface3d_rjs(volcano,color=c("red","green"))

## Create a data table
tables_rjs(swiss)