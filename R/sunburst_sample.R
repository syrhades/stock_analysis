# devtools::install_github("timelyportfolio/sunburstR")

library(sunburstR)

# read in sample visit-sequences.csv data provided in source
# only use first 200 rows to speed package build and check
#   https://gist.github.com/kerryrodden/7090426#file-visit-sequences-csv
sequences <- read.csv(
  system.file("examples/visit-sequences.csv",package="sunburstR")
  ,header = FALSE
  ,stringsAsFactors = FALSE
)[1:100,]

sunburst(sequences)

## Not run: 

# explore some of the arguments
sunburst(
  sequences
  ,count = TRUE
)

sunburst(
  sequences
  # apply sort order to the legends
  ,legendOrder = unique(unlist(strsplit(sequences[,1],"-")))
  # just provide the name in the explanation in the center
  ,explanation = "function(d){return d.data.name}"
)


# try with json data
sequence_json <- jsonlite::fromJSON(
  system.file("examples/visit-sequences.json",package="sunburstR"),
  simplifyDataFrame = FALSE
)
sunburst(sequence_json)



# try with csv data from this fork
#  https://gist.github.com/mkajava/7515402
# great use for new breadbrumb wrapping
sunburst(
  csvdata = read.csv(
    file = paste0(
      "https://gist.githubusercontent.com/mkajava/",
      "7515402/raw/9f80d28094dc9dfed7090f8fb3376ef1539f4fd2/",
      "comment-sequences.csv"
    )
    ,header = TRUE
    ,stringsAsFactors = FALSE
  )
)


# try with csv data from this fork
#  https://gist.github.com/rileycrane/92a2c36eb932b4f99e51/
sunburst( csvdata = read.csv(
  file = paste0(
    "https://gist.githubusercontent.com/rileycrane/",
    "92a2c36eb932b4f99e51/raw/",
    "a0212b4ca8043af47ec82369aa5f023530279aa3/visit-sequences.csv"
  )
  ,header=FALSE
  ,stringsAsFactors = FALSE
))

## End(Not run)
## Not run: 
#  use sunburst to analyze ngram data from Peter Norvig
#    http://norvig.com/mayzner.html

library(sunburstR)
library(pipeR)

#  read the csv data downloaded from the Google Fusion Table linked in the article
ngrams2 <- read.csv(
  system.file(
    "examples/ngrams2.csv"
    ,package="sunburstR"
  )
  , stringsAsFactors = FALSE
)

ngrams2 %>>%
  #  let's look at ngrams at the start of a word, so columns 1 and 3
  (.[,c(1,3)]) %>>%
  #  split the ngrams into a sequence by splitting each letter and adding -
  (
    data.frame(
      sequence = strsplit(.[,1],"") %>>%
        lapply( function(ng){ paste0(ng,collapse = "-") } ) %>>%
        unlist
      ,freq = .[,2]
      ,stringsAsFactors = FALSE
    )
  ) %>>%
  sunburst


library(htmltools)

ngrams2 %>>%
  (
    lapply(
      seq.int(3,ncol(.))
      ,function(letpos){
        (.[,c(1,letpos)]) %>>%
          #  split the ngrams into a sequence by splitting each letter and adding -
          (
            data.frame(
              sequence = strsplit(.[,1],"") %>>%
                lapply( function(ng){ paste0(ng,collapse = "-") } ) %>>%
                unlist
              ,freq = .[,2]
              ,stringsAsFactors = FALSE
            )
          ) %>>%
          ( tags$div(style="float:left;",sunburst( ., height = 300, width = 300 )) )
      }
    )
  ) %>>%
  tagList %>>%
  browsable

## End(Not run)
## Not run: 
  library(treemap)
  library(sunburstR)
  library(d3r)

  # use example from ?treemap::treemap
  data(GNI2014)
  tm <- treemap(GNI2014,
          index=c("continent", "iso3"),
          vSize="population",
          vColor="continent",
          type="index")

  tm_nest <- d3_nest(
    tm$tm[,c("continent", "iso3", "vSize", "color")],
    value_cols = c("vSize", "color")
  )

  sunburst(
    data = tm_nest,
    valueField = "vSize",
    count = TRUE,
    colors = htmlwidgets::JS("function(d){return d3.select(this).datum().data.color;}"),
    withD3 = TRUE
  )

## End(Not run)
# calendar sunburst example

library(sunburstR)

df <- data.frame(
  date = seq.Date(
    as.Date('2014-01-01'),
    as.Date('2016-12-31'),
    by = "days"
  ),
  stringsAsFactors = FALSE
)

df$year = format(df$date, "%Y")
df$quarter = paste0("Q", ceiling(as.numeric(format(df$date,"%m"))/3))
df$month = format(df$date, "%b")
df$path = paste(df$year, df$quarter, df$month, sep="-")
df$count = rep(1, nrow(df))

sunburst(
  data.frame(xtabs(count~path,df)),
  # added a degree of difficulty by providing
  #  not easily sortable names
  sortFunction = htmlwidgets::JS(
"
function(a,b){
  abb = {
    2014:-7,
    2015:-6,
    2016:-5,
    Q1:-4,
    Q2:-3,
    Q3:-2,
    Q4:-1,
    Jan:1,
    Feb:2,
    Mar:3,
    Apr:4,
    May:5,
    Jun:6,
    Jul:7,
    Aug:8,
    Sep:9,
    Oct:10,
    Nov:11,
    Dec:12
  }
  return abb[a.data.name] - abb[b.data.name];
}
"
  )
)
# sorting example: place data in order of occurence

library(sunburstR)

df <- data.frame(
  group = c("foo", "bar", "xyz"),
  value = c(1, 3, 2)
)

sunburst(df,
         # create a trivial sort function
         sortFunction = htmlwidgets::JS('function(x) {return x;}'))

new_order <- c(3,2,1)
sunburst(df[new_order,],
         sortFunction = htmlwidgets::JS('function(x) {return x;}'))

