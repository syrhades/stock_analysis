https://tensorflow.rstudio.com/keras/


# Defining data variables
X = matrix(rnorm(2000), ncol = 10)
y = as.matrix(rnorm(200))
# Bundling data variables into dataframe
train_data <- data.frame(X,y)
# Training model for generating prediction
lmodel<- lm(y~ train_data $X1 + train_data $X2 + train_data $X3 +
train_data $X4 + train_data $X5 + train_data $X6 + train_data $X7 +
train_data $X8 + train_data $X9 + train_data $X10,data= train_data)
summary(lmodel)


• RSS: This is equal to ∑(yactual - y)2.
• Degrees of Freedom (DOF): This is used for identifying the degree of ft for
the prediction model, which should be as small as possible (logically, the
value 0 means perfect prediction).
• Residual standard error (RSS/DF): This is used for identifying the goodness
of ft for the prediction model, which should be as small as possible
(logically, the value 0 means perfect prediction).
• pr: This is the probability for a variable to be included into the model; it
should be less than 0.05 for a variable to be included.
• t-value: This is equal to 15.
• f: This is the statistic that checks whether R square is a value other than zero.


# XtX =
values(
# For loading hdfs data in to R
from.dfs(
# MapReduce Job to produce XT*X
mapreduce(
input = X.index,
# Mapper – To calculate and emitting XT*X
map =
function(., Xi) {
yi = y[Xi[,1],]
Xi = Xi[,-1]
keyval(1, list(t(Xi) %*% Xi))},
# Reducer – To reduce the Mapper output by performing sum
operation over them
reduce = Sum,
combine = TRUE)))[[1]]

###########################
Xty = values(
# For loading hdfs data
from.dfs(
# MapReduce job to produce XT * y
mapreduce(
input = X.index,
# Mapper – To calculate and emitting XT*y
map = function(., Xi) {
yi = y[Xi[,1],]
Xi = Xi[,-1]
keyval(1, list(t(Xi) %*% yi))},
# Reducer – To reducer the Mapper output by performing # sum
operation over them
reduce = Sum,
combine = TRUE)))[[1]]

solve(XtX, Xty)

Logistic regression with R
To perform logistic regression with R, we will use the iris dataset and the
glm model.
#loading iris dataset
data(iris)
# Setting up target variable
target <- data.frame(isSetosa=(iris$Species == 'setosa'))
# Adding target to iris and creating new dataset
inputdata <- cbind(target,iris)
# Defining the logistic regression formula
formula <- isSetosa ~ Sepal.Length + Sepal.Width + Petal.Length +
Petal.Width
# running Logistic model via glm()
logisticModel <- glm(formula, data=inputdata, family="binomial")
dims<2
t(rep(0, dims))


g = function(z) 1/(1 + exp(-z))


curve(g, -8, 7, n = 2000)


chippy <- function(x) sin(cos(x)*exp(-x/2))

There are several clustering techniques available within R libraries, such as k-means,
k-medoids, hierarchical, and density-based clustering. Among them, k-means is
widely used as the clustering algorithm in data science. This algorithm asks for a
number of clusters to be the input parameters from the user side.
Applications of clustering are as follows:
• Market segmentation
• Social network analysis
• Organizing computer network
• Astronomical data analysis

Clustering with R
We are considering the k-means method here for implementing the clustering
model over the iris input dataset, which can be achieved by just calling its
in-built R dataset – the iris data (for more information, visit http://stat.ethz.
ch/R-manual/R-devel/library/datasets/html/iris.html). Here we will see
how k-means clustering can be performed with R.
# Loading iris flower dataset
data("iris")
# generating clusters for iris dataset
kmeans <- kmeans(iris[, -5], 3, iter.max = 1000)
# comparing iris Species with generated cluster points
Comp <- table(iris[, 5], kmeans$cluster)
Deriving clusters for small datasets is quite simple, but deriving it for huge datasets
requires the use of Hadoop for providing computation power.
Performing clustering with R and Hadoop
Since the k-means clustering algorithm is already developed in RHadoop, we
are going to use and understand it. You can make changes in their Mappers and
Reducers as per the input dataset format. As we are dealing with Hadoop, we need
to develop the Mappers and Reducers to be run on nodes in a parallel manner.


The outline of the clustering algorithm is as follows:
• Defning the dist.fun distance function
• Defning the k-means.map k-means Mapper function
• Defning the k-means.reduce k-means Reducer function
• Defning the k-means.mr k-means MapReduce function
• Defning input data points to be provided to the clustering algorithms
Now we will run k-means.mr (the k-means MapReduce job) by providing the
required parameters.





Recommendation algorithms

User-based recommendations: In this type, users (customers) similar to
current user (customer) are determined. Based on this user similarity, their
interested/used items can be recommended to other users. Let's learn it
through an example.


Assume there are two users named Wendell and James; both have a similar
interest because both are using an iPhone. Wendell had used two items, iPad
and iPhone, so James will be recommended to use iPad. This is user-based
recommendation.
Item-based recommendations: In this type, items similar to the items that are
being currently used by a user are determined. Based on the item-similarity
score, the similar items will be presented to the users for cross-selling and
up-selling type of recommendations. Let's learn it through an example.



For example, a user named Vaibhav likes and uses the following books:
• Apache Mahout Cookbook, Piero Giacomelli, Packt Publishing
• Hadoop MapReduce Cookbook, Thilina Gunarathne and Srinath Perera, Packt
Publishing
• Hadoop Real-World Solutions Cookbook, Brian Femiano, Jon Lentz, and Jonathan R.
Owens, Packt Publishing
• Big Data For Dummies, Dr. Fern Halper, Judith Hurwitz, Marcia Kaufman, and
Alan Nugent, John Wiley & Sons Publishers
Based on the preceding information, the recommender system will predict which
new books Vaibhav would like to read, as follows:
• Big Data Analytics with R and Hadoop, Vignesh Prajapati, Packt Publishing
Now we will see how to generate recommendations with R and Hadoop. But before
going towards the R and Hadoop combination, let us frst see how to generate it with
R. This will clear the concepts to translate your generated recommender systems to
MapReduce recommendation algorithms. In case of generating recommendations
with R and Hadoop, we will use the RHadoop distribution of Revolution Analytics.




Steps to generate recommendations in R
To generate recommendations for users, we need to have datasets in a special format
that can be read by the algorithm. Here, we will use the collaborative fltering
algorithm for generating the recommendations rather than content-based algorithms.
Hence, we will need the user's rating information for the available item sets. So, the
small.csv dataset is given in the format user ID, item ID, item's ratings.
# user ID, item ID, item's rating
1, 101, 5.0
1, 102, 3.0
1, 103, 2.5
2, 101, 2.0
2, 102, 2.5
2, 103, 5.0
2, 104, 2.0
3, 101, 2.0
3, 104, 4.0
3, 105, 4.5
3, 107, 5.0
4, 101, 5.0
4, 103, 3.0
4, 104, 4.5
4, 106, 4.0
5, 101, 4.0
5, 102, 3.0
5, 103, 2.0
5, 104, 4.0
5, 105, 3.5
5, 106, 4.0
The preceding code and datasets are reproduced from the book Mahout in Action, Robin
Anil, Ellen Friedman, Ted Dunning, and Sean Owen, Manning Publications and the website is
http://www.fens.me/.
Recommendations can be derived from the matrix-factorization technique as follows:
Co-occurrence matrix * scoring matrix = Recommended Results
To generate the recommenders, we will follow the given steps:
1. Computing the co-occurrence matrix.
2. Establishing the user-scoring matrix.
3. Generating recommendations.
From the next section, we will see technical details for performing the
preceding steps.
1. In the frst section, computing the co-occurrence matrix, we will be able to
identify the co-occurred item sets given in the dataset. In simple words, we
can call it counting the pair of items from the given dataset.
# Quote plyr package
library (plyr)
# Read dataset
train <-read.csv (file = "small.csv", header = FALSE)
names (train) <-c ("user", "item", "pref")
# Calculated User Lists
usersUnique <-function () {
users <-unique (train $ user)
users [order (users)]
}
# Calculation Method Product List
itemsUnique <-function () {
items <-unique (train $ item)
items [order (items)]
}
# Derive unique User Lists
users <-usersUnique ()
# Product List
items <-itemsUnique ()
# Establish Product List Index
index <-function (x) which (items %in% x)
data<-ddply(train,.(user,item,pref),summarize,idx=index(item))
# Co-occurrence matrix
Co-occurrence <-function (data) {
n <-length (items)
co <-matrix (rep (0, n * n), nrow = n)
for (u in users) {
  idx <-index (data $ item [which(data$user == u)])
m <-merge (idx, idx)
for (i in 1: nrow (m)) {
co [m$x[i], m$y[i]] = co[m$x[i], m$y[i]]+1
}
}
return (co)
}
# Generate co-occurrence matrix
co <-co-occurrence (data)
2. To establish the user-scoring matrix based on the user's rating information,
the user-item rating matrix can be generated for users.
# Recommendation algorithm
recommend <-function (udata = udata, co = coMatrix, num = 0) {
n <- length(items)
# All of pref
pref <- rep (0, n)
pref[udata$idx] <-udata$pref
# User Rating Matrix
userx <- matrix(pref, nrow = n)
# Scoring matrix co-occurrence matrix *
r <- co %*% userx
# Recommended Sort
r[udata$idx] <-0
idx <-order(r, decreasing = TRUE)
topn <-data.frame (user = rep(udata$user[1], length(idx)), item
= items[idx], val = r[idx])
# Recommended results take months before the num
if (num> 0) {
topn <-head (topn, num)
}
# Recommended results take months before the num
if (num> 0) {
topn <-head (topn, num)
}
# Back to results
return (topn)
}
3. Finally, the recommendations as output can be generated by the product
operations of both matrix items: co-occurrence matrix and user's scoring
matrix.
# initializing dataframe for recommendations storage
recommendation<-data.frame()
# Generating recommendations for all of the users
for(i in 1:length(users)){
udata<-data[which(data$user==users[i]),]
recommendation<-rbind(recommendation,recommend(udata,co,0))
}
Generating recommendations via Myrrix and R interface is quite easy.
For more information, refer to https://github.com/jwijffels/
Myrrix-R-interface.
Generating recommendations with
R and Hadoop
To generate recommendations with R and Hadoop, we need to develop an
algorithm that will be able to run and perform data processing in a parallel manner.
This can be implemented using Mappers and Reducers. A very interesting part of
this section is how we can use R and Hadoop together to generate recommendations
from big datasets.
So, here are the steps that are similar to generating recommendations with R, but
translating them to the Mapper and Reducer paradigms is a little tricky:
1. Establishing the co-occurrence matrix items.
2. Establishing the user scoring matrix to articles.
3. Generating recommendations.
We will use the same concepts as our previous operation with R to generate
recommendations with R and Hadoop. But in this case, we need to use a key-value
paradigm as it's the base of parallel operations. Therefore, every function will be
implemented by considering the key-value paradigm.
1. In the frst section, establishment of the co-occurrence matrix items, we will
establish co-occurrence items in steps: grouped by user, locate each user
selected items appearing alone counting, and counting in pairs.
# Load rmr2 package
library (rmr2)
# Input Data File
train <-read.csv (file = "small.csv", header = FALSE)
names (train) <-c ("user", "item", "pref")
# Use the hadoop rmr format, hadoop is the default setting.
rmr.options (backend = 'hadoop')
# The data set into HDFS
train.hdfs = to.dfs (keyval (train$user, train))
# see the data from hdfs
from.dfs (train.hdfs)
The key points to note are:
° train.mr: This is the MapReduce job's key-value paradigm
information
° key: This is the list of items vector
° value: This is the item combination vector
# MapReduce job 1 for co-occurrence matrix items
train.mr <-mapreduce (
train.hdfs,
map = function (k, v) {
keyval (k, v$item)
}
# for identification of co-occurrence items
, Reduce = function (k, v) {
m <-merge (v, v)
keyval (m$x, m$y)
}
)
The co-occurrence matrix items will be combined to count them.
To defne a MapReduce job, step2.mr is used for calculating the frequency
of the combinations of items.
° Step2.mr: This is the MapReduce job's key value paradigm
information
° key: This is the list of items vector
° value: This is the co-occurrence matrix dataframe value (item, item,
Freq)
# MapReduce function for calculating the frequency of the
combinations of the items.
step2.mr <-mapreduce (
train.mr,
map = function (k, v) {
d <-data.frame (k, v)
d2 <-ddply (d,. (k, v), count)
key <- d2$k
val <- d2
keyval(key, val)
}
)
# loading data from HDFS
from.dfs(step2.mr)
2. To establish the user-scoring matrix to articles, let us defne the Train2.mr
MapReduce job.
# MapReduce job for establish user scoring matrix to articles
train2.mr <-mapreduce (
train.hdfs,
map = function(k, v) {
df <- v
# key as item
key <-df $ item
# value as [item, user pref]
val <-data.frame (item = df$item, user = df$user, pref =
df$pref)
# emitting (key, value)pairs
keyval(key, val)
}
)
# loading data from HDFS
from.dfs(train2.mr)
° Train2.mr: This is the MapReduce job's key value paradigm
information
° key: This is the list of items
° value: This is the value of the user goods scoring matrix
The following is the consolidation and co-occurrence scoring matrix:
# Running equi joining two data – step2.mr and train2.mr
eq.hdfs <-equijoin (
left.input = step2.mr,
right.input = train2.mr,
map.left = function (k, v) {
keyval (k, v)
},
map.right = function (k, v) {
keyval (k, v)
},
outer = c ("left")
)
# loading data from HDFS
from.dfs (eq.hdfs)
° eq.hdfs: This is the MapReduce job's key value paradigm
information
° key: The key here is null
° value: This is the merged dataframe value

3. In the section of generating recommendations, we will obtain the
recommended list of results.
# MapReduce job to obtain recommended list of result from
equijoined data
cal.mr <-mapreduce (
input = eq.hdfs,
map = function (k, v) {
val <-v
na <-is.na (v$user.r)
if (length (which(na))> 0) val <-v [-which (is.na (v $
user.r)),]
keyval (val$kl, val)
}
, Reduce = function (k, v) {
val <-ddply (v,. (kl, vl, user.r), summarize, v = freq.l *
pref.r)
keyval (val $ kl, val)
}
)
# loading data from HDFS
from.dfs (cal.mr)
° Cal.mr: This is the MapReduce job's key value paradigm information
° key: This is the list of items
° value: This is the recommended result dataframe value

y defning the result for getting
preference value, the sorting process will be applied on the
recommendation result.
# MapReduce job for sorting the recommendation output
result.mr <-mapreduce (
input = cal.mr,
map = function (k, v) {
keyval (v $ user.r, v)
}
, Reduce = function (k, v) {
val <-ddply (v,. (user.r, vl), summarize, v = sum (v))
val2 <-val [order (val$v, decreasing = TRUE),]
names (val2) <-c ("user", "item", "pref")
keyval (val2$user, val2)
}
)
# loading data from HDFS
from.dfs (result.mr)
° result.mr: This is the MapReduce job's key value paradigm
information
° key: This is the user ID
° value: This is the recommended outcome dataframe value
Here, we have designed the collaborative algorithms for generating item-based
recommendation. Since we have tried to make it run on parallel nodes, we have
focused on the Mapper and Reducer. They may not be optimal in some cases, but
you can make them optimal by using the available code.
Summary
In this chapter, we learned how we can perform Big Data analytics with machine
learning with the help of R and Hadoop technologies. In the next chapter, we will
learn how to enrich datasets in R by integrating R to various external data sources.

usersUnique <-function () {
users <-unique (train $ user)
users [order (users)]
}





Generating recommendations with
R and Hadoop
To generate recommendations with R and Hadoop, we need to develop an
algorithm that will be able to run and perform data processing in a parallel manner.
This can be implemented using Mappers and Reducers. A very interesting part of
this section is how we can use R and Hadoop together to generate recommendations
from big datasets.
So, here are the steps that are similar to generating recommendations with R, but
translating them to the Mapper and Reducer paradigms is a little tricky:
1. Establishing the co-occurrence matrix items.
2. Establishing the user scoring matrix to articles.
3. Generating recommendations.


x <- 1:4
(z <- x %*% x)    # scalar ("inner") product (1 x 1 matrix)
drop(z)             # as scalar

y <- diag(x)
z <- matrix(1:12, ncol = 3, nrow = 4)
y %*% z
y %*% x
x %*% z

z1 <- matrix(c(2,1,4,3), ncol = 2, nrow = 2,byrow = T)
z2 <- matrix(c(1,2,1,0), ncol = 2, nrow = 2,byrow = T)
z1 %*%z2
z2 %*%z1

2x+y=3
4x+3y=7

2 1   x   3
4 3 * y= 7

z1 <- matrix(c(2,1,4,3), ncol = 2, nrow = 2,byrow = T)

result <- matrix(c(3,7), nrow = 2,byrow = T)

solve(z1, result)


This generic function solves the equation a %*% x = b for x, where b can be either a vector or a matrix.

Usage

solve(a, b, ...)

## Default S3 method:
solve(a, b, tol, LINPACK = FALSE, ...)
Arguments




Installing MySQL
We will see how to get MySQL installed on Linux:
// Updating the linux package list
sudo apt-get update
// Upgrading the updated packages
sudo apt-get dist-upgrade
//First, install the MySQL server and client packages:
sudo apt-get install mysql-server mysql-client
Log in to MySQL database using the following command:
mysql -u root -p

Installing RMySQL
Now, we have installed MySQL on our Linux machine. It's time to install RMySQL –
R library from CRAN via the following R commands:
# to install RMySQL library
install.packages("RMySQL")
#Loading RMySQL
library(RMySQL)
After the RMySQL library is installed on R, perform MySQL database connection by
providing the user privileges as provided in MySQL administration console:
mydb = dbConnect(MySQL(), user='root', password='', dbname='sample_
table', host='localhost')

Learning to list the tables and their structure
Now, the database connection has been done successfully. To list the available
tables and their structure of data base in MySQL database, look at the following
commands. To return the available tables created under mydb database, use the
following command:
dbListTables(mydb)
To return a list of data felds created under the sample_table table, use the
following command:
dbListFields(mydb, 'sample_table')

Importing the data into R
We know how to check MySQL tables and their felds. After identifcation of useful
data tables, we can import them in R using the following RMySQL command. To
retrieve the custom data from MySQL database as per the provided SQL query, we
need to store it in an object:
rs = dbSendQuery(mydb, "select * from sample_table")
The available data-related information can be retrieved from MySQL to R via the
fetch command as follows:
dataset = fetch(rs, n=-1)
Here, the specifed parameter n = -1 is used for retrieving all pending records.
Understanding data manipulation
To perform the data operation with MySQL database, we need to fre the
SQL queries. But in case of RMySQL, we can fre commands with the
dbSendQuery function.
Creating a new table with the help of available R dataframe into MySQL database
can be done with the following command:
dbWriteTable(mydb, name='mysql_table_name', value=data.frame.name)
To insert R matrix data into the existing data table in MySQL, use the following
command:
# defining data matrix
datamatrix <- matrix(1:4, 2, 2)
# defining query to insert the data
query <- paste("INSERT INTO names VALUES(",datamatrix [1,1], ",",
datamatrix [1,2], ")")
# command for submitting the defined SQL query dbGetQuery(con, query)
Sometimes we need to delete a MySQL table when it is no longer of use. We can fre
the following query to delete the mysql_some_table table:
dbSendQuery(mydb, 'drop table if exists mysql_some_table').


• xlsxjars
• rJava
Installing xlsxX packages:
• Install.packages("xlsxjars")
• Install.packages("rJava")
• Install.packages("xlsx")


• MongoDB installation
• rmongodb installation

Installing MongoDB
The following are the steps provided for installation of MongoDB in Ubuntu 12.04
and CentOS:
First, we will see installation steps for Ubuntu.
1. Confgure Package Management System (APT) using the
following command:
sudo apt-key adv --keyserverhkp://keyserver.ubuntu.com:80
--recv 7F0CEB10
2. Create /etc/apt/sources.list.d/mongodb.list by using the
following command:
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart
dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
3. Now, update the package list of your OS using the following command:
sudo apt-get update
4. Install the latest version of MongoDB by using the following command:
apt-get install mongodb-10gen
Now, we will see the installation steps for CentOs.
1. Confgure Package Management System (YUM).
2. Create /etc/yum.repos.d/mongodb.repo and use the following
confgurations:
° For a 64-bit system use the following command:
[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/
x86_64/
gpgcheck=0
enabled=1
° For a 32-bit system use the following command:
[mongodb]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/
i686/
gpgcheck=0
enabled=1
3. Install Packages.

With the following command, install a stable version of MongoDB and the
associated tools:
yum install mongo-10gen mongo-10gen-server
Now, you have successfully installed MongoDB.
Useful commands for controlling a mongodb service
To start the mongodb service we use the following command:
sudo service mongodb start
To stop the mongodb service we use the following command:
sudo service mongodb stop
To restart the mongodb service we use the following command:
sudo service mongodb restart
To start a Mongo console we use the following command:
mongo
Mapping SQL to MongoDB
The following are the mappings of SQL terms to MongoDB terms for better
understanding of data storage:
No. SQL Term MongoDB Term
1. Database Database
2. Table Collection
3. Index Index
4. Row Document
5. Column Field
6. Joining Embedding & linking

Mapping SQL to MongoQL
The following are the mapping of SQL statements to Mongo QL statements for the
understanding of query development/conversion:
No. SQL Statement Mongo QL Statement
1. INSERT INTO students
VALUES(1,1)
$db->students-
>insert(array("a" => 1, "b"
=> 1));
2. SELECT a, b FROM students $db->students->find(array(),
array("a" => 1, "b" => 1));
3. SELECT * FROM students
WHERE age < 15
$db->students-
>find(array("age" =>
array('$lt' => 15)));
4. UPDATE students SET a=1
WHERE b='q'
$db->students-
>update(array("b" => "q"),
array('$set' => array("a" =>
1)));
5. DELETE FROM students WHERE
name="siddharth"
$db->students-
>remove(array("name" => "
siddharth"));

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list


https://www.howtoforge.com/tutorial/install-mongodb-on-ubuntu-16.04/#step-importing-the-public-key

sudo apt-get update

Step 4 - Install MongoDB

Now you can install MongoDB by typing this command:
sudo apt-get install -y mongodb-org
install.packages (rmongodb)



Installing SQLite
To install the SQLite database in Ubuntu, follow the given commands:
// install sqllite by firing the following commands
sudo apt-get purge sqlite3 sqlite3-doc libsqlite3-0
sudo apt-get autoremove
sudo apt-get install sqlite3 sqlite3-doc
Installing RSQLite
We can install RSQLite by following the given command:
# installing RSQLite library from CRAN in R
Install.packages("RSQLite")


#loading the installed package
library("RSQLite")

With the following commands, you can connect to DB and list all tables from the
database:
# connect to db
con <- dbConnect(SQLite(), dbname="data/first.db")
# list all tables
tables <- dbListTables(con)
# exclude sqlite_sequence (contains table information)
tables <- tables[tables != "sqlite_sequence"]
lDataFrames <- vector("list", length=length(tables))
# create a data.frame for each table
for (i in seq(along=tables)) {
lDataFrames[[i]] <- dbGetQuery(conn=con, statement=paste("SELECT *
FROM '", tables[[i]], "'", sep=""))
}
Understanding data manipulation
We can manipulate the dataset using the following commands:
dbBeginTransaction(con)
rs <- dbSendQuery(con, "DELETE from candidates WHERE age > 50")
Exporting the data from Rdata(USArrests)
dbWriteTable(con, "USArrests", USArrests)

Installing PostgreSQL
In this section, we will learn about installing PostgreSQL.
The given commands will be followed for the installation of PostgreSQL:
// updating the packages list
Sudo apt-get update
// installing postgresql
sudo apt-get install postgresql postgresql-contrib
// creating postgresql user
su – postgres createuser
Installing RPostgreSQL
We will now see how to install and use RPostgreSQL:
# installing package from CRAN
install.packages(RPostgreSQL)
Importing the data into R# loading the installed package
library(RPostgreSQL)
## load the PostgreSQL driver
drv <- dbDriver("PostgreSQL")

## Open a connection
con <- dbConnect(drv, dbname="oxford")
## Submits a statement
rs <- dbSendQuery(con, "select * from student")
## fetch all elements from the result set
fetch(rs,n=-1)
## Closes the connection
dbDisconnect(con)
## Frees all the resources on the driver
dbUnloadDriver(drv)
With the following code, we will learn how to operate data stored at PostgreSQL
from within R:
opendbGetQuery(con, "BEGIN TRANSACTION")
rs <- dbSendQuery(con,
"Delete * from sales as p where p.cost>10")
if(dbGetInfo(rs, what = "rowsAffected") > 250){
warning("Rolling back transaction")
dbRollback(con)
}else{
dbCommit(con)
}
Exporting the data from R
In this section, we are going to learn how to load data, write the contents of the
dataframe value into the table name specifed, and remove the specifed table from
the database connection:
conn <- dbConnect("PostgreSQL", dbname = "wireless")
if(dbExistsTable(con, "frame_fuel")){
dbRemoveTable(conn, "frame_fuel")
dbWriteTable(conn, "frame_fuel", fuel.frame)
}
if(dbExistsTable(conn, "RESULTS")){
dbWriteTable(conn, "RESULTS", results2000, append = T)
else
dbWriteTable(conn, "RESULTS", results2000)
}


Understanding Hive
Hive is a Hadoop-based data warehousing-like framework developed by Facebook.
It allows users to fre queries in SQL, with languages like HiveQL, which are
highly abstracted to Hadoop MapReduce. This allows SQL programmers with no
MapReduce experience to use the warehouse and makes it easier to integrate with
business intelligence and visualization tools for real-time query processing.
Understanding features of Hive
The following are the features of Hive:
• Hibernate Query Language (HQL)
• Supports UDF
• Metadata storage
• Data indexing
• Different storage type
• Hadoop integration
Prerequisites for RHive are as follows:
• Hadoop
• Hive
We assume here that our readers have already confgured Hadoop; else they can
learn Hadoop installation from Chapter 1, Getting Ready to Use R and Hadoop. As Hive
will be required for running RHive, we will frst see how Hive can be installed.

Installing Hive
The commands to install Hive are as follows:
// Downloading the hive source from apache mirror
wget http://www.motorlogy.com/apache/hive/hive-0.11.0/hive-0.11.0.tar.gz
// For extracting the hive source
tar xzvf hive-0.11.0.tar.gz

Setting up Hive confgurations
To setup Hive confguration, we need to update the hive-site.xml fle with a
few additions:
• Update hive-site.xml using the following commands:
<description> JDBC connect string for a JDBC metastore </
description>
</Property>
<property>
<name> javax.jdo.option.ConnectionDriverName </ name>
<value> com.mysql.jdbc.Driver </ value>
<description> Driver class name for a JDBC metastore </
description>
</Property>
<property>
<name> javax.jdo.option.ConnectionUserName </ name>
<value> hive </value>
<description> username to use against metastore database </
description>
</ Property>
<property>
<name> javax.jdo.option.ConnectionPassword </name>
<value> hive</value>
<description> password to use against metastore database </
description>
</Property>
<property>
<name> hive.metastore.warehouse.dir </ name>
<value> /user/hive/warehouse </value>
<description> location of default database for the warehouse </
description>
</Property>
• Update hive-log4j.properties by adding the following line:
log4j.appender.EventCounter = org.apache.hadoop.log.metrics.
EventCounter
• Update the environment variables by using the following command:
export $HIVE_HOME=/usr/local/ hive-0.11.0



• In HDFS, create specifc directories for Hive:
$HADOOP_HOME/bin/ hadoop fs-mkidr /tmp
$HADOOP_HOME/bin/ hadoop fs-mkidr /user/hive/warehouse
$HADOOP_HOME/bin/ hadoop fs-chmod g+w / tmp
$HADOOP_HOME/bin/ hadoop fs-chmod g+w /user/hive/warehouse
To start the hive server, the hive --service hiveserver
command needs to be called from HIVE_HOME.
Installing RHive
• Install the dependant library, rjava, using the following commands:
// for setting up java configuration variables
sudo R CMD javareconf
// Installing rJava package
install.packages ("rJava")
// Installing RHive package from CRAN
install.packages("RHive")
// Loading RHive library
library("RHive")
Understanding RHive operations
We will see how we can load and operate over Hive datasets in R using the
RHive library:
• To initialize RHive we use:
rhive.init ()
• To connect with the Hive server we use:
rhive.connect ("192.168.1.210")
• To view all tables we use:
rhive.list.tables ()
tab_name
1 hive_algo_t_account
2 o_account
3 r_t_account
• To view the table structure we use:
rhive.desc.table ('o_account');
col_name data_type comment
1 id int
2 email string
3 create_date string
• To execute the HQL queries we use:
rhive.query ("select * from o_account");
• To close connection to the Hive server we use:
rhive.close()
Understanding HBase
Apache HBase is a distributed Big Data store for Hadoop. This allows random,
real-time, read/write access to Big Data. This is designed as a column-oriented,
data-storage model, innovated after being inspired by Google Big table.
Understanding HBase features
Following are the features for HBase:
• RESTful web service with XML
• Linear and modular scalability
• Strict consistent reads and writes
• Extensible shell
• Block cache and Bloom flters for real-time queries
Pre-requisites for RHBase are as follows:
• Hadoop
• HBase
• Thrift
Here we assume that users have already confgured Hadoop for their Linux machine.
If anyone wishes to know how to install Hadoop on Linux, please refer to Chapter 1,
Getting Ready to Use R and Hadoop.
Installing HBase
Following are the steps for installing HBase:
1. Download the tar fle of HBase and extract it:
wget http://apache.cs.utah.edu/hbase/stable/hbase-0.94.11.tar.gz
tar -xzf hbase-0.94.11.tar.gz
2. Go to HBase installation directory and update the confguration fles:
cd hbase-0.94.11/
vi conf/hbase-site.xml
3. Modify the confguration fles:
1. Update hbase-env.sh.
~ Vi conf / hbase-env.sh
2. Set up the configuration for HBase:
export JAVA_HOME = /usr/lib/jvm/java-6-sun
export HBASE_HOME = /usr/local/hbase-0.94.11
export HADOOP_INSTALL = /usr/local/hadoop
export HBASE_CLASSPATH = /usr/local/hadoop/conf
export HBASE_MANAGES_ZK = true
3. Update hbase-site.xmlzxml:
Vi conf / hbase-site.xml

4. Change hbase-site.cml, which should look like the following code:
<configuration>
<property>
<name> hbase.rootdir </name>
<value> hdfs://master:9000/hbase </value>
</Property>
<property>
<name>hbase.cluster.distributed </name>
<value>true</value>
</Property>
<property>
<name>dfs.replication </name>
<value>1</value>
</Property>
<property>
<name>hbase.zookeeper.quorum </name>
<value>master</value>
</Property>
<property>
<name>hbase.zookeeper.property.clientPort </name>
<value>2181</value>
</Property>
<property>
<name>hbase.zookeeper.property.dataDir </name>
<value>/root/hadoop/hdata</value>
</Property>
</ Configuration>
If a separate zookeper setup is used, the
configuration needs to be changed.
5. Copy the Hadoop environment configuration files and libraries.
Cp $HADOOP_HOME/conf/hdfs-site.xml $HBASE_HOME/conf
Cp $HADOOP_HOME/hadoop-core-1.0.3.jar $HBASE_HOME/lib
Cp $HADOOP_HOME/lib/commons-configuration-1.6.jar $HBASE_
HOME/lib
Cp $HADOOP_HOME/lib/commons-collections-3.2.1.jar $HBASE_
HOME/lib
Installing thrift
Following are the steps for installing thrift:
1. Download the thrift source from the Internet and place it to client.
We will do it with Ubuntu O.S 12.04:
get http://archive.apache.org/dist/thrift/0.8.0/thrift-0.8.0.tar.
gz
2. To extract the downloaded .tar.gz fle, use the following command:
tar xzvf thrift-0.8.0.tar.gz
cd thrift-0.8.0/
3. Compile the confguration parameters:
./Configure
4. Install thrift:
Make
Make install
To start the HBase thrift server we need to call the
following command:
$HBASE_HOME/bin/hbase-daemon.sh start
Installing RHBase
After installing HBase , we will see how to get the RHBase library.
• To install rhbase we use the following command:
wget https://github.com/RevolutionAnalytics/rhbase/blob/master/
build/rhbase_1.2.0.tar.gz
• To install the downloaded package we use the following command:
R CMD INSTALL rhbase_1.2.0.tar.gz
porting
Once RHBase is installed, we can load the dataset in R from HBase with the help
of RHBase:
• To list all tables we use:
hb.list.tables ()
• To create a new table we use:
hb.new.table ("student")
• To display the table structure we use:
hb.describe.table("student_rhbase")
• To read data we use:
hb.get ('student_rhbase', 'mary')
Understanding data manipulation
Now, we will see how to operate over the dataset of HBase from within R:
• To create the table we use:
hb.new.table ("student_rhbase", "info")
• To insert the data we use:
hb.insert ("student_rhbase", list (list ("mary", "info: age",
"24")))
• To delete a sheet we use:
hb.delete.table ('student_rhbase')


http://blog.fens.me/

 http://www.r-bloggers.com/
 http://decisionstats.com/

 http://www.rdatamining.com/
 http://had.co.nz/
 http://www.michael-noll.com/
 http://hive.apache.org/downloads.html

 wget http://mirror.bit.edu.cn/apache/hive/stable-2/apache-hive-2.3.2-bin.tar.gz 




 multicore
 Motivation: You have an R script that spends an hour executing a function using
lapply() on your laptop.
Solution: Replace lapply() with the mclapply() function from the multicore package.
Good because: It’s easy to install, easy to use, and makes use of hardware that you
probably already own.

install.packages("multicore")


library(parallel)
R.version.string



library(parallel)
library(MASS)
RNGkind("L'Ecuyer-CMRG")
mc.cores <- detectCores()
results <- mclapply(rep(25, 4),
function(nstart) kmeans(Boston, 4, nstart=nstart),
mc.cores=mc.cores)
i <- sapply(results, function(result) result$tot.withinss)
result <- results[[which.min(i)]]



library(parallel)
cl <- makeCluster(detectCores())
clusterSetRNGStream(cl)
clusterEvalQ(cl, library(MASS))
results <- clusterApply(cl, rep(25, 4), function(nstart) kmeans(iris, 4,
nstart=nstart))
i <- sapply(results, function(result) result$tot.withinss)
result <- results[[which.min(i)]]
stopCluster(cl)


onetest <- kmeans(Boston, 4,nstart=25)



library(parallel)
library(MASS)
RNGkind("L'Ecuyer-CMRG")
mc.cores <- detectCores()
results <- mclapply(rep(25, 4),
function(nstart) kmeans(Boston, 4, nstart=nstart),
mc.cores=mc.cores)
i <- sapply(results, function(result) result$tot.withinss)
result <- results[[which.min(i)]]
