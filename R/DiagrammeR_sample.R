library(DiagrammeR)

grViz("
digraph DAG {

  # Intialization of graph attributes
  graph [overlap = true]

  # Initialization of node attributes
  node [shape = box,
        fontname = Helvetica,
        color = blue,
        type = box,
        fixedsize = true]

  # Initialization of edge attributes
  edge [color = green,
        rel = yields]

  # Node statements
  1; 2; 3; 4; 8; 9; 10; 11

  # Revision to node attributes
  node [shape = circle]

  # Node statements
  5; 6; 7

  # Edge statements
  1->5; 2->6; 3->9; 4->7; 5->8; 5->10; 7->11

  # Revision to edge attributes
  edge [color = red]

  # Edge statements
  1->8; 3->6; 3->11; 3->7; 5->9; 6->10
}
")


#######################
library(DiagrammeR)
library(magrittr)

graph <-
  create_graph() %>%
  set_graph_name("DAG") %>%
  set_global_graph_attrs("graph", "overlap", "true") %>%
  set_global_graph_attrs("graph", "fixedsize", "true") %>%
  set_global_graph_attrs("node", "color", "blue") %>%
  set_global_graph_attrs("node", "fontname", "Helvetica") %>%
  add_n_nodes(11) %>%
  select_nodes_by_id(c(1:4, 8:11)) %>% 
  set_node_attrs_ws("shape", "box") %>%
  clear_selection %>%
  select_nodes_by_id(5:7) %>% 
  set_node_attrs_ws("shape", "circle") %>%
  clear_selection %>%
  add_edges_w_string(
    "1->5 2->6 3->9 4->7 5->8 5->10 7->11", "green") %>%
  add_edges_w_string(
    "1->8 3->6 3->11 3->7 5->9 6->10", "red") %>%
  select_edges("rel", "green") %>%
  set_edge_attrs_ws("color", "green") %>%
  invert_selection %>%
  set_edge_attrs_ws("color", "red")
# https://github.com/rich-iannone/DiagrammeR


library(magrittr)
# Create a new graph and add a cycle of nodes to it
graph <-
create_graph() %>%
add_cycle(6)

node_info(graph)


graph <-
create_graph() %>%
add_cycle(10)


# Create a graph with two nodes
graph <-
create_graph() %>%
add_n_nodes(2)
render_graph(graph)

# Add an edge between those nodes and attach a
# relationship to the edge
graph <-
add_edge(
graph,
from = 1,
to = 2,
rel = "to_get")
# Use the `edge_info()` function to verify that
# the edge has been created
edge_info(graph)
render_graph(graph)


graph <- create_graph() %>%
add_edges_from_table(
mtcars,
from_col = "cyl",
to_col = "disp")
render_graph(graph)

diamonds_df<-diamonds %>% as.data.frame
graph2 <- create_graph() %>%
add_edges_from_table(
diamonds_df,
from_col = "clarity",
to_col = "color")
render_graph(graph2)

# Get a count of nodes in the graph
node_count(graph)
#> [1] 13
# Get a count of edges in the graph
edge_count(graph)
#> [1] 13
## End(Not run)

# Create a graph with 10 nodes
graph <-
create_graph() %>%
add_n_nodes(10)
# Add edges between nodes using a character string
graph <-
graph %>%
add_edges_w_string(
"1->2 1->3 2->4 2->5 3->6 3->7 4->8 4->9 5->10")
render_graph(graph)


# Create a graph with nodes and no edges
nodes <-
create_nodes(
nodes = c("a", "b", "c", "d"),
type = "letter",
color = c("red", "green", "grey", "blue"),
value = c(3.5, 2.6, 9.4, 2.7))
graph <- create_graph(nodes_df = nodes)
# Create an edge data frame
edges <-
create_edges(
from = c("a", "b", "c"),
to = c("d", "c", "a"),
rel = "leading_to")
# Add the edge data frame to the graph object to create a
# graph with both nodes and edges
graph <-
add_edge_df(
graph = graph,
edge_df = edges)
get_edges(graph, return_type = "vector")
#> [1] "a -> d" "b -> c" "c -> a"



# Create an empty graph
graph <- create_graph()
# Add two nodes
graph <- add_node(graph)
graph <- add_node(graph)
get_nodes(graph)
#> [1] "1" "2"
# Add a node with 'type' defined
graph <- add_node(graph, type = "person")
get_node_df(graph)



graph_1 <-
create_graph() %>%
add_nodes_from_table(mtcars)
# View the graph's internal node data frame (ndf)
# with `get_node_df()` and dplyr's `as.tbl()`
graph_1 %>% get_node_df %>% as.tbl

render_graph(graph_1)

# Create an empty graph
graph <- create_graph()
# Create a node data frame
nodes <-
create_nodes(
nodes = c("a", "b", "c", "d"),
type = "letter",
color = c("red", "green", "grey", "blue"),
value = c(3.5, 2.6, 9.4, 2.7))
# Add the node data frame to the graph object to
# create a graph with nodes
graph <-
add_node_df(graph = graph, node_df = nodes)
get_node_df(graph)


nodes_2 <-
create_nodes(
nodes = c("e", "f", "g", "h"),
type = "letter",
color = c("white", "brown", "aqua", "pink"),
value = c(1.6, 6.4, 0.8, 4.2))
# Add the second node data frame to the graph object
# to add more nodes with attributes to the graph
graph <-
add_node_df(graph = graph, node_df = nodes_2)

graph <-
create_graph() %>%
add_n_nodes(5)
# Get the graph's nodes
graph %>% get_nodes
#> [1] "1" "2" "3" "4" "5"

graph <-
create_graph() %>%
add_n_nodes(1) %>%
select_last_node %>%
add_n_nodes_ws(5, "from")
# Get the graph's nodes
graph %>% get_nodes
#> [1] "1" "2" "3" "4" "5" "6"
# Get the graph's edges
graph %>% get_edges
#> "1 -> 2" "1 -> 3" "1 -> 4" "1 -> 5" "1 -> 6"

graph <-
create_graph() %>%
add_n_nodes(1) %>%
select_last_node %>%
add_n_nodes_ws(5, "to")
# Get the graph's nodes
graph %>% get_nodes
#> [1] "1" "2" "3" "4" "5" "6"
# Get the graph's edges
graph %>% get_edges
#> "2 -> 1" "3 -> 1" "4 -> 1" "5 -> 1" "6 -> 1"
render_graph(graph)

graph <-
create_graph() %>%
add_path(4, "four_path") %>%
add_path(5, "five_path") %>%
add_path(6, "six_path")
render_graph(graph)

graph <-
create_graph() %>%
add_path(3, "four_path") %>%
add_path(5, "five_path") %>%
add_path(7, "six_path")

graph <-
create_graph() %>%
add_prism(3, "prism")

graph <-
create_graph() %>%
add_star(4, "four_star") %>%
add_star(5, "five_star") %>%
add_star(6, "six_star3")


# Create three graphs
graph_1 <-
create_graph() %>%
add_node("a") %>%
add_node("b") %>%
add_node("c") %>%
add_edge("a", "c") %>%
add_edge("a", "b") %>%
add_edge("b", "c")
graph_2 <-
graph_1 %>%
add_node("d") %>%
add_edge("d", "c")
graph_3 <-
graph_2 %>%
add_node("e") %>%
add_edge("e", "b")
# Create an empty graph series and add
# the graphs
series <-
create_series() %>%
add_to_series(graph_1, .) %>%
add_to_series(graph_2, .) %>%
add_to_series(graph_3, .)
# Count the number of graphs in the graph series
graph_count(series)
#> [1] 3
render_graph(series)


# Create a simple edge data frame (edf) and
# view the results
edges <-
create_edges(
from = c(1, 2, 3,4),
to = c(4, 3, 1,2),
rel = c("a","b","c"))
# Display the `edges` edf
edges

# Render the graph to make it viewable in
# the Viewer pane
render_graph(
create_graph(edges_df = edges),
output = "visNetwork")

# Create an edge data frame with several
# additional parameters
edges <-
create_edges(
from = c(1, 2, 3),
to = c(4, 3, 1),
rel = "a",
length = c(50, 100, 250),
color = "green",
width = c(1, 5, 2))
# Render the graph to make it viewable in
# the Viewer pane
render_graph(
create_graph(edges_df = edges),
output = "visNetwork")


# Create an empty graph
graph <- create_graph()
# A graph can be created with nodes and
# without edges; this is usually done in 2 steps:
# 1. create a node data frame (ndf) using the
#
`create_nodes()` function
nodes <-
create_nodes(
nodes = c("a", "b", "c", "d"))
# 2. create the graph object with `create_graph()`
#
and pass in the ndf to `nodes_df`
graph <- create_graph(nodes_df = nodes)
# You can create a similar graph with just nodes but
# also provide a range of attributes for the nodes
# (e.g., types, labels, arbitrary 'values')
nodes <-
create_nodes(
nodes = c("a", "b", "c", "d"),
label = TRUE,
type = c("type_1", "type_1",
"type_5", "type_2"),
shape = c("circle", "circle",
"rectangle", "rectangle"),
values = c(3.5, 2.6, 9.4, 2.7))
graph <- create_graph(nodes_df = nodes)

# with different function--although edge attributes
# can specified); this is usually done in 2 steps:
# 1. create an edge data frame (edf) using the
#
`create_edges()` function:
edges <-
create_edges(
from = c("a", "b", "c"),
to = c("d", "c", "a"),
rel = "leading_to",
values = c(7.3, 2.6, 8.3))
# 2. create the graph object with `create_graph()`
#
and pass in the edf to `edges_df`
graph <- create_graph(edges_df = edges)
# You can create a graph with both nodes and nodes
# defined, and, also add in some default attributes
# to be applied to all the nodes (`node_attrs`) and
# edges (`edge_attrs`) in this initial graph
graph <-
create_graph(
nodes_df = nodes,
edges_df = edges,
node_attrs = "fontname = Helvetica",
edge_attrs = c("color = blue",
"arrowsize = 2"))


nodes <-
create_nodes(
nodes = c("a", "b", "c", "d"),
label = TRUE,
type = c("type_1", "type_1",
"type_5", "type_2"),
shape = c("circle", "circle",
"rectangle", "rectangle"),
values = c(3.5, 2.6, 9.4, 2.7))
graph <- create_graph(nodes_df = nodes)


edges <-
create_edges(
from = c("a", "b", "c"),
to = c("d", "c", "a"),
rel = "leading_to",
values = c(7.3, 2.6, 8.3))
# 2. create the graph object with `create_graph()`
#
and pass in the edf to `edges_df`
graph <- create_graph(edges_df = edges)

graph <-
create_graph(
nodes_df = nodes,
edges_df = edges,
node_attrs = "fontname = Helvetica",
edge_attrs = c("color = blue",
"arrowsize = 2"))
render_graph(graph)

nodes <-
create_nodes(
nodes = 1:4,
type = "a",
label = TRUE,
style = "filled",
color = "aqua",
shape = c("circle", "circle",
"rectangle", "rectangle"),
value = c(3.5, 2.6, 9.4, 2.7))
graph <-
create_graph(
nodes_df = nodes,
node_attrs = "fontname = Helvetica",
edge_attrs = c("color = blue",
"arrowsize = 2"))


random_graph_directed <-
create_random_graph(
n = 50,
m = 75,
directed = TRUE)
render_graph(random_graph_directed)


DiagrammeR("
graph LR
A-->B
A-->C
C-->E
B-->D
C-->D
D-->F
E-->F
")
DiagrammeR("
graph TB
A-->B
A-->C
C-->E
B-->D
C-->D
D-->F
E-->F
")

DiagrammeR("graph LR;A(Rounded)-->B[Squared];B-->C{A Decision};
C-->D[Square One];C-->E[Square Two];
style A fill:#E5E25F; style B fill:#87AB51; style C fill:#3C8937;
style D fill:#23772C; style E fill:#B6E6E6;"
)


data(mtcars)
connections <- sapply(
1:ncol(mtcars)
,function(i){
paste0(
i
,"(",colnames(mtcars)[i],")---"
,i,"-stats("
,paste0(
names(summary(mtcars[,i]))
,": "
,unname(summary(mtcars[,i]))
,collapse="<br/>"
)
,")"
)
}
)

DiagrammeR(
paste0(
"graph TD;", "\n",
paste(connections, collapse = "\n"),"\n",
"classDef column fill:#0001CC, stroke:#0D3FF3, stroke-width:1px;" ,"\n",
"class ", paste0(1:length(connections), collapse = ","), " column;"
)
)

DiagrammeR("
sequenceDiagram;
customer->>ticket seller: ask ticket;
ticket seller->>database: seats;
alt tickets available
database->>ticket seller: ok;
ticket seller->>customer: confirm;
customer->>ticket seller: ok;
ticket seller->>database: book a seat;
ticket seller->>printer: print ticket;
else sold out
database->>ticket seller: none left;
ticket seller->>customer: sorry;
end
")



graph <-
create_graph() %>%
add_balanced_tree(2, 2) %>%
add_balanced_tree(3, 2)%>%
add_balanced_tree(3, 3)
render_graph(graph)

graph %>% export_csv(output_path = "/tmp/")

# Create a PDF file for the graph (`graph.pdf`)
graph %>% export_graph("graph.pdf")
library(DiagrammeRsvg)

graph %>% export_graph("/tmp/graph.pdf")


# Create a PNG file for the graph (`mypng`)
graph %>%
export_graph(
file_name = "mypng",
file_type = "PNG")
## End(Not run)



# View the second graph in the series in the Viewer
render_graph_from_series(
graph_series = series,
graph_no = 2)

sage
renderGrViz(expr, env = parent.frame(), quoted = FALSE)
Arguments
expr an expression that generates a DiagrammeR graph
env the environment in which to evaluate expr.
quoted is expr a quoted expression (with quote())? This is useful if you want to save an
expression in a variable.
See Also
grVizOutput for an example in Shiny



visnetwork(graph)

vivagraph(graph = graph)


install.packages("ebookPortfolio",
repos = c("http://cran.r-project.org"),
type = getOption("pkgType"))


# Traditional code:
plot(density(sample(mtcars$mpg, size = 10000, replace = TRUE),
kernel = "gaussian"), col = "red", main="density of mpg (bootstrap)")
# Operator-based pipeline using %>>%:
mtcars$mpg %>>%
sample(size = 10000, replace = TRUE) %>>%
density(kernel = "gaussian") %>>%
plot(col = "red", main = "density of mpg (bootstrap)")
# Object-based pipeline using Pipe():
Pipe(mtcars$mpg)$
sample(size = 10000, replace = TRUE)$
density(kernel = "gaussian")$
plot(col = "red", main = "density of mpg (bootstrap)")
# Argument-based pipeline using pipeline():
pipeline(mtcars$mpg,
sample(size = 10000, replace = TRUE),
density(kernel = "gaussian"),
plot(col = "red", main = "density of mpg (bootstrap)"))
# Expression-based pipeline using pipeline():
pipeline({
mtcars$mpg
sample(size = 10000, replace = TRUE)
density(kernel = "gaussian")
plot(col = "red", main = "density of mpg (bootstrap)")
})
