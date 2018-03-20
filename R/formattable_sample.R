df <- data.frame(
  id = 1:10,
  name = c("Bob", "Ashley", "James", "David", "Jenny", 
    "Hans", "Leo", "John", "Emily", "Lee"), 
  age = c(28, 27, 30, 28, 29, 29, 27, 27, 31, 30),
  grade = c("C", "A", "A", "C", "B", "B", "B", "A", "C", "C"),
  test1_score = c(8.9, 9.5, 9.6, 8.9, 9.1, 9.3, 9.3, 9.9, 8.5, 8.6),
  test2_score = c(9.1, 9.1, 9.2, 9.1, 8.9, 8.5, 9.2, 9.3, 9.1, 8.8),
  final_score = c(9, 9.3, 9.4, 9, 9, 8.9, 9.25, 9.6, 8.8, 8.7),
  registered = c(TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE),
  stringsAsFactors = FALSE)

library(formattable)

formattable(df, list(
  age = color_tile("white", "orange"),
  grade = formatter("span", style = x ~ ifelse(x == "A", 
    style(color = "green", font.weight = "bold"), NA)),
  area(col = c(test1_score, test2_score)) ~ normalize_bar("pink", 0.2),
  final_score = formatter("span",
    style = x ~ style(color = ifelse(rank(-x) <= 3, "green", "gray")),
    x ~ sprintf("%.2f (rank: %02d)", x, rank(-x))),
  registered = formatter("span",
    style = x ~ style(color = ifelse(x, "green", "red")),
    x ~ icontext(ifelse(x, "ok", "remove"), ifelse(x, "Yes", "No")))
))

library(wordcloud2)
## Sys.setlocale("LC_CTYPE","eng")
wordcloud2(demoFreqC, size = 2, fontFamily = "微软雅黑",
           color = "random-light", backgroundColor = "grey")

wordcloud2(demoFreq, size = 2, minRotation = -pi/6, maxRotation = -pi/6,
  rotateRatio = 1)
wordcloud2(demoFreq, size = 2, minRotation = -pi/2, maxRotation = -pi/2)
wordcloud2(demoFreq, size = 1,shape = 'star') 


require(rpivotTable)
data(HairEyeColor)
rpivotTable(data = HairEyeColor, rows = "Hair",cols="Eye", vals = "Freq", aggregatorName = "Sum", rendererName = "Table", width="100%", height="400px")
rpivotTable(mtcars)


d3heatmap

if (!require("devtools")) install.packages("devtools")
devtools::install_github("rstudio/d3heatmap")

http://spark.apache.org/downloads.html
https://github.com/rstudio/sparklyr

devtools::install_github("rstudio/tensorflow")
https://www.tensorflow.org/get_started/os_setup.html#download-and-setup
# Ubuntu/Linux 64-bit
$ sudo apt-get install python-pip python-dev
pip install tensorflow
# Python 2
$ sudo pip install --upgrade $TF_BINARY_URL

# Python 3
$ sudo pip3 install --upgrade $TF_BINARY_URL


Sys.setenv(TENSORFLOW_PYTHON="/usr/local/bin/python")
devtools::install_github("rstudio/tensorflow")
Sys.setenv(TENSORFLOW_PYTHON_VERSION = 3)
devtools::install_github("rstudio/tensorflow")
library(tensorflow)
sess = tf$Session()
hello <- tf$constant('Hello, TensorFlow!')
sess$run(hello)



#######################################


scores <- data.frame(id = 1:5,
  prev_score = c(10, 8, 6, 8, 8),
  cur_score = c(8, 9, 7, 8, 9),
  change = c(-2, 1, 1, 0, 1))
library(formattable)
formattable(scores)

plain_formatter <- formatter("span")
plain_formatter(c(1, 2, 3))

width_formatter <- formatter("span",
  style = x ~ style(width = suffix(x, "px")))
width_formatter(c(10, 11, 12))

sign_formatter <- formatter("span", 
  style = x ~ style(color = ifelse(x > 0, "green", 
    ifelse(x < 0, "red", "black"))))
sign_formatter(c(-1, 0, 1))

formattable(scores, list(change = sign_formatter))

above_avg_bold <- formatter("span", 
  style = x ~ style("font-weight" = ifelse(x > mean(x), "bold", NA)))
above_avg_bold(c(-1, 0, 1))


formattable(scores, list(
  prev_score = above_avg_bold,
  cur_score = above_avg_bold,
  change = sign_formatter))


Sometimes, we need to format one column based on the values of another column. This can be easily done with one-sided formula in formatter(). When using formatter("span", style = ~ expr), expr is evaluated in the data frame so that all columns are available for use.


formattable(scores, list(
  cur_score = formatter("span", 
    style = ~ style(color = ifelse(change >= 0, "green", "red")))))


formattable(scores, list(prev_score = FALSE))

products <- data.frame(id = 1:5, 
  price = c(10, 15, 12, 8, 9),
  rating = c(5, 4, 4, 3, 4),
  market_share = percent(c(0.1, 0.12, 0.05, 0.03, 0.14)),
  revenue = accounting(c(55000, 36400, 12000, -25000, 98100)),
  profit = accounting(c(25300, 11500, -8200, -46000, 65000)))
products

formattable(products, list(profit = sign_formatter))

formattable(products, list(
  price = color_tile("transparent", "lightpink"),
  rating = color_bar("lightgreen"),
  market_share = color_bar("lightblue"),
  revenue = sign_formatter,
  profit = sign_formatter))

set.seed(123)
df <- data.frame(id = 1:10, 
  a = rnorm(10), b = rnorm(10), c = rnorm(10))
formattable(df, list(area(col = a:c) ~ color_tile("transparent", "pink")))
formattable(df, list(area(col = a:b) ~ color_tile("transparent", "pink")))
formattable(df[, -1], list(~ percent))


df <- cbind(data.frame(id = 1:10), 
  do.call(cbind, lapply(1:8, function(x) rnorm(10))))
formattable(df, lapply(1:nrow(df), function(row) {
  area(row, col = -1) ~ color_tile("lightpink", "lightblue")
}))

as.datatable(formattable(products))

as.datatable(formattable(products, list(
  price = color_tile("transparent", "lightpink"),
  revenue = sign_formatter,
  profit = sign_formatter)))


dates <- formattable(as.Date(c("2016-05-01", "2016-05-10")), format = "%Y%m%d")
dates

Note that isTRUE() does not directly work with values of lv because isTRUE() uses identical(x, TRUE) and lv[[1]], as a formattable logical value is not identical to a plain TRUE.

all(lv)
## [1] no
any(lv)
## [1] yes

pm <- matrix(rnorm(6, 0.8, 0.1), 2, 3, 
  dimnames = list(c("a", "b"), c("X", "Y", "Z")))
pm
fpm <- percent(pm)
fpm
fpm["a", c("Y", "Z")]
pa <- array(rnorm(12, 0.8, 0.1), c(2, 3, 2))
pa

percent(pa)

p <- data.frame(
  id = c(1, 2, 3, 4, 5), 
  name = c("A1", "A2", "B1", "B2", "C1"),
  balance = accounting(c(52500, 36150, 25000, 18300, 7600), format = "d"),
  growth = percent(c(0.3, 0.3, 0.1, 0.15, 0.15), format = "d"),
  ready = formattable(c(TRUE, TRUE, FALSE, FALSE, TRUE), "yes", "no"))
p


formattable::style(color = "red")
style(color = "red", "font-weight" = "bold")
style("background-color" = "gray", "border-radius" = "4px")
style("padding-right" = "2px")

formattable(mtcars, list(
  mpg = formatter("span",
    style = x ~ style(color = ifelse(x > median(x), "red", NA)))))