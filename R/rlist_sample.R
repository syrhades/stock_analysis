library(rlist)
library(pipeR)
l_mtcars <- as.list(mtcars)


l_mtcars %>>%
  list.filter(l_mtcars$mpg >= 1) %>>%
  list.class(cyl) 


url <- "e:/R/people.json"
people <- list.load(url)
people %>>%
  list.filter(Expertise$R >= 1 & Expertise$Python >= 1) %>>%
  list.class(Interests) %>>%
  list.sort(-length(.)) %>>%
  list.take(3) %>>%
  list.map(. %>>% list.table(Age))


  You may find that the JSON text above fully replicates the information in the table but using notations such as [], {} and "key" : value. Here is a simplified introduction to these notations:

[] creates a unnamed node array.
{} creates a named node list.
"key" : value creates a key-value pair where value can be a number, a string, a [] array, or a {} list.
These notations allow the use of nested lists or arrays, just like how list object in R can be nested. Therefore, this similarity briges the use of JSON and R. rlist package imports jsonlite package to read/write JSON data.

Another file format that is also widely used is YAML. The following text is a YAML format representation (stored here) of the non-tabular data:


To extract the name of each people (list element), traditionally we can call lapply() like the following:

lapply(people, function(x) {
  x$Name
})
# [[1]]
# [1] "Ken"
# 
# [[2]]
# [1] "James"
# 
# [[3]]
# [1] "Penny"
Using rlist's list.map() the task is made extremely easy:

list.map(people, Name)
# [[1]]
# [1] "Ken"
# 
# [[2]]
# [1] "James"
# 
# [[3]]
# [1] "Penny"

list.map(people, Age)
list.map(people, sum(as.numeric(Expertise)))

list.map(people, list(age=Age, range=range(as.numeric(Expertise))))

In some cases we need to refer to the item itself, or its index in the list, or even its name. In the expression, . represents the item itself, .i represents its index, and .name represents its name.

For example,

nums <- c(a=3, b=2, c=1)
list.map(nums, . + 1)

list.map(nums, .i)
# $a
# [1] 1
# 
# $b
# [1] 2
# 
# $c
# [1] 3
list.map(nums, paste0("name: ", .name))
# $a
# [1] "name: a"
# 
# $b
# [1] "name: b"
# 
# $c
# [1] "name: c"

list.mapv

If we want to get the mapping results as a vector rather than a list, we can use list.mapv(), which basically calls unlist() to the list resulted from list.map().

list.mapv(people, Age)
# [1] 24 25 24
list.mapv(people, sum(as.numeric(Expertise)))


list.select

In contrast to list.map(), list.select() provides an easier way to map each list member to a new list. This functions basically evaluates all given expressions and put the results into a list.

If a field name a list member is selected, its name will automatically preserved. If a list item evaluated from other expression is selected, we may better give it a name, or otherwise it will only have an index.

list.select(people, Name, Age)

list.select(people, Name, Age, nlang=length(Expertise))

Sometimes we don't really need the result of a mapping but its side effects. For example, if we only need to print out something about each list member, we don't need to carry on the output of mapping.

list.iter() performs iterations over a list and returns the input data invisibly for further data transformation.

list.iter(people, cat(Name, ":", Age, "\n"))

list.maps

All the previous functions work with a single list. However, there are scenarios where mapping multiple lists is needed. list.maps() evaluates an expression with multiple lists each of which is represented by a user-defined symbol at the function call.

l1 <- list(p1=list(x=1,y=2), p2=list(x=3,y=4), p3=list(x=1,y=3))
l2 <- list(2, 3, 5)
list.maps(a$x*b+a$y, a=l1, b=l2)


The function does not require named be supplied with the lists as arguments. In this case, we can use ..1, ..2, etc. to refer to the first, second or other lists.

list.maps(..1$x*..2 + ..1$y, l1, l2)


list.filter() filters a list by an expression that returns TRUE or FALSE. The results only contain the list elements for which the value of that expression turns out to be TRUE.

Different from list mapping which evaluates an expression given each list element, list filtering evaluates an expression to decide whether to include the entire element in the results.


str(list.filter(people, Age >= 25))

people %>>%
  list.filter(Age >= 25) %>>%
  list.mapv(Name)

people %>>%
  list.filter("music" %in% Interests) %>>%
  list.mapv(Name)


  people %>>%
  list.filter(mean(as.numeric(Expertise)) >= 3) %>>%
  list.mapv(Name)

  Meta-symbols like ., .i, and .name can also be used. The following code will pick up the list element whose index is even.

people %>>%
  list.filter(.i %% 2 == 0) %>>%
  list.mapv(Name)


  list.find

In some cases, we don't need to find all the instances given the criteria. Rather, we only need to find a few, sometimes only one. list.find() avoids searching across all list element but stops at a specific number of items found.

people %>>%
  list.find(Age >= 25, 10) %>>%
  list.mapv(Name)
# [1] "James"
list.findi

Similar with list.find(), list.findi() only returns the index of the elements found.

list.findi(people, Age >= 23, 2)

list.first, list.last

list.first() and list.last() are used to find the first and last element that meets certain condition if specified, respectively.

str(list.first(people, Age >= 23))
# List of 4
#  $ Name     : chr "Ken"
#  $ Age      : int 24
#  $ Interests: chr [1:3] "reading" "music" "movies"
#  $ Expertise:List of 3
#   ..$ R     : int 2
#   ..$ CSharp: int 4
#   ..$ Python: int 3
str(list.last(people, Age >= 23))
# List of 4
#  $ Name     : chr "Penny"
#  $ Age      : int 24
#  $ Interests: chr [1:2] "movies" "reading"
#  $ Expertise:List of 3
#   ..$ R     : int 1
#   ..$ Cpp   : int 4
#   ..$ Python: int 2
These two functions also works when the condition is missing. In this case, they simply take out the first/last element from the list or vector.

list.first(1:10)
# [1] 1
list.last(1:10)
# [1] 10

list.take

list.take() takes at most a given number of elements from a list. If the number is even larger than the length of the list, the function will by default return all elements in the list.

list.take(1:10, 3)
# [1] 1 2 3
list.take(1:5, 8)
# [1] 1 2 3 4 5

list.skip

As opposed to list.take(), list.skip() skips at most a given number of elements in the list and take all the rest as the results. If the number of elements to skip is equal or greater than the length of that list, an empty one will be returned.

list.skip(1:10, 3)
# [1]  4  5  6  7  8  9 10
list.skip(1:5, 8)


list.takeWhile

Similar to list.take(), list.takeWhile() is also designed to take out some elements from a list but subject to a condition. Basically, it keeps taking elements while a condition holds true.

people %>>%
  list.takeWhile(Expertise$R >= 2) %>>%
  list.map(list(Name = Name, R = Expertise$R)) %>>%
  str
# List of 2
#  $ :List of 2
#   ..$ Name: chr "Ken"
#   ..$ R   : int 2
#  $ :List of 2
#   ..$ Name: chr "James"
#   ..$ R   : int 3

list.skipWhile

list.skipWhile() keeps skipping elements while a condition holds true.

people %>>%
  list.skipWhile(Expertise$R <= 2) %>>%
  list.map(list(Name = Name, R = Expertise$R)) %>>%
  str


list.is

list.is() returns a logical vector that indicates whether a condition holds for each member of a list.

list.is(people, "music" %in% Interests)
# [1]  TRUE  TRUE FALSE
list.is(people, "Java" %in% names(Expertise))
# [1] FALSE  TRUE FALSE

list.which

list.which() returns a integer vector of the indices of the elements of a list that meet a given condition.

list.which(people, "music" %in% Interests)
# [1] 1 2
list.which(people, "Java" %in% names(Expertise))
# [1] 2
list.all

list.all() returns TRUE if all the elements of a list satisfy a given condition, or FALSE otherwise.

list.all(people, mean(as.numeric(Expertise)) >= 3)
# [1] FALSE
list.all(people, "R" %in% names(Expertise))
# [1] TRUE

list.any

list.any() returns TRUE if at least one of the elements of a list satisfies a given condition, or FALSE otherwise.

list.any(people, mean(as.numeric(Expertise)) >= 3)
# [1] TRUE
list.any(people, "Python" %in% names(Expertise))
# [1] TRUE

list.count

list.count() return a scalar integer that indicates the number of elements of a list that satisfy a given condition.

list.count(people, mean(as.numeric(Expertise)) >= 3)
# [1] 2
list.count(people, "R" %in% names(Expertise))
# [1] 3

list.match

list.match() filters a list by matching the names of the list elements by a regular expression pattern.

data <- list(p1 = 1, p2 = 2, a1 = 3, a2 = 4)
list.match(data, "p[12]")
# $p1
# [1] 1
# 
# $p2
# [1] 2
list.remove

list.remove() removes list elements by index or name.

list.remove(data, c("p1","p2"))
# $a1
# [1] 3
# 
# $a2
# [1] 4
list.remove(data, c(2,3))
# $p1
# [1] 1
# 
# $a2
# [1] 4

list.match

list.match() filters a list by matching the names of the list elements by a regular expression pattern.

data <- list(p1 = 1, p2 = 2, a1 = 3, a2 = 4)
list.match(data, "p[12]")
# $p1
# [1] 1
# 
# $p2
# [1] 2
list.remove

list.remove() removes list elements by index or name.

list.remove(data, c("p1","p2"))
# $a1
# [1] 3
# 
# $a2
# [1] 4
list.remove(data, c(2,3))
# $p1
# [1] 1
# 
# $a2
# [1] 4
list.exclude

list.exclude() removes list elements that satisfy given condition.

people %>>%
  list.exclude("sports" %in% Interests) %>>%
  list.mapv(Name)
# [1] "Ken"   "Penny"
list.clean

list.clean() is used to clean a list by a function either recursively or not. The function can be built-in function like is.null() to remove all NULL values from the list, or can be user-defined function like function(x) length(x) == 0 to remove all empty objects like NULL, character(0L), etc.

x <- list(a=1, b=NULL, c=list(x=1,y=NULL,z=logical(0L),w=c(NA,1)))
str(x)
# List of 3
#  $ a: num 1
#  $ b: NULL
#  $ c:List of 4
#   ..$ x: num 1
#   ..$ y: NULL
#   ..$ z: logi(0) 
#   ..$ w: num [1:2] NA 1
To clear all NULL values in the list recursively, we can call

str(list.clean(x, recursive = TRUE))
# List of 2
#  $ a: num 1
#  $ c:List of 3
#   ..$ x: num 1
#   ..$ z: logi(0) 
#   ..$ w: num [1:2] NA 1
To remove all empty values including NULL and zero-length vectors, we can call

str(list.clean(x, function(x) length(x) == 0L, recursive = TRUE))
# List of 2
#  $ a: num 1
#  $ c:List of 2
#   ..$ x: num 1
#   ..$ w: num [1:2] NA 1
The function can also be related to missing values. For example, exclude all empty values and vectors with at least NAs.

str(list.clean(x, function(x) length(x) == 0L || anyNA(x), recursive = TRUE))
# List of 2
#  $ a: num 1
#  $ c:List of 1
#   ..$ x: num 1

subset

subset() is implemented for list object in a way that combines list.filter() and list.map(). This function basically filters a list while at the same time maps the qualified list elements by an expression.

people %>>%
  subset(Age >= 24, Name)
# [[1]]
# [1] "Ken"
# 
# [[2]]
# [1] "James"
# 
# [[3]]
# [1] "Penny"
people %>>%
  subset("reading" %in% Interests, sum(as.numeric(Expertise)))
# [[1]]
# [1] 9
# 
# [[2]]
# [1] 7

Updating
list.update() partially modifies the given list by a number of lists resulted from expressions.

First, we load the data without any modification.

library(rlist)
library(pipeR)
people <- list.load("http://renkun.me/rlist-tutorial/data/sample.json")
people %>>%
  list.select(Name, Age) %>>%
  list.stack
#    Name Age
# 1   Ken  24
# 2 James  25
# 3 Penny  24
list.stack() converts a list to a data frame with equivalent structure. We will introduce this function later.

Suppose we find that the age of each people is mistakenly recorded, say, 1 year less than their actual ages, respectively, we need to update the original data by refresh the age of each element.

people %>>%
  list.update(Age = Age + 1) %>>%
  list.select(Name, Age) %>>%
  list.stack
#    Name Age
# 1   Ken  25
# 2 James  26
# 3 Penny  25
list.update() can also be used to exclude certain fields of the elements. Once we update the fields we want to exclude to NULL, those fields are removed.

people %>>%
  list.update(Interests = NULL, Expertise = NULL, N = length(Expertise)) %>>%
  list.stack

  list.order(people, Age)
  list.order(people, length(Interests))

  Get the order of people by the number of years using R in descending order.

list.order(people, (Expertise$R))

Get the order of people by the maximal number of years using a programming language in ascending order.

list.order(people, max(unlist(Expertise)))
list.order(people, (length(Interests)), (Expertise$R))
people %>>%
  list.sort(Age) %>>%
  list.select(Name, Age) %>>%
  str


  people %>>%
  list.sort(length(Interests)) %>>%
  list.select(Name, nint = length(Interests)) %>>%
  str


  people %>>%
  list.sort((Expertise$R)) %>>%
  list.select(Name, R = Expertise$R) %>>%
  str

  people %>>%
  list.sort(max(unlist(Expertise))) %>>%
  list.mapv(Name)
# [1] "Ken"   "Penny" "James"
people %>>%
  list.sort((length(Interests)), (Expertise$R)) %>>%
  list.select(Name, nint = length(Interests), R = Expertise$R) %>>%
  str

  list.group(1:10, . %% 2 == 0)

  str(list.group(people, Age))

  people %>>%
  list.group(Age) %>>%
  list.map(. %>>% list.mapv(Name))

  people %>>%
  list.group(length(Interests)) %>>%
  list.map(. %>>% list.mapv(Name))

  list.ungroup

list.group() produces a nested list in which the first level are groups and the second level are the original list elements put into different groups.

list.ungroup() reverts this process. In other words, the function eradicates the group level of a list.

ageGroups <- list.group(people, Age)
str(list.ungroup(ageGroups))


list.cases

In non-relational data structures, a field can be a vector of multiple values. list.cases() is used to find out all possible cases by evaluating a vector-valued expression for each list element.

In data people, field Interests is usually a character vector of multiple values. The following code will find out all possible Interests for all list elements.

list.cases(people, Interests)
list.cases(people, names(Expertise))

people %>>%
  list.class(Interests) %>>%
  list.map(. %>>% list.mapv(Name))

  people %>>%
  list.class(names(Expertise)) %>>%
  list.map(. %>>% list.mapv(Name))

  list.common

This function returns the common cases by evaluating a given expression for all list elements.

Get the common Interests of all developers.

list.common(people, Interests)
# character(0)
It concludes that no interests are common to every one. Let's see if there is any common programming language they all use.

list.common(people, names(Expertise))
# [1] "R"


list.table

table() builds a contingency table of the counts at each combination of factor levels using cross-classifying factors. list.table() is a wrapper that creates a table in which each dimension results from the values for an expression.

The function is very handy to serve as a counter. The following examples shows an easy way to know the remainders and the number of integers from 1 to 1000 when each is divided by 3.

list.table(1:1000, . %% 3)
# 
#   0   1   2 
# 333 334 333
For people dataset, we can build a two-dimensional table to show the distribution of number of interests and age.

list.table(people, Interests=length(Interests), Age)
#          Age
# Interests 24 25
#         2  1  1
#         3  1  0

list.join() joins two lists by certain expressions and list.merge() merges a series of named lists.

library(rlist)
library(pipeR)
people <- list.load("http://renkun.me/rlist-tutorial/data/sample.json") %>>%
  list.names(Name)
list.join

list.join() is used to join two lists by a key evaluated from either a common expression for the two lists or two separate expressions for each list.

newinfo <-
  list(
    list(Name="Ken", Email="[email protected]"),
    list(Name="Penny", Email="[email protected]"),
    list(Name="James", Email="[email protected]"))
str(list.join(people, newinfo, Name))
# List of 3
#  $ Ken  :List of 5
#   ..$ Name     : chr "Ken"
#   ..$ Age      : int 24
#   ..$ Interests: chr [1:3] "reading" "music" "movies"
#   ..$ Expertise:List of 3
#   .. ..$ R     : int 2
#   .. ..$ CSharp: int 4
#   .. ..$ Python: int 3
#   ..$ Email    : chr "ken@xyz.com"
#  $ James:List of 5
#   ..$ Name     : chr "James"
#   ..$ Age      : int 25
#   ..$ Interests: chr [1:2] "sports" "music"
#   ..$ Expertise:List of 3
#   .. ..$ R   : int 3
#   .. ..$ Java: int 2
#   .. ..$ Cpp : int 5
#   ..$ Email    : chr "james@xyz.com"
#  $ Penny:List of 5
#   ..$ Name     : chr "Penny"
#   ..$ Age      : int 24
#   ..$ Interests: chr [1:2] "movies" "reading"
#   ..$ Expertise:List of 3
#   .. ..$ R     : int 1
#   .. ..$ Cpp   : int 4
#   .. ..$ Python: int 2
#   ..$ Email    : chr "penny@xyz.com"
list.merge

list.merge() is used to recursively merge a series of lists with the later always updates the former. It works with two lists, as shown in the example below, in which a revision is merged with the original list.

More specifically, the merge works in a way that lists are partially updated, which allows us to specify only the fields we want to update or add for a list element, or use NULL to remove a field.

rev1 <-
  list(
    Ken = list(Age=25),
    James = list(Expertise = list(R=2, Cpp=4)),
    Penny = list(Expertise = list(R=2, Python=NULL)))
str(list.merge(people,rev1))
# List of 3
#  $ Ken  :List of 4
#   ..$ Name     : chr "Ken"
#   ..$ Age      : num 25
#   ..$ Interests: chr [1:3] "reading" "music" "movies"
#   ..$ Expertise:List of 3
#   .. ..$ R     : int 2
#   .. ..$ CSharp: int 4
#   .. ..$ Python: int 3
#  $ James:List of 4
#   ..$ Name     : chr "James"
#   ..$ Age      : int 25
#   ..$ Interests: chr [1:2] "sports" "music"
#   ..$ Expertise:List of 3
#   .. ..$ R   : num 2
#   .. ..$ Java: int 2
#   .. ..$ Cpp : num 4
#  $ Penny:List of 4
#   ..$ Name     : chr "Penny"
#   ..$ Age      : int 24
#   ..$ Interests: chr [1:2] "movies" "reading"
#   ..$ Expertise:List of 2
#   .. ..$ R  : num 2
#   .. ..$ Cpp: int 4
The function also works with multiple lists. When the second revision is obtained, the three lists can be merged in order.

rev2 <-
  list(
    James = list(Expertise=list(CSharp = 5)),
    Penny = list(Age = 24,Expertise=list(R = 3)))
str(list.merge(people,rev1, rev2))
# List of 3
#  $ Ken  :List of 4
#   ..$ Name     : chr "Ken"
#   ..$ Age      : num 25
#   ..$ Interests: chr [1:3] "reading" "music" "movies"
#   ..$ Expertise:List of 3
#   .. ..$ R     : int 2
#   .. ..$ CSharp: int 4
#   .. ..$ Python: int 3
#  $ James:List of 4
#   ..$ Name     : chr "James"
#   ..$ Age      : int 25
#   ..$ Interests: chr [1:2] "sports" "music"
#   ..$ Expertise:List of 4
#   .. ..$ R     : num 2
#   .. ..$ Java  : int 2
#   .. ..$ Cpp   : num 4
#   .. ..$ CSharp: num 5
#  $ Penny:List of 4
#   ..$ Name     : chr "Penny"
#   ..$ Age      : num 24
#   ..$ Interests: chr [1:2] "movies" "reading"
#   ..$ Expertise:List of 2
#   .. ..$ R  : num 3
#   .. ..$ Cpp: int 4
Note that list.merge() only works with lists with names; otherwise the merging function will not know the correspondence between the list elements to merge.


Searching
rlist provides searching capabilities, that is, to find values within a list recursively. list.search() handles a variety of search demands.

library(rlist)
library(pipeR)
friends <- list.load("http://renkun.me/rlist-tutorial/data/friends.json")
If the expression results in a single-valued logical vector and its value is TRUE, the whole vector will be collected. If it results in multi-valued non-logical vector, the non-NA results will be collected.

Search all elements equal to Ken recursively.

list.search(friends, . == "Ken")
# $Ken.Name
# [1] "Ken"
# 
# $James.Friends
# [1]  TRUE FALSE
# 
# $Penny.Friends
# [1] FALSE FALSE
Note that . represents every atomic vector in the list and sublists. For single-valued vector, the search expression results in TRUE or FALSE indicating whether or not to return the text of the character vector. For multi-valued vector, the search expression instead results in mutli-valued logical vector which will be considered invalid as search results.

To find out all vectors that includes Ken, we can use %in%, which always returns TRUE or FALSE for this dataset.

list.search(friends, "Ken" %in% .)
# $Ken.Name
# [1] "Ken"
# 
# $James.Friends
# [1] "Ken"   "Penny"
If the search expression returns a non-logical vector with non-NA values, then these values are returned. For example, search all values of Ken.

list.search(friends, .[. == "Ken"])
# $Ken.Name
# [1] "Ken"
# 
# $James.Friends
# [1] "Ken"
The selector can be very flexible. We can use regular expression in the search expression. For example, search all values that matches the pattern en, that is, includes en in the text.

list.search(friends, .[grepl("en",.)])
# $Ken.Name
# [1] "Ken"
# 
# $James.Friends
# [1] "Ken"   "Penny"
# 
# $Penny.Name
# [1] "Penny"
# 
# $David.Friends
# [1] "Penny"
The above examples demonstrate how searching can be done recursively using list.search(). However, the function by defaults evaluate with all types of sub-elements. For example, if we look for character values of 24,

list.search(friends, . == "24")
# $Ken.Age
# [1] 24
# 
# $James.Friends
# [1] FALSE FALSE
# 
# $Penny.Age
# [1] 24
# 
# $Penny.Friends
# [1] FALSE FALSE
the integer value will be returned too. It is because when R evaluates the following expression

24 == "24"
# [1] TRUE
number 24 is coerced to string 24 which then are equal. This is also known as the result of comparison of atomic vectors. However, this behavior is not always desirable in practice. If we want to limit the search to the range of character vectors rather than any, we have to specify classes = argument for list.search().

list.search(friends, . == "24", classes = "character")
# $James.Friends
# [1] FALSE FALSE
# 
# $Penny.Friends
# [1] FALSE FALSE
This time no character value is found to equal 24. To improve the search performance and safety, it is always recommended to explicitly specify the classes to search so as to avoid undesired coercion which might lead to unexpected results.

In some cases, the search results are deeply nested. In this case, we need to unlist it so that the results are better viewed. In this case, we can set unlist = TRUE so that an atomic vector will be returned.

list.search(friends, .[grepl("en",.)], "character", unlist = TRUE)
#       Ken.Name James.Friends1 James.Friends2     Penny.Name  David.Friends 
#          "Ken"          "Ken"        "Penny"        "Penny"        "Penny"
Sometimes, we don't need that many results to be found. We can set n = to limit the number of results to show.

list.search(friends, .[grepl("en",.)], "character", n = 3, unlist = TRUE)
#       Ken.Name James.Friends1 James.Friends2     Penny.Name 
#          "Ken"          "Ken"        "Penny"        "Penny"
Like other rlist functions, the search expression can be a lambda expression. However, list.search() does not name meta-sybmol in search expression yet. In other words, you cannot use .name to represent the name of the element. You can use .i to represent the number of vectors that has been checked, and .n to represent the number of vectors that satisfy the condition.

url <- "e:/R/friend.json"
friends <- list.load(url)

list.search(friends, . == "Ken")


list.search(friends, "Ken" %in% .)
# $Ken.Name
# [1] "Ken"
# 
# $James.Friends
# [1] "Ken"   "Penny"
If the search expression returns a non-logical vector with non-NA values, then these values are returned. For example, search all values of Ken.

list.search(friends, .[. == "Ken"])
# $Ken.Name
# [1] "Ken"
# 
# $James.Friends
# [1] "Ken"

The selector can be very flexible. We can use regular expression in the search expression. For example, search all values that matches the pattern en, that is, includes en in the text.

list.search(friends, .[grepl("en",.)])

list.search(friends, . == "24")

number 24 is coerced to string 24 which then are equal. This is also known as the result of comparison of atomic vectors. However, this behavior is not always desirable in practice. If we want to limit the search to the range of character vectors rather than any, we have to specify classes = argument for list.search().

list.search(friends, . == "24", classes = "character")
# $James.Friends
# [1] FALSE FALSE
# 
# $Penny.Friends
# [1] FALSE FALSE

list.search(friends, .[grepl("en",.)], "character", unlist = TRUE)
#       Ken.Name James.Friends1 James.Friends2     Penny.Name  David.Friends 
#          "Ken"          "Ken"        "Penny"        "Penny"        "Penny"

list.search(friends, .[grepl("en",.)], "character", n = 3, unlist = TRUE)
#       Ken.Name James.Friends1 James.Friends2     Penny.Name 
#          "Ken"          "Ken"        "Penny"        "Penny"	

Having known the difference between exact comparing (identical()) and value comparing (==), we filter the people by whether their Name is exactly identical to Ken.

people %>>%
  list.filter(identical(Name, "Ken")) %>>%
  str

  list.search(friends, identical(., "Ken"))
  list.search(friends, identical(., "Ken"), unlist = TRUE)

  list.search(friends, identical(., c("Ken","Penny")))

  Next, we search values exactly identical to numeric value 24.

list.search(friends, identical(., 24))

you will find that the ages are all stored as integers rather than numerics. Therefore, searching exact integers will work.

list.search(friends, identical(., 24L))
# $Ken.Age
# [1] 24
# 
# $Penny.Age
# [1] 24

For example, we search all values at least include one of "Ken" and "Penny".

list.search(friends, any(c("Ken","Penny") %in% .), unlist = TRUE)
#       Ken.Name James.Friends1 James.Friends2     Penny.Name  David.Friends 
#          "Ken"          "Ken"        "Penny"        "Penny"        "Penny"
Similarly, we search all numeric and integer values equal to 24.

list.search(friends, . == 24, c("numeric","integer"), unlist = TRUE)
#   Ken.Age Penny.Age 
#        24        24

people %>>%
  list.filter(grepl("en", Name)) %>>%
  list.select(Name, Age) %>>%
  list.stack
  people1 <- list(
    p1 = list(name="Ken",age=24),
    p2 = list(name="Kent",age=26),
    p3 = list(name="Sam",age=24),
    p4 = list(name="Keynes",age=30),
    p5 = list(name="Kwen",age=31))
We can use stringdist() in stringdist with list.filter(). For example, find all list elements whose name is like "Ken" with maximum distance 1, and output their pasted names as a named character vector.

people1 %>>%
  list.filter(stringdist(name,"Ken") <= 1) %>>%
  list.mapv(name)
#     p1     p2     p5 
#  "Ken" "Kent" "Kwen"

people2 %>>%
  list.search(any(stringdist(., "ken") <= 2), "character") %>>%
  str

  people2 %>>%
  list.search(.[stringdist(., "Ken") <= 1], "character") %>>%
  str
# List of 3
#  $ p1.name: chr [1:2] "Ken" "Ren"
#  $ p2.name: chr "Kent"
#  $ p5.name: chr "Kwen"

people2 %>>%
  list.filter(any(stringdist(name, "Li", method = "soundex") == 0)) %>>%
  list.mapv(name %>>% paste0(collapse = " "))
#        p3 
# "Sam Lee"

list.parse

list.parse() is used to convert an object to list. For example, this function can convert data.frame, matrix to a list with identical structure.

library(rlist)
df1 <- data.frame(name=c("Ken","Ashley","James"),
  age=c(24,25,23), stringsAsFactors = FALSE)
str(list.parse(df1))

jsontext <- '
[{ "name": "Ken", "age": 24 },
 { "name": "Ashley", "age": 25},
 { "name": "James", "age": 23 }]'
str(list.parse(jsontext, "json"))


yamltext <- "
p1:
  name: Ken
  age: 24
p2:
  name: Ashley
  age: 25
p3:
  name: James
  age: 23
"
str(list.parse(yamltext, "yaml"))

jsontext <- '
[{ "name": "Ken", "age": 24 },
 { "name": "Ashley", "age": 25},
 { "name": "James", "age": 23 }]'
data <- list.parse(jsontext, "json")
list.stack(data)
list.save() saves a list to a JSON, YAML, RData, or RDS file. Its default behavior is similar with that of list.load().


list.save(people, 'e:/list.yaml')


Misc functions
rlist provides miscellaneous functions to assist data manipulation. These functions are mainly designed to alter the structure of an list object.

list.append, list.prepend

list.append() appends an element to a list and list.prepend() prepends an element to a list.

library(rlist)
list.append(list(a=1, b=1), c=1)
# $a
# [1] 1
# 
# $b
# [1] 1
# 
# $c
# [1] 1
list.prepend(list(b=1, c=2), a=0)
# $a
# [1] 0
# 
# $b
# [1] 1
# 
# $c
# [1] 2
The function also works with vector.

list.append(1:3, 4)
# [1] 1 2 3 4
list.prepend(1:3, 0)
# [1] 0 1 2 3
The names of the vector can be well handled.

list.append(c(a=1,b=2), c=3)
# a b c 
# 1 2 3
list.prepend(c(b=2,c=3), a=1)
# a b c 
# 1 2 3
list.reverse

list.reverse() simply reverses a list or vector.

list.reverse(1:10)
#  [1] 10  9  8  7  6  5  4  3  2  1
list.zip

list.zip() combines multiple lists element-wisely. In other words, the function takes the first element from all parameters, and then the second, and so on.

str(list.zip(a=c(1,2,3), b=c(4,5,6)))
# List of 3
#  $ :List of 2
#   ..$ a: num 1
#   ..$ b: num 4
#  $ :List of 2
#   ..$ a: num 2
#   ..$ b: num 5
#  $ :List of 2
#   ..$ a: num 3
#   ..$ b: num 6
The list elements need not be atomic vectors. They can be any lists.

str(list.zip(x=list(1,"x"), y=list("y",2)))
# List of 2
#  $ :List of 2
#   ..$ x: num 1
#   ..$ y: chr "y"
#  $ :List of 2
#   ..$ x: chr "x"
#   ..$ y: num 2
The parameters do not have to be the same type.

str(list.zip(x=c(1,2), y=list("x","y")))
# List of 2
#  $ :List of 2
#   ..$ x: num 1
#   ..$ y: chr "x"
#  $ :List of 2
#   ..$ x: num 2
#   ..$ y: chr "y"
list.rbind, list.cbind

list.rbind() binds atomic vectors by row and list.cbind() by column.

scores <- list(score1=c(10,9,10),score2=c(8,9,6),score3=c(9,8,10))
list.rbind(scores)
#        [,1] [,2] [,3]
# score1   10    9   10
# score2    8    9    6
# score3    9    8   10
list.cbind(scores)
#      score1 score2 score3
# [1,]     10      8      9
# [2,]      9      9      8
# [3,]     10      6     10
Note that the two functions finally call rbind() and cbind(), respectively, which result in matrix or data frame.

If a list of lists are supplied, then a matrix of list will be created.

scores2 <- list(score1=list(10,9,10),
  score2=list(8,9,6),type=list("a","b","a"))
rscores2 <- list.rbind(scores2)
rscores2
#        [,1] [,2] [,3]
# score1 10   9    10  
# score2 8    9    6   
# type   "a"  "b"  "a"
rscores2 is a matrix of lists rather than atomic values.

rscores2[1,1]
# $score1
# [1] 10
rscores2[,1]
# $score1
# [1] 10
# 
# $score2
# [1] 8
# 
# $type
# [1] "a"
This is not a common practice and may lead to unexpected mistakes if one is not fully aware of it and take for granted that the extracted value should be an atomic value like a number or string. Therefore, it is not recommended to either list.rbind() or list.cbind() a list of lists.

list.stack

To create a data.frame from a list of lists, use list.stack(). It is particularly useful when we want to transform a non-tabular data to a stage where it actually fits a tabular form.

For example, a list of lists with the same single-entry fields can be transformed to a equivalent data frame.

nontab <- list(list(type="A",score=10),list(type="B",score=9))
list.stack(nontab)
#   type score
# 1    A    10
# 2    B     9
For non-tabular data, we can select fields or columns in the data and stack the records together to create a data frame.

library(pipeR)
list.load("http://renkun.me/rlist-tutorial/data/sample.json") %>>%
  list.select(Name, Age) %>>%
  list.stack
#    Name Age
# 1   Ken  24
# 2 James  25
# 3 Penny  24
list.flatten

list is powerful in its recursive nature. Sometimes, however, we don't need its recursive feature but want to flatten it so that all its child elements are put to the first level.

list.flatten() recursively extract all elements at all levels and put them to the first level.

data <- list(list(a=1,b=2),list(c=1,d=list(x=1,y=2)))
str(data)
# List of 2
#  $ :List of 2
#   ..$ a: num 1
#   ..$ b: num 2
#  $ :List of 2
#   ..$ c: num 1
#   ..$ d:List of 2
#   .. ..$ x: num 1
#   .. ..$ y: num 2
list.flatten(data)
# $a
# [1] 1
# 
# $b
# [1] 2
# 
# $c
# [1] 1
# 
# $d.x
# [1] 1
# 
# $d.y
# [1] 2
list.names

list.names() can be used to set names of list elements by expression.

people <- list.load("http://renkun.me/rlist-tutorial/data/sample.json") %>>%
  list.select(Name, Age)
str(people)
# List of 3
#  $ :List of 2
#   ..$ Name: chr "Ken"
#   ..$ Age : int 24
#  $ :List of 2
#   ..$ Name: chr "James"
#   ..$ Age : int 25
#  $ :List of 2
#   ..$ Name: chr "Penny"
#   ..$ Age : int 24
Note that the elements in people currently do not have names. In some cases, it would be nice to assign appropriate names to those elements so that the distinctive information can be preserved in list transformations.

npeople <- people %>>% 
  list.names(Name)
str(npeople)
# List of 3
#  $ Ken  :List of 2
#   ..$ Name: chr "Ken"
#   ..$ Age : int 24
#  $ James:List of 2
#   ..$ Name: chr "James"
#   ..$ Age : int 25
#  $ Penny:List of 2
#   ..$ Name: chr "Penny"
#   ..$ Age : int 24
The names of the list elements can be preserved in various types of data manipulation. For example,

npeople %>>%
  list.mapv(Age)
#   Ken James Penny 
#    24    25    24
The names of the resulted vector exactly come from the names of the list elements.

list.sample

Sometimes it is useful to take a sample from a list. If it is a weighted sampling, the weights are in most cases related with individual subjects. list.sample() is a wrapper function of the built-in sample() but provides weight argument as an expression to evaluate for each list element to determine the weight of that element.

The following example shows a simple sampling from integers 1-10 by weight of squares.

set.seed(0)
list.sample(1:10, size = 3, weight = .^2)
# [1]  5 10  8

Lambda expression
Although the fields of each list element are directly accessible in the expression, sometimes we still need to access the list element itself, usually for its meta-information. Lambda expressions provide a mechanism that allows you to use default or customized meta-symbols to access the meta-information of the list element.

In rlist package, all functions that work with expressions support implicit lambda expressions, that is, an ordinary expression with no special syntax yet the fields of elements are directly accessible. All functions working with expressions except list.select() also support explicit lambda expression including

Univariate lambda expression: In contrast to implicit lambda expression, the symbol that refers to the element is customized in the following formats:
x ~ expression
f(x) ~ expression
Multivariate lambda expression: In contrast to univariate lambda expression, the symbols of element, index, and member name are customized in the following formats:
f(x,i) ~ expression
f(x,i,name) ~ expression
library(rlist)
Implicit lambda expression

Implicit lambda expression is an ordinary expression with no special syntax like ~. In this case, meta symbols are implicitly defined in default, that is, . represents the element, .i represents the index, and .name represents the name of the element.

For example,

x <- list(a=list(x=1,y=2),b=list(x=2,y=3))
list.map(x,y)
# $a
# [1] 2
# 
# $b
# [1] 3
list.map(x,sum(as.numeric(.)))
# $a
# [1] 3
# 
# $b
# [1] 5
In the second mapping above, . represents each element. For the first member, the meta-symbols take the following values:

. = x[[1]] = list(x=1,y=2)
.i = 1
.name = "a"
Explicit lambda expression

To use other symbols to represent the metadata of a element, we can use explicit lambda expressions.

x <- list(a=list(x=1,y=2),b=list(x=2,y=3))
list.map(x, f(item,index) ~ unlist(item) * index)
# $a
# x y 
# 1 2 
# 
# $b
# x y 
# 4 6
list.map(x, f(item,index,name) ~ list(name=name,sum=sum(unlist(item))))
# $a
# $a$name
# [1] "a"
# 
# $a$sum
# [1] 3
# 
# 
# $b
# $b$name
# [1] "b"
# 
# $b$sum
# [1] 5
For unnamed vector members, it is almost necessary to use lambda expressions.

x <- list(a=c(1,2),b=c(3,4))
list.map(x,sum(.))
# $a
# [1] 3
# 
# $b
# [1] 7
list.map(x,item ~ sum(item))
# $a
# [1] 3
# 
# $b
# [1] 7
list.map(x,f(m,i) ~ m+i)
# $a
# [1] 2 3
# 
# $b
# [1] 5 6
For named vector members, their name can also be directly used in the expression.

x <- list(a=c(x=1,y=2),b=c(x=3,y=4))
list.map(x,sum(y))
# $a
# [1] 2
# 
# $b
# [1] 4
list.map(x,x*y)
# $a
# [1] 2
# 
# $b
# [1] 12
list.map(x,.i)
# $a
# [1] 1
# 
# $b
# [1] 2
list.map(x,x+.i)
# $a
# [1] 2
# 
# $b
# [1] 5
list.map(x,f(.,i) ~ . + i)
# $a
# x y 
# 2 3 
# 
# $b
# x y 
# 5 6
list.map(x,.name)
# $a
# [1] "a"
# 
# $b
# [1] "b"
NOTE: list.select does not support explicit lambda expressions.