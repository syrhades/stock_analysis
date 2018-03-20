library(jsonlite)
all.equal(mtcars, fromJSON(toJSON(mtcars)))

$(function () {
    Highcharts.chart('container', {
        chart: {
            type: 'column',
            options3d: {
                enabled: true,
                alpha: 15,
                beta: 15,
                viewDistance: 25,
                depth: 40
            }
        },

        title: {
            text: 'Total fruit consumption, grouped by gender'
        },

        xAxis: {
            categories: ['Apples', 'Oranges', 'Pears', 'Grapes', 'Bananas']
        },

        yAxis: {
            allowDecimals: false,
            min: 0,
            title: {
                text: 'Number of fruits'
            }
        },

        tooltip: {
            headerFormat: '<b>{point.key}</b><br>',
            pointFormat: '<span style="color:{series.color}">\u25CF</span> {series.name}: {point.y} / {point.stackTotal}'
        },

        plotOptions: {
            column: {
                stacking: 'normal',
                depth: 40
            }
        },

        series: [{
            name: 'John',
            data: [5, 3, 4, 7, 2],
            stack: 'male'
        }, {
            name: 'Joe',
            data: [3, 4, 4, 2, 5],
            stack: 'male'
        }, {
            name: 'Jane',
            data: [2, 5, 6, 2, 1],
            stack: 'female'
        }, {
            name: 'Janet',
            data: [3, 0, 4, 4, 3],
            stack: 'female'
        }]
    });
});

JSON structure 	Example JSON data 	Simplifies to R class 	Argument in fromJSON
Array of primitives 	["Amsterdam", "Rotterdam", "Utrecht", "Den Haag"] 	Atomic Vector 	simplifyVector
Array of objects 	[{"name":"Erik", "age":43}, {"name":"Anna", "age":32}] 	Data Frame 	simplifyDataFrame
Array of arrays 	[ [1, 2, 3], [4, 5, 6] ] 	Matrix 	simplifyMatrix

json <- '["Mario", "Peach", null, "Bowser"]'

# Simplifies into an atomic vector
fromJSON(json)

fromJSON(json, simplifyVector = FALSE)

json <-
'[
  {"Name" : "Mario", "Age" : 32, "Occupation" : "Plumber"}, 
  {"Name" : "Peach", "Age" : 21, "Occupation" : "Princess"},
  {},
  {"Name" : "Bowser", "Occupation" : "Koopa"}
]'
mydf <- fromJSON(json)
mydf

json <-
'[
  {"Name" : "Mario", "Age" : 32, "Occupation" : "Plumber"}, 
  {"Name" : "Peach", "Age" : 21, "Occupation" : "Princess"},
  {},
  {"Name" : "Bowser", "Occupation" : "Koopa"}
]'
mydf <- fromJSON(json)
mydf

mydf%>% toJSON

https://cran.r-project.org/web/packages/jsonlite/vignettes/json-aaquickstart.html

mydf$Ranking <- c(3, 1, 2, 4)
toJSON(mydf, pretty=TRUE)
json <-'[{"name": "Jane","data": [1, 0, 4,6]}, 
        {"name": "John","data": [5, 7, 3]}
                    ] '

mydf <- fromJSON(json)
mydf

toJSON(mydf, pretty=TRUE)

[
  {
    "name": "Jane",
    "data": [1, 0, 4, 6]
  },
  {
    "name": "John",
    "data": [5, 7, 3]
  }
] 


[{
                    name: 'Jane',
                    data: [1, 0, 4,6]
                }, {
                    name: 'John',
                    data: [5, 7, 3]
                }]

toJSON(mydf, pretty=TRUE) %>% toString %>% gsub('"',"'",.) %>% write("/tmp/eee.txt")


mydf2 <- mtcars[,1:2]
names(mydf2) <- c("data","name")
mydf2$name <- rownames(mydf2)
rownames(mydf2) <- NULL
mydf2$data<-mydf2$data %>% as.list


toJSON(mydf2, pretty=TRUE) %>% toString %>% gsub('"',"'",.)
toJSON(mydf2, pretty=TRUE) %>% gsub('"',"'",.)



#######################stock chart
json <-'[{"name": AAPL,
                "data":  [[1147651200000,376.20],
[1147737600000,371.30],
[1147824000000,374.50],
[1147910400000,370.99],
[1147996800000,370.02],
[1148256000000,370.95],
[1148342400000,375.58],
[1148428800000,381.25],
[1148515200000,382.99],
[1148601600000,381.35],
[1148947200000,371.94],
[1149033600000,371.82]]              
            }]'
mydfstock <- fromJSON(json)



##########################
Highcharts <- fromJSON("http://datas.org.cn/jsonp?filename=json/aapl-c.json&callback=?")


hadley_orgs <- fromJSON("https://api.github.com/users/hadley/orgs")
hadley_repos <- fromJSON("https://api.github.com/users/hadley/repos")
gg_commits <- fromJSON("https://api.github.com/repos/hadley/ggplot2/commits")
gg_issues <- fromJSON("https://api.github.com/repos/hadley/ggplot2/issues")

#latest issues
paste(format(gg_issues$user$login), ":", gg_issues$title)