Do more with dates and times in R with lubridate 1.3.0

note: This vignette is an updated version of the blog post first published at r-statistics

Lubridate is an R package that makes it easier to work with dates and times. Below is a concise tour of some of the things lubridate can do for you.

Lubridate was created by Garrett Grolemund and Hadley Wickham.

Parsing dates and times

Getting R to agree that your data contains the dates and times you think it does can be tricky. Lubridate simplifies that. Identify the order in which the year, month, and day appears in your dates. Now arrange “y”, “m”, and “d” in the same order. This is the name of the function in lubridate that will parse your dates. For example,

library(lubridate)
## 
## Attaching package: 'lubridate'
## The following object is masked from 'package:base':
## 
##     date
ymd("20110604")
## [1] "2011-06-04"
mdy("06-04-2011")
## [1] "2011-06-04"
dmy("04/06/2011")
## [1] "2011-06-04"
Lubridate's parse functions handle a wide variety of formats and separators, which simplifies the parsing process.

If your date includes time information, add h, m, and/or s to the name of the function. ymd_hms is probably the most common date time format. To read the dates in with a certain time zone, supply the official name of that time zone in the tz argument.

arrive <- ymd_hms("2011-06-04 12:00:00", tz = "Pacific/Auckland")
arrive
## [1] "2011-06-04 12:00:00 NZST"
leave <- ymd_hms("2011-08-10 14:00:00", tz = "Pacific/Auckland")
leave
## [1] "2011-08-10 14:00:00 NZST"
Setting and Extracting information

Extract information from date times with the functions second, minute, hour, day, wday, yday, week, month, year, and tz. You can also use each of these to set (i.e, change) the given information. Notice that this will alter the date time. wday and month have an optional label argument, which replaces their numeric output with the name of the weekday or month.

second(arrive)
## [1] 0
second(arrive) <- 25
arrive
## [1] "2011-06-04 12:00:25 NZST"
second(arrive) <- 0

wday(arrive)
## [1] 7
wday(arrive, label = TRUE)
## [1] Sat
## Levels: Sun < Mon < Tues < Wed < Thurs < Fri < Sat
Time Zones

There are two very useful things to do with dates and time zones. First, display the same moment in a different time zone. Second, create a new moment by combining an existing clock time with a new time zone. These are accomplished by with_tz and force_tz.

For example, a while ago I was in Auckland, New Zealand. I arranged to meet the co-author of lubridate, Hadley, over skype at 9:00 in the morning Auckland time. What time was that for Hadley who was back in Houston, TX?

meeting <- ymd_hms("2011-07-01 09:00:00", tz = "Pacific/Auckland")
with_tz(meeting, "America/Chicago")
## [1] "2011-06-30 16:00:00 CDT"
So the meetings occurred at 4:00 Hadley's time (and the day before no less). Of course, this was the same actual moment of time as 9:00 in New Zealand. It just appears to be a different day due to the curvature of the Earth.

What if Hadley made a mistake and signed on at 9:00 his time? What time would it then be my time?

mistake <- force_tz(meeting, "America/Chicago")
with_tz(mistake, "Pacific/Auckland")
## [1] "2011-07-02 02:00:00 NZST"
His call would arrive at 2:00 am my time! Luckily he never did that.

Time Intervals

You can save an interval of time as an Interval class object with lubridate. This is quite useful! For example, my stay in Auckland lasted from June 4, 2011 to August 10, 2011 (which we've already saved as arrive and leave). We can create this interval in one of two ways:

auckland <- interval(arrive, leave) 
auckland
## [1] 2011-06-04 12:00:00 NZST--2011-08-10 14:00:00 NZST
auckland <- arrive %--% leave
auckland
## [1] 2011-06-04 12:00:00 NZST--2011-08-10 14:00:00 NZST
My mentor at the University of Auckland, Chris, traveled to various conferences that year including the Joint Statistical Meetings (JSM). This took him out of the country from July 20 until the end of August.

jsm <- interval(ymd(20110720, tz = "Pacific/Auckland"), ymd(20110831, tz = "Pacific/Auckland"))
jsm
## [1] 2011-07-20 NZST--2011-08-31 NZST
Will my visit overlap with and his travels? Yes.

int_overlaps(jsm, auckland)
## [1] TRUE
Then I better make hay while the sun shines! For what part of my visit will Chris be there?

setdiff(auckland, jsm)
## [1] 2011-06-04 12:00:00 NZST--2011-07-20 NZST
Other functions that work with intervals include int_start, int_end, int_flip, int_shift, int_aligns, union, intersect, setdiff, and %within%.

Arithmetic with date times

Intervals are specific time spans (because they are tied to specific dates), but lubridate also supplies two general time span classes: Durations and Periods. Helper functions for creating periods are named after the units of time (plural). Helper functions for creating durations follow the same format but begin with a “d” (for duration) or, if you prefer, and “e” (for exact).

minutes(2) ## period
## [1] "2M 0S"
dminutes(2) ## duration
## [1] "120s (~2 minutes)"
Why two classes? Because the timeline is not as reliable as the number line. The Duration class will always supply mathematically precise results. A duration year will always equal 365 days. Periods, on the other hand, fluctuate the same way the timeline does to give intuitive results. This makes them useful for modeling clock times. For example, durations will be honest in the face of a leap year, but periods may return what you want:

leap_year(2011) ## regular year
## [1] FALSE
ymd(20110101) + dyears(1)
## [1] "2012-01-01"
ymd(20110101) + years(1)
## [1] "2012-01-01"
leap_year(2012) ## leap year
## [1] TRUE
ymd(20120101) + dyears(1)
## [1] "2012-12-31"
ymd(20120101) + years(1)
## [1] "2013-01-01"
You can use periods and durations to do basic arithmetic with date times. For example, if I wanted to set up a reoccuring weekly skype meeting with Hadley, it would occur on:

meetings <- meeting + weeks(0:5)
Hadley travelled to conferences at the same time as Chris. Which of these meetings would be affected? The last two.

meetings %within% jsm
## [1] FALSE FALSE FALSE  TRUE  TRUE  TRUE
How long was my stay in Auckland?

auckland / ddays(1)
## [1] 67.08333
auckland / ddays(2)
## [1] 33.54167
auckland / dminutes(1)
## [1] 96600
And so on. Alternatively, we can do modulo and integer division. Sometimes this is more sensible than division - it is not obvious how to express a remainder as a fraction of a month because the length of a month constantly changes.

auckland %/% months(1)
## Note: method with signature 'Timespan#Timespan' chosen for function '%/%',
##  target signature 'Interval#Period'.
##  "Interval#ANY", "ANY#Period" would also be valid
## [1] 2
auckland %% months(1)
## [1] 2011-08-04 12:00:00 NZST--2011-08-10 14:00:00 NZST
Modulo with an timespan returns the remainder as a new (smaller) interval. You can turn this or any interval into a generalized time span with as.period.

as.period(auckland %% months(1))
## [1] "6d 2H 0M 0S"
as.period(auckland)
## [1] "2m 6d 2H 0M 0S"
If anyone drove a time machine, they would crash

The length of months and years change so often that doing arithmetic with them can be unintuitive. Consider a simple operation, January 31st + one month. Should the answer be

February 31st (which doesn't exist)
March 4th (31 days after January 31), or
February 28th (assuming its not a leap year)
A basic property of arithmetic is that a + b - b = a. Only solution 1 obeys this property, but it is an invalid date. I've tried to make lubridate as consistent as possible by invoking the following rule if adding or subtracting a month or a year creates an invalid date, lubridate will return an NA. This is new with version 1.3.0, so if you're an old hand with lubridate be sure to remember this!

If you thought solution 2 or 3 was more useful, no problem. You can still get those results with clever arithmetic, or by using the special %m+% and %m-% operators. %m+% and %m-% automatically roll dates back to the last day of the month, should that be necessary.

jan31 <- ymd("2013-01-31")
jan31 + months(0:11)
##  [1] "2013-01-31" NA           "2013-03-31" NA           "2013-05-31"
##  [6] NA           "2013-07-31" "2013-08-31" NA           "2013-10-31"
## [11] NA           "2013-12-31"
floor_date(jan31, "month") + months(0:11) + days(31)
##  [1] "2013-02-01" "2013-03-04" "2013-04-01" "2013-05-02" "2013-06-01"
##  [6] "2013-07-02" "2013-08-01" "2013-09-01" "2013-10-02" "2013-11-01"
## [11] "2013-12-02" "2014-01-01"
jan31 %m+% months(0:11)
##  [1] "2013-01-31" "2013-02-28" "2013-03-31" "2013-04-30" "2013-05-31"
##  [6] "2013-06-30" "2013-07-31" "2013-08-31" "2013-09-30" "2013-10-31"
## [11] "2013-11-30" "2013-12-31"
Notice that this will only affect arithmetic with months (and arithmetic with years if your start date it Feb 29).

Vectorization

The code in lubridate is vectorized and ready to be used in both interactive settings and within functions. As an example, I offer a function for advancing a date to the last day of the month

last_day <- function(date) {
  ceiling_date(date, "month") - days(1)
}
Further Resources

To learn more about lubridate, including the specifics of periods and durations, please read the original lubridate paper. Questions about lubridate can be addressed to the lubridate google group. Bugs and feature requests should be submitted to the lubridate development page on github.
############################################################

Introduction to stringr

2016-08-19

Strings are not glamorous, high-profile components of R, but they do play a big role in many data cleaning and preparations tasks. R provides a solid set of string operations, but because they have grown organically over time, they can be inconsistent and a little hard to learn. Additionally, they lag behind the string operations in other programming languages, so that some things that are easy to do in languages like Ruby or Python are rather hard to do in R. The stringr package aims to remedy these problems by providing a clean, modern interface to common string operations.

More concretely, stringr:

Simplifies string operations by eliminating options that you don’t need 95% of the time (the other 5% of the time you can functions from base R or stringi).

Uses consistent function names and arguments.

Produces outputs than can easily be used as inputs. This includes ensuring that missing inputs result in missing outputs, and zero length inputs result in zero length outputs. It also processes factors and character vectors in the same way.

Completes R’s string handling functions with useful functions from other programming languages.

To meet these goals, stringr provides two basic families of functions:

basic string operations, and

pattern matching functions which use regular expressions to detect, locate, match, replace, extract, and split strings.

As of version 1.0, stringr is a thin wrapper around stringi, which implements all the functions in stringr with efficient C code based on the ICU library. Compared to stringi, stringr is considerably simpler: it provides fewer options and fewer functions. This is great when you’re getting started learning string functions, and if you do need more of stringi’s power, you should find the interface similar.

These are described in more detail in the following sections.

Basic string operations

There are three string functions that are closely related to their base R equivalents, but with a few enhancements:

str_c() is equivalent to paste(), but it uses the empty string (“”) as the default separator and silently removes NULL inputs.

str_length() is equivalent to nchar(), but it preserves NA’s (rather than giving them length 2) and converts factors to characters (not integers).

str_sub() is equivalent to substr() but it returns a zero length vector if any of its inputs are zero length, and otherwise expands each argument to match the longest. It also accepts negative positions, which are calculated from the left of the last character. The end position defaults to -1, which corresponds to the last character.

str_sub<- is equivalent to substr<-, but like str_sub it understands negative indices, and replacement strings not do need to be the same length as the string they are replacing.

Three functions add new functionality:

str_dup() to duplicate the characters within a string.

str_trim() to remove leading and trailing whitespace.

str_pad() to pad a string with extra whitespace on the left, right, or both sides.

Pattern matching

stringr provides pattern matching functions to detect, locate, extract, match, replace, and split strings. I’ll illustrate how they work with some strings and a regular expression designed to match (US) phone numbers:

strings <- c(
  "apple", 
  "219 733 8965", 
  "329-293-8753", 
  "Work: 579-499-7527; Home: 543.355.3679"
)
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
str_detect() detects the presence or absence of a pattern and returns a logical vector (similar to grepl()). str_subset() returns the elements of a character vector that match a regular expression (similar to grep() with value = TRUE)`.

# Which strings contain phone numbers?
str_detect(strings, phone)
#> [1] FALSE  TRUE  TRUE  TRUE
str_subset(strings, phone)
#> [1] "219 733 8965"                          
#> [2] "329-293-8753"                          
#> [3] "Work: 579-499-7527; Home: 543.355.3679"
str_locate() locates the first position of a pattern and returns a numeric matrix with columns start and end. str_locate_all() locates all matches, returning a list of numeric matrices. Similar to regexpr() and gregexpr().

# Where in the string is the phone number located?
(loc <- str_locate(strings, phone))
#>      start end
#> [1,]    NA  NA
#> [2,]     1  12
#> [3,]     1  12
#> [4,]     7  18
str_locate_all(strings, phone)
#> [[1]]
#>      start end
#> 
#> [[2]]
#>      start end
#> [1,]     1  12
#> 
#> [[3]]
#>      start end
#> [1,]     1  12
#> 
#> [[4]]
#>      start end
#> [1,]     7  18
#> [2,]    27  38
str_extract() extracts text corresponding to the first match, returning a character vector. str_extract_all() extracts all matches and returns a list of character vectors.

# What are the phone numbers?
str_extract(strings, phone)
#> [1] NA             "219 733 8965" "329-293-8753" "579-499-7527"
str_extract_all(strings, phone)
#> [[1]]
#> character(0)
#> 
#> [[2]]
#> [1] "219 733 8965"
#> 
#> [[3]]
#> [1] "329-293-8753"
#> 
#> [[4]]
#> [1] "579-499-7527" "543.355.3679"
str_extract_all(strings, phone, simplify = TRUE)
#>      [,1]           [,2]          
#> [1,] ""             ""            
#> [2,] "219 733 8965" ""            
#> [3,] "329-293-8753" ""            
#> [4,] "579-499-7527" "543.355.3679"
str_match() extracts capture groups formed by () from the first match. It returns a character matrix with one column for the complete match and one column for each group. str_match_all() extracts capture groups from all matches and returns a list of character matrices. Similar to regmatches().

# Pull out the three components of the match
str_match(strings, phone)
#>      [,1]           [,2]  [,3]  [,4]  
#> [1,] NA             NA    NA    NA    
#> [2,] "219 733 8965" "219" "733" "8965"
#> [3,] "329-293-8753" "329" "293" "8753"
#> [4,] "579-499-7527" "579" "499" "7527"
str_match_all(strings, phone)
#> [[1]]
#>      [,1] [,2] [,3] [,4]
#> 
#> [[2]]
#>      [,1]           [,2]  [,3]  [,4]  
#> [1,] "219 733 8965" "219" "733" "8965"
#> 
#> [[3]]
#>      [,1]           [,2]  [,3]  [,4]  
#> [1,] "329-293-8753" "329" "293" "8753"
#> 
#> [[4]]
#>      [,1]           [,2]  [,3]  [,4]  
#> [1,] "579-499-7527" "579" "499" "7527"
#> [2,] "543.355.3679" "543" "355" "3679"
str_replace() replaces the first matched pattern and returns a character vector. str_replace_all() replaces all matches. Similar to sub() and gsub().

str_replace(strings, phone, "XXX-XXX-XXXX")
#> [1] "apple"                                 
#> [2] "XXX-XXX-XXXX"                          
#> [3] "XXX-XXX-XXXX"                          
#> [4] "Work: XXX-XXX-XXXX; Home: 543.355.3679"
str_replace_all(strings, phone, "XXX-XXX-XXXX")
#> [1] "apple"                                 
#> [2] "XXX-XXX-XXXX"                          
#> [3] "XXX-XXX-XXXX"                          
#> [4] "Work: XXX-XXX-XXXX; Home: XXX-XXX-XXXX"
str_split_fixed() splits the string into a fixed number of pieces based on a pattern and returns a character matrix. str_split() splits a string into a variable number of pieces and returns a list of character vectors.

Arguments

Each pattern matching function has the same first two arguments, a character vector of strings to process and a single pattern (regular expression) to match. The replace functions have an additional argument specifying the replacement string, and the split functions have an argument to specify the number of pieces.

Unlike base string functions, stringr offers control over matching not through arguments, but through modifier functions, regex(), coll() and fixed(). This is a deliberate choice made to simplify these functions. For example, while grepl has six arguments, str_detect() only has two.

Regular expressions

To be able to use these functions effectively, you’ll need a good knowledge of regular expressions, which this vignette is not going to teach you. Some useful tools to get you started:

A good reference sheet.

A tool that allows you to interactively test what a regular expression will match.

A tool to build a regular expression from an input string.

When writing regular expressions, I strongly recommend generating a list of positive (pattern should match) and negative (pattern shouldn’t match) test cases to ensure that you are matching the correct components.

Functions that return lists

Many of the functions return a list of vectors or matrices. To work with each element of the list there are two strategies: iterate through a common set of indices, or use Map() to iterate through the vectors simultaneously. The second strategy is illustrated below:

col2hex <- function(col) {
  rgb <- col2rgb(col)
  rgb(rgb["red", ], rgb["green", ], rgb["blue", ], max = 255)
}

# Goal replace colour names in a string with their hex equivalent
strings <- c("Roses are red, violets are blue", "My favourite colour is green")

colours <- str_c("\\b", colors(), "\\b", collapse="|")
# This gets us the colours, but we have no way of replacing them
str_extract_all(strings, colours)
#> [[1]]
#> [1] "red"  "blue"
#> 
#> [[2]]
#> [1] "green"

# Instead, let's work with locations
locs <- str_locate_all(strings, colours)
Map(function(string, loc) {
  hex <- col2hex(str_sub(string, loc))
  str_sub(string, loc) <- hex
  string
}, strings, locs)
#> $`Roses are red, violets are blue`
#> [1] "Roses are #FF0000, violets are blue"
#> [2] "Roses are red, violets are #0000FF" 
#> 
#> $`My favourite colour is green`
#> [1] "My favourite colour is #00FF00"
Another approach is to use the second form of str_replace_all(): if you give it a named vector, it applies each pattern = replacement in turn:

matches <- col2hex(colors())
names(matches) <- str_c("\\b", colors(), "\\b")

str_replace_all(strings, matches)
#> [1] "Roses are #FF0000, violets are #0000FF"
#> [2] "My favourite colour is #00FF00"
Conclusion

stringr provides an opinionated interface to strings in R. It makes string processing simpler by removing uncommon options, and by vigorously enforcing consistency across functions. I have also added new functions that I have found useful from Ruby, and over time, I hope users will suggest useful functions from other programming languages. I will continue to build on the included test suite to ensure that the package behaves as expected and remains bug free.

