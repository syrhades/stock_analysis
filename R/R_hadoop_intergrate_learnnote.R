we will learn to develop the
MapReduce programs in R that run over the Hadoop cluster. This chapter will
provide development tutorials on R and Hadoop with RHIPE and RHadoop. After
installing R and Hadoop, we will see how R and Hadoop can be integrated using
easy steps.
data analytics
 data engineers
  the integration of such data-driven tools and technologies can build a
powerful scalable system that has features of both of them.


Three ways to link R and Hadoop are as follows:
• RHIPE
• RHadoop
• Hadoop streaming

RHIPE stands for R and Hadoop Integrated Programming Environment. 
http://www.datadr.org/

The RHIPE package uses the Divide and Recombine technique to perform
data analytics over Big Data
 In this technique, data is divided into subsets,
computation is performed over those subsets by specifc R analytics operations,
and the output is combined. RHIPE has mainly been designed to accomplish two
goals that are as follows:
• Allowing you to perform in-depth analysis of large as well as small data.
• Allowing users to perform the analytics operations within R using a lower
level language. RHIPE is designed with several functions that help perform
Hadoop Distribute File System (HDFS) as well as MapReduce operations
using a simple R console.


Installing RHIPE
As RHIPE is a connector of R and Hadoop, we need Hadoop and R installed on our
machine or in our clusters in the following sequence:
1. Installing Hadoop.
2. Installing R.
3. Installing protocol buffers.
4. Setting up environment variables.
5. Installing rJava.
6. Installing RHIPE.
Let us begin with the installation.

Installing protocol buffers
## For downloading the protocol buffer 2.4.1
wget http://protobuf.googlecode.com/files/protobuf-2.4.1.tar.gz
## To extracting the protocol buffer
tar -xzf protobuf-2.4.1.tar.gz
## To get in to the extracted protocol buffer directory
cd protobuf-2.4.1
## For making install the protocol buffer
./configure # --prefix=...
make
make install


Environment variables

For confguring the Hadoop libraries, we need to set two variables, PKG_CONFIG_
PATH and LD_LIBRARY_PATH, to the ~./bashrc fle of hduser (Hadoop user) so that it
can automatically be set when the user logs in to the system.
Here, PKG_CONFIG_PATH is an environment variable that holds the path of the
pkg-config script for retrieving information about installed libraries in the system,
and LD_LIBRARY_PATH is an environment variable that holds the path of native
shared libraries.


export PKG_CONFIG_PATH = /usr/local/lib
export LD_LIBRARY_PATH = /usr/local/lib
You can also set all these variables from your R console, as follows:
Sys.setenv(HADOOP_HOME="/usr/local/hadoop/")
Sys.setenv(HADOOP_BIN="/usr/local/hadoop/bin")
Sys.setenv(HADOOP_CONF_DIR="/usr/local/hadoop/conf")
Where HADOOP_HOME is used for specifying the location of the Hadoop directory,
HADOOP_BIN is used for specifying the location of binary fles of Hadoop, and
HADOOP_CONF_DIR is used for specifying the confguration fles of Hadoop.
Setting the variables is temporary and valid up to a particular R session. If we want
to make this variable permanent, as initialized automatically when the R session
initializes, we need to set these variables to the /etc/R/Renviron fle as we set the
environment variable in .bashrc of a specifc user profle.

Setting the variables is temporary and valid up to a particular R session. If we want
to make this variable permanent, as initialized automatically when the R session
initializes, we need to set these variables to the /etc/R/Renviron fle as we set the
environment variable in .bashrc of a specifc user profle.


The rJava package installation
Since RHIPE is a Java package, it acts like a Java bridge between R and Hadoop.
RHIPE serializes the input data to a Java type, which has to be serialized over the
cluster. It needs a low-level interface to Java, which is provided by rJava. So, we will
install rJava to enable the functioning of RHIPE.
## For installing the rJava Package will be used for calling java
libraries from R.
install.packages("rJava")
Installing RHIPE
Now, it's time to install the RHIPE package from its repository.
## Downloading RHIPE package from RHIPE repository
Wget http://ml.stat.purdue.edu/rhipebin/Rhipe_0.73.1-2.tar.gz
## Installing the RHIPE package in R via CMD command
R CMD INSTALL Rhipe_0.73.1.tar.gz
Now, we are ready with a RHIPE system for performing data analytics with R and
Hadoop.

Understanding the architecture of RHIPE
Let's understand the working of the RHIPE library package developed to integrate R
and Hadoop for effective Big Data analytics

There are a number of Hadoop components that will be used for data analytics
operations with R and Hadoop.
The components of RHIPE are as follows:
• RClient: RClient is an R application that calls the JobTracker to execute the
job with an indication of several MapReduce job resources such as Mapper,
Reducer, input format, output format, input fle, output fle, and other
several parameters that can handle the MapReduce jobs with RClient.
• JobTracker: A JobTracker is the master node of the Hadoop MapReduce
operations for initializing and monitoring the MapReduce jobs over the
Hadoop cluster.


RHIPE sample program (Map only)
MapReduce problem defnition: The goal of this MapReduce sample program is to
test the RHIPE installation by using the min and max functions over numeric data
with the Hadoop environment. Since this is a sample program, we have included
only the Map phase, which will store its output in the HDFS directory.
To start the development with RHIPE, we need to initialize the RHIPE subsystem by
loading the library and calling the rhinit() method.
## Loading the RHIPE library
library(Rhipe)
## initializing the RHIPE subsystem, which is used for everything. RHIPE
will not work if rhinit is not called.
rhinit()
Input: We insert a numerical value rather than using a fle as an input.

Map phase: The Map phase of this MapReduce program will call 10 different
iterations and in all of those iterations, random numbers from 1 to 10 will be
generated as per their iteration number. After that, the max and min values for that
generated numbers will be calculated.
## Defining the Map phase
Map(function(k,v){
## for generating the random deviates
X runif(v)
## for emitting the key-value pairs with key – k and
## value – min and max of generated random deviates.
rhcollect(k, c(Min=min(x),Max=max(x))
}
Output: Finally the output of the Map phase will be considered here as an output of
this MapReduce job and it will be stored to HDFS at /app/hadoop/RHIPE/.
Defning the MapReduce job by the rhwatch() method of the RHIPE package:
## Create and running a MapReduce job by following
job = rhwatch(map=map,input=10,reduce=0,
output="/app/Hadoop/RHIPE/test",jobname='test')
Reading the MapReduce output from HDFS:
## Read the results of job from HDFS
result <- rhread(job)
For displaying the result in a more readable form in the table format, use the
following code:
## Displaying the result
outputdata <- do.call('rbind', lapply(result, "[[", 2))


Word count
MapReduce problem defnition: This RHIPE MapReduce program is defned for
identifying the frequency of all of the words that are present in the provided input
text fles.
Also note that this is the same MapReduce problem as we saw in Chapter 2, Writing
Hadoop MapReduce Programs.
## Loading the RHIPE Library
library(Rhipe)
Input: We will use the CHANGES.txt fle, which comes with Hadoop distribution,
and use it with this MapReduce algorithm. By using the following command, we will
copy it to HDFS:
rhput("/usr/local/hadoop/CHANGES.txt","/RHIPE/input/")
Map phase: The Map phase contains the code for reading all the words from a fle
and assigning all of them to value 1.
## Defining the Map function
w_map<-expression({
words_vector<-unlist(strsplit(unlist(map.values)," "))
lapply(words_vector,function(i) rhcollect(i,1))
})
Reduce phase: With this reducer task, we can calculate the total frequency of the
words in the input text fles.
## For reference, RHIPE provides a canned version
Reduce = rhoptions()$templates$scalarsummer
## Defining the Reduce function
w_reduce<-expression(
pre={total=0},
reduce={total<-sum(total,unlist(reduce.values))},
post={rhcollect(reduce.key,total)}
)
Defning the MapReduce job object: After defning the word count mapper and
reducer, we need to design the driver method that can execute this MapReduce job
by calling Mapper and Reducer sequentially.
## defining and executing a MapReduce job object
Job1 <-
rhwatch(map=w_map,reduce=w_reduce,
,input="/RHIPE/input/",output="/RHIPE/output/",
jobname="word_count")
Reading the MapReduce output:
## for reading the job output data from HDFS
Output_data <- rhread(Job1)
results <- data.frame(words=unlist(lapply(Output_data,"[[",1)), count
=unlist(lapply(Output_data,"[[",2)))
The output of MapReduce job will be stored to output_data, we will convert this
output into R supported dataframe format. The dataframe output will be stored to
the results variable. For displaying the MapReduce output in the data frame the
format will be as follows:
Output for head (results):


Understanding the RHIPE function reference
RHIPE is specially designed for providing a lower-level interface over Hadoop. So
R users with a RHIPE package can easily fre the Hadoop data operations over large
datasets that are stored on HDFS, just like the print() function called in R.
Now we will see all the possible functional uses of all methods that are available in
RHIPE library. All these methods are with three categories: Initialization, HDFS, and
MapReduce operations.
Initialization
We use the following command for initialization:
• rhinit: This is used to initialize the Rhipe subsystem.
rhinit(TRUE,TRUE)
HDFS
We use the following command for HDFS operations:
• rhls: This is used to retrieve all directories from HDFS.
Its syntax is rhls(path)
rhls("/")

• hdfs.getwd: This is used for acquiring the current working HDFS directory.
Its syntax is hdfs.getwd()
• hdfs.setwd: This is used for setting up the current working HDFS directory.
Its syntax is hdfs.setwd("/RHIPE")
• rhput: This is used to copy a fle from a local directory to HDFS. Its syntax
is rhput(src,dest) and rhput("/usr/local/hadoop/NOTICE.txt","/
RHIPE/").
• rhcp: This is used to copy a fle from one HDFS location to another HDFS
location. Its syntax is rhcp('/RHIPE/1/change.txt','/RHIPE/2/change.
txt').
• rhdel: This is used to delete a directory/fle from HDFS. Its syntax is
rhdel("/RHIPE/1").
• rhget: This is used to copy the HDFS fle to a local directory. Its syntax is
rhget("/RHIPE/1/part-r-00000", "/usr/local/").
• rwrite: This is used to write the R data to HDFS. its syntax is
rhwrite(list(1,2,3),"/tmp/x").


MapReduce
We use the following commands for MapReduce operations:
• rhwatch: This is used to prepare, submit, and monitor MapReduce jobs.
# Syntax:
rhwatch(map, reduce, combiner, input, output,
mapred,partitioner,mapred, jobname)
## to prepare and submit MapReduce job:
z=rhwatch(map=map,reduce=0,input=5000,output="/tmp/
sort",mapred=mapred,read=FALSE)
results <- rhread(z)
• rhex: This is used to execute the MapReduce job from over Hadoop cluster.
## Submit the job
rhex(job)
• rhjoin: This is used to check whether the MapReduce job is completed or
not. Its syntax is rhjoin(job).
• rhkill: This is used to kill the running MapReduce job. Its syntax is
rhkill(job).
• rhoptions: This is used for getting or setting the RHIPE confguration
options. Its syntax is rhoptions().
• rhstatus: This is used to get the status of the RHIPE MapReduce job. Its
syntax is rhstatus(job).
rhstatus(job, mon.sec = 5, autokill = TRUE,
showErrors = TRUE, verbose = FALSE, handler = NULL)

https://en.wikipedia.org/wiki/Rhipe
##########################################
RHadoop

Introducing RHadoop
RHadoop is a collection of three R packages for providing large data operations with
an R environment. It was developed by Revolution Analytics, which is the leading
commercial provider of software based on R. RHadoop is available with three main
R packages: rhdfs, rmr, and rhbase. Each of them offers different Hadoop features.
• rhdfs is an R interface for providing the HDFS usability from the R console.
As Hadoop MapReduce programs write their output on HDFS, it is very easy
to access them by calling the rhdfs methods. The R programmer can easily
perform read and write operations on distributed data fles. Basically, rhdfs
package calls the HDFS API in backend to operate data sources stored on
HDFS.
• rmr is an R interface for providing Hadoop MapReduce facility inside the
R environment. So, the R programmer needs to just divide their application
logic into the map and reduce phases and submit it with the rmr methods.
After that, rmr calls the Hadoop streaming MapReduce API with several job
parameters as input directory, output directory, mapper, reducer, and so on,
to perform the R MapReduce job over Hadoop cluster.
• rhbase is an R interface for operating the Hadoop HBase data source
stored at the distributed network via a Thrift server. The rhbase package is
designed with several methods for initialization and read/write and table
manipulation operations.
Here it's not necessary to install all of the three RHadoop packages to run the
Hadoop MapReduce operations with R and Hadoop. If we have stored our input
data source at the HBase data source, we need to install rhbase; else we require
rhdfs and rmr packages. As Hadoop is most popular for its two main features,
Hadoop MapReduce and HDFS, both of these features will be used within the R
console with the help of RHadoop rhdfs and rmr packages. These packages are
enough to run Hadoop MapReduce from R. Basically, rhdfs provides HDFS data
operations while rmr provides MapReduce execution operations.
RHadoop also includes another package called quick check, which is designed for
debugging the developed MapReduce job defned by the rmr package.
In the next section, we will see their architectural relationships as well as their
installation steps.


Understanding the architecture of RHadoop
Since Hadoop is highly popular because of HDFS and MapReduce, Revolution
Analytics has developed separate R packages, namely, rhdfs, rmr, and rhbase.
The architecture of RHadoop is shown in the following diagram:



Installing RHadoop
In this section, we will learn some installation tricks for the three RHadoop packages
including their prerequisites.
• R and Hadoop installation: As we are going to use an R and Hadoop
integrated environment, we need Hadoop as well as R installed on our
machine. If you haven't installed yet, see Chapter 1, Getting Ready to Use R and
Hadoop. As we know, if we have too much data, we need to scale our cluster
by increasing the number of nodes. Based on this, to get RHadoop installed
on our system we need Hadoop with either a single node or multimode
installation as per the size of our data.
RHadoop is already tested with several Hadoop distributions provided by
Cloudera, Hortonworks, and MapR.

• Installing the R packages: We need several R packages to be installed that
help it to connect R with Hadoop. The list of the packages is as follows:
° rJava
° RJSONIO
° itertools
° digest
° Rcpp
° httr
° functional
° devtools
° plyr
° reshape2
We can install them by calling the execution of the following R command in
the R console:
install.packages( c('rJava','RJSONIO', 'itertools', 'digest','Rcpp
','httr','functional','devtools', 'plyr','reshape2'))
• Setting environment variables: We can set this via the R console using the
following code:
## Setting HADOOP_CMD
Sys.setenv(HADOOP_CMD="/usr/local/hadoop/bin/hadoop")
## Setting up HADOOP_STREAMING
Sys.setenv(HADOOP_STREAMING="/usr/local/hadoop/contrib/streaming/
hadoop-streaming-1.0.3.jar")
or, we can also set the R console via the command line as follows:
export HADOOP_CMD=/usr/local/Hadoop
export HADOOP_STREAMING=/usr/lib/hadoop-0.20-mapreduce/contrib/
streaming/hadoop-streaming-2.0.0-mr1-cdh4.1.1.jar
https://github.com/RevolutionAnalytics/RHadoop/wiki/Downloads
• Installing RHadoop [rhdfs, rmr, rhbase]
1. Download RHadoop packages from GitHub repository of Revolution
Analytics: https://github.com/RevolutionAnalytics/RHadoop.
° rmr: [rmr-2.2.2.tar.gz]
° rhdfs: [rhdfs-1.6.0.tar.gz]
° rhbase: [rhbase-1.2.0.tar.gz]
2. Installing packages.
° For rmr we use:
R CMD INSTALL rmr-2.2.2.tar.gz
° For rhdfs we use:
R CMD INSTALL rmr-2.2.2.tar.gz
° For rhbase we use:
R CMD INSTALL rhbase-1.2.0.tar.gz
To install rhbase, we need to have HBase and Zookeeper
installed on our Hadoop cluster


Understanding RHadoop examples
Once we complete the installation of RHadoop, we can test the setup by running the
MapReduce job with the rmr2 and rhdfs libraries in the RHadoop sample program
as follows:
## loading the libraries
library(rhdfs')
library('rmr2')
## initializing the RHadoop
hdfs.init()
# defining the input data
small.ints = to.dfs(1:10)
## Defining the MapReduce job
mapreduce(
# defining input parameters as small.ints hdfs object, map parameter as
function to calculate the min and max for generated random deviates.
input = small.ints,
map = function(k, v)
{
lapply(seq_along(v), function(r){
x <- runif(v[[r]])
keyval(r,c(max(x),min(x)))
})})
After running these lines, simply pressing Ctrl + Enter will execute this
MapReduce program. If it succeeds, the last line will appear as shown in the
following screenshot:
Where characters of that last line indicate the output location of the MapReduce job.
To read the result of the executed MapReduce job, copy the output location, as
provided in the last line, and pass it to the from.dfs()


Word count
MapReduce problem defnition: This RHadoop MapReduce program is defned
for identifying the frequency of all the words that are present in the provided input
text fles.
Also, note that this is the same MapReduce problem as we learned in the previous
section about RHIPE in Chapter 2, Writing Hadoop MapReduce Programs.
wordcount = function(input,
output = NULL,
pattern = " "){
Map phase: This map function will read the text fle line by line and split them by
spaces. This map phase will assign 1 as a value to all the words that are caught by
the mapper.
wc.map = function(., lines) {
keyval(
unlist(
strsplit(
x = lines,
split = pattern)),
1)}
Reduce phase: Reduce phase will calculate the total frequency of all the words by
performing sum operations over words with the same keys.
wc.reduce = function(word, counts ) {
keyval(word, sum(counts))}
Defning the MapReduce job: After defning the word count mapper and reducer, we
need to create the driver method that starts the execution of MapReduce.
# To execute the defined Mapper and Reducer functions
# by specifying the input, output, map, reduce and input.format as
parameters.
# Syntax:
# mapreduce(input, output, input.format, map,reduce,
# combine)

mapreduce(input = input ,
output = output,
input.format = "text",
map = wc.map,
reduce = wc.reduce,
combine = T)}
Executing the MapReduce job: We will execute the RHadoop MapReduce job by
passing the input data location as a parameter for the wordcount function.
wordcount('/RHadoop/1/')
Exploring the wordcount output:
from.dfs("/tmp/RtmpRMIXzb/file2bda5e10e25f")
Understanding the RHadoop function
reference
RHadoop has three different packages, which are in terms of HDFS, MapReduce,
and HBase operations, to perform operations over the data.
Here we will see how to use the rmr and rhdfs package functions:
The hdfs package
The categorized functions are:
• Initialization
° hdfs.init: This is used to initialize the rhdfs package. Its syntax is
hdfs.init().
° hdfs.defaults: This is used to retrieve and set the rhdfs defaults.
Its syntax is hdfs.defaults().
To retrieve the hdfs confguration defaults, refer to the following screenshot:
[ 83 ]
• File manipulation
° hdfs.put: This is used to copy files from the local filesystem to the
HDFS filesystem.
hdfs.put('/usr/local/hadoop/README.txt','/RHadoop/1/')
° hdfs.copy: This is used to copy files from the HDFS directory to the
local filesystem.
hdfs.put('/RHadoop/1/','/RHadoop/2/')
° hdfs.move: This is used to move a file from one HDFS directory to
another HDFS directory.
hdfs.move('/RHadoop/1/README.txt','/RHadoop/2/')
° hdfs.rename: This is used to rename the file stored at HDFS from R.
hdfs.rename('/RHadoop/README.txt','/RHadoop/README1.txt')
° hdfs.delete: This is used to delete the HDFS file or directory from
R.
hdfs.delete("/RHadoop")
° hdfs.rm: This is used to delete the HDFS file or directory from R.
hdfs.rm("/RHadoop")
° hdfs.chmod: This is used to change permissions of some files.
hdfs.chmod('/RHadoop', permissions= '777')
• File read/write:
° hdfs.file: This is used to initialize the file to be used for read/write
operation.
f = hdfs.file("/RHadoop/2/README.
txt","r",buffersize=104857600)
° hdfs.write: This is used to write in to the file stored at HDFS via
streaming.
f = hdfs.file("/RHadoop/2/README.
txt","r",buffersize=104857600)
hdfs.write(object,con,hsync=FALSE)
° hdfs.close: This is used to close the stream when a file operation
is complete. It will close the stream and will not allow further file
operations.
hdfs.close(f)
° hdfs.read: This is used to read from binary files on the HDFS
directory. This will use the stream for the deserialization of the data.
f = hdfs.fle("/RHadoop/2/README.txt","r",buffersize=104857600)
m = hdfs.read(f)
c = rawToChar(m)
print(c)
• Directory operation:
° hdfs.dircreate or hdfs.mkdir: Both these functions will be used
for creating a directory over the HDFS filesystem.
hdfs.mkdir("/RHadoop/2/")
° hdfs.rm or hdfs.rmr or hdfs.delete - to delete the directory or file
from HDFS.
hdfs.rm("/RHadoop/2/")
• Utility:
° hdfs.ls: This is used to list the directory from HDFS.
Hdfs.ls('/')


wordcount = function(input,
output = NULL,
pattern = " ")
{
  wc.map = function(., lines) {
    keyval(
    unlist(
    strsplit(
    x = lines,
    split = pattern)),
    1)
  }

  wc.reduce = function(word, counts ) {
    keyval(word, sum(counts))
  }
  mapreduce(input = input ,
  output = output,
  input.format = "text",
  map = wc.map,
  reduce = wc.reduce,
  combine = T)
}

Executing the MapReduce job: We will execute the RHadoop MapReduce job by
passing the input data location as a parameter for the wordcount function.
wordcount('/RHadoop/1/')
Exploring the wordcount output:
from.dfs("/tmp/RtmpRMIXzb/file2bda5e10e25f")
http://www.sosuopan.com/

Using Hadoop
Streaming with R

In the previous chapter, we learned how to integrate R and Hadoop with the help
of RHIPE and RHadoop and also sample examples. In this chapter, we are going to
discuss the following topics:
• Understanding the basics of Hadoop streaming
• Understanding how to run Hadoop streaming with R
• Exploring the HadoopStreaming R package
Understanding the basics of
Hadoop streaming
Hadoop streaming is a Hadoop utility for running the Hadoop MapReduce job with
executable scripts such as Mapper and Reducer. This is similar to the pipe operation
in Linux. With this, the text input fle is printed on stream (stdin), which is provided
as an input to Mapper and the output (stdout) of Mapper is provided as an input to
Reducer; fnally, Reducer writes the output to the HDFS directory.

The main advantage of the Hadoop streaming utility is that it allows Java as well as
non-Java programmed MapReduce jobs to be executed over Hadoop clusters. Also,
it takes care of the progress of running MapReduce jobs. The Hadoop streaming
supports the Perl, Python, PHP, R, and C++ programming languages. To run an
application written in other programming languages, the developer just needs to
translate the application logic into the Mapper and Reducer sections with the key and
value output elements. We learned in Chapter 2, Writing Hadoop MapReduce Programs,
that to create Hadoop MapReduce jobs we need Mapper, Reducer, and Driver as the
three main components. Here, creating the driver fle for running the MapReduce job
is optional when we are implementing MapReduce with R and Hadoop.
This chapter is written with the intention of integrating R and Hadoop. So we
will see the example of R with Hadoop streaming. Now, we will see how we can
use Hadoop streaming with the R script written with Mapper and Reducer. From
the following diagrams, we can identify the various components of the Hadoop
streaming MapReduce job.



Now, assume we have implemented our Mapper and Reducer as code_mapper.R
and code_reducer.R. We will see how we can run them in an integrated
environment of R and Hadoop. This can be run with the Hadoop streaming
command with various generic and streaming options.
Let's see the format of the Hadoop streaming command:
bin/hadoop command [generic Options] [streaming Options]


The following diagram shows an example of the execution of Hadoop streaming, a
MapReduce job with several streaming options.
Hadoop streaming command options
In the preceding image, there are about six unique important components that are
required for the entire Hadoop streaming MapReduce job. All of them are streaming
options except jar.
The following is a line-wise description of the preceding Hadoop
streaming command:
• Line 1: This is used to specify the Hadoop jar fles (setting up the classpath
for the Hadoop jar)
• Line 2: This is used for specifying the input directory of HDFS
• Line 3: This is used for specifying the output directory of HDFS
• Line 4: This is used for making a fle available to a local machine
• Line 5: This is used to defne the available R fle as Mapper
• Line 6: This is used for making a fle available to a local machine
• Line 7: This is used to defne the available R fle as Reducer
The main six Hadoop streaming components of the preceding command are listed
and explained as follows:
• jar: This option is used to run a jar with coded classes that are designed for
serving the streaming functionality with Java as well as other programmed
Mappers and Reducers. It's called the Hadoop streaming jar.
• input: This option is used for specifying the location of input dataset (stored
on HDFS) to Hadoop streaming MapReduce job.


• output: This option is used for telling the HDFS output directory (where
the output of the MapReduce job will be written) to Hadoop streaming
MapReduce job.
• fle: This option is used for copying the MapReduce resources such as
Mapper, Reducer, and Combiner to computer nodes (Tasktrackers) to make
it local.
• mapper: This option is used for identifcation of the executable Mapper fle.
• reducer: This option is used for identifcation of the executable Reducer fle.
There are other Hadoop streaming command options too, but they are optional. Let's
have a look at them:
• inputformat: This is used to defne the input data format by specifying the
Java class name. By default, it's TextInputFormat.
• outputformat: This is used to defne the output data format by specifying
the Java class name. By default, it's TextOutputFormat.
• partitioner: This is used to include the class or fle written with the code
for partitioning the output as (key, value) pairs of the Mapper phase.
• combiner: This is used to include the class or fle written with the code for
reducing the Mapper output by aggregating the values of keys. Also, we can
use the default combiner that will simply combine all the key attribute values
before providing the Mapper's output to the Reducer.
• cmdenv: This option will pass the environment variable to the streaming
command. For example, we can pass R_LIBS = /your /path /to /R /
libraries.
• inputreader: This can be used instead of the inputformat class for
specifying the record reader class.
• verbose: This is used to verbose the output.
• numReduceTasks: This is used to specify the number of Reducers.
• mapdebug: This is used to debug the script of the Mapper fle when the
Mapper task fails.
• reducedebug: This is used to debug the script of the Reducer fle when the
Reducer task fails.
Now, it's time to look at some generic options for the Hadoop streaming
MapReduce job.
• conf: This is used to specify an application confguration fle.
-conf configuration_file
• D: This is used to defne the value for a specifc MapReduce or HDFS
property. For example:
• -D property = value or to specify the temporary HDFS directory.
-D dfs.temp.dir=/app/tmp/Hadoop/
or to specify the total number of zero Reducers:
-D mapred.reduce.tasks=0
The -D option only works when a tool is implemented.
• fs: This is used to defne the Hadoop NameNode.
-fs localhost:port
• jt: This is used to defne the Hadoop JobTracker.
-jt localhost:port
• files: This is used to specify the large or multiple text fles from HDFS.
-files hdfs://host:port/directory/txtfile.txt
• libjars: This is used to specify the multiple jar fles to be included in the
classpath.
-libjars /opt/ current/lib/a.jar, /opt/ current/lib/b.jar
• archives: This is used to specify the jar fles to be unarchived on the local
machine.
-archives hdfs://host:fs_port/user/testfile.jar


Understanding how to run Hadoop
streaming with R

The four different stages of MapReduce operations are explained here as follows:
• Understanding a MapReduce application
• Understanding how to code a MapReduce application
• Understanding how to run a MapReduce application
• Understanding how to explore the output of a MapReduce application


Understanding a MapReduce application
Problem defnition: The problem is to segment a page visit by the geolocation.
In this problem, we are going to consider the website http://www.
gtuadmissionhelpline.com/, which has been developed to provide guidance to
students who are looking for admission in the Gujarat Technological University.
This website contains the college details of various felds such as Engineering
(diploma, degree, and masters), Medical, Hotel Management, Architecture,
Pharmacy, MBA, and MCA. With this MapReduce application, we will identify the
felds that visitors are interested in geographically.
For example, most of the online visitors from Valsad city visit the pages of MBA
colleges more often. Based on this, we can identify the mindset of Valsad students;
they are highly interested in getting admissions in the MBA feld. So, with this
website traffc dataset, we can identify the city-wise interest levels. Now, if there are
no MBA colleges in Valsad, it will be a big issue for them. They will need to relocate
to other cities; this may increase the cost of their education.
By using this type of data, the Gujarat Technological University can generate
informative insights for students from different cities.
Input dataset source: To perform this type of analysis, we need to have the web
traffc data for that website. Google Analytics is one of the popular and free services
for tracking an online visitor's metadata from the website. Google Analytics stores
the web traffc data in terms of various dimensions ad metrics. We need to design a
specifc query to extract the dataset from Google Analytics.

Input dataset: The extracted Google Analytics dataset contains the following four
data columns:
• date: This is the date of visit and in the form of YYYY/MM/DD.
• country: This is the country of the visitor.
• city: This is the city of the visitor.
• pagePath: This is the URL of a page of the website.
The head section of the input dataset is as follows:
$ head -5 gadata_mr.csv
20120301,India,Ahmedabad,/
20120302,India,Ahmedabad,/gtuadmissionhelpline-team
20120302,India,Mumbai,/
20120302,India,Mumbai,/merit-calculator
20120303,India,Chennai,/
The expected output format is shown in the following diagram:


Understanding how to code a MapReduce
application
In this section, we will learn about the following two units of a
MapReduce application:
• Mapper code
• Reducer code
Let's start with the Mapper code.
Mapper code: This R script, named ga-mapper.R, will take care of the Map phase of
a MapReduce job.
The Mapper's job is to work on each line and extract a pair (key, value) and pass it
to the Reducer to be grouped/aggregated. In this example, each line is an input to
Mapper and the output City:PagePath. City is a key and PagePath is a value. Now
Reducer can get all the page paths for a given city; hence, it can be grouped easily.
# To identify the type of the script, here it is RScript
#! /usr/bin/env Rscript
# To disable the warning massages to be printed
options(warn=-1)
# To initiating the connection to standard input
input <- file("stdin", "r")

Each line has these four fields (date, country, city, and
pagePath) in the same order. We split the line by a comma.
The result is a vector which has the date, country, city, and
pathPath in the indexes 1,2,3, and 4 respectively.
We extract the third and fourth element for the city and pagePath respectively.
Then, they will be written to the stream as key-value pairs and fed to Reducer for
further processing.
# Running while loop until all the lines are read
while(length(currentLine <- readLines(input, n=1, warn=FALSE)) > 0) {
# Splitting the line into vectors by "," separator
fields <- unlist(strsplit(currentLine, ","))
# Capturing the city and pagePath from fields
city <- as.character(fields[3])
pagepath <- as.character(fields[4])
# Printing both to the standard output
print(paste(city, pagepath,sep="\t"),stdout())
}
# Closing the connection to that input stream
close(input)
As soon as the output of the Mapper phase as (key, value) pairs is available to the
standard output, Reducers will read the line-oriented output from stdout and
convert it into fnal aggregated key-value pairs.
Let's see how the Mapper output format is and how the input data format of Reducer
looks like.
Reducer code: This R script named ga_reducer.R will take care of the Reducer
section of the MapReduce job.

print(paste("city", "pagepath",sep="\t"),stdout())

showConnections(all = TRUE)
## Not run: 
textConnection(letters)
# oops, I forgot to record that one
showConnections()
#  class     description      mode text   isopen   can read can write
#3 "letters" "textConnection" "r"  "text" "opened" "yes"    "no"
mycon <- getConnection(3)

## End(Not run)

c(isatty(stdin()), isatty(stdout()), isatty(stderr()))

As we discussed, the output of Mapper will be considered as the input for Reducer.
Reducer will read these city and pagePath pairs, and combine all of the values with
its respective key elements.
# To identify the type of the script, here it is RScript
#! /usr/bin/env Rscript
# Defining the variables with their initial values
city.key <- NA
page.value <- 0.0
# To initiating the connection to standard input
input <- file("stdin", open="r")
# Running while loop until all the lines are read
while (length(currentLine <- readLines(input, n=1)) > 0) {
# Splitting the Mapper output line into vectors by
# tab("\t") separator
fields <- strsplit(currentLine, "\t")
# capturing key and value form the fields
# collecting the first data element from line which is city
key <- fields[[1]][1]
# collecting the pagepath value from line
value <- as.character(fields[[1]][2])
The Mapper output is written in two main felds with \t as the separator and the
data line-by-line; hence, we have split the data by using \t to capture the two main
attributes (key and values) from the stream input.
After collecting the key and value, the Reducer will compare it with the previously
captured value. If not set previously, then set it; otherwise, combine it with the
previous character value using the combine function in R and fnally, print it to the
HDFS output location.
# setting up key and values
# if block will check whether key attribute is
# initialized or not. If not initialized then it will be # assigned from
collected key attribute with value from # mapper output. This is designed
to run at initial time.
if (is.na(city.key)) {
city.key <- key
page.value <- value
}
else {
# Once key attributes are set, then will match with the previous key
attribute value. If both of them matched then they will combined in to
one.
if (city.key == key) {
page.value <- c(page.value, value)
}
else {
# if key attributes are set already but attribute value # is other than
previous one then it will emit the store #p agepath values along with
associated key attribute value of city,
page.value <- unique(page.value)
# printing key and value to standard output
print(list(city.key, page.value),stdout())
city.key <- key
page.value <- value
}
}
}
print(list(city.key, page.value), stdout())
# closing the connection
close(input)



Understanding how to run a MapReduce
application
After the development of the Mapper and Reducer script with the R language, it's
time to run them in the Hadoop environment. Before we execute this script, it is
recommended to test them on the sample dataset with simple pipe operations.
$ cat gadata_sample.csv | ga_mapper.R |sort | ga_reducer.R
The preceding command will run the developed Mapper and Reducer scripts
over a local machine. But it will run similar to the Hadoop streaming job. We need
to test this for any issue that might occur at runtime or for the identifcation of
programming or logical mistakes.
Now, we have Mapper and Reducer tested and ready to be run with the Hadoop
streaming command. This Hadoop streaming operation can be executed by calling
the generic jar command followed with the streaming command options as we
learned in the Understanding the basics of Hadoop streaming section of this chapter. We
can execute the Hadoop streaming job in the following ways:
• From a command prompt
• R or the RStudio console
The execution command with the generic and streaming command options will be
the same for both the ways.
Executing a Hadoop streaming job from the
command prompt
As we already learned in the section Understanding the basics of Hadoop streaming, the
execution of Hadoop streaming MapReduce jobs developed with R can be run using
the following command:
$ bin/hadoop jar {HADOOP_HOME}/contrib/streaming/hadoop-streaming-
1.0.3.jar
-input /ga/gadaat_mr.csv
-output /ga/output1
-file /usr/local/hadoop/ga/ga_mapper.R
-mapper ga_mapper.R
-file /usr/local/hadoop/ga/ga_ reducer.R
-reducer ga_reducer.R

Executing the Hadoop streaming job from R or an
RStudio console
Being an R user, it will be more appropriate to run the Hadoop streaming job from
an R console. This can be done with the system command:
system(paste("bin/hadoop jar", "{HADOOP_HOME}/contrib/streaming/hadoop
streaming-1.0.3.jar",
"-input /ga/gadata_mr.csv",
"-output /ga/output2",
"-file /usr/local/hadoop/ga/ga_mapper.R",
"-mapper ga_mapper.R",
"-file /usr/local/hadoop/ga/ga_reducer.R",
"-reducer ga_reducer.R"))
This preceding command is similar to the one that you have already used in the
command prompt to execute the Hadoop streaming job with the generic options as
well as the streaming options.
Understanding how to explore the output of
MapReduce application
After completing the execution successfully, it's time to explore the output to check
whether the generated output is important or not. The output will be generated
along with two directories, _logs and _SUCCESS. _logs will be used for tracking all
the operations as well as errors; _SUCCESS will be generated only on the successful
completion of the MapReduce job.
Again, the commands can be fred in the following two ways:
• From a command prompt
• From an R console
Exploring an output from the command prompt
To list the generated fles in the output directory, the following command will be
called:
$ bin/hadoop dfs -cat /ga/output/part-* > temp.txt
$ head -n 40 temp.txt

Exploring an output from R or an RStudio console
The same command can be used with the system method in the R
(with RStudio) console.
dir <- system("bin/hadoop dfs -ls /ga/output",intern=TRUE)
out <- system("bin/hadoop dfs -cat /ga/output2/part-00000",intern=TRUE)

Understanding basic R functions used in
Hadoop MapReduce scripts
Now, we will see some basic utility functions used in Hadoop Mapper and Reducer
for data processing:
• file: This function is used to create the connection to a fle for the reading
or writing operation. It is also used for reading and writing from/to stdin
or stdout. This function will be used at the initiation of the Mapper and
Reducer phase.
Con <- file("stdin", "r")
• write: This function is used to write data to a fle or standard input. It will be
used after the key and value pair is set in the Mapper.
write(paste(city,pagepath,sep="\t"),stdout())
• print: This function is used to write data to a fle or standard input. It will be
used after the key and value pair is ready in the Mapper.
print(paste(city,pagepath,sep="\t"),stdout())
• close: This function can be used for closing the connection to the fle after
the reading or writing operation is completed. It can be used with Mapper
and Reducer at the close (conn) end when all the processes are completed.



• stdin: This is a standard connection corresponding to the input.
The stdin() function is a text mode connection that returns the connection
object. This function will be used in Mapper as well as Reducer.
conn <- file("stdin", open="r")
• stdout: This is a standard connection corresponding to the output.
The stdout() function is a text mode connection that also returns the object.
This function will be used in Mapper as well as Reducer.
print(list(city.key, page.value),stdout())
## where city.key is key and page.value is value of that key
• sink: sink drives the R output to the connection. If there is a fle or stream
connection, the output will be returned to the fle or stream. This will be used
in Mapper and Reducer for tracking all the functional outputs as well as the
errors.
sink("log.txt")
k <- 1:5
for(i in 1:k){
print(paste("value of k",k))
}sink()
unlink("log.txt")
Monitoring the Hadoop MapReduce job
A small syntax error in the Reducer phase leads to a failure of the MapReduce job.
After the failure of a Hadoop MapReduce job, we can track the problem from the
Hadoop MapReduce administration page, where we can get information about
running jobs as well as completed jobs.
In case of a failed job, we can see the total number of completed/failed Map and
Reduce jobs. Clicking on the failed jobs will provide the reason for the failing of
those particular number of Mappers or Reducers.
Also, we can check the real-time progress of that running MapReduce job with the
JobTracker console as shown in the following screenshot:


• stdin: This is a standard connection corresponding to the input.
The stdin() function is a text mode connection that returns the connection
object. This function will be used in Mapper as well as Reducer.
conn <- file("stdin", open="r")
• stdout: This is a standard connection corresponding to the output.
The stdout() function is a text mode connection that also returns the object.
This function will be used in Mapper as well as Reducer.
print(list(city.key, page.value),stdout())
## where city.key is key and page.value is value of that key
• sink: sink drives the R output to the connection. If there is a fle or stream
connection, the output will be returned to the fle or stream. This will be used
in Mapper and Reducer for tracking all the functional outputs as well as the
errors.
sink("log.txt")
k <- 1:5
for(i in 1:k){
print(paste("value of k",k))
}sink()
unlink("log.txt")
Monitoring the Hadoop MapReduce job
A small syntax error in the Reducer phase leads to a failure of the MapReduce job.
After the failure of a Hadoop MapReduce job, we can track the problem from the
Hadoop MapReduce administration page, where we can get information about
running jobs as well as completed jobs.
In case of a failed job, we can see the total number of completed/failed Map and
Reduce jobs. Clicking on the failed jobs will provide the reason for the failing of
those particular number of Mappers or Reducers.
Also, we can check the real-time progress of that running MapReduce job with the
JobTracker console as shown in the following screenshot:

Through the command, we can check the history of that particular MapReduce job
by specifying its output directory with the following command:
$ bin/hadoop job –history /output/location
The following command will print the details of the MapReduce job, failed and
reasons for killed up jobs.
$ bin/hadoop job -history all /output/location
The preceding command will print about the successful task and the task attempts
made for each task.
Exploring the HadoopStreaming
R package
HadoopStreaming is an R package developed by David S. Rosenberg. We can say this
is a simple framework for MapReduce scripting. This also runs without Hadoop for
operating data in a streaming fashion. We can consider this R package as a Hadoop
MapReduce initiator. For any analyst or developer who is not able to recall the
Hadoop streaming command to be passed in the command prompt, this package
will be helpful to quickly run the Hadoop MapReduce job.


The three main features of this package are as follows:
• Chunkwise data reading: The package allows chunkwise data reading and
writing for Hadoop streaming. This feature will overcome memory issues.
• Supports various data formats: The package allows the reading and writing
of data in three different data formats.
• Robust utility for the Hadoop streaming command: The package also allows
users to specify the command-line argument for Hadoop streaming.
This package is mainly designed with three functions for reading the data effciently:
• hsTableReader
• hsKeyValReader
• hsLineReader
Now, let's understand these functions and their use cases. After that we will
understand these functions with the help of the word count MapReduce job.
Understanding the hsTableReader function
The hsTableReader function is designed for reading data in the table format. This
function assumes that there is an input connection established with the fle, so it will
retrieve the entire row. It assumes that all the rows with the same keys are stored
consecutively in the input fle.
As the Hadoop streaming job guarantees that the output rows of Mappers will be
sorted before providing to the reducers, there is no need to use the sort function in a
Hadoop streaming MapReduce job. When we are not running this over Hadoop, we
explicitly need to call the sort function after the Mapper function gets execute.
Defning a function of hsTableReader:
hsTableReader(file="", cols='character',
chunkSize=-1, FUN=print,
ignoreKey=TRUE, singleKey=TRUE, skip=0,
sep='\t', keyCol='key',
FUN=NULL, ,carryMemLimit=512e6,
carryMaxRows=Inf,
stringsAsFactors=FALSE)


The terms in the preceding code are as follows:
• file: This is a connection object, stream, or string.
• chunkSize: This indicates the maximum number of lines to be read at a time
by the function. -1 means all the lines at a time.
• cols: This means a list of column names as "what" argument to scan.
• skip: This is used to skip the frst n data rows.
• FUN: This function will use the data entered by the user.
• carryMemLimit: This indicates the maximum memory limit for the values of
a single key.
• carryMaxRows: This indicates the maximum rows to be considered or read
from the fle.
• stringsAsFactors: This defnes whether the strings are converted to factors
or not (TRUE or FALSE).
For example, data in fle:
# Loading libraries
Library("HadoopStreaming")
# Input data String with collection of key and values
str <- "
key1\t1.91\nkey1\t2.1\nkey1\t20.2\nkey1\t3.2\
nkey2\t1.2\nkey2\t10\nkey3\t2.5\nkey3\t2.1\nkey4\t1.2\n"
cat(str)
The output for the preceding code is as shown in the following screenshot:


The data read by hsTableReader is as follows:
# A list of column names, as'what' arg to scan
cols = list(key='',val=0)
# To make a text connection
con <- textConnection(str, open = "r")
# To read the data with chunksize 3
hsTableReader(con,cols,chunkSize=3,FUN=print,ignoreKey=TRUE)
The output for the preceding code is as shown in the following screenshot:
Understanding the hsKeyValReader function
The hsKeyValReader function is designed for reading the data available in the key
value pair format. This function also uses chunkSize for defning the number of lines
to be read at a time, and each line consists of a key string and a value string.
hsKeyValReader(file = "", chunkSize = -1, skip = 0, sep = "\t",FUN =
function(k, v) cat(paste(k, v))
The terms of this function are similar to hsTablereader().

Example:
# Function for reading chunkwise dataset
printkeyval <- function(k,v) {
cat('A chunk:\n')
cat(paste(k,v,sep=': '),sep='\n')
}
str <- "key1\tval1\nkey2\tval2\nkey3\tval3\n"
con <- textConnection(str, open = "r")
hsKeyValReader(con, chunkSize=1, FUN=printFn)
The output for the preceding code is as shown in the following screenshot:
Understanding the hsLineReader function
The hsLineReader function is designed for reading the entire line as a string without
performing the data-parsing operation. It repeatedly reads the chunkSize lines of
data from the fle and passes a character vector of these strings to FUN.
hsLineReader(file = "", chunkSize = 3, skip = 0, FUN = function(x)
cat(x, sep = "\n"))
The terms of this function are similar to hsTablereader().
Example:
str <- " This is HadoopStreaming!!\n here are,\n examples for chunk
dataset!!\n in R\n ?"
# For defining the string as data source
con <- textConnection(str, open = "r")
# read from the con object
hsLineReader(con,chunkSize=2,FUN=print)

The output for the preceding code is as shown in the following screenshot:
You can get more information on these methods as well as other existing
methods at http://cran.r-project.org/web/packages/HadoopStreaming/
HadoopStreaming.pdf.
Now, we will implement the above data-reading methods with the Hadoop
MapReduce program to be run over Hadoop. In some of the cases, the key-values
pairs or data rows will not be fed in the machine memory; so reading that data chunk
wise will be more appropriate than improving the machine confguration.
Problem defnition:
Hadoop word count: As we already know what a word count application is, we will
implement the above given methods with the concept of word count. This R script
has been reproduced here from the HadoopStreaming R package, which can be
downloaded along with the HadoopStreaming R library distribution as the sample
code.
Input dataset: This has been taken from Chapter 1 of Anna Karenina (novel) by the
Russian writer Leo Tolstoy.
R script: This section contains the code of the Mapper, Reducer, and the rest of the
confguration parameters.
File: hsWordCnt.R
## Loading the library
library(HadoopStreaming)
## Additional command line arguments for this script (rest are
default in hsCmdLineArgs)
spec = c('printDone','D',0,"logical","A flag to write DONE at the
end.",FALSE)
opts = hsCmdLineArgs(spec, openConnections=T)
if (!opts$set) {

  [ 109 ]
quit(status=0)
}
# Defining the Mapper columns names
mapperOutCols = c('word','cnt')
# Defining the Reducer columns names
reducerOutCols = c('word','cnt')
# printing the column header for Mapper output
if (opts$mapcols) {
cat( paste(mapperOutCols,collapse=opts$outsep),'\n',
file=opts$outcon )
}
# Printing the column header for Reducer output
if (opts$reducecols) {
cat( paste(reducerOutCols,collapse=opts$outsep),'\n',
file=opts$outcon )
}
## For running the Mapper
if (opts$mapper) {
mapper <- function(d) {
words <- strsplit(paste(d,collapse=' '),'[[:punct:][:space:]]+')[[1]]
# split on punctuation and spaces
words <- words[!(words=='')] # get rid of empty words caused by
whitespace at beginning of lines
df = data.frame(word=words)
df[,'cnt']=1
# For writing the output in the form of key-value table format
hsWriteTable(df[,mapperOutCols],file=opts$outcon,sep=opts$outsep)
}
## For chunk wise reading the Mapper output, to be feeded to Reducer hsLi
neReader(opts$incon,chunkSize=opts$chunksize,FUN=mapper)

## For running the Reducer
} else if (opts$reducer) {
reducer <- function(d) {
cat(d[1,'word'],sum(d$cnt),'\n',sep=opts$outsep)
}
cols=list(word='',cnt=0) # define the column names and types
(''-->string 0-->numeric)
hsTableReader(opts$incon,cols,chunkSize=opts$chunksize,skip=opts$skip,s
ep=opts$insep,keyCol='word',singleKey=T, ignoreKey= F, FUN=reducer)
if (opts$printDone) {
cat("DONE\n");
}
}
# For closing the connection corresponding to input
if (!is.na(opts$infile)) {
close(opts$incon)
}
# For closing the connection corresponding to input
if (!is.na(opts$outfile)) {
close(opts$outcon)
}
Running a Hadoop streaming job
Since this is a Hadoop streaming job, it will run same as the executed previous
example of a Hadoop streaming job. For this example, we will use a shell script to
execute the runHadoop.sh fle to run Hadoop streaming.
Setting up the system environment variable:
#! /usr/bin/env bash
HADOOP="$HADOOP_HOME/bin/hadoop" # Hadoop command
HADOOPSTREAMING="$HADOOP jar
$HADOOP_HOME/contrib/streaming/hadoop-streaming-1.0.3.jar" # change
version number as appropriate

RLIBPATH=/usr/local/lib/R/site-library # can specify additional R
Library paths here
Setting up the MapReduce job parameters:
INPUTFILE="anna.txt"
HFSINPUTDIR="/HadoopStreaming"
OUTDIR="/HadoopStreamingRpkg_output"
RFILE=" home/hduser/Desktop/HadoopStreaming/inst/wordCntDemo/
hsWordCnt.R"
#LOCALOUT="/home/hduser/Desktop/HadoopStreaming/inst/wordCntDemo/
annaWordCnts.out"
# Put the file into the Hadoop file system
#$HADOOP fs -put $INPUTFILE $HFSINPUTDIR
Removing the existing output directory:
# Remove the directory if already exists (otherwise, won't run)
#$HADOOP fs -rmr $OUTDIR
Designing the Hadoop MapReduce command with generic and streaming options:
MAPARGS="--mapper"
REDARGS="--reducer"
JOBARGS="-cmdenv R_LIBS=$RLIBPATH" # numReduceTasks 0
# echo $HADOOPSTREAMING -cmdenv R_LIBS=$RLIBPATH -input
$HFSINPUTDIR/$INPUTFILE -output $OUTDIR -mapper "$RFILE $MAPARGS"
-reducer "$RFILE $REDARGS" -file $RFILE
$HADOOPSTREAMING $JOBARGS -input $HFSINPUTDIR/$INPUTFILE -output
$OUTDIR -mapper "$RFILE $MAPARGS" -reducer "$RFILE $REDARGS" -file $RFILE
Extracting the output from HDFS to the local directory:
# Extract output
./$RFILE --reducecols > $LOCALOUT
$HADOOP fs -cat $OUTDIR/part* >> $LOCALOUT

Executing the Hadoop streaming job
We can now execute the Hadoop streaming job by executing the command,
runHadoop.sh. To execute this, we need to set the user permission.
sudo chmod +x runHadoop.sh
Executing via the following command:
./runHadoop.sh
Finally, it will execute the whole Hadoop streaming job and then copy the output to
the local directory.
Summary
We have learned most of the ways to integrate R and Hadoop for performing data
operations. In the next chapter, we will learn about the data analytics cycle for
solving real world data analytics problems with the help of R and Hadoop.


http://www.doc88.com/p-4384928825695.html

In this chapter, we will learn how to perform data analytics operations over an
integrated R and Hadoop environment. Since this chapter is designed for data
analytics, we will understand this with an effective data analytics cycle.
In this chapter we will learn about:
• Understanding the data analytics project life cycle
• Understanding data analytics problems


10.0.2.15

 include 
1 identifying the data analytics problems,
2 designing and collecting datasets,
3 data analytics, 
4 data visualization.


1 identifying the problem
  2 designing data requirement
    3 preprocessing data
      4 performing analytics over data
          5 visualizing data

page 114
ubuntu 

http://www.sosuopan.com/search?q=Learning+d3.js+Data+Visualization


Hadoop has proven useful for extracttransform-load (ETL) work, image processing, data analysis, and more.

Map Phase
1. Each cluster node takes a piece of the initial mountain of data and runs a Map task
on each record (item) of input. You supply the code for the Map task.
2. The Map tasks all run in parallel, creating a key/value pair for each record. The key
identifies the item’s pile for the reduce operation. The value can be the record itself
or some derivation thereof.

The Shuffle
1. At the end of the Map phase, the machines all pool their results. Every key/value
pair is assigned to a pile, based on the key. (You don’t supply any code for the
shuffle. All of this is taken care of for you, behind the scenes.)‡
Reduce Phase
1. The cluster machines then switch roles and run the Reduce task on each pile. You
supply the code for the Reduce task, which gets the entire pile (that is, all of the
key/value pairs for a given key) at once.
2. The Reduce task typically, but not necessarily, emits some output for each pile.
emits