install.packages("dplyr")
require(dplyr)

my_db <- src_sqlite("e:/my_db.sqlite3", create = T)

bs_sqlite <- copy_to(my_db, BS_table2, temporary = FALSE, )

tbl(my_db, sql("SELECT * FROM BS_table2"))

select(bs_sqlite, close, avg)

filter(bs_sqlite, avg > 3)

arrange(bs_sqlite, open, close, high)  #排序
mutate(bs_sqlite, all_price = open + close + high + low)

summarise(bs_sqlite, mean_price = mean(avg))


c1 <- filter(flights_sqlite, year == 2013, month == 1, day == 1)
c2 <- select(c1, year, month, day, carrier, dep_delay, air_time, distance)
c3 <- mutate(c2, speed = distance / air_time * 60)
c4 <- arrange(c3, year, month, day, carrier)


c1 <- filter(bs_sqlite, avg > 3)
c1
collect(c1)

explain(c1)

> explain(c1)
<SQL>
SELECT *
FROM (SELECT `open`, `high`, `low`, `close`, `vol`, `close1`, `type`, `avg`, `Date`, `close_max_roll_50`, `close_min_roll_50`, `close_mean_roll_50`, `ind_type`, `deltaroll`, `boll_up`, `boll_down`, `open` + `close` + `high` + `low` AS `all_price`
FROM `BS_table2`)
WHERE (`avg` > 3.0)


There are three ways to force the computation of a query:

collect() executes the query and returns the results to R.

compute() executes the query and stores the results in a temporary table in the database.

collapse() turns the query into a table expression.
collapse(c1)



# In SQLite variable names are escaped by double quotes:
translate_sql(x)
#> <SQL> "x"
# And strings are escaped by single quotes
translate_sql("x")
#> <SQL> 'x'

# Many functions have slightly different names
translate_sql(x == 1 && (y < 2 || z > 3))
#> <SQL> "x" = 1.0 AND ("y" < 2.0 OR "z" > 3.0)
translate_sql(x ^ 2 < 10)
#> <SQL> POWER("x", 2.0) < 10.0
translate_sql(x %% 2 == 10)
#> <SQL> "x" % 2.0 = 10.0

# R and SQL have different defaults for integers and reals.
# In R, 1 is a real, and 1L is an integer
# In SQL, 1 is an integer, and 1.0 is a real
translate_sql(1)
#> <SQL> 1.0
translate_sql(1L)
#> <SQL> 1

by_tailnum <- group_by(flights_sqlite, tailnum)
delay <- summarise(by_tailnum,
  count = n(),
  dist = mean(distance),
  delay = mean(arr_delay)
)
delay <- filter(delay, count > 20, dist < 2000)
delay_local <- collect(delay)




library(nycflights13)
dim(flights)
#> [1] 336776     19
head(flights)
#> # A tibble: 6 x 19
#>    year month   day dep_time sched_dep_time dep_delay arr_time
#>   <int> <int> <int>    <int>          <int>     <dbl>    <int>
#> 1  2013     1     1      517            515         2      830
#> 2  2013     1     1      533            529         4      850
#> 3  2013     1     1      542            540         2      923
#> 4  2013     1     1      544            545        -1     1004
#> ... with 2 more rows, and 12 more variables: sched_arr_time <int>,
#>   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
#>   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
#>   minute <dbl>, time_hour <time>
dplyr can work with data frames as is, but if you’re dealing with large data, it’s worthwhile to convert them to a tbl_df: this is a wrapper around a data frame that won’t accidentally print a lot of data to the screen.

Single table verbs

Dplyr aims to provide a function for each basic verb of data manipulation:

filter() (and slice())
arrange()
select() (and rename())
distinct()
mutate() (and transmute())
summarise()
sample_n() (and sample_frac())


filter(flights, month == 1 | month == 2)
To select rows by position, use slice():

slice(flights, 1:10)
#> # A tibble: 10 x 19
#>    year month   day dep_time sched_dep_time dep_delay arr_time
#>   <int> <int> <int>    <int>          <int>     <dbl>    <int>
#> 1  2013     1     1      517            515         2      830
#> 2  2013     1     1      533            529         4      850
#> 3  2013     1     1      542            540         2      923
#> 4  2013     1     1      544            545        -1     1004
#> ... with 6 more rows, and 12 more variables: sched_arr_time <int>,
#>   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
#>   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
#>   minute <dbl>, time_hour <time>



tbl_df_BS<-tbl_df(BS_table2)
filter(tbl_df_BS, avg > 3 | close > 2)

filter(tbl_df_BS, Close > 2)

slice(tbl_df_BS, 10:11)

Arrange rows with arrange()

arrange() works similarly to filter() except that instead of filtering or selecting rows, it reorders them. It takes a data frame, and a set of column names (or more complicated expressions) to order by. If you provide more than one column name, each additional column will be used to break ties in the values of preceding columns:

arrange(flights, year, month, day)

Use desc() to order a column in descending order:

arrange(flights, desc(arr_delay))

# Select columns by name
select(flights, year, month, day)
#> # A tibble: 336,776 x 3
#>    year month   day
#>   <int> <int> <int>
#> 1  2013     1     1
#> 2  2013     1     1
#> 3  2013     1     1
#> 4  2013     1     1
#> ... with 336,772 more rows
# Select all columns between year and day (inclusive)
select(flights, year:day)
#> # A tibble: 336,776 x 3
#>    year month   day
#>   <int> <int> <int>
#> 1  2013     1     1
#> 2  2013     1     1
#> 3  2013     1     1
#> 4  2013     1     1
#> ... with 336,772 more rows
# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))
#> # A tibble: 336,776 x 16
#>   dep_time sched_dep_time dep_delay arr_time sched_arr_time arr_delay
#>      <int>          <int>     <dbl>    <int>          <int>     <dbl>
#> 1      517            515         2      830            819        11
#> 2      533            529         4      850            830        20
#> 3      542            540         2      923            850        33
#> 4      544            545        -1     1004           1022       -18
#> ... with 336,772 more rows, and 10 more variables: carrier <chr>,
#>   flight <int>, tailnum <chr>, origin <chr>, dest <chr>, air_time <dbl>,
#>   distance <dbl>, hour <dbl>, minute <dbl>, time_hour <time>

There are a number of helper functions you can use within select(), like starts_with(), ends_with(), matches() and contains(). These let you quickly match larger blocks of variables that meet some criterion. See ?select for more details.

You can rename variables with select() by using named arguments:

select(flights, tail_num = tailnum)

But because select() drops all the variables not explicitly mentioned, it’s not that useful. Instead, use rename():

rename(flights, tail_num = tailnum)
#> # A tibble: 336,776 x 19
#>    year month   day dep_time sched_dep_time dep_delay arr_time
#>   <int> <int> <int>    <int>          <int>     <dbl>    <int>
#> 1  2013     1     1      517            515         2      830
#> 2  2013     1     1      533            529         4      850
#> 3  2013     1     1      542            540         2      923
#> 4  2013     1     1      544            545        -1     1004
#> ... with 336,772 more rows, and 12 more variables: sched_arr_time <int>,
#>   arr_delay <dbl>, carrier <chr>, flight <int>, tail_num <chr>,
#>   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
#>   minute <dbl>, time_hour <time>

#>   minute <dbl>, time_hour <time>
Extract distinct (unique) rows

Use distinct()to find unique values in a table:

distinct(flights, tailnum)
#> # A tibble: 4,044 x 1
#>   tailnum
#>     <chr>
#> 1  N14228
#> 2  N24211
#> 3  N619AA
#> 4  N804JB
#> ... with 4,040 more rows
distinct(flights, origin, dest)


Add new columns with mutate()

Besides selecting sets of existing columns, it’s often useful to add new columns that are functions of existing columns. This is the job of mutate():

mutate(flights,
  gain = arr_delay - dep_delay,
  speed = distance / air_time * 60)
  
  
  mutate(flights,
  gain = arr_delay - dep_delay,
  gain_per_hour = gain / (air_time / 60)
)


transform(flights,
  gain = arr_delay - delay,
  gain_per_hour = gain / (air_time / 60)
)
#> Error: object 'gain' not found
If you only want to keep the new variables, use transmute():

transmute(flights,
  gain = arr_delay - dep_delay,
  gain_per_hour = gain / (air_time / 60)
)
#> # A tibble: 336,776 x 2
#>    gain gain_per_hour
#>   <dbl>         <dbl>
#> 1     9      2.378855
#> 2    16      4.229075
#> 3    31     11.625000
#> 4   -17     -5.573770
#> ... with 336,772 more rows

Summarise values with summarise()

The last verb is summarise(). It collapses a data frame to a single row (this is exactly equivalent to plyr::summarise()):

summarise(flights,
  delay = mean(dep_delay, na.rm = TRUE))
#> # A tibble: 1 x 1
#>      delay
#>      <dbl>
#> 1 12.63907

Randomly sample rows with sample_n() and sample_frac()

You can use sample_n() and sample_frac() to take a random sample of rows: use sample_n() for a fixed number and sample_frac() for a fixed fraction.

sample_n(flights, 10)
#> # A tibble: 10 x 19
#>    year month   day dep_time sched_dep_time dep_delay arr_time
#>   <int> <int> <int>    <int>          <int>     <dbl>    <int>
#> 1  2013     7     8     2205           2019       106      103
#> 2  2013     9    12     1602           1545        17       NA
#> 3  2013    11     4     1459           1459         0     1642
#> 4  2013    10    25     1354           1350         4     1534
#> ... with 6 more rows, and 12 more variables: sched_arr_time <int>,
#>   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
#>   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
#>   minute <dbl>, time_hour <time>
sample_frac(flights, 0.01)
#> # A tibble: 3,368 x 19
#>    year month   day dep_time sched_dep_time dep_delay arr_time
#>   <int> <int> <int>    <int>          <int>     <dbl>    <int>
#> 1  2013     5    14      850            850         0     1237
#> 2  2013    11     8      832            840        -8     1016
#> 3  2013    12     1     1155           1155         0     1309
#> 4  2013     1     1      929            925         4     1220
#> ... with 3,364 more rows, and 12 more variables: sched_arr_time <int>,
#>   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
#>   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
#>   minute <dbl>, time_hour <time>
Use replace = TRUE to perform a bootstrap sample. If needed, you can weight the sample with the weight argument.

by_tailnum <- group_by(flights, tailnum)
delay <- summarise(by_tailnum,
  count = n(),
  dist = mean(distance, na.rm = TRUE),
  delay = mean(arr_delay, na.rm = TRUE))
delay <- filter(delay, count > 20, dist < 2000)


# Interestingly, the average delay is only slightly related to the
# average distance flown by a plane.
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area()
  
  
  n(): the number of observations in the current group

n_distinct(x):the number of unique values in x.

first(x), last(x) and nth(x, n) - these work similarly to x[1], x[length(x)], and x[n] but give you more control over the result if the value is missing.

For example, we could use these to find the number of planes and the number of flights that go to each possible destination:

destinations <- group_by(flights, dest)
summarise(destinations,
  planes = n_distinct(tailnum),
  flights = n()
)
#> # A tibble: 105 x 3
#>    dest planes flights
#>   <chr>  <int>   <int>
#> 1   ABQ    108     254
#> 2   ACK     58     265
#> 3   ALB    172     439
#> 4   ANC      6       8
#> ... with 101 more rows


When you group by multiple variables, each summary peels off one level of the grouping. That makes it easy to progressively roll-up a dataset:

daily <- group_by(flights, year, month, day)
(per_day   <- summarise(daily, flights = n()))
#> Source: local data frame [365 x 4]
#> Groups: year, month [?]
#> 
#> # A tibble: 365 x 4
#>    year month   day flights
#>   <int> <int> <int>   <int>
#> 1  2013     1     1     842
#> 2  2013     1     2     943
#> 3  2013     1     3     914
#> 4  2013     1     4     915
#> ... with 361 more rows
(per_month <- summarise(per_day, flights = sum(flights)))
#> Source: local data frame [12 x 3]
#> Groups: year [?]
#> 
#> # A tibble: 12 x 3
#>    year month flights
#>   <int> <int>   <int>
#> 1  2013     1   27004
#> 2  2013     2   24951
#> 3  2013     3   28834
#> 4  2013     4   28330
#> ... with 8 more rows
(per_year  <- summarise(per_month, flights = sum(flights)))
#> # A tibble: 1 x 2
#>    year flights
#>   <int>   <int>
#> 1  2013  336776



Chaining

The dplyr API is functional in the sense that function calls don’t have side-effects. You must always save their results. This doesn’t lead to particularly elegant code, especially if you want to do many operations at once. You either have to do it step-by-step:

a1 <- group_by(flights, year, month, day)
a2 <- select(a1, arr_delay, dep_delay)
a3 <- summarise(a2,
  arr = mean(arr_delay, na.rm = TRUE),
  dep = mean(dep_delay, na.rm = TRUE))
a4 <- filter(a3, arr > 30 | dep > 30)


filter(
  summarise(
    select(
      group_by(flights, year, month, day),
      arr_delay, dep_delay
    ),
    arr = mean(arr_delay, na.rm = TRUE),
    dep = mean(dep_delay, na.rm = TRUE)
  ),
  arr > 30 | dep > 30
)
  
  
  
  This is difficult to read because the order of the operations is from inside to out. Thus, the arguments are a long way away from the function. To get around this problem, 
  dplyr provides the %>% operator. x %>% f(y) turns into f(x, y) so you can use it to rewrite multiple operations that you can read left-to-right, top-to-bottom:

flights %>%
  group_by(year, month, day) %>%
  select(arr_delay, dep_delay) %>%
  summarise(
    arr = mean(arr_delay, na.rm = TRUE),
    dep = mean(dep_delay, na.rm = TRUE)
  ) %>%
  filter(arr > 30 | dep > 30)
  
  
  only provides tools for working with data frames (e.g. most of dplyr is equivalent to ddply() + various functions, do() is equivalent to dlply())
  
  Mutating joins

Mutating joins allow you to combine variables from multiple tables. For example, take the nycflights13 data. In one table we have flight information with an abbreviation for carrier, and in another we have a mapping between abbreviations and full names. You can use a join to add the carrier names to the flight data:

library("nycflights13")
# Drop unimportant variables so it's easier to understand the join results.
flights2 <- flights %>% select(year:day, hour, origin, dest, tailnum, carrier)

flights2 %>% 
  left_join(airlines)
#> Joining, by = "carrier"
#> # A tibble: 336,776 x 9
#>    year month   day  hour origin  dest tailnum carrier
#>   <int> <int> <int> <dbl>  <chr> <chr>   <chr>   <chr>
#> 1  2013     1     1     5    EWR   IAH  N14228      UA
#> 2  2013     1     1     5    LGA   IAH  N24211      UA
#> 3  2013     1     1     5    JFK   MIA  N619AA      AA
#> 4  2013     1     1     5    JFK   BQN  N804JB      B6
#> 5  2013     1     1     6    LGA   ATL  N668DN      DL
#> ... with 3.368e+05 more rows, and 1 more variables: name <chr>


flights2 %>% left_join(planes, by = "tailnum")

Two-table verbs

2016-06-23

It’s rare that a data analysis involves only a single table of data. In practice, you’ll normally have many tables that contribute to an analysis, and you need flexible tools to combine them. In dplyr, there are three families of verbs that work with two tables at a time:

Mutating joins, which add new variables to one table from matching rows in another.

Filtering joins, which filter observations from one table based on whether or not they match an observation in the other table.

Set operations, which combine the observations in the data sets as if they were set elements.

(This discussion assumes that you have tidy data, where the rows are observations and the columns are variables. If you’re not familiar with that framework, I’d recommend reading up on it first.)

All two-table verbs work similarly. The first two arguments are x and y, and provide the tables to combine. The output is always a new table with the same type as x.

Mutating joins

Mutating joins allow you to combine variables from multiple tables. For example, take the nycflights13 data. In one table we have flight information with an abbreviation for carrier, and in another we have a mapping between abbreviations and full names. You can use a join to add the carrier names to the flight data:

library("nycflights13")
# Drop unimportant variables so it's easier to understand the join results.
flights2 <- flights %>% select(year:day, hour, origin, dest, tailnum, carrier)

flights2 %>% 
  left_join(airlines)
#> Joining, by = "carrier"
#> # A tibble: 336,776 x 9
#>    year month   day  hour origin  dest tailnum carrier
#>   <int> <int> <int> <dbl>  <chr> <chr>   <chr>   <chr>
#> 1  2013     1     1     5    EWR   IAH  N14228      UA
#> 2  2013     1     1     5    LGA   IAH  N24211      UA
#> 3  2013     1     1     5    JFK   MIA  N619AA      AA
#> 4  2013     1     1     5    JFK   BQN  N804JB      B6
#> 5  2013     1     1     6    LGA   ATL  N668DN      DL
#> ... with 3.368e+05 more rows, and 1 more variables: name <chr>
Controlling how the tables are matched

As well as x and y, each mutating join takes an argument by that controls which variables are used to match observations in the two tables. There are a few ways to specify it, as I illustrate below with various tables from nycflights13:

NULL, the default. dplyr will will use all variables that appear in both tables, a natural join. For example, the flights and weather tables match on their common variables: year, month, day, hour and origin.

flights2 %>% left_join(weather)
#> Joining, by = c("year", "month", "day", "hour", "origin")
#> # A tibble: 336,776 x 18
#>    year month   day  hour origin  dest tailnum carrier  temp  dewp humid
#>   <dbl> <dbl> <int> <dbl>  <chr> <chr>   <chr>   <chr> <dbl> <dbl> <dbl>
#> 1  2013     1     1     5    EWR   IAH  N14228      UA    NA    NA    NA
#> 2  2013     1     1     5    LGA   IAH  N24211      UA    NA    NA    NA
#> 3  2013     1     1     5    JFK   MIA  N619AA      AA    NA    NA    NA
#> 4  2013     1     1     5    JFK   BQN  N804JB      B6    NA    NA    NA
#> 5  2013     1     1     6    LGA   ATL  N668DN      DL 39.92 26.06 57.33
#> ... with 3.368e+05 more rows, and 7 more variables: wind_dir <dbl>,
#>   wind_speed <dbl>, wind_gust <dbl>, precip <dbl>, pressure <dbl>,
#>   visib <dbl>, time_hour <time>
A character vector, by = "x". Like a natural join, but uses only some of the common variables. For example, flights and planes have year columns, but they mean different things so we only want to join by tailnum.

flights2 %>% left_join(planes, by = "tailnum")
#> # A tibble: 336,776 x 16
#>   year.x month   day  hour origin  dest tailnum carrier year.y
#>    <int> <int> <int> <dbl>  <chr> <chr>   <chr>   <chr>  <int>
#> 1   2013     1     1     5    EWR   IAH  N14228      UA   1999
#> 2   2013     1     1     5    LGA   IAH  N24211      UA   1998
#> 3   2013     1     1     5    JFK   MIA  N619AA      AA   1990
#> 4   2013     1     1     5    JFK   BQN  N804JB      B6   2012
#> 5   2013     1     1     6    LGA   ATL  N668DN      DL   1991
#> ... with 3.368e+05 more rows, and 7 more variables: type <chr>,
#>   manufacturer <chr>, model <chr>, engines <int>, seats <int>,
#>   speed <int>, engine <chr>
Note that the year columns in the output are disambiguated with a suffix.

A named character vector: by = c("x" = "a"). This will match variable x in table x to variable a in table b. The variables from use will be used in the output.

Each flight has an origin and destination airport, so we need to specify which one we want to join to:

flights2 %>% left_join(airports, c("dest" = "faa"))
#> # A tibble: 336,776 x 14
#>    year month   day  hour origin  dest tailnum carrier
#>   <int> <int> <int> <dbl>  <chr> <chr>   <chr>   <chr>
#> 1  2013     1     1     5    EWR   IAH  N14228      UA
#> 2  2013     1     1     5    LGA   IAH  N24211      UA
#> 3  2013     1     1     5    JFK   MIA  N619AA      AA
#> 4  2013     1     1     5    JFK   BQN  N804JB      B6
#> 5  2013     1     1     6    LGA   ATL  N668DN      DL
#> ... with 3.368e+05 more rows, and 6 more variables: name <chr>, lat <dbl>,
#>   lon <dbl>, alt <int>, tz <dbl>, dst <chr>
flights2 %>% left_join(airports, c("origin" = "faa"))
#> # A tibble: 336,776 x 14
#>    year month   day  hour origin  dest tailnum carrier                name
#>   <int> <int> <int> <dbl>  <chr> <chr>   <chr>   <chr>               <chr>
#> 1  2013     1     1     5    EWR   IAH  N14228      UA Newark Liberty Intl
#> 2  2013     1     1     5    LGA   IAH  N24211      UA          La Guardia
#> 3  2013     1     1     5    JFK   MIA  N619AA      AA John F Kennedy Intl
#> 4  2013     1     1     5    JFK   BQN  N804JB      B6 John F Kennedy Intl
#> 5  2013     1     1     6    LGA   ATL  N668DN      DL          La Guardia
#> ... with 3.368e+05 more rows, and 5 more variables: lat <dbl>, lon <dbl>,
#>   alt <int>, tz <dbl>, dst <chr>
Types of join

There are four types of mutating join, which differ in their behaviour when a match is not found. We’ll illustrate each with a simple example:

(df1 <- data_frame(x = c(1, 2), y = 2:1))
#> # A tibble: 2 x 2
#>       x     y
#>   <dbl> <int>
#> 1     1     2
#> 2     2     1
(df2 <- data_frame(x = c(1, 3), a = 10, b = "a"))
#> # A tibble: 2 x 3
#>       x     a     b
#>   <dbl> <dbl> <chr>
#> 1     1    10     a
#> 2     3    10     a
inner_join(x, y) only includes observations that match in both x and y.

df1 %>% inner_join(df2) %>% knitr::kable()
#> Joining, by = "x"
x	y	a	b
1	2	10	a
left_join(x, y) includes all observations in x, regardless of whether they match or not. This is the most commonly used join because it ensures that you don’t lose observations from your primary table.

df1 %>% left_join(df2)
#> Joining, by = "x"
#> # A tibble: 2 x 4
#>       x     y     a     b
#>   <dbl> <int> <dbl> <chr>
#> 1     1     2    10     a
#> 2     2     1    NA  <NA>
right_join(x, y) includes all observations in y. It’s equivalent to left_join(y, x), but the columns will be ordered differently.

df1 %>% right_join(df2)
#> Joining, by = "x"
#> # A tibble: 2 x 4
#>       x     y     a     b
#>   <dbl> <int> <dbl> <chr>
#> 1     1     2    10     a
#> 2     3    NA    10     a
df2 %>% left_join(df1)
#> Joining, by = "x"
#> # A tibble: 2 x 4
#>       x     a     b     y
#>   <dbl> <dbl> <chr> <int>
#> 1     1    10     a     2
#> 2     3    10     a    NA
full_join() includes all observations from x and y.

df1 %>% full_join(df2)
#> Joining, by = "x"
#> # A tibble: 3 x 4
#>       x     y     a     b
#>   <dbl> <int> <dbl> <chr>
#> 1     1     2    10     a
#> 2     2     1    NA  <NA>
#> 3     3    NA    10     a
The left, right and full joins are collectively know as outer joins. When a row doesn’t match in an outer join, the new variables are filled in with missing values.

Observations

While mutating joins are primarily used to add new variables, they can also generate new observations. If a match is not unique, a join will add all possible combinations (the Cartesian product) of the matching observations:

df1 <- data_frame(x = c(1, 1, 2), y = 1:3)
df2 <- data_frame(x = c(1, 1, 2), z = c("a", "b", "a"))

df1 %>% left_join(df2)
#> Joining, by = "x"
#> # A tibble: 5 x 3
#>       x     y     z
#>   <dbl> <int> <chr>
#> 1     1     1     a
#> 2     1     1     b
#> 3     1     2     a
#> 4     1     2     b
#> 5     2     3     a
Filtering joins

Filtering joins match obserations in the same way as mutating joins, but affect the observations, not the variables. There are two types:

semi_join(x, y) keeps all observations in x that have a match in y.
anti_join(x, y) drops all observations in x that have a match in y.
These are most useful for diagnosing join mismatches. For example, there are many flights in the nycflights13 dataset that don’t have a matching tail number in the planes table:

library("nycflights13")
flights %>% 
  anti_join(planes, by = "tailnum") %>% 
  count(tailnum, sort = TRUE)
#> # A tibble: 722 x 2
#>   tailnum     n
#>     <chr> <int>
#> 1    <NA>  2512
#> 2  N725MQ   575
#> 3  N722MQ   513
#> 4  N723MQ   507
#> 5  N713MQ   483
#> ... with 717 more rows
If you’re worried about what observations your joins will match, start with a semi_join() or anti_join(). semi_join() and anti_join() never duplicate; they only ever remove observations.

df1 <- data_frame(x = c(1, 1, 3, 4), y = 1:4)
df2 <- data_frame(x = c(1, 1, 2), z = c("a", "b", "a"))

# Four rows to start with:
df1 %>% nrow()
#> [1] 4
# And we get four rows after the join
df1 %>% inner_join(df2, by = "x") %>% nrow()
#> [1] 4
# But only two rows actually match
df1 %>% semi_join(df2, by = "x") %>% nrow()
#> [1] 2
Set operations

The final type of two-table verb is set operations. These expect the x and y inputs to have the same variables, and treat the observations like sets:

intersect(x, y): return only observations in both x and y
union(x, y): return unique observations in x and y
setdiff(x, y): return observations in x, but not in y.
Given this simple data:

(df1 <- data_frame(x = 1:2, y = c(1L, 1L)))
#> # A tibble: 2 x 2
#>       x     y
#>   <int> <int>
#> 1     1     1
#> 2     2     1
(df2 <- data_frame(x = 1:2, y = 1:2))
#> # A tibble: 2 x 2
#>       x     y
#>   <int> <int>
#> 1     1     1
#> 2     2     2
The four possibilities are:

intersect(df1, df2)
#> # A tibble: 1 x 2
#>       x     y
#>   <int> <int>
#> 1     1     1
# Note that we get 3 rows, not 4
union(df1, df2)
#> # A tibble: 3 x 2
#>       x     y
#>   <int> <int>
#> 1     2     2
#> 2     2     1
#> 3     1     1
setdiff(df1, df2)
#> # A tibble: 1 x 2
#>       x     y
#>   <int> <int>
#> 1     2     1
setdiff(df2, df1)
#> # A tibble: 1 x 2
#>       x     y
#>   <int> <int>
#> 1     2     2
Databases

Each two-table verb has a straightforward SQL equivalent:

R	SQL
inner_join()	SELECT * FROM x JOIN y ON x.a = y.a
left_join()	SELECT * FROM x LEFT JOIN y ON x.a = y.a
right_join()	SELECT * FROM x RIGHT JOIN y ON x.a = y.a
full_join()	SELECT * FROM x FULL JOIN y ON x.a = y.a
semi_join()	SELECT * FROM x WHERE EXISTS (SELECT 1 FROM y WHERE x.a = y.a)
anti_join()	SELECT * FROM x WHERE NOT EXISTS (SELECT 1 FROM y WHERE x.a = y.a)
intersect(x, y)	SELECT * FROM x INTERSECT SELECT * FROM y
union(x, y)	SELECT * FROM x UNION SELECT * FROM y
setdiff(x, y)	SELECT * FROM x EXCEPT SELECT * FROM y
x and y don’t have to be tables in the same database. If you specify copy = TRUE, dplyr will copy the y table into the same location as the x variable. This is useful if you’ve downloaded a summarised dataset and determined a subset of interest that you now want the full data for. You can use semi_join(x, y, copy = TRUE) to upload the indices of interest to a temporary table in the same database as x, and then perform a efficient semi join in the database.

If you’re working with large data, it maybe also be helpful to set auto_index = TRUE. That will automatically add an index on the join variables to the temporary table.

Coercion rules

When joining tables, dplyr is a little more conservative than base R about the types of variable that it considers equivalent. This is mostly likely to surprise if you’re working factors:

Factors with different levels are coerced to character with a warning:

df1 <- data_frame(x = 1, y = factor("a"))
df2 <- data_frame(x = 2, y = factor("b"))
full_join(df1, df2) %>% str()
#> Joining, by = c("x", "y")
#> Warning in full_join_impl(x, y, by$x, by$y, suffix$x, suffix$y): joining
#> factors with different levels, coercing to character vector
#> Classes 'tbl_df', 'tbl' and 'data.frame':    2 obs. of  2 variables:
#>  $ x: num  1 2
#>  $ y: chr  "a" "b"
Factors with the same levels in a different order are coerced to character with a warning:

df1 <- data_frame(x = 1, y = factor("a", levels = c("a", "b")))
df2 <- data_frame(x = 2, y = factor("b", levels = c("b", "a")))
full_join(df1, df2) %>% str()
#> Joining, by = c("x", "y")
#> Warning in full_join_impl(x, y, by$x, by$y, suffix$x, suffix$y): joining
#> factors with different levels, coercing to character vector
#> Classes 'tbl_df', 'tbl' and 'data.frame':    2 obs. of  2 variables:
#>  $ x: num  1 2
#>  $ y: chr  "a" "b"
Factors are preserved only if the levels match exactly:

df1 <- data_frame(x = 1, y = factor("a", levels = c("a", "b")))
df2 <- data_frame(x = 2, y = factor("b", levels = c("a", "b")))
full_join(df1, df2) %>% str()
#> Joining, by = c("x", "y")
#> Classes 'tbl_df', 'tbl' and 'data.frame':    2 obs. of  2 variables:
#>  $ x: num  1 2
#>  $ y: Factor w/ 2 levels "a","b": 1 2
A factor and a character are coerced to character with a warning:

df1 <- data_frame(x = 1, y = "a")
df2 <- data_frame(x = 2, y = factor("a"))
full_join(df1, df2) %>% str()
#> Joining, by = c("x", "y")
#> Warning in full_join_impl(x, y, by$x, by$y, suffix$x, suffix$y): joining
#> factor and character vector, coercing into character vector
#> Classes 'tbl_df', 'tbl' and 'data.frame':    2 obs. of  2 variables:
#>  $ x: num  1 2
#>  $ y: chr  "a" "a"
Otherwise logicals will be silently upcast to integer, and integer to numeric, but coercing to character will raise an error:

df1 <- data_frame(x = 1, y = 1L)
df2 <- data_frame(x = 2, y = 1.5)
full_join(df1, df2) %>% str()
#> Joining, by = c("x", "y")
#> Classes 'tbl_df', 'tbl' and 'data.frame':    2 obs. of  2 variables:
#>  $ x: num  1 2
#>  $ y: num  1 1.5

df1 <- data_frame(x = 1, y = 1L)
df2 <- data_frame(x = 2, y = "a")
full_join(df1, df2) %>% str()
#> Joining, by = c("x", "y")
#> Error in eval(expr, envir, enclos): Can't join on 'y' x 'y' because of incompatible types (character / integer)
Multiple-table verbs

dplyr does not provide any functions for working with three or more tables. Instead use Reduce(), as described in Advanced R, to iteratively combine the two-table verbs to handle as many tables as you need.




Window functions and grouped mutate/filter

2016-06-23

A window function is a variation on an aggregation function. Where an aggregation function, like sum() and mean(), takes n inputs and return a single value, a window function returns n values. The output of a window function depends on all its input values, so window functions don’t include functions that work element-wise, like + or round(). Window functions include variations on aggregate functions, like cumsum() and cummean(), functions for ranking and ordering, like rank(), and functions for taking offsets, like lead() and lag().

Window functions are used in conjunction with mutate and filter to solve a wide range of problems, some of which are shown below:

library(Lahman)
batting <- select(tbl_df(Batting), playerID, yearID, teamID, G, AB:H) 
batting <- arrange(batting, playerID, yearID, teamID)
players <- group_by(batting, playerID)

# For each player, find the two years with most hits
filter(players, min_rank(desc(H)) <= 2 & H > 0)
# Within each player, rank each year by the number of games played
mutate(players, G_rank = min_rank(G))

# For each player, find every year that was better than the previous year
filter(players, G > lag(G))
# For each player, compute avg change in games played per year
mutate(players, G_change = (G - lag(G)) / (yearID - lag(yearID)))

# For each player, find all where they played more games than average
filter(players, G > mean(G))
# For each, player compute a z score based on number of games played
mutate(players, G_z = (G - mean(G)) / sd(G))
This vignette is broken down into two sections. First you’ll learn about the five families of window functions in R, and what you can use them for. If you’re only working with local data sources, you can stop there. Otherwise, continue on to learn about window functions in SQL. They are relatively new, but are supported by Postgres, Amazon’s Redshift and Google’s bigquery. The window functions themselves are basically the same (modulo a few name conflicts), but their specification is a little different. I’ll briefly review how they work, and then show how dplyr translates their R equivalents to SQL.

Before reading this vignette, you should be familiar with mutate() and filter(). If you want to use window functions with SQL databases, you should also be familiar with the basics of dplyr’s SQL translation.

Types of window functions

There are five main families of window functions. Two families are unrelated to aggregation functions:

Ranking and ordering functions: row_number(), min_rank (RANK in SQL), dense_rank(), cume_dist(), percent_rank(), and ntile(). These functions all take a vector to order by, and return various types of ranks.

Offsets lead() and lag() allow you to access the previous and next values in a vector, making it easy to compute differences and trends.

The other three families are variations on familiar aggregate functions:

Cumulative aggregates: cumsum(), cummin(), cummax() (from base R), and cumall(), cumany(), and cummean() (from dplyr).

Rolling aggregates operate in a fixed width window. You won’t find them in base R or in dplyr, but there are many implementations in other packages, such as RcppRoll.

Recycled aggregates, where an aggregate is repeated to match the length of the input. These are not needed in R because vector recycling automatically recycles aggregates where needed. They are important in SQL, because the presence of an aggregation function usually tells the database to return only one row per group.

Each family is described in more detail below, focussing on the general goals and how to use them with dplyr. For more details, refer to the individual function documentation.

Ranking functions

The ranking functions are variations on a theme, differing in how they handle ties:

x <- c(1, 1, 2, 2, 2)

row_number(x)
#> [1] 1 2 3 4 5
min_rank(x)
#> [1] 1 1 3 3 3
dense_rank(x)
#> [1] 1 1 2 2 2
If you’re familiar with R, you may recognise that row_number() and min_rank() can be computed with the base rank() function and various values of the ties.method argument. These functions are provided to save a little typing, and to make it easier to convert between R and SQL.

Two other ranking functions return numbers between 0 and 1. percent_rank() gives the percentage of the rank; cume_dist() gives the proportion of values less than or equal to the current value.

cume_dist(x)
#> [1] 0.4 0.4 1.0 1.0 1.0
percent_rank(x)
#> [1] 0.0 0.0 0.5 0.5 0.5
These are useful if you want to select (for example) the top 10% of records within each group. For example:

# Selects best two years
filter(players, min_rank(desc(G)) < 2)

# Selects best 10% of years
filter(players, cume_dist(desc(G)) < 0.1)
Finally, ntile() divides the data up into n evenly sized buckets. It’s a coarse ranking, and it can be used in with mutate() to divide the data into buckets for further summary. For example, we could use ntile() to divide the players within a team into four ranked groups, and calculate the average number of games within each group.

by_team_player <- group_by(batting, teamID, playerID)
by_team <- summarise(by_team_player, G = sum(G))
by_team_quartile <- group_by(by_team, quartile = ntile(G, 4))
summarise(by_team_quartile, mean(G))
#> # A tibble: 4 x 2
#>   quartile    mean(G)
#>      <int>      <dbl>
#> 1        1   5.326246
#> 2        2  24.698241
#> 3        3  76.878375
#> 4        4 372.300738
All ranking functions rank from lowest to highest so that small input values get small ranks. Use desc() to rank from highest to lowest.

Lead and lag

lead() and lag() produce offset versions of a input vector that is either ahead of or behind the original vector.

x <- 1:5
lead(x)
#> [1]  2  3  4  5 NA
lag(x)
#> [1] NA  1  2  3  4
You can use them to:

Compute differences or percent changes.

# Compute the relative change in games played
mutate(players, G_delta = G - lag(G))
Using lag() is more convenient than diff() because for n inputs diff() returns n - 1 outputs.

Find out when a value changes.

# Find when a player changed teams
filter(players, teamID != lag(teamID))
lead() and lag() have an optional argument order_by. If set, instead of using the row order to determine which value comes before another, they will use another variable. This important if you have not already sorted the data, or you want to sort one way and lag another.

Here’s a simple example of what happens if you don’t specify order_by when you need it:

df <- data.frame(year = 2000:2005, value = (0:5) ^ 2)
scrambled <- df[sample(nrow(df)), ]

wrong <- mutate(scrambled, running = cumsum(value))
arrange(wrong, year)
#>   year value running
#> 1 2000     0       0
#> 2 2001     1      55
#> 3 2002     4      29
#> 4 2003     9      54
#> 5 2004    16      45
#> 6 2005    25      25

right <- mutate(scrambled, running = order_by(year, cumsum(value)))
arrange(right, year)
#>   year value running
#> 1 2000     0       0
#> 2 2001     1       1
#> 3 2002     4       5
#> 4 2003     9      14
#> 5 2004    16      30
#> 6 2005    25      55
Cumulative aggregates

Base R provides cumulative sum (cumsum()), cumulative min (cummin()) and cumulative max (cummax()). (It also provides cumprod() but that is rarely useful). Other common accumulating functions are cumany() and cumall(), cumulative versions of || and &&, and cummean(), a cumulative mean. These are not included in base R, but efficient versions are provided by dplyr.

cumany() and cumall() are useful for selecting all rows up to, or all rows after, a condition is true for the first (or last) time. For example, we can use cumany() to find all records for a player after they played a year with 150 games:

filter(players, cumany(G > 150))
Like lead and lag, you may want to control the order in which the accumulation occurs. None of the built in functions have an order_by argument so dplyr provides a helper: order_by(). You give it the variable you want to order by, and then the call to the window function:

x <- 1:10
y <- 10:1
order_by(y, cumsum(x))
#>  [1] 55 54 52 49 45 40 34 27 19 10
This function uses a bit of non-standard evaluation, so I wouldn’t recommend using it inside another function; use the simpler but less concise with_order() instead.

Recycled aggregates

R’s vector recycling make it easy to select values that are higher or lower than a summary. I call this a recycled aggregate because the value of the aggregate is recycled to be the same length as the original vector. Recycled aggregates are useful if you want to find all records greater than the mean or less than the median:

filter(players, G > mean(G))
filter(players, G < median(G))
While most SQL databases don’t have an equivalent of median() or quantile(), when filtering you can achieve the same effect with ntile(). For example, x > median(x) is equivalent to ntile(x, 2) == 2; x > quantile(x, 75) is equivalent to ntile(x, 100) > 75 or ntile(x, 4) > 3.

filter(players, ntile(G, 2) == 2)
You can also use this idea to select the records with the highest (x == max(x)) or lowest value (x == min(x)) for a field, but the ranking functions give you more control over ties, and allow you to select any number of records.

Recycled aggregates are also useful in conjunction with mutate(). For example, with the batting data, we could compute the “career year”, the number of years a player has played since they entered the league:

mutate(players, career_year = yearID - min(yearID) + 1)
#> # A tibble: 99,846 x 8
#>    playerID yearID teamID     G    AB     R     H career_year
#>       <chr>  <int> <fctr> <int> <int> <int> <int>       <dbl>
#> 1 aardsda01   2004    SFN    11     0     0     0           1
#> 2 aardsda01   2006    CHN    45     2     0     0           3
#> 3 aardsda01   2007    CHA    25     0     0     0           4
#> 4 aardsda01   2008    BOS    47     1     0     0           5
#> ... with 99,842 more rows
Or, as in the introductory example, we could compute a z-score:

mutate(players, G_z = (G - mean(G)) / sd(G))
#> # A tibble: 99,846 x 8
#>    playerID yearID teamID     G    AB     R     H        G_z
#>       <chr>  <int> <fctr> <int> <int> <int> <int>      <dbl>
#> 1 aardsda01   2004    SFN    11     0     0     0 -1.1167685
#> 2 aardsda01   2006    CHN    45     2     0     0  0.3297126
#> 3 aardsda01   2007    CHA    25     0     0     0 -0.5211586
#> 4 aardsda01   2008    BOS    47     1     0     0  0.4147997
#> ... with 99,842 more rows
Window functions in SQL

Window functions have a slightly different flavour in SQL. The syntax is a little different, and the cumulative, rolling and recycled aggregate functions are all based on the simple aggregate function. The goal in this section is not to tell you everything you need to know about window functions in SQL, but to remind you of the basics and show you how dplyr translates your R expressions in to SQL.

Structure of a window function in SQL

In SQL, window functions have the form [expression] OVER ([partition clause] [order clause] [frame_clause]):

The expression is a combination of variable names and window functions. Support for window functions varies from database to database, but most support the ranking functions, lead, lag, nth, first, last, count, min, max, sum, avg and stddev. dplyr generates this from the R expression in your mutate or filter call.

The partition clause specifies how the window function is broken down over groups. It plays an analogous role to GROUP BY for aggregate functions, and group_by() in dplyr. It is possible for different window functions to be partitioned into different groups, but not all databases support it, and neither does dplyr.

The order clause controls the ordering (when it makes a difference). This is important for the ranking functions since it specifies which variables to rank by, but it’s also needed for cumulative functions and lead. Whenever you’re thinking about before and after in SQL, you must always tell it which variable defines the order. In dplyr you do this with arrange(). If the order clause is missing when needed, some databases fail with an error message while others return non-deterministic results.

The frame clause defines which rows, or frame, that are passed to the window function, describing which rows (relative to the current row) should be included. The frame clause provides two offsets which determine the start and end of frame. There are three special values: -Inf means to include all preceeding rows (in SQL, “unbounded preceding”), 0 means the current row (“current row”), and Inf means all following rows (“unbounded following)”. The complete set of options is comprehensive, but fairly confusing, and is summarised visually below.

A visual summary of frame options
A visual summary of frame options

Of the many possible specifications, there are only three that commonly used. They select between aggregation variants:

Recycled: BETWEEN UNBOUND PRECEEDING AND UNBOUND FOLLOWING

Cumulative: BETWEEN UNBOUND PRECEEDING AND CURRENT ROW

Rolling: BETWEEN 2 PRECEEDING AND 2 FOLLOWING

dplyr generates the frame clause based on whether your using a recycled aggregate or a cumulative aggregate.

It’s easiest to understand these specifications by looking at a few examples. Simple examples just need the partition and order clauses:

Rank each year within a player by number of home runs: RANK() OVER (PARTITION BY playerID ORDER BY desc(H))

Compute change in number of games from one year to the next: G - LAG(G) OVER (PARTITION G playerID ORDER BY yearID)

Aggregate variants are more verbose because we also need to supply the frame clause:

Running sum of G for each player: SUM(G) OVER (PARTITION BY playerID ORDER BY yearID BETWEEN UNBOUND PRECEEDING AND CURRENT ROW)

Compute the career year: YearID - min(YearID) OVER (PARTITION BY playerID BETWEEN UNBOUND PRECEEDING AND UNBOUND FOLLOWING) + 1

Compute a rolling average of games player: MEAN(G) OVER (PARTITION BY playerID ORDER BY yearID BETWEEN 2 PRECEEDING AND 2 FOLLOWING)

You’ll notice that window functions in SQL are more verbose than in R. This is because different window functions can have different partitions, and the frame specification is more general than the two aggregate variants (recycled and cumulative) provided by dplyr. dplyr makes a tradeoff: you can’t access rarely used window function capabilities (unless you write raw SQL), but in return, common operations are much more succinct.

Translating dplyr to SQL

To see how individual window functions are translated to SQL, we can use translate_sql() with the argument window = TRUE.

if (has_lahman("postgres")) {
  players_db <- group_by(tbl(lahman_postgres(), "Batting"), playerID)
  
  print(translate_sql(mean(G), tbl = players_db, window = TRUE))
  print(translate_sql(cummean(G), tbl = players_db, window = TRUE))
  print(translate_sql(rank(G), tbl = players_db, window = TRUE))
  print(translate_sql(ntile(G, 2), tbl = players_db, window = TRUE))
  print(translate_sql(lag(G), tbl = players_db, window = TRUE))
}
If the tbl has been arranged previously, then that ordering will be used for the order clause:

if (has_lahman("postgres")) {
  players_by_year <- arrange(players_db, yearID)
  print(translate_sql(cummean(G), tbl = players_by_year, window = TRUE))
  print(translate_sql(rank(), tbl = players_by_year, window = TRUE))
  print(translate_sql(lag(G), tbl = players_by_year, window = TRUE))
}
There are some challenges when translating window functions between R and SQL, because dplyr tries to keep the window functions as similar as possible to both the existing R analogues and to the SQL functions. This means that there are three ways to control the order clause depending on which window function you’re using:

For ranking functions, the ordering variable is the first argument: rank(x), ntile(y, 2). If omitted or NULL, will use the default ordering associated with the tbl (as set by arrange()).

Accumulating aggegates only take a single argument (the vector to aggregate). To control ordering, use order_by().

Aggregates implemented in dplyr (lead, lag, nth_value, first_value, last_value) have an order_by argument. Supply it to override the default ordering.

The three options are illustrated in the snippet below:

mutate(players,
  min_rank(yearID),
  order_by(yearID, cumsum(G)),
  lead(order_by = yearID, G)
)
Currently there is no way to order by multiple variables, except by setting the default ordering with arrange(). This will be added in a future release.

Translating filters based on window functions

There are some restrictions on window functions in SQL that make their use with WHERE somewhat challenging. Take this simple example, where we want to find the year each player played the most games:

filter(players, rank(G) == 1)
The following straightforward translation does not work because window functions are only allowed in SELECT and ORDER_BY.

SELECT *
FROM Batting
WHERE rank() OVER (PARTITION BY "playerID" ORDER BY "G") = 1;
Computing the window function in SELECT and referring to it in WHERE or HAVING doesn’t work either, because WHERE and HAVING are computed before windowing functions.

SELECT *, rank() OVER (PARTITION BY "playerID" ORDER BY "G") as rank
FROM Batting
WHERE rank = 1;

SELECT *, rank() OVER (PARTITION BY "playerID" ORDER BY "G") as rank
FROM Batting
HAVING rank = 1;
Instead, we must use a subquery:

SELECT *
FROM (
  SELECT *, rank() OVER (PARTITION BY "playerID" ORDER BY "G") as rank
  FROM Batting
) tmp
WHERE rank = 1;
And even that query is a slightly simplification because it will also add a rank column to the original columns. dplyr takes care of generating the full, verbose, query, so you can focus on your data analysis challenges.


  