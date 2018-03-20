install.packages("tibble")
library("tibble") 
 data_frame(x = rnorm(100), y = rnorm(100))
 as_data_frame(iris)

 
 Tidyr: crucial Step Reshaping Data with R for Easier Analyses
What is a tidy data set?: a data structure convention where each column is a variable and each row an observation
Reshaping data using tidyr package
Installing and loading tidyr: type install.packages(“tidyr”) for installing and library(“tidyr”) for loading.
Example data sets: USArrests
gather(): collapse columns into rows
spread(): spread two columns into multiple columns
unite(): Unite multiple columns into one
separate(): separate one column into multiple
%>%: Chaining multiple operations