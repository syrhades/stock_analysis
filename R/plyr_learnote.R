library(plyr)
# sort mtcars data by cylinder and displacement
mtcars[with(mtcars, order(cyl, disp)), ]
# Same result using arrange: no need to use with(), as the context is implicit
# NOTE: plyr functions do NOT preserve row.names
arrange(mtcars, cyl, disp)
# Let's keep the row.names in this example
myCars = cbind(vehicle=row.names(mtcars), mtcars)
arrange(myCars, cyl, disp)
# Sort with displacement in descending order
arrange(myCars, cyl, desc(disp))


#############################33
# Let's extract the number of teams and total period of time
# covered by the baseball dataframe
summarise(baseball,
 duration = max(year) - min(year),
 nteams = length(unique(team)))
# Combine with ddply to do that for each separate id
ddply(baseball, "id", summarise,
 duration = max(year) - min(year),
 nteams = length(unique(team)))
######################3
first <- ddply(baseball, "id", summarise, first = min(year))
system.time(b2 <- merge(baseball, first, by = "id", all.x = TRUE))
system.time(b3 <- join(baseball, first, by = "id"))

b2 <- arrange(b2, id, year, stint)
b3 <- arrange(b3, id, year, stint)
stopifnot(all.equal(b2, b3))

#######################
#############################3
# Examples from transform
mutate(airquality, Ozone = -Ozone)
mutate(airquality, new = -Ozone, Temp = (Temp - 32) / 1.8)

# Things transform can't do
mutate(airquality, Temp = (Temp - 32) / 1.8, OzT = Ozone / Temp)

# mutate is rather faster than transform
system.time(transform(baseball, avg_ab = ab / g))
system.time(mutate(baseball, avg_ab = ab / g))



# count the occurrences of each id in the baseball dataframe, then get the subset with a freq >25
longterm <- subset(count(baseball, "id"), freq > 25)
# longterm
#             id freq
# 30   ansonca01   27
# 48   baineha01   27
# ...
# Select only rows from these longterm players from the baseball dataframe
# (match would default to match on shared column names, but here was explicitly set "id")
bb_longterm <- match_df(baseball, longterm, on="id")
bb_longterm[1:5,]


Examples

# Count number of missing values
nmissing <- function(x) sum(is.na(x))

# Apply to every column in a data frame
colwise(nmissing)(baseball)
# This syntax looks a little different.  It is shorthand for the
# the following:
f <- colwise(nmissing)
f(baseball)

# This is particularly useful in conjunction with d*ply
ddply(baseball, .(year), colwise(nmissing))

# To operate only on specified columns, supply them as the second
# argument.  Many different forms are accepted.
ddply(baseball, .(year), colwise(nmissing, .(sb, cs, so)))
ddply(baseball, .(year), colwise(nmissing, c("sb", "cs", "so")))
ddply(baseball, .(year), colwise(nmissing, ~ sb + cs + so))

# Alternatively, you can specify a boolean function that determines
# whether or not a column should be included
ddply(baseball, .(year), colwise(nmissing, is.character))
ddply(baseball, .(year), colwise(nmissing, is.numeric))
ddply(baseball, .(year), colwise(nmissing, is.discrete))

# These last two cases are particularly common, so some shortcuts are
# provided:
ddply(baseball, .(year), numcolwise(nmissing))
ddply(baseball, .(year), catcolwise(nmissing))

# You can supply additional arguments to either colwise, or the function
# it generates:
numcolwise(mean)(baseball, na.rm = TRUE)
numcolwise(mean, na.rm = TRUE)(baseball)


x <- c("a" = 1, "b" = 2, d = 3, 4)
# Rename column d to "c", updating the variable "x" with the result
x <- rename(x, replace = c("d" = "c"))
x
# Rename column "disp" to "displacement"
rename(mtcars, c("disp" = "displacement"))



round_any(135, 10)
round_any(135, 100)
round_any(135, 25)
round_any(135, 10, floor)
round_any(135, 100, floor)
round_any(135, 25, floor)
round_any(135, 10, ceiling)
round_any(135, 100, ceiling)
round_any(135, 25, ceiling)

round_any(Sys.time() + 1:10, 5)
round_any(Sys.time() + 1:10, 5, floor)
round_any(Sys.time(), 3600)

Examples

# Count of each value of "id" in the first 100 cases
count(baseball[1:100,], vars = "id")
# Count of ids, weighted by their "g" loading
count(baseball[1:100,], vars = "id", wt_var = "g")
count(baseball, "id", "ab")
count(baseball, "lg")
# How many stints do players do?
count(baseball, "stint")
# Count of times each player appeared in each of the years they played
count(baseball[1:100,], c("id", "year"))
# Count of counts
count(count(baseball[1:100,], c("id", "year")), "id", "freq")
count(count(baseball, c("id", "year")), "freq")


arrange(count(baseball[1:100,], vars = "id"),desc(freq))


####################################


dim(ozone)
aaply(ozone, 1, mean)
aaply(ozone, 1, mean, .drop = FALSE)
aaply(ozone, 3, mean)
aaply(ozone, c(1,2), mean)

dim(aaply(ozone, c(1,2), mean))
dim(aaply(ozone, c(1,2), mean, .drop = FALSE))

aaply(ozone, 1, each(min, max))
aaply(ozone, 3, each(min, max))

standardise <- function(x) (x - min(x)) / (max(x) - min(x))
aaply(ozone, 3, standardise)
aaply(ozone, 1:2, standardise)

aaply(ozone, 1:2, diff)

See Also

Other array input: a_ply; aaply; adply 

Other list output: dlply; llply; mlply 

Examples
alply(ozone, 3, quantile)
alply(ozone, 3, function(x) table(round(x)))


# Call min() and max() on the vector 1:10
each(min, max)(1:10)
# This syntax looks a little different.  It is shorthand for the
# the following:
f<- each(min, max)
f(1:10)
# Three equivalent ways to call min() and max() on the vector 1:10
each("min", "max")(1:10)
each(c("min", "max"))(1:10)
each(c(min, max))(1:10)
# Call length(), min() and max() on a random normal vector
each(length, mean, var)(rnorm(100))

#################################

f <- function(x) if (x == 1) stop("Error!") else 1
## Not run: 
f(1)
f(2)

## End(Not run)

safef <- failwith(NULL, f)
safef(1)
safef(2)

#################################

This function captures the current context, making it easier to use **ply with functions that do special evaluation and need access to the environment where ddply was called from. 

Usage
here(f)


Arguments

f 
a function that does non-standard evaluation
 

Author(s)

Peter Meilstrup, https://github.com/crowding 

Examples
df <- data.frame(a = rep(c("a","b"), each = 10), b = 1:20)
f1 <- function(label) {
   ddply(df, "a", mutate, label = paste(label, b))
}
## Not run: f1("name:")
# Doesn't work because mutate can't find label in the current scope

f2 <- function(label) {
   ddply(df, "a", here(mutate), label = paste(label, b))
}
f2("name:")
# Works :)

#############################################
system.time(dlply(baseball, "id", nrow))
system.time(dlply(idata.frame(baseball), "id", nrow))

###############################
Join two data frames together.

Description

Join, like merge, is designed for the types of problems where you would use a sql join. 

Usage
join(x, y, by = NULL, type = "left", match = "all")


Arguments

x 
data frame
 
y 
data frame
 
by 
character vector of variable names to join by. If omitted, will match on all common variables.
 
type 
type of join: left (default), right, inner or full. See details for more information.
 
match 
how should duplicate ids be matched? Either match just the "first" matching row, or match "all" matching rows. Defaults to "all" for compatibility with merge, but "first" is significantly faster.
 

Details

The four join types return: 

•inner: only rows with matching keys in both x and y 


•left: all rows in x, adding matching columns from y 


•right: all rows in y, adding matching columns from x 


•full: all rows in x with matching columns in y, then the rows of y that don't match x. 


Note that from plyr 1.5, join will (by default) return all matches, not just the first match, as it did previously. 

Unlike merge, preserves the order of x no matter what join type is used. If needed, rows from y will be added to the bottom. Join is often faster than merge, although it is somewhat less featureful - it currently offers no way to rename output or merge on different variables in the x and y data frames. 

Examples
first <- ddply(baseball, "id", summarise, first = min(year))
system.time(b2 <- merge(baseball, first, by = "id", all.x = TRUE))
system.time(b3 <- join(baseball, first, by = "id"))

b2 <- arrange(b2, id, year, stint)
b3 <- arrange(b3, id, year, stint)
stopifnot(all.equal(b2, b3))



join {plyr} R Documentation 

Join two data frames together.

Description

Join, like merge, is designed for the types of problems where you would use a sql join. 

Usage
join(x, y, by = NULL, type = "left", match = "all")


Arguments

x 
data frame
 
y 
data frame
 
by 
character vector of variable names to join by. If omitted, will match on all common variables.
 
type 
type of join: left (default), right, inner or full. See details for more information.
 
match 
how should duplicate ids be matched? Either match just the "first" matching row, or match "all" matching rows. Defaults to "all" for compatibility with merge, but "first" is significantly faster.
 

Details

The four join types return: 

•inner: only rows with matching keys in both x and y 


•left: all rows in x, adding matching columns from y 


•right: all rows in y, adding matching columns from x 


•full: all rows in x with matching columns in y, then the rows of y that don't match x. 


Note that from plyr 1.5, join will (by default) return all matches, not just the first match, as it did previously. 

Unlike merge, preserves the order of x no matter what join type is used. If needed, rows from y will be added to the bottom. Join is often faster than merge, although it is somewhat less featureful - it currently offers no way to rename output or merge on different variables in the x and y data frames. 

Examples
first <- ddply(baseball, "id", summarise, first = min(year))
system.time(b2 <- merge(baseball, first, by = "id", all.x = TRUE))
system.time(b3 <- join(baseball, first, by = "id"))

b2 <- arrange(b2, id, year, stint)
b3 <- arrange(b3, id, year, stint)
stopifnot(all.equal(b2, b3))



[Package plyr version 1.8.3 Index]



＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃
Recursively join a list of data frames.

Description

Recursively join a list of data frames. 

Usage
join_all(dfs, by = NULL, type = "left", match = "all")


Arguments

dfs 
A list of data frames.
 
by 
character vector of variable names to join by. If omitted, will match on all common variables.
 
type 
type of join: left (default), right, inner or full. See details for more information.
 
match 
how should duplicate ids be matched? Either match just the "first" matching row, or match "all" matching rows. Defaults to "all" for compatibility with merge, but "first" is significantly faster.
 

Examples
dfs <- list(
  a = data.frame(x = 1:10, a = runif(10)),
  b = data.frame(x = 1:10, b = runif(10)),
  c = data.frame(x = 1:10, c = runif(10))
)
join_all(dfs)
join_all(dfs, "x")


#################################
Call function with arguments in array or data frame, returning an array.

Description

Call a multi-argument function with values taken from columns of an data frame or array, and combine results into an array 

Usage
maply(.data, .fun = NULL, ..., .expand = TRUE, .progress = "none",
  .inform = FALSE, .drop = TRUE, .parallel = FALSE, .paropts = NULL)


Arguments

.data 
matrix or data frame to use as source of arguments
 
.fun 
function to apply to each piece
 
... 
other arguments passed on to .fun
 
.expand 
should output be 1d (expand = FALSE), with an element for each row; or nd (expand = TRUE), with a dimension for each variable.
 
.progress 
name of the progress bar to use, see create_progress_bar
 
.inform 
produce informative error messages? This is turned off by default because it substantially slows processing speed, but is very useful for debugging
 
.drop 
should extra dimensions of length 1 in the output be dropped, simplifying the output. Defaults to TRUE
 
.parallel 
if TRUE, apply function in parallel, using parallel backend provided by foreach
 
.paropts 
a list of additional options passed into the foreach function when parallel computation is enabled. This is important if (for example) your code relies on external data or packages: use the .export and .packages arguments to supply them so that all cluster nodes have the correct environment set up for computing.
 

Details

The m*ply functions are the plyr version of mapply, specialised according to the type of output they produce. These functions are just a convenient wrapper around a*ply with margins = 1 and .fun wrapped in splat. 

Value

if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions) 

Input

Call a multi-argument function with values taken from columns of an data frame or array 

Output

If there are no results, then this function will return a vector of length 0 (vector()). 

References

Hadley Wickham (2011). The Split-Apply-Combine Strategy for Data Analysis. Journal of Statistical Software, 40(1), 1-29. http://www.jstatsoft.org/v40/i01/. 

See Also

Other array output: aaply; daply; laply 

Other multiple arguments input: m_ply; mdply; mlply 

Examples
maply(cbind(mean = 1:5, sd = 1:5), rnorm, n = 5)
maply(expand.grid(mean = 1:5, sd = 1:5), rnorm, n = 5)
maply(cbind(1:5, 1:5), rnorm, n = 5)




mdply(cbind(mean = 1:5, sd = 5:1), max, n = 1)
mdply(data.frame(mean = 1:5, sd = 1:5), rnorm, n = 2)
mdply(expand.grid(mean = 1:5, sd = 1:5), rnorm, n = 2)
mdply(cbind(mean = 1:5, sd = 1:5), rnorm, n = 5)
mdply(cbind(mean = 1:5, sd = 1:5), as.data.frame(rnorm), n = 5)


mapvalues {plyr}	R Documentation
Replace specified values with new values, in a vector or factor.
Description

Item in x that match items from will be replaced by items in to, matched by position. For example, items in x that match the first element in from will be replaced by the first element of to.
Usage

mapvalues(x, from, to, warn_missing = TRUE)

Arguments
x 	

the factor or vector to modify
from 	

a vector of the items to replace
to 	

a vector of replacement values
warn_missing 	

print a message if any of the old values are not actually present in x
Details

If x is a factor, the matching levels of the factor will be replaced with the new values.

The related revalue function works only on character vectors and factors, but this function works on vectors of any type and factors.
See Also

revalue to do the same thing but with a single named vector instead of two separate vectors.
Examples

x <- c("a", "b", "c")
mapvalues(x, c("a", "c"), c("A", "C"))

# Works on factors
y <- factor(c("a", "b", "c", "a"))
mapvalues(y, c("a", "c"), c("A", "C"))

# Works on numeric vectors
z <- c(1, 4, 5, 9)
mapvalues(z, from = c(1, 5, 9), to = c(10, 50, 90))



match_df {plyr}	R Documentation
Extract matching rows of a data frame.
Description

Match works in the same way as join, but instead of return the combined dataset, it only returns the matching rows from the first dataset. This is particularly useful when you've summarised the data in some way and want to subset the original data by a characteristic of the subset.
Usage

match_df(x, y, on = NULL)

Arguments
x 	

data frame to subset.
y 	

data frame defining matching rows.
on 	

variables to match on - by default will use all variables common to both data frames.
Details

match_df shares the same semantics as join, not match:

    the match criterion is ==, not identical).

    it doesn't work for columns that are not atomic vectors

    if there are no matches, the row will be omitted'

Value

a data frame
See Also

join to combine the columns from both x and y and match for the base function selecting matching items
Examples

# count the occurrences of each id in the baseball dataframe, then get the subset with a freq >25
longterm <- subset(count(baseball, "id"), freq > 25)
# longterm
#             id freq
# 30   ansonca01   27
# 48   baineha01   27
# ...
# Select only rows from these longterm players from the baseball dataframe
# (match would default to match on shared column names, but here was explicitly set "id")
bb_longterm <- match_df(baseball, longterm, on="id")
bb_longterm[1:5,]

Toggle row names between explicit and implicit.
Description

Plyr functions ignore row names, so this function provides a way to preserve them by converting them to an explicit column in the data frame. After the plyr operation, you can then apply name_rows again to convert back from the explicit column to the implicit rownames.
Usage

name_rows(df)

Arguments
df 	

a data.frame, with either rownames, or a column called .rownames.
Examples

name_rows(mtcars)
name_rows(name_rows(mtcars))

df <- data.frame(a = sample(10))
arrange(df, a)
arrange(name_rows(df), a)
name_rows(arrange(name_rows(df), a))
############################################

# Count number of missing values
nmissing <- function(x) sum(is.na(x))

# Apply to every column in a data frame
colwise(nmissing)(baseball)
# This syntax looks a little different.  It is shorthand for the
# the following:
f <- colwise(nmissing)
f(baseball)

# This is particularly useful in conjunction with d*ply
ddply(baseball, .(year), colwise(nmissing))

# To operate only on specified columns, supply them as the second
# argument.  Many different forms are accepted.
ddply(baseball, .(year), colwise(nmissing, .(sb, cs, so)))
ddply(baseball, .(year), colwise(nmissing, c("sb", "cs", "so")))
ddply(baseball, .(year), colwise(nmissing, ~ sb + cs + so))

# Alternatively, you can specify a boolean function that determines
# whether or not a column should be included
ddply(baseball, .(year), colwise(nmissing, is.character))
ddply(baseball, .(year), colwise(nmissing, is.numeric))
ddply(baseball, .(year), colwise(nmissing, is.discrete))

# These last two cases are particularly common, so some shortcuts are
# provided:
ddply(baseball, .(year), numcolwise(nmissing))
ddply(baseball, .(year), catcolwise(nmissing))

# You can supply additional arguments to either colwise, or the function
# it generates:
numcolwise(mean)(baseball, na.rm = TRUE)
numcolwise(mean, na.rm = TRUE)(baseball)





ddply(mtcars, "cyl", each(nrow, ncol,max,min))


Examples

.(a, b, c)
.(first = a, second = b, third = c)
.(a ^ 2, b - d, log(c))
as.quoted(~ a + b + c)
as.quoted(a ~ b + c)
as.quoted(c("a", "b", "c"))

# Some examples using ddply - look at the column names
ddply(mtcars, "cyl", each(nrow, ncol))
ddply(mtcars, ~ cyl, each(nrow, ncol))
ddply(mtcars, .(cyl), each(nrow, ncol))
ddply(mtcars, .(log(cyl)), each(nrow, ncol))
ddply(mtcars, .(logcyl = log(cyl)), each(nrow, ncol))
ddply(mtcars, .(vs + am), each(nrow, ncol))
ddply(mtcars, .(vsam = vs + am), each(nrow, ncol))





Replicate expression and return results in a array.
Description

Evalulate expression n times then combine results into an array
Usage

raply(.n, .expr, .progress = "none", .drop = TRUE)

Arguments
.n 	

number of times to evaluate the expression
.expr 	

expression to evaluate
.progress 	

name of the progress bar to use, see create_progress_bar
.drop 	

should extra dimensions of length 1 be dropped, simplifying the output. Defaults to TRUE
Details

This function runs an expression multiple times, and combines the result into a data frame. If there are no results, then this function returns a vector of length 0 (vector(0)). This function is equivalent to replicate, but will always return results as a vector, matrix or array.
Value

if results are atomic with same type and dimensionality, a vector, matrix or array; otherwise, a list-array (a list with dimensions)
References

Hadley Wickham (2011). The Split-Apply-Combine Strategy for Data Analysis. Journal of Statistical Software, 40(1), 1-29. http://www.jstatsoft.org/v40/i01/.
Examples

raply(100, mean(runif(100)))
raply(100, each(mean, var)(runif(100)))

raply(10, runif(4))
raply(10, matrix(runif(4), nrow=2))

# See the central limit theorem in action
hist(raply(1000, mean(rexp(10))))
hist(raply(1000, mean(rexp(100))))
hist(raply(1000, mean(rexp(1000))))

Combine data.frames by row, filling in missing columns.
Description

rbinds a list of data frames filling missing columns with NA.
Usage

rbind.fill(...)

Arguments
... 	

input data frames to row bind together. The first argument can be a list of data frames, in which case all other arguments are ignored. Any NULL inputs are silently dropped. If all inputs are NULL, the output is NULL.
Details

This is an enhancement to rbind that adds in columns that are not present in all inputs, accepts a list of data frames, and operates substantially faster.

Column names and types in the output will appear in the order in which they were encountered.

Unordered factor columns will have their levels unified and character data bound with factors will be converted to character. POSIXct data will be converted to be in the same time zone. Array and matrix columns must have identical dimensions after the row count. Aside from these there are no general checks that each column is of consistent data type.
Value

a single data frame
See Also

Other binding functions: rbind.fill.matrix
Examples



rbind.fill(mtcars[c("mpg", "wt")], mtcars[c("wt", "cyl")])



rdply(20, mean(runif(100)))
rdply(20, each(mean, var)(runif(100)))
rdply(20, data.frame(x = runif(2)))



x <- c("a" = 1, "b" = 2, d = 3, 4)
# Rename column d to "c", updating the variable "x" with the result
x <- rename(x, replace = c("d" = "c"))
x
# Rename column "disp" to "displacement"
rename(mtcars, c("disp" = "displacement"))


x <- c("a", "b", "c")
revalue(x, c(a = "A", c = "C"))
revalue(x, c("a" = "A", "c" = "C"))

y <- factor(c("a", "b", "c", "a"))
revalue(y, c(a = "A", c = "C"))



round_any(135, 10)
round_any(135, 100)
round_any(135, 25)
round_any(135, 10, floor)
round_any(135, 100, floor)
round_any(135, 25, floor)
round_any(135, 10, ceiling)
round_any(135, 100, ceiling)
round_any(135, 25, ceiling)

round_any(Sys.time() + 1:10, 5)
round_any(Sys.time() + 1:10, 5, floor)
round_any(Sys.time(), 3600)

r_ply(10, plot(runif(50)))
r_ply(25, hist(runif(1000)))


#####################3
‘Splat’ arguments to a function.
Description

Wraps a function in do.call, so instead of taking multiple arguments, it takes a single named list which will be interpreted as its arguments.
Usage

splat(flat)

Arguments
flat 	

function to splat
Details

This is useful when you want to pass a function a row of data frame or array, and don't want to manually pull it apart in your function.
Value

a function
Examples

hp_per_cyl <- function(hp, cyl, ...) hp / cyl
splat(hp_per_cyl)(mtcars[1,])
splat(hp_per_cyl)(mtcars)

f <- function(mpg, wt, ...) data.frame(mw = mpg / wt)
ddply(mtcars, .(cyl), splat(f))


##############################
Remove splitting variables from a data frame.
Description

This is useful when you want to perform some operation to every column in the data frame, except the variables that you have used to split it. These variables will be automatically added back on to the result when combining all results together.
Usage

strip_splits(df)

Arguments
df 	

data frame produced by d*ply.
Examples

dlply(mtcars, c("vs", "am"))
dlply(mtcars, c("vs", "am"), strip_splits)


# Let's extract the number of teams and total period of time
# covered by the baseball dataframe
summarise(baseball,
 duration = max(year) - min(year),
 nteams = length(unique(team)))
# Combine with ddply to do that for each separate id
ddply(baseball, "id", summarise,
 duration = max(year) - min(year),
 nteams = length(unique(team)))


# Let's extract the number of teams and total period of time
# covered by the baseball dataframe
summarise(baseball,
 duration = max(year) - min(year),
 nteams = length(unique(team)))
# Combine with ddply to do that for each separate id
ddply(baseball, "id", summarise,
 duration = max(year) - min(year),
 nteams = length(unique(team)))


Take a subset along an arbitrary dimension
Description

Take a subset along an arbitrary dimension
Usage

take(x, along, indices, drop = FALSE)

Arguments
x 	

matrix or array to subset
along 	

dimension to subset along
indices 	

the indices to select
drop 	

should the dimensions of the array be simplified? Defaults to FALSE which is the opposite of the useful R default.
Examples

x <- array(seq_len(3 * 4 * 5), c(3, 4, 5))
take(x, 3, 1)
take(x, 2, 1)
take(x, 1, 1)
take(x, 3, 1, drop = TRUE)
take(x, 2, 1, drop = TRUE)
take(x, 1, 1, drop = TRUE)


Vector aggregate.
Description

This function is somewhat similar to tapply, but is designed for use in conjunction with id. It is simpler in that it only accepts a single grouping vector (use id if you have more) and uses vapply internally, using the .default value as the template.
Usage

vaggregate(.value, .group, .fun, ..., .default = NULL, .n = nlevels(.group))

Arguments
.value 	

vector of values to aggregate
.group 	

grouping vector
.fun 	

aggregation function
... 	

other arguments passed on to .fun
.default 	

default value used for missing groups. This argument is also used as the template for function output.
.n 	

total number of groups
Details

vaggregate should be faster than tapply in most situations because it avoids making a copy of the data.
Examples

# Some examples of use borrowed from ?tapply
n <- 17; fac <- factor(rep(1:3, length.out = n), levels = 1:5)
table(fac)
vaggregate(1:n, fac, sum)
vaggregate(1:n, fac, sum, .default = NA_integer_)
vaggregate(1:n, fac, range)
vaggregate(1:n, fac, range, .default = c(NA, NA) + 0)
vaggregate(1:n, fac, quantile)
# Unlike tapply, vaggregate does not support multi-d output:
tapply(warpbreaks$breaks, warpbreaks[,-1], sum)
vaggregate(warpbreaks$breaks, id(warpbreaks[,-1]), sum)

# But it is about 10x faster
x <- rnorm(1e6)
y1 <- sample.int(10, 1e6, replace = TRUE)
system.time(tapply(x, y1, mean))
system.time(vaggregate(x, y1, mean))



