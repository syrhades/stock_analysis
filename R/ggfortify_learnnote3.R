library("ggfortify")
autoplot(object, geom = "tile")

df <- mtcars[, c("mpg", "disp", "hp", "drat", "wt")]
df <- as.matrix(df)
# Heatmap
autoplot(scale(df))



Plotting PCA (Principal Component Analysis)

Data set: iris
Function: autoplot.prcomp()
# Prepare the data
df <- iris[, -5]
# Principal component analysis
pca <- prcomp(df, scale. = TRUE)
# Plot
autoplot(pca, loadings = TRUE, loadings.label = TRUE,
         data = iris, colour = 'Species')


autoplot(pca, loadings = F, loadings.label = F,
         data = iris, colour = 'Species')