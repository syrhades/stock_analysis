
STHDA    
Statistical tools for high-throughput data analysis
Licence: Licence Creative Commons

Search...
  
 
Home
Basics
What's R and Why R?
Installing R/RStudio
Running R/RStudio
R Programming Basics
Getting Help
Installing R Packages
R Built-in data sets
Data
Import
Export
Reshape
Manipulate
Visualize
R Base Graphs
Lattice Graphs
Ggplot2
3D Graphics
How to Choose Great Colors?
Analyze
Statistics
Descriptive Statistics and Graphics
Normality Test in R
Statistical Tests and Assumptions
Correlation Analysis
Comparing Means
Comparing Variances
Comparing Proportions
Survival
Survival Analysis Basics
Cox Proportional Hazards Model
Cox Model Assumptions
Clustering
Clustering basics
Partitioning clustering
Hierarchical clustering
Clustering Evaluation & Validation
Advanced clustering
Quick Guide for Cluster Analysis
Visualize Dendrograms: 5+ methods
Principal Component Methods
Products
Books
R Packages
factoextra
survminer
ggpubr
ggcorrplot
fastqcr
Web App
Contribute
Support
Forum
Contact
About
Sign in
Login 
Login
Password 
Password
Auto connect   Sign in
Register  
Forgotten password
Welcome!
Want to Learn More on R Programming and Data Science?
Follow us by Email


Subscribe
by FeedBurner


on Social Networks


 
R Packages
 factoextra factoextra
Overview
Official Doc
Related Tutorials
Cluster Analysis
Principal Component Methods
 survminer survminer
Overview
Cheatsheet
Official Doc
Related Tutorials
Survival Analysis
Release Posts
v0.3.0
v0.2.4
 ggpubr ggpubr
Overview
Official Doc
 ggcorrplot ggcorrplot
Overview
 fastqcr fastqcr
Overview
Official Doc

 
Our Books
 
R Graphics Essentials for Great Data Visualization: 200 Practical Examples You Want to Know for Data Science
 NEW!!


 
Practical Guide to Cluster Analysis in R

 
Practical Guide to Principal Component Methods in R



3D Plots in R 


Guest Book
I'm psychologist, from Chile. This website is WONDERFUL!! Comprehensive, clear, simple, great!!!!

Thank you, thank you!!!!

Pablo

By Visitor

Guest Book
Blogroll
R-Bloggers R-Bloggers
Actions menu for module Wiki
Home
Explorer
Home  Easy Guides  R software  Data Visualization  ggplot2 - Essentials  ggfortify : Extension to ggplot2 to handle some popular packages - R software and data visualization

 


 ggfortify : Extension to ggplot2 to handle some popular packages - R software and data visualization

 
Tools
 Discussion
Installation
Loading ggfortify
Plotting matrix
Plotting diagnostics for LM and GLM
Diagnostic plots for Linear Models (LM)
Diagnostic plots with Generalized Linear Models (GLM)
Plotting time series
Plotting ts objects
Plotting with changepoint package
Plotting with strucchange package
Plotting PCA (Principal Component Analysis)
Plotting K-means
Plotting cluster package
Plotting Local Fisher Discriminant Analysis
Plotting survival curves
Learn more
Infos


ggfortify extends ggplot2 for plotting some popular R packages using a standardized approach, included in the function autoplot().

This article describes how to draw:

a matrix,
a scatter plot,
diagnostic plots for linear model,
time series,
the results of principal component analysis,
the results of clustering analysis,
and survival curves
The following R packages and functions are covered in the package ggfortify:

Package name  Functions
base  matrix and table
cluster clara, fanny and pam
changepoint cpt
dlm dlmFilter and dlmSmooth
fGarch  fGARCH
forecast  bats, forecast, ets and nnetar
fracdiff  fracdiff
glmnet  glmnet
KFAS  KFS and signal
lfda  klfda and self
MASS  isoMDS and sammon
stats acf, ar, Arima, smdscale, decomposed.ts, density, fractanal, glm, HoltWinters, kmeans, lm, prcomp, princomp, spec, stepfun, stl and ts
survival  survfit and survfit.cox
strucchange breakpoints and breakpointsfull
timeSeries  timeSeries
tseries irts
vars  varprd
xts xts
zoo zooreg
Installation

ggfortify can be installed from GitHub or CRAN:

# Github
if(!require(devtools)) install.packages("devtools")
devtools::install_github("sinhrks/ggfortify")
# CRAN
install.packages("ggfortify")
Loading ggfortify

library("ggfortify")
Plotting matrix

The function autoplot.matrix() is used:

autoplot(object, geom = "tile")
object: an object of class matrix
geom: allowed values are “tile” (for heatmap) or “point” (for scatter plot)
The mtcars data set is used in the example below.

df <- mtcars[, c("mpg", "disp", "hp", "drat", "wt")]
df <- as.matrix(df)
Plot a heatmap:

# Heatmap
autoplot(scale(df))
ggplot2 and ggfortify - R software and data visualization

Plot a scatter plot: The data should be a matrix with 2 columns named V1 and V2. The R code below plots mpg by wt. We start by renaming column names.

# Extract the data
df2 <- df[, c("wt", "mpg")]
colnames(df2) <- c("V1", "V2")
# Scatter plot
autoplot(df2, geom = 'point') +
  labs(x = "mpg", y = "wt")
ggplot2 and ggfortify - R software and data visualization

Plotting diagnostics for LM and GLM

The function autoplot.lm() is used to draw diagnostic plots for LM and GLM [in stats package].

autoplot(object, which = c(1:3, 5))
object: stats::lm instance
which: If a subset of the plots is required, specify a subset of the numbers 1:6.
ncol and nrow allows you to specify the number of subplot columns and rows.
Diagnostic plots for Linear Models (LM)

iris data set is used for computing the linear model

# Compute a linear model
m <- lm(Petal.Width ~ Petal.Length, data = iris)
# Create the plot
autoplot(m, which = 1:6, ncol = 2, label.size = 3)
ggplot2 and ggfortify - R software and data visualization

# Change the color by groups (species)
autoplot(m, which = 1:6, label.size = 3, data = iris,
         colour = 'Species')
ggplot2 and ggfortify - R software and data visualization

Diagnostic plots with Generalized Linear Models (GLM)

USArrests data set is used.

# Compute a generalized linear model
m <- glm(Murder ~ Assault + UrbanPop + Rape,
         family = gaussian, data = USArrests)
# Create the plot
# Change the theme and colour
autoplot(m, which = 1:6, ncol = 2, label.size = 3,
         colour = "steelblue") + theme_bw()
ggplot2 and ggfortify - R software and data visualization

Plotting time series

Plotting ts objects

Data set: AirPassengers
R Function: autoplot.ts()
autoplot(AirPassengers)
ggplot2 and ggfortify - R software and data visualization

The function autoplot() can handle also other time-series-likes packages, including:

zoo::zooreg()
xts::xts()
timeSeries::timSeries()
tseries::irts()
forecast::forecast()
vars:vars()
Plotting with changepoint package

The changepoint package provides a simple approach for identifying shifts in mean and/or variance in a time series.

ggfortify supports cpt object in changepoint package.

library(changepoint)
autoplot(cpt.meanvar(AirPassengers))
ggplot2 and ggfortify - R software and data visualization

Plotting with strucchange package

strucchange is an R package for detecting jumps in data.

Data set: Nile

library(strucchange)
autoplot(breakpoints(Nile ~ 1))
ggplot2 and ggfortify - R software and data visualization

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
ggplot2 and ggfortify - R software and data visualization

Plotting K-means

Data set: USArrests
Function: autoplot.kmeans()
The original data is required as kmeans object doesn’t store original data. Samples will be colored by groups (clusters).

autoplot(kmeans(USArrests, 3), data = USArrests,
         label = TRUE, label.size = 3, frame = TRUE)
ggplot2 and ggfortify - R software and data visualization

Plotting cluster package

ggfortify supports cluster::clara, cluster::fanny and cluster::pam classes. These functions return object containing original data, so there is no need to pass original data explicitly.

The R code below shows an example for pam() function:

library(cluster)
autoplot(pam(iris[-5], 3), frame = TRUE, frame.type = 'norm')
ggplot2 and ggfortify - R software and data visualization

Plotting Local Fisher Discriminant Analysis

library(lfda)
# Local Fisher Discriminant Analysis (LFDA)
model <- lfda(iris[,-5], iris[, 5], 4, metric="plain")
autoplot(model, data = iris, frame = TRUE, frame.colour = 'Species')
Plotting survival curves

library(survival)
fit <- survfit(Surv(time, status) ~ sex, data = lung)
autoplot(fit)
ggplot2 and ggfortify - R software and data visualization

Learn more

Read more on ggfortify.

Infos

This analysis has been performed using R software (ver. 3.2.1) and ggplot2 (ver. 1.0.1)


Enjoyed this article? I’d be very grateful if you’d help it spread by emailing it to a friend, or sharing it on Twitter, Facebook or Linked In. 

Show me some love with the like buttons below... Thank you and please don't forget to share and comment below!!


 

Tweet

Share4




 

Recommended for You!

 
R Graphics Essentials for Great Data Visualization: 200 Practical Examples You Want to Know for Data Science
 NEW!!

 
Practical Guide to Cluster Analysis in R
 
Practical Guide to Principal Component Methods in R



More books on R and data science


Want to Learn More on R Programming and Data Science?

Follow us by Email


Subscribe
by FeedBurner

On Social Networks:
on Social Networks



 Get involved : 
  Click to follow us on Facebook and Google+ :    
  Comment this article by clicking on "Discussion" button (top-right position of this page)
This page has been seen 20817 times
Newsletter  
Email
  
Boosted by PHPBoost
Share to Facebook
, Number of shares
Share to Twitter
Share to LinkedIn
, Number of shares
Share to Google+
More AddThis Share options
, Number of shares
Follow
Show
Recommended for you
ggplot2.stripchart : Easy one dimensional scatter plot using ggplot2 and R software - Easy Guides - Wiki - STHDA
ggplot2.stripchart : Easy one dimensional...
www.sthda.com
Perfect Scatter Plots with Correlation and Marginal Histograms - Articles - STHDA
Perfect Scatter Plots with Correlation and...
www.sthda.com
Practical Guide to Cluster Analysis in R - Downloads - STHDA
Practical Guide to Cluster Analysis in R...
www.sthda.com
PCA - Principal Component Analysis Essentials - Articles - STHDA
PCA - Principal Component Analysis...
www.sthda.com
AddThis