 # d3Network
 require(d3Network)
URL <- paste0(
        "https://cdn.rawgit.com/christophergandrud/networkD3/",
        "master/JSONdata//flare.json")

## Convert to list format
Flare <- jsonlite::fromJSON(URL, simplifyDataFrame = FALSE)

# Use subset of data for more readable diagram
Flare$children = Flare$children[1:3]

radialNetwork(List = Flare, fontSize = 10, opacity = 0.9)


# Download JSON data
library(RCurl)
URL <- "https://raw.githubusercontent.com/christophergandrud/d3Network/master/JSONdata/flare.json"
Flare <- getURL(URL)

# Convert to list format
Flare <- rjson::fromJSON(Flare)

# Create Graph
d3Tree(List = Flare, fontsize = 8, diameter = 800)







########################################3
require(d3Network)
CanadaPC <- list(name = "Canada",
             children = list(list(name = "Newfoundland",
                                  children = list(list(name = "St. John's"))),
                             list(name = "PEI",
                                  children = list(list(name = "Charlottetown"))),
                             list(name = "Nova Scotia",
                                  children = list(list(name = "Halifax"))),
                             list(name = "New Brunswick",
                                  children = list(list(name = "Fredericton"))),
                             list(name = "Quebec",
                                  children = list(list(name = "Montreal"),
                                                  list(name = "Quebec City"))),
                             list(name = "Ontario",
                                  children = list(list(name = "Toronto"),
                                                  list(name = "Ottawa"))),
                             list(name = "Manitoba",
                                  children = list(list(name = "Winnipeg"))),
                             list(name = "Saskatchewan",
                                  children = list(list(name = "Regina"))),
                             list(name = "Nunavuet",
                                  children = list(list(name = "Iqaluit"))),
                             list(name = "NWT",
                                  children = list(list(name = "Yellowknife"))),
                             list(name = "Alberta",
                                  children = list(list(name = "Edmonton"))),
                             list(name = "British Columbia",
                                  children = list(list(name = "Victoria"),
                                                  list(name = "Vancouver"))),
                             list(name = "Yukon",
                                  children = list(list(name = "Whitehorse")))
             ))

 d3Tree(List = CanadaPC, fontsize = 10, diameter = 500,
       textColour = "#D95F0E", linkColour = "#FEC44F",
       nodeColour = "#D95F0E")
 ################################################3

 # Load energy projection data
library(RCurl)
URL <- "https://raw.githubusercontent.com/christophergandrud/d3Network/sankey/JSONdata/energy.json"
Energy <- getURL(URL, ssl.verifypeer = FALSE)
# Convert to data frame
EngLinks <- JSONtoDF(jsonStr = Energy, array = "links")
EngNodes <- JSONtoDF(jsonStr = Energy, array = "nodes")

# Plot
d3Sankey(Links = EngLinks, Nodes = EngNodes, Source = "source",
         Target = "target", Value = "value", NodeID = "name",
         fontsize = 12, nodeWidth = 30, width = 700)
################################################################################3
require(networkD3)
URL <- paste0(
        "https://cdn.rawgit.com/christophergandrud/networkD3/",
        "master/JSONdata//flare.json")

## Convert to list format
Flare <- jsonlite::fromJSON(URL, simplifyDataFrame = FALSE)

# Use subset of data for more readable diagram
Flare$children = Flare$children[1:3]

radialNetwork(List = Flare, fontSize = 10, opacity = 0.9)


diagonalNetwork(List = Flare, fontSize = 10, opacity = 0.9)



hc <- hclust(dist(USArrests), "ave")

dendroNetwork(hc, height = 600)

dendroNetwork(hclust(Flare))


# Load igraph
library(igraph)

# Use igraph to make the graph and find membership
karate <- make_graph("Zachary")
wc <- cluster_walktrap(karate)
members <- membership(wc)

# Convert to object suitable for networkD3
karate_d3 <- igraph_to_networkD3(karate, group = members)

# Create force directed network plot
forceNetwork(Links = karate_d3$links, Nodes = karate_d3$nodes, 
             Source = 'source', Target = 'target', 
             NodeID = 'name', Group = 'group')	



library(magrittr)

simpleNetwork(networkData) %>%
saveNetwork(file = 'Net1.html')

