# names of states
states = rownames(USArrests)
# substr
substr(x = states, start = 1, stop = 4)

# abbreviate state names
states2 = abbreviate(states)
# remove vector names (for convenience)
names(states2) = NULL
states2

abbreviate(states)

# size (in characters) of each name
state_chars = nchar(states)
# longest name
states[which(state_chars == max(state_chars))]
## [1] "North Carolina" "South Carolina"
# get states names with 'k'
grep(pattern = "k", x = states, value = TRUE)
## [1] "Alaska" "Arkansas" "Kentucky" "Nebraska"
## [5] "New York" "North Dakota" "Oklahoma" "South Dakota"

# get states names with 'w'
grep(pattern = "w", x = states, value = TRUE)

# get states names with 'w' or 'W'
grep(pattern = "[wW]", x = states, value = TRUE)

# get states names with 'w'
grep(pattern = "w", x = tolower(states), value = TRUE)
# get states names with 'W'
grep(pattern = "W", x = toupper(states), value = TRUE)

# get states names with 'w'
grep(pattern = "w", x = states, value = TRUE, ignore.case = TRUE)

# histogram
hist(nchar(states), main = "Histogram",
xlab = "number of characters in US State names")

# position of a's
positions_a = gregexpr(pattern = "a", text = states, ignore.case = TRUE)
# how many a's?
num_a = sapply(positions_a, function(x) ifelse(x[1] > 0, length(x), 0))
num_a
## [1] 4 3 2 3 2 1 0 2 1 1 2 1 0 2 1 2 0 2 1 2 2 1 1 0 0 2 2 2 1 0 0 0 2 2 0
## [36] 2 0 2 1 2 2 0 1 1 0 1 1 1 0 0
The same operation can be performed by using the function
str count() from the package "stringr" .
# load stringr (remember to install it first)
library(stringr)
# total number of a's
str_count(states, "a")
## [1] 3 2 1 2 2 1 0 2 1 1 2 1 0 2 1 2 0 2 1 2 2 1 1 0 0 2 2 2 1 0 0 0 2 2 0
## [36] 2 0 2 1 2 2 0 1 1 0 1 1 1 0 0
Notice that we are only getting the number of a’s in lower case. Since str count() does not
contain the argument ignore.case, we need to transform all letters to lower case, and then
count the number of a’s like this:
# total number of a's
str_count(tolower(states), "a")

Once we know how to do it for one vowel, we can do the same for all the vowels:
# vector of vowels
vowels = c("a", "e", "i", "o", "u")
# vector for storing results
num_vowels = vector(mode = "integer", length = 5)
# calculate number of vowels in each name
for (j in seq_along(vowels)) {

	num_aux = str_count(tolower(states), vowels[j])
	num_vowels[j] = sum(num_aux)
}
# add vowel names
names(num_vowels) = vowels
# total number of vowels
num_vowels

## a e i o u
## 61 28 44 36 8
# sort them in decreasing order
sort(num_vowels, decreasing = TRUE)
## a i o e u
## 61 44 36 28 8
And finally, we can visualize the distribution with a barplot:
# barplot
barplot(num_vowels, main = "Number of vowels in USA States names",
border = NA, ylim = c(0, 80))

# empty string
empty_str = ""
# display
empty_str
## [1] ""
# class
class(empty_str)
## [1] "character"

2.1.2 Empty character vector
Another basic string structure is the empty character vector produced by the function
character() and its argument length=0:
# empty character vector
empty_chr = character(0)
# display
empty_chr
## character(0)
# class
class(empty_chr)
## [1] "character"
It is important not to confuse the empty character vector character(0) with the empty
string "" ; one of the main differences between them is that they have different lengths:
# length of empty string
length(empty_str)
## [1] 1

# length of empty character vector
length(empty_chr)
## [1] 0
Notice that the empty string empty str has length 1, while the empty character vector
empty chr has length 0.
2.1.3 character()
As we already mentioned, character() is a function to create character vectors. We just
have to specify the length of the vector, and character() will produce a character vector
with as many empty strings, for instance:
# character vector with 5 empty strings
char_vector = character(5)
# display
char_vector
## [1] "" "" "" "" ""
Once an empty character object has been created, new components may be added to it simply
by giving it an index value outside its previous range.
# another example
example = character(0)
example
## character(0)
# check its length
length(example)
## [1] 0
# add first element
example[1] = "first"
example
## [1] "first"
# check its length again
length(example)

## [1] 1
We can add more elements without the need to follow a consecutive index range:
example[4] = "fourth"
example
## [1] "first" NA NA "fourth"
length(example)
## [1] 4
Notice that we went from a one-element vector to a four-element vector without sp ecifying
the second and third elements. R fills this gap with missing values NA.
2.1.4 is.character() and as.character()
Related to character() we have its two sister functions: as.character() and is.character() .
These two functions are generic methos for creating and testing for objects of type "character".
To test if an object is of type "character" you use the function is.character() :
# define two objects 'a' and 'b'
a = "test me"
b = 8 + 9
# are 'a' and 'b' characters?
is.character(a)
## [1] TRUE
is.character(b)
## [1] FALSE
Likewise, you can also use the function class() to get the class of an object:
# classes of 'a' and 'b'
class(a)
## [1] "character"
class(b)
## [1] "numeric"

df2 = data.frame(numbers = 1:5, letters = letters[1:5],
stringsAsFactors = FALSE)
df2
2.3.1 Reading tables
If the data we want to import is in some tabular format we can use the set of functions to
read tables like read.table() and its sister functions —e.g. read.csv(), read.delim(),
read.fwf()—. These functions read a file in table format and create a data frame from it,
with rows corresponding to cases, and columns corresponding to fields in the file.
Functions to read files in tabular format
Function Description
read.table() main function to read file in table format
read.csv() reads csv files separated by a comma ","
read.csv2() reads csv files separated by a semicolon ";"
read.delim() reads files separated by tabs " \t"
read.delim2() similar to read.delim()
read.fwf() read fixed width format files
Let’s see a simple example reading a file from the Australian radio broadcaster ABC (http:
//www.abc.net.au/radio/). In particular, we’ll read a csv file that contains data from
ABC’s radio stations. Such file is located at:
http://www.abc.net.au/local/data/public/stations/abc-local-radio.csv
To import the file abc-local-radio.csv, we can use either read.table() or read.csv()
(just choose the right parameters). Here’s the code to read the file with read.table():
# abc radio stations data URL
abc = "http://www.abc.net.au/local/data/public/stations/abc-local-radio.csv"
# read data from URL
radio = read.table(abc, header = TRUE, sep = ",", stringsAsFactors = FALSE)
In this case, the location of the file is defined in the object abc which is the first argument
passed to read.table(). Then we choose other arguments such as header = TRUE, sep =
",", and stringsAsFactors = FALSE. The argument header = TRUE indicates that the first
row of the file contains the names of the columns. The separator (a comma) is specifcied by
sep = ",". And finally, to keep the character strings in the file as "character" in the data
frame, we use stringsAsFactors = FALSE.
If everything went fine during the file reading operation, the next thing to do is to chek the
size of the created data frame using dim():

paste(..., sep = " ", collapse = NULL)

# paste
PI = paste("The life of", pi)

# paste
IloveR = paste("I", "love", "R", sep = "-")
IloveR
## [1] "I-love-R"

# paste with objects of different lengths
paste("X", 1:5, sep = ".")
## [1] "X.1" "X.2" "X.3" "X.4" "X.5"
To see the effect of the collapse argument, let’s compare the difference with collapsing and
without it:
# paste with collapsing
paste(1:3, c("!", "?", "+"), sep = "", collapse = "")
## [1] "1!2?3+"
# paste without collapsing
paste(1:3, c("!", "?", "+"), sep = "")
## [1] "1!" "2?" "3+"
One of the potential problems with paste() is that it coerces missing values NA into the
character "NA":
# with missing values NA
evalue = paste("the value of 'e' is", exp(1), NA)
evalue
## [1] "the value of 'e' is 2.71828182845905 NA"

In addition to paste(), there’s also the function paste0() which is the equivalent of
paste(..., sep = "", collapse)
# collapsing with paste0
paste0("In addition to paste(), there’s also the function paste0() which is the equivalent of
paste(..., sep = "", collapse)
# collapsing with paste0
paste0("let's", "collapse", "all", "these", "words")
## [1] "let'scollapseallthesewords"let's", "collapse", "all", "these", "words")
## [1] "let'scollapseallthesewords"

3.2 Printing characters
R provides a series of functions for printing strings. Some of the printing functions are useful
when creating print methods for programmed objects’ classes. Other functions are useful
for printing outputs either in the R console or in a given file. In this section we will describe
the following print-related functions:
Printing functions
Function Description
print() generic printing
noquote() print with no quotes
cat() concatenation
format() special formats
toString() convert to string
sprintf() printing

# print without quotes
print(my_string, quote = FALSE)
## [1] programming with data is fun


3.2.2 Unquoted characters with noquote()
We know that we can print text without quotes using print() with its argument quote =
FALSE. An alternative option for achieving a similar output is by using noquote(). As its
names implies, this function prints character strings with no quotes:
# noquote
noquote(my_string)
## [1] programming with data is fun
To be more precise noquote() creates a character object of class "noquote" which always
gets displayed without quotes:
# class noquote
no_quotes = noquote(c("some", "quoted", "text", "!%^(&="))
# display
no_quotes
## [1] some quoted text !%^(&=
# check class
class(no_quotes)
## [1] "noquote"
# test character
is.character(no_quotes)
## [1] TRUE
# no quotes even when subscripting
no_quotes[2:3]
## [1] quoted text
3.2.3 Concatenate and print with cat()
Another very useful function is cat() which allows us to concatenate objects and print them
either on screen or to a file. Its usage has the following structure:
cat(..., file = "", sep = " ", fill = FALSE, labels = NULL, append = FALSE)
The argument ...implies that cat() accepts several types of data. However, when we pass
numeric and/or complex elements they are automatically converted to character strings by
cat(). By default, the strings are concatenated with a space character as separator. This
can be modified with the sep argument.
If we use cat() with only one single string, you get a similar (although not identical) result
as noquote():
# simply print with 'cat()'
cat(my_string)
## programming with data is fun
As you can see, cat() prints its arguments without quotes. In essence, cat() simply displays
its content (on screen or in a file). Compared to noquote(), cat() does not print the numeric
line indicator ([1] in this case).
The usefulness of cat() is when we have two or more strings that we want to concatenate:
# concatenate and print
cat(my_string, "with R")
## programming with data is fun with R
You can use the argument sep to indicate a chacracter vector that will be included to separate
the concatenated elements:
# especifying 'sep'
cat(my_string, "with R", sep = " =) ")
## programming with data is fun =) with R
# another example
cat(1:10, sep = "-")
## 1-2-3-4-5-6-7-8-9-10
When we pass vectors to cat(), each of the elements are treated as though they were separate
arguments:
# first four months
cat(month.name[1:4], sep = " ")
## January February March April
The argument fill allows us to break long strings; this is achieved when we specify the
string width with an integer number:
# fill = 30
cat("Loooooooooong strings", "can be displayed", "in a nice format",
"by using the 'fill' argument", fill = 30)

## Loooooooooong strings
## can be displayed
## in a nice format
## by using the 'fill' argument
Last but not least, we can sp ecify a file output in cat(). For instance, let’s suppose that we
want to save the output in the file output.txt located in our working directory:
# cat with output in a given file
cat(my_string, "with R", file = "output.txt")
3.2.4 Enco ding strings with format()
The function format() allows us to format an R object for pretty printing. Essentially,
format() treats the elements of a vector as character strings using a common format. This
is especially useful when printing numbers and quantities under different formats.
# default usage
format(13.7)
## [1] "13.7"
# another example
format(13.12345678)
## [1] "13.12"
Some useful arguments:
• width the (minimum) width of strings produced
• trim if set to TRUE there is no padding with spaces
• justify controls how padding takes place for strings. Takes the values "left",
"right", "centre", "none"
For controling the printing of numbers, use these arguments:
• digits The number of digits to the right of the decimal place.
• scientific use TRUE for scientific notation, FALSE for standard notation
Keep in mind that justify does not apply to numeric values.
# use of 'nsmall'
format(13.7, nsmall = 3)
## [1] "13.700"

# use of 'digits'
format(c(6, 13.1), digits = 2)
## [1] " 6" "13"
# use of 'digits' and 'nsmall'
format(c(6, 13.1), digits = 2, nsmall = 1)
## [1] " 6.0" "13.1"
By default, format() pads the strings with spaces so that they are all the same length.
# justify options
format(c("A", "BB", "CCC"), width = 5, justify = "centre")
## [1] " A " " BB " " CCC "
format(c("A", "BB", "CCC"), width = 5, justify = "left")
## [1] "A " "BB " "CCC "
format(c("A", "BB", "CCC"), width = 5, justify = "right")
## [1] " A" " BB" " CCC"
format(c("A", "BB", "CCC"), width = 5, justify = "none")
## [1] "A" "BB" "CCC"
# digits
format(1/1:5, digits = 2)
## [1] "1.00" "0.50" "0.33" "0.25" "0.20"
# use of 'digits', widths and justify
format(format(1/1:5, digits = 2), width = 6, justify = "c")
## [1] " 1.00 " " 0.50 " " 0.33 " " 0.25 " " 0.20 "
For printing large quantities with a sequenced format we can use the arguments big.mark
or big.interval. For instance, here is how we can print a number with sequences separated
by a comma ","
# big.mark
format(123456789, big.mark = ",")
## [1] "123,456,789"

3.2.5 C-style string formatting with sprintf()
The function sprintf() is a wrapper for the C function sprintf() that returns a formatted
string combining text and variable values. The nice feature about sprintf() is that it
provides us a very flexible way of formatting vector elements as character strings. Its usage
has the following form:
sprintf(fmt, ...)
The argument fmt is a character vector of format strings. The allowed conversion specifica
tions start the symbol % followed by numbers and letters. For demonstration purposes here
are several ways in which the number pi can be formatted:
# '%f' indicates 'fixed point' decimal notation
sprintf("%f", pi)
## [1] "3.141593"
# decimal notation with 3 decimal digits
sprintf("%.3f", pi)
## [1] "3.142"
# 1 integer and 0 decimal digits
sprintf("%1.0f", pi)
## [1] "3"
# decimal notation with 3 decimal digits
sprintf("%5.1f", pi)
## [1] " 3.1"
sprintf("%05.1f", pi)
## [1] "003.1"
# print with sign (positive)
sprintf("%+f", pi)
## [1] "+3.141593"
# prefix a space
sprintf("% f", pi)
## [1] " 3.141593"
# left adjustment
sprintf("%-10f", pi) # left justified

## [1] "3.141593 "
# exponential decimal notation 'e'
sprintf("%e", pi)
## [1] "3.141593e+00"
# exponential decimal notation 'E'
sprintf("%E", pi)
## [1] "3.141593E+00"
# number of significant digits (6 by default)
sprintf("%g", pi)
## [1] "3.14159"
3.2.6 Converting ob jects to strings with toString()
The function toString() allows us to convert an R object to a character string. This function
can be used as a helper for format() to produce a single character string from several obejcts
inside a vector. The result will be a character vector of length 1 with elements separated by
commas:
# default usage
toString(17.04)
## [1] "17.04"
# combining two objects
toString(c(17.04, 1978))
## [1] "17.04, 1978"
# combining several objects
toString(c("Bonjour", 123, TRUE, NA, log(exp(1))))
## [1] "Bonjour, 123, TRUE, NA, 1"
One of the nice features about toString() is that you can specify its argument width to fix
a maximum field width.
# use of 'width'
toString(c("one", "two", "3333333333"), width = 8)
## [1] "one,...."
# use of 'width'
toString(c("one", "two", "3333333333"), width = 12)
## [1] "one, two...."
3.2.7 Comparing printing metho ds
Even though R has just a small collection of functions for printing and formatting strings,
we can use them to get a wide variety of outputs. The choice of function (and its arguments)
will depend on what we want to print, how we want to print it, and where we want to print
it. Sometimes the answer of which function to use is straightforward. Sometimes however,
we would need to experiment and compare different ways until we find the most adequate
method. To finish this section let’s consider a simple example with a numeric vector with 5
elements:
# printing method
print(1:5)
## [1] 1 2 3 4 5
# convert to character
as.character(1:5)
## [1] "1" "2" "3" "4" "5"
# concatenation
cat(1:5, sep = "-")
## 1-2-3-4-5
# default pasting
paste(1:5)
## [1] "1" "2" "3" "4" "5"
# paste with collapsing
paste(1:5, collapse = "")
## [1] "12345"
# convert to a single string
toString(1:5)
## [1] "1, 2, 3, 4, 5"
# unquoted output
noquote(as.character(1:5))

## [1] 1 2 3 4 5
3.3 Basic String Manipulations
Besides creating and printing strings, there are a numb er of very handy functions in R
for doing some basic manipulation of strings. In this section we will review the following
functions:
Manipulation of strings
Function Description
nchar() number of characters
tolower() convert to lower case
toupper() convert to upper case
casefold() case folding
chartr() character translation
abbreviate() abbreviation
substring() substrings of a character vector
substr() substrings of a character vector
3.3.1 Count numb er of characters with nchar()
One of the main functions for manipulating character strings is nchar() which counts the
number of characters in a string. In other words, nchar() provides the “length” of a string:
# how many characters?
nchar(c("How", "many", "characters?"))
## [1] 3 4 11
# how many characters?
nchar("How many characters?")
## [1] 20
Notice that the white spaces between words in the second example are also counted as
characters.
It is important not to confuse nchar() with length(). While the former gives us the number
of characters, the later only gives the number of elements in a vector.
# how many elements?
length(c("How", "many", "characters?"))
## [1] 3
# how many elements?
length("How many characters?")
## [1] 1
3.3.2 Convert to lower case with tolower()
R comes with three functions for text casefolding. The first function we’ll discuss is tolower()
which converts any upper case characters into lower case:
# to lower case
tolower(c("aLL ChaRacterS in LoweR caSe", "ABCDE"))
## [1] "all characters in lower case" "abcde"
3.3.3 Convert to upp er case with toupper()
The opposite function of tolower() is toupper. As you may guess, this function converts
any lower case characters into upper case:
# to upper case
toupper(c("All ChaRacterS in Upper Case", "abcde"))
## [1] "ALL CHARACTERS IN UPPER CASE" "ABCDE"
3.3.4 Upp er or lower case conversion with casefold()
The third function for case-folding is casefold() which is a wraper for both tolower() and
toupper() . Its uasge has the following form:
casefold(x, upper = FALSE)
By default, casefold() converts all characters to lower case, but we can use the argument
upper = TRUE to indicate the opposite (characters in upper case):
# lower case folding
casefold("aLL ChaRacterS in LoweR caSe")

## [1] "all characters in lower case"
# upper case folding
casefold("All ChaRacterS in Upper Case", upper = TRUE)
## [1] "ALL CHARACTERS IN UPPER CASE"
3.3.5 Character translation with chartr()
There’s also the function chartr() which stands for character translation. chartr() takes
three arguments: an old string, a new string, and a character vector x:
chartr(old, new, x)
The way chartr() works is by replacing the characters in old that appear in x by those
indicated in new. For example, suppose we want to translate the letter ’a’ (lower case) with
’A’ (upper case) in the sentence x:
# replace 'a' by 'A'
chartr("a", "A", "This is a boring string")
## [1] "This is A boring string"
It is important to note that old and new must have the same number of characters, otherwise
you will get a nasty error message like this one:
# incorrect use
chartr("ai", "X", "This is a bad example")
## Error: ’old’ is longer than ’new’
Here’s a more interesting example with old = "aei" and new = "#!?". This implies that
any ’a’ in ’x’ will be replaced by ’#’, any ’e’ in ’x’ will be replaced by ’?’, and any ’i
in ’x’ will be replaced by ’?’:
# multiple replacements
crazy = c("Here's to the crazy ones", "The misfits", "The rebels")
chartr("aei", "#!?", crazy)
## [1] "H!r!'s to th! cr#zy on!s" "Th! m?sf?ts"
## [3] "Th! r!b!ls"

3.3.6 Abbreviate strings with abbreviate()
Another useful function for basic manipulation of character strings is abbreviate(). Its
usage has the following structure:
abbreviate(names.org, minlength = 4, dot = FALSE, strict = FALSE,
method = c("left.keep", "both.sides"))
Although there are several arguments, the main parameter is the character vector (names.org)
which will contain the names that we want to abbreviate:
# some color names
some_colors = colors()[1:4]
some_colors
## [1] "white" "aliceblue" "antiquewhite" "antiquewhite1"
# abbreviate (default usage)
colors1 = abbreviate(some_colors)
colors1
## white aliceblue antiquewhite antiquewhite1
## "whit" "alcb" "antq" "ant1"
# abbreviate with 'minlength'
colors2 = abbreviate(some_colors, minlength = 5)
colors2
## white aliceblue antiquewhite antiquewhite1
## "white" "alcbl" "antqw" "antq1"
# abbreviate
colors3 = abbreviate(some_colors, minlength = 3, method = "both.sides")
colors3
## white aliceblue antiquewhite antiquewhite1
## "wht" "alc" "ant" "an1"
3.3.7 Replace substrings with substr()
One common operation when working with strings is the extraction and replacement of
some characters. For such tasks we have the function substr() which extracts or replaces
substrings in a character vector. Its usage has the following form:
substr(x, start, stop)
x is a character vector, start indicates the first element to be replaced, and stop indicates
the last element to be replaced:
# extract 'bcd'
substr("abcdef", 2, 4)
## [1] "bcd"
# replace 2nd letter with hash symbol
x = c("may", "the", "force", "be", "with", "you")
substr(x, 2, 2) <- "#"
x
## [1] "m#y" "t#e" "f#rce" "b#" "w#th" "y#u"
# replace 2nd and 3rd letters with happy face
y = c("may", "the", "force", "be", "with", "you")
substr(y, 2, 3) <- ":)"
y
## [1] "m:)" "t:)" "f:)ce" "b:" "w:)h" "y:)"
# replacement with recycling
z = c("may", "the", "force", "be", "with", "you")
substr(z, 2, 3) <- c("#", "@")
z
## [1] "m#y" "t@e" "f#rce" "b@" "w#th" "y@u"
3.3.8 Replace substrings with substring()
Closely related to substr() , the function substring() extracts or replaces substrings in a
character vector. Its usage has the following form:
substring(text, first, last = 1000000L)
text is a character vector, first indicates the first element to be replaced, and last indicates
the last element to be replaced:
substrings in a character vector. Its usage has the following form:
substr(x, start, stop)
x is a character vector, start indicates the first element to be replaced, and stop indicates
the last element to be replaced:
# extract 'bcd'
substr("abcdef", 2, 4)
## [1] "bcd"
# replace 2nd letter with hash symbol
x = c("may", "the", "force", "be", "with", "you")
substr(x, 2, 2) <- "#"
x
## [1] "m#y" "t#e" "f#rce" "b#" "w#th" "y#u"
# replace 2nd and 3rd letters with happy face
y = c("may", "the", "force", "be", "with", "you")
substr(y, 2, 3) <- ":)"
y
## [1] "m:)" "t:)" "f:)ce" "b:" "w:)h" "y:)"
# replacement with recycling
z = c("may", "the", "force", "be", "with", "you")
substr(z, 2, 3) <- c("#", "@")
z
## [1] "m#y" "t@e" "f#rce" "b@" "w#th" "y@u"
3.3.8 Replace substrings with substring()
Closely related to substr() , the function substring() extracts or replaces substrings in a
character vector. Its usage has the following form:
substring(text, first, last = 1000000L)
text is a character vector, first indicates the first element to be replaced, and last indicates
the last element to be replaced:
# same as 'substr'
substring("ABCDEF", 2, 4)
## [1] "BCD"
substr("ABCDEF", 2, 4)
## [1] "BCD"
# extract each letter
substring("ABCDEF", 1:6, 1:6)
## [1] "A" "B" "C" "D" "E" "F"
# multiple replacement with recycling
text = c("more", "emotions", "are", "better", "than", "less")
substring(text, 1:3) <- c(" ", "zzz")
text
## [1] " ore" "ezzzions" "ar " "zzzter" "t an" "lezz"
3.4 Set Op erations
R has dedicated functions for performing set operations on two given vectors. This implies
that we can apply functions such as set union, intersection, difference, equality and member
ship, on "character" vectors.
Set Op erations
Function Description
union() set union
intersect() intersection
setdiff() set difference
setequal() equal sets
identical() exact equality
is.element() is element
%in%() contains
sort() sorting
paste(rep()) repetition
3.4.1 Set union with union()
Let’s start our reviewing of set functions with union(). As its name indicates, we can use
union() when we want to obtain the elements of the union between two character vectors:
# two character vectors
set1 = c("some", "random", "words", "some")
set2 = c("some", "many", "none", "few")
# union of set1 and set2
union(set1, set2)
## [1] "some" "random" "words" "many" "none" "few"
Notice that union() discards any duplicated values in the provided vectors. In the previous
example the word "some" appears twice inside set1 but it appears only once in the union.
In fact all the set operation functions will discard any duplicated values.
3.4.2 Set intersection with intersect()
Set intersection is performed with the function intersect(). We can use this function when
we wish to get those elements that are common to both vectors:
# two character vectors
set3 = c("some", "random", "few", "words")
set4 = c("some", "many", "none", "few")
# intersect of set3 and set4
intersect(set3, set4)
## [1] "some" "few"
3.4.3 Set difference with setdiff()
Related to the intersection, we might be interested in getting the difference of the elements
between two character vectors. This can be done with setdiff():
# two character vectors
set5 = c("some", "random", "few", "words")
set6 = c("some", "many", "none", "few")
# difference between set5 and set6
setdiff(set5, set6)
## [1] "random" "words"
3.4.4 Set equality with setequal()
The function setequal() allows us to test the equality of two character vectors. If the
vectors contain the same elements, setequal() returns TRUE (FALSE otherwise)
# three character vectors
set7 = c("some", "random", "strings")
set8 = c("some", "many", "none", "few")
set9 = c("strings", "random", "some")
# set7 == set8?
setequal(set7, set8)
## [1] FALSE
# set7 == set9?
setequal(set7, set9)
## [1] TRUE
3.4.5 Exact equality with identical()
Sometimes setequal() is not always what we want to use. It might be the case that we want
to test whether two vectors are exactly equal (element by element). For instance, testing if
set7 is exactly equal to set9. Although both vectors contain the same set of elements, they
are not exactly the same vector. Such test can be performed with the function identical()
# set7 identical to set7?
identical(set7, set7)
## [1] TRUE
# set7 identical to set9?
identical(set7, set9)
## [1] FALSE
If we consult the help do cumentation of identical(), we can see that this function is the
“safe and reliable way to test two objects for being exactly equal”.
3.4.6 Element contained with is.element()
If we wish to test if an element is contained in a given set of character strings we can do so
with is.element():
# three vectors
set10 = c("some", "stuff", "to", "play", "with")
elem1 = "play"
elem2 = "crazy"
# elem1 in set10?
is.element(elem1, set10)
## [1] TRUE
# elem2 in set10?
is.element(elem2, set10)
## [1] FALSE
Alternatively, we can use the binary operator %in% to test if an element is contained in a
given set. The function %in% returns TRUE if the first operand is contained in the second,
and it returns FALSE otherwise:
# elem1 in set10?
elem1 %in% set10
## [1] TRUE
# elem2 in set10?
elem2 %in% set10
## [1] FALSE
3.4.7 Sorting with sort()
The function sort() allows us to sort the elements of a vector, either in increasing order (by
default) or in decreasing order using the argument decreasing:
set11 = c("today", "produced", "example", "beautiful", "a", "nicely")
# sort (decreasing order)
sort(set11)
## [1] "a" "beautiful" "example" "nicely" "produced" "today"
# sort (increasing order)
sort(set11, decreasing = TRUE)
## [1] "today" "produced" "nicely" "example" "beautiful" "a"
If we have alpha-numeric strings, sort() will put the numbers first when sorting in increasing
order:
set12 = c("today", "produced", "example", "beautiful", "1", "nicely")
# sort (decreasing order)
sort(set12)
## [1] "1" "beautiful" "example" "nicely" "produced" "today"
# sort (increasing order)
sort(set12, decreasing = TRUE)
## [1] "today" "produced" "nicely" "example" "beautiful" "1"
3.4.8 Rep etition with rep()
A very common operation with strings is replication, that is, given a string we want to
replicate it several times. Although there is no single function in R for that purpose, we can
combine paste() and rep() like so:
# repeat 'x' 4 times
paste(rep("x", 4), collapse = "")
## [1] "xxxx"

String manipulations with stringr
As we saw in the previous chapters, R provides a useful range of functions for basic string
processing and manipulations of "character" data. Most of the times these functions are
enough and they will allow us to get our job done. However, they have some drawbacks. For
instance, consider the following example:
# some text vector
text = c("one", "two", "three", NA, "five")
# how many characters in each string?
nchar(text)
## [1] 3 3 5 2 4
As you can see, nchar() gives NA a value of 2, as if it were a string formed by two characters.
Perhaps this may be acceptable in some cases, but taking into account all the operations in
R, it would be better to leave NA as is, instead of treating it as a string of two characters.
Another awkward example can be found with paste() . The default separator is a blank
space, which more often than not is what we want to use. But that’s secondary. The really
annoying thing is when we want to paste things that include zero length arguments. How
does paste() behave in those cases? See below:
# this works fine
paste("University", "of", "California", "Berkeley")
## [1] "University of California Berkeley"
# this works fine too
paste("University", "of", "California", "Berkeley")
## [1] "University of California Berkeley"
# this is weird
paste("University", "of", "California", "Berkeley", NULL)
## [1] "University of California Berkeley "
# this is ugly
paste("University", "of", "California", "Berkeley", NULL, character(0),
"Go Bears!")
## [1] "University of California Berkeley Go Bears!"
Notice the output from the last example (the ugly one). The objects NULL and character(0)
have zero length, yet when included inside paste() they are treated as an empty string "".
Wouldn’t be good if paste() removed zero length arguments? Sadly, there’s nothing we can
do to change nchar() and paste() . But fear not. There is a very nice package that solves
these problems and provides several functions for carrying out consistent string processing.
4.1 Package stringr
Thanks to Hadley Wickham, we have the package stringr that adds more functionality to
the base functions for handling strings in R. According to the description of the package (see
http://cran.r-project.org/web/packages/stringr/index.html) stringr
“is a set of simple wrapp ers that m ake R’s string functions more consistent, simpler
and easier to us e. It do es this by ensuring that: function and argument names (and
p ositions) are consistent, all functions deal with NA’s and zero length character ap
propriately, and the output data structures from each function matches the input data
structures of other functions.”
To install stringr use the function install.packages() . Once installed, load it to your
current session with library() :
# installing 'stringr'
install.packages("stringr")
# load 'stringr'
library(stringr)

4.2 Basic String Op erations
stringr provides functions for both 1) basic manipulations and 2) for regular expression
operations. In this chapter we cover those functions that have to do with basic manipulations.
In turn, regular expression functions with stringr are discussed in chapter 6.
The following table contains the stringr functions for basic string operations:
Function Description Similar to
str c() string concatenation paste()
str length() number of characters nchar()
str sub() extracts substrings substring()
str dup() duplicates characters none
str trim() removes leading and trailing whitespace none
str pad() pads a string none
str wrap() wraps a string paragraph strwrap()
str trim() trims a string none
As you can see, all functions in stringr start with "str " followed by a term associated
to the task they perform. For example, str length() gives us the number (i.e. length) of
characters in a string. In addition, some functions are designed to provide a better alternative
to already existing functions. This is the case of str length() which is intended to be a
substitute of nchar(). Other functions, however, don’t have a corresponding alternative
such as str dup() which allows us to duplicate characters.
4.2.1 Concatenating with str c()
Let’s begin with str c(). This function is equivalent to paste() but instead of using the
white space as the default separator, str c() uses the empty string "".
# default usage
str_c("May", "The", "Force", "Be", "With", "You")
## [1] "MayTheForceBeWithYou"
# removing zero length objects
str_c("May", "The", "Force", NULL, "Be", "With", "You", character(0))
## [1] "MayTheForceBeWithYou"
Notice another major difference between str c() and paste(): zero length arguments like
NULL and character(0) are silently removed by str c().

If we want to change the default separator, we can do that as usual by sp ecifying the argument
sep:
# changing separator
str_c("May", "The", "Force", "Be", "With", "You", sep = "_")
## [1] "May_The_Force_Be_With_You"
# synonym function 'str_join'
str_join("May", "The", "Force", "Be", "With", "You", sep = "-")
## [1] "May-The-Force-Be-With-You"
As you can see from the previous examples, a synonym for str c() is str join() .
4.2.2 Numb er of characters with str length()
As we’ve mentioned before, the function str length() is equivalent to nchar() . Both
functions return the number of characters in a string, that is, the length of a string (do
not confuse it with the length() of a vector). Compared to nchar() , str length() has a
more consistent behavior when dealing with NA values. Instead of giving NA a length of 2,
str length() preserves missing values just as NAs.
# some text (NA included)
some_text = c("one", "two", "three", NA, "five")
# compare 'str_length' with 'nchar'
nchar(some_text)
## [1] 3 3 5 2 4
str_length(some_text)
## [1] 3 3 5 NA 4
In addition, str length() has the nice feature that it converts factors to characters, some
thing that nchar() is not able to handle:
# some factor
some_factor = factor(c(1, 1, 1, 2, 2, 2), labels = c("good", "bad"))
some_factor
## [1] good good good bad bad bad
## Levels: good bad
# try 'nchar' on a factor

nchar(some_factor)
## Error: ’nchar()’ requires a character vector
# now compare it with 'str_length'
str_length(some_factor)
## [1] 4 4 4 3 3 3
4.2.3 Substring with str sub()
To extract substrings from a character vector stringr provides str sub() which is equivalent
to substring(). The function str sub() has the following usage form:
str_sub(string, start = 1L, end = -1L)
The three arguments in the function are: a string vector, a start value indicating the
position of the first character in substring, and an end value indicating the position of the
last character. Here’s a simple example with a single string in which characters from 1 to 5
are extracted:
# some text
lorem = "Lorem Ipsum"
# apply 'str_sub'
str_sub(lorem, start = 1, end = 5)
## [1] "Lorem"
# equivalent to 'substring'
substring(lorem, first = 1, last = 5)
## [1] "Lorem"
# another example
str_sub("adios", 1:3)
## [1] "adios" "dios" "ios"
An interesting feature of str sub() is its ability to work with negative indices in the start
and end positions. When we use a negative position, str sub() counts backwards from last
character:
# some strings
resto = c("brasserie", "bistrot", "creperie", "bouchon")
# 'str_sub' with negative positions
str_sub(resto, start = -4, end = -1)
## [1] "erie" "trot" "erie" "chon"
# compared to substring (useless)
substring(resto, first = -4, last = -1)
## [1] "" "" "" ""
Similar to substring(), we can also give str sub() a set of positions which will be recycled
over the string. But even better, we can give str sub() a negative sequence, something that
substring() ignores:
# extracting sequentially
str_sub(lorem, seq_len(nchar(lorem)))
## [1] "Lorem Ipsum" "orem Ipsum" "rem Ipsum" "em Ipsum" "m Ipsum"
## [6] " Ipsum" "Ipsum" "psum" "sum" "um"
## [11] "m"
substring(lorem, seq_len(nchar(lorem)))
## [1] "Lorem Ipsum" "orem Ipsum" "rem Ipsum" "em Ipsum" "m Ipsum"
## [6] " Ipsum" "Ipsum" "psum" "sum" "um"
## [11] "m"
# reverse substrings with negative positions
str_sub(lorem, -seq_len(nchar(lorem)))
## [1] "m" "um" "sum" "psum" "Ipsum"
## [6] " Ipsum" "m Ipsum" "em Ipsum" "rem Ipsum" "orem Ipsum"
## [11] "Lorem Ipsum"
substring(lorem, -seq_len(nchar(lorem)))
## [1] "Lorem Ipsum" "Lorem Ipsum" "Lorem Ipsum" "Lorem Ipsum" "Lorem Ipsum"
## [6] "Lorem Ipsum" "Lorem Ipsum" "Lorem Ipsum" "Lorem Ipsum" "Lorem Ipsum"
## [11] "Lorem Ipsum"
We can use str sub() not only for extracting subtrings but also for replacing substrings:
# replacing 'Lorem' with 'Nullam'
lorem = "Lorem Ipsum"
str_sub(lorem, 1, 5) <- "Nullam"
lorem
## [1] "Nullam Ipsum"

# replacing with negative positions
lorem = "Lorem Ipsum"
str_sub(lorem, -1) <- "Nullam"
lorem
## [1] "Lorem IpsuNullam"
# multiple replacements
lorem = "Lorem Ipsum"
str_sub(lorem, c(1, 7), c(5, 8)) <- c("Nullam", "Enim")
lorem
## [1] "Nullam Ipsum" "Lorem Enimsum"
4.2.4 Duplication with str dup()
A common op eration when handling characters is duplication. The problem is that R doesn’t
have a specific function for that purpose. But stringr does: str dup() duplicates and
concatenates strings within a character vector. Its usage requires two arguments:
str_dup(string, times)
The first input is the string that we want to repeat. The second input, times, is the number
of times to duplicate each string:
# default usage
str_dup("hola", 3)
## [1] "holaholahola"
# use with differetn 'times'
str_dup("adios", 1:3)
## [1] "adios" "adiosadios" "adiosadiosadios"
# use with a string vector
words = c("lorem", "ipsum", "dolor", "sit", "amet")
str_dup(words, 2)
## [1] "loremlorem" "ipsumipsum" "dolordolor" "sitsit" "ametamet"
str_dup(words, 1:5)

## [1] "lorem" "ipsumipsum" "dolordolordolor"
## [4] "sitsitsitsit" "ametametametametamet"
4.2.5 Padding with str pad()
Another handy function that we can find in stringr is str pad() for padding a string. Its
default usage has the following form:
str_pad(string, width, side = "left", pad = " ")
The idea of str pad() is to take a string and pad it with leading or trailing characters
to a specified total width. The default padding character is a space (pad = " "), and
consequently the returned string will appear to be either left-aligned (side = "left"), right
aligned (side = "right"), or both (side = "both")
Let’s see some examples:
# default usage
str_pad("hola", width = 7)
## [1] " hola"
# pad both sides
str_pad("adios", width = 7, side = "both")
## [1] " adios "
# left padding with '#'
str_pad("hashtag", width = 8, pad = "#")
## [1] "#hashtag"
# pad both sides with '-'
str_pad("hashtag", width = 9, side = "both", pad = "-")
## [1] "-hashtag-"
4.2.6 Wrapping with str wrap()
The function str wrap() is equivalent to strwrap() which can be used to wrap a string to
format paragraphs. The idea of wrapping a (long) string is to first split it into paragraphs

according to the given width, and then add the specified indentation in each line (first line
with indent, following lines with exdent). Its default usage has the following form:
str_wrap(string, width = 80, indent = 0, exdent = 0)
For instance, consider the following quote (from Douglas Adams) converted into a paragraph:
# quote (by Douglas Adams)
some_quote = c(
"I may not have gone",
"where I intended to go,",
"but I think I have ended up",
"where I needed to be")
# some_quote in a single paragraph
some_quote = paste(some_quote, collapse = " ")
Now, say we want to display the text of some quote within some pre-specified column width
(e.g. width of 30). We can achieve this by applying str wrap() and setting the argument
width = 30
# display paragraph with width=30
cat(str_wrap(some_quote, width = 30))
## I may not have gone where I
## intended to go, but I think I
## have ended up where I needed
## to be
Besides displaying a (long) paragraph into several lines, we may also wish to add some
indentation. Here’s how we can indent the first line, as well as the following lines:
# display paragraph with first line indentation of 2
cat(str_wrap(some_quote, width = 30, indent = 2), " \n")
## I may not have gone where I
## intended to go, but I think I
## have ended up where I needed
## to be
# display paragraph with following lines indentation of 3
cat(str_wrap(some_quote, width = 30, exdent = 3), " \n")
## I may not have gone where I
## intended to go, but I

## think I have ended up
## where I needed to be
4.2.7 Trimming with str trim()
One of the typical tasks of string pro cessing is that of parsing a text into individual words.
Usually, we end up with words that have blank spaces, called whitespaces, on either end of
the word. In this situation, we can use the str trim() function to remove any number of
whitespaces at the ends of a string. Its usage requires only two arguments:
str_trim(string, side = "both")
The first input is the string to be strimmed, and the second input indicates the side on
which the whitespace will be removed.
Consider the following vector of strings, some of which have whitespaces either on the left,
on the right, or on both sides. Here’s what str trim() would do to them under different
settings of side
# text with whitespaces
bad_text = c("This", " example ", "has several ", " whitespaces ")
# remove whitespaces on the left side
str_trim(bad_text, side = "left")
## [1] "This" "example " "has several " "whitespaces "
# remove whitespaces on the right side
str_trim(bad_text, side = "right")
## [1] "This" " example" "has several" " whitespaces"
# remove whitespaces on both sides
str_trim(bad_text, side = "both")
## [1] "This" "example" "has several" "whitespaces"
4.2.8 Word extraction with word()
We end this chapter describing the word() function that is designed to extract words from
a sentence:
word(string, start = 1L, end = start, sep = fixed(" "))
The way in which we use word() is by passing it a string, together with a start position
of the first word to extract, and an end position of the last word to extract. By default, the
separator sep used between words is a single space.
Let’s see some examples:
# some sentence
change = c("Be the change", "you want to be")
# extract first word
word(change, 1)
## [1] "Be" "you"
# extract second word
word(change, 2)
## [1] "the" "want"
# extract last word
word(change, -1)
## [1] "change" "be"
# extract all but the first words
word(change, 2, -1)
## [1] "the change" "want to be"
stringr has more functions but we’ll discuss them in chapter 6 since they have to do with
regular expressions.
Metacharacters and how to es cap e them in R
Metacharacter Literal meaning Escap e in R
. the period or dot \\.
$ the dollar sign \\$
* the asterisk or star \\*
+ the plus sign \\+
? the question mark \\?
| the vertical bar or pipe symbol \\|
\ the backslash \\\\
^ the caret \\^
[ the opening square bracket \\[
] the closing square bracket \\]
{ the opening curly bracket \\{
} the closing curly bracket \\}
( the opening round bracket \\(
) the closing round bracket \\)
For instance, consider the character string "$money". Say we wanted to replace the dollar
sign $ with an empty string "". This can be done with the function sub() . The naive (but
wrong) way is to simply try to match the dollar sign with the character "$":
# string
money = "$money"
# the naive but wrong way
sub(pattern = "$", replacement = "", x = money)
## [1] "$money"
As you can see, nothing happened. In most scripting languages, when we want to represent
any of the metacharacters with its literal meaning in a regex, we need to escape them with
a backslash. The problem with R is that the traditional way doesn’t work (you will get a
nasty error):
# the usual (in other languages) yet wrong way in R
sub(pattern = " \$", replacement = "", x = money)
In R we need to scape metacharacters with a double backslash. This is how we would
effectively replace the $ sign:
# the right way in R
sub(pattern = " \\$", replacement = "", x = money)
## [1] "money"


Here are some silly examples that show how to escap e metacharacters in R in order to be
replaced with an empty "":
# dollar
sub(" \\$", "", "$Peace-Love")
## [1] "Peace-Love"
# dot
sub(" \\.", "", "Peace.Love")
## [1] "PeaceLove"
# plus
sub(" \\+", "", "Peace+Love")
## [1] "PeaceLove"
# caret
sub(" \\^", "", "Peace^Love")
## [1] "PeaceLove"
# vertical bar
sub(" \\|", "", "Peace|Love")
## [1] "PeaceLove"
# opening round bracket
sub(" \\(", "", "Peace(Love)")
## [1] "PeaceLove)"
# closing round bracket
sub(" \\)", "", "Peace(Love)")
## [1] "Peace(Love"
# opening square bracket
sub(" \\[", "", "Peace[Love]")
## [1] "PeaceLove]"
# closing square bracket
sub(" \\]", "", "Peace[Love]")
## [1] "Peace[Love"
# opening curly bracket
sub(" \\{", "", "Peace{Love}")

## [1] "PeaceLove}"
# closing curly bracket
sub(" \\}", "", "Peace{Love}")
## [1] "Peace{Love"
# double backslash
sub(" \\\\", "", "Peace\\Love")
## [1] "PeaceLove"
5.2.3 Sequences
Sequences define, no surprinsingly, sequences of characters which can match. We have short
hand versions (or anchors) for commonly used sequences in R:
Anchor Sequences in R
Anchor Description
\\d match a digit character
\\D match a non-digit character
\\s match a space character
\\S match a non-space character
\\w match a word character
\\W match a non-word character
\\b match a word boundary
\\B match a non-(word boundary)
\\h match a horizontal space
\\H match a non-horizontal space
\\v match a vertical space
\\V match a non-vertical space
Let’s see an application of the anchor sequences with some examples around substitution
operations. Substitutions can be performed with the functions sub() and gsub(). Although
we’ll discuss the replacements functions later in this chapter, it is important to keep in mind
their difference. sub() replaces the first match, while gsub() replaces all the matches.
Let’s consider the string "the dandelion war 2010", and let’s check the different substition
effects of replacing each anchor sequence with an underscore " ".
Digits and non-digits

# replace digit with '_'
sub(" \\d", "_", "the dandelion war 2010")
## [1] "the dandelion war _010"
gsub(" \\d", "_", "the dandelion war 2010")
## [1] "the dandelion war ____"
# replace non-digit with '_'
sub(" \\D", "_", "the dandelion war 2010")
## [1] "_he dandelion war 2010"
gsub(" \\D", "_", "the dandelion war 2010")
## [1] "__________________2010"
Spaces and non-spaces
# replace space with '_'
sub(" \\s", "_", "the dandelion war 2010")
## [1] "the_dandelion war 2010"
gsub(" \\s", "_", "the dandelion war 2010")
## [1] "the_dandelion_war_2010"
# replace non-space with '_'
sub(" \\S", "_", "the dandelion war 2010")
## [1] "_he dandelion war 2010"
gsub(" \\S", "_", "the dandelion war 2010")
## [1] "___ _________ ___ ____"
Words and non-words
# replace word with '_'
sub(" \\b", "_", "the dandelion war 2010")
## [1] "_the dandelion war 2010"
gsub(" \\b", "_", "the dandelion war 2010")
## [1] "_t_h_e_ _d_a_n_d_e_l_i_o_n_ _w_a_r_ _2_0_1_0_"

# replace non-word with '_'
sub(" \\B", "_", "the dandelion war 2010")
## [1] "t_he dandelion war 2010"
gsub(" \\B", "_", "the dandelion war 2010")
## [1] "t_he d_an_de_li_on w_ar 2_01_0"
Word b oundaries and non-word-b oundaries
# replace word boundary with '_'
sub(" \\w", "_", "the dandelion war 2010")
## [1] "_he dandelion war 2010"
gsub(" \\w", "_", "the dandelion war 2010")
## [1] "___ _________ ___ ____"
# replace non-word-boundary with '_'
sub(" \\W", "_", "the dandelion war 2010")
## [1] "the_dandelion war 2010"
gsub(" \\W", "_", "the dandelion war 2010")
## [1] "the_dandelion_war_2010"
5.2.4 Character Classes
A character class or character set is a list of characters enclosed by square brackets [ ] .
Character sets are used to match only one of several characters. For instance, the regex
character class [aA] matches any lower case letter a or any upper case letter A. Likewise, the
regular expression [0123456789] matches any single digit. It is important not to confuse a
regex character class with the native R "character" class concept.
A particular case of character classes is when we include the caret ^ at the beginning of the
list: this indicates that the regular expression matches any character NOT in the list. This
is the reason why this configuration is also known as class negation or negated character
class. For example, the regular expression [^xyz] matches anything except the characters
x, y or z.
In addition, sets of characters such as digits, lower case ASCII letters, and upper case ASCII
letters can be specified as a range of characters by giving the first and last characters, sepa
rated by a hyphen. For instance, the regular expression [a-z] matches any lower case ASCII


84312


4102B6 1,00 OFTP TCP/IP Adapter - 2 channels first version
Key-Code W64Z6


letter. In turn the chracter class [0-9] matches any digit.
Some (Regex) Character Classes
Anchor Description
[aeiou] match any one lower case vowel
[AEIOU] match any one upper case vowel
[0123456789] match any digit
[0-9] match any digit (same as previous class)
[a-z] match any lower case ASCII letter
[A-Z] match any upper case ASCII letter
[a-zA-Z0-9] match any of the above classes
[^aeiou] match anything other than a lowercase vowel
[^0-9] match anything other than a digit
Let’s see a basic example. Imagine that we have a character vector with several words and
that we are interested in matching those words containing the vowels "e" or "i". For this
purpose, we can use the character class "[ei]":
# some string
transport = c("car", "bike", "plane", "boat")
# look for 'e' or 'i'
grep(pattern = "[ei]", transport, value = TRUE)
## [1] "bike" "plane"
Here’s another example with digit character classes:
# some numeric strings
numerics = c("123", "17-April", "I-II-III", "R 3.0.1")
# match strings with 0 or 1
grep(pattern = "[01]", numerics, value = TRUE)
## [1] "123" "17-April" "R 3.0.1"
# match any digit
grep(pattern = "[0-9]", numerics, value = TRUE)
## [1] "123" "17-April" "R 3.0.1"
# negated digit
grep(pattern = "[^0-9]", numerics, value = TRUE)
## [1] "17-April" "I-II-III" "R 3.0.1"

5.2.5 POSIX Character Classes
Closely related to the regex character classes we have what is known as POSIX character
classes. In R, POSIX character classes are represented with expressions inside double brackets
[[ ]] . The following table shows the POSIX character classes as used in R:
POSIX Character Classes in R
Class Description
[[:lower:]] Lower-case letters
[[:upper:]] Upper-case letters
[[:alpha:]] Alphabetic characters ([[:lower:]] and [[:upper:]] )
[[:digit:]] Digits: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
[[:alnum:]] Alphanumeric characters ([[:alpha:]] and [[:digit:]] )
[[:blank:]] Blank characters: space and tab
[[:cntrl:]] Control characters
[[:punct:]] Punctuation characters: ! ” # % & ’ ( ) * + , - . / : ;
[[:space:]] Space characters: tab, newline, vertical tab, form feed,
carriage return, and space
[[:xdigit:]] Hexadecimal digits: 0-9 A B C D E F a b c d e f
[[:print:]] Printable characters ([[:alpha:]] , [[:punct:]] and space)
[[:graph:]] Graphical characters ([[:alpha:]] and [[:punct:]] )
For example, suppose we are dealing with the following string:
# la vie (string)
la_vie = "La vie en #FFC0CB (rose); \nCes't la vie! \ttres jolie"
# if you print 'la_vie'
print(la_vie)
## [1] "La vie en #FFC0CB (rose);\nCes't la vie! \ttres jolie"
# if you cat 'la_vie'
cat(la_vie)
## La vie en #FFC0CB (rose);
## Ces't la vie! tres jolie
Here’s what would happen to the string la vie if we apply some substitutions with the
POSIX character classes:

# remove space characters
gsub(pattern = "[[:blank:]]", replacement = "", la_vie)
## [1] "Lavieen#FFC0CB(rose);\nCes'tlavie!tresjolie"
# remove digits
gsub(pattern = "[[:punct:]]", replacement = "", la_vie)
## [1] "La vie en FFC0CB rose\nCest la vie \ttres jolie"
# remove digits
gsub(pattern = "[[:xdigit:]]", replacement = "", la_vie)
## [1] "L vi n # (ros);\ns't l vi! \ttrs joli"
# remove printable characters
gsub(pattern = "[[:print:]]", replacement = "", la_vie)
## [1] "\n\t"
# remove non-printable characters
gsub(pattern = "[^[:print:]]", replacement = "", la_vie)
## [1] "La vie en #FFC0CB (rose);Ces't la vie! tres jolie"
# remove graphical characters
gsub(pattern = "[[:graph:]]", replacement = "", la_vie)
## [1] " \n \t "
# remove non-graphical characters
gsub(pattern = "[^[:graph:]]", replacement = "", la_vie)
## [1] "Lavieen#FFC0CB(rose);Ces'tlavie!tresjolie"
5.2.6 Quantifiers
Another imp ortant set of regex elements are the so-called quantifiers. These are used when
we want to match a certain number of characters that meet certain criteria.
Quantifiers specify how many instances of a character, group, or character class must be
present in the input for a match to b e found. The following table shows the regex quantifiers:
Quantifiers in R
Quantifier Description
? The preceding item is optional and will be matched at most once
* The preceding item will be matched zero or more times
+ The preceding item will be matched one or more times
{n} The preceding item is matched exactly n times
{n, } The preceding item is matched n or more times
{n,m} The preceding item is matched at least n times, but not more than m times
Some examples
# people names
people = c("rori", "emilia", "matteo", "mehmet", "filipe", "anna", "tyler",
"rasmus", "jacob", "youna", "flora", "adi")
# match 'm' at most once
grep(pattern = "m?", people, value = TRUE)
## [1] "rori" "emilia" "matteo" "mehmet" "filipe" "anna" "tyler"
## [8] "rasmus" "jacob" "youna" "flora" "adi"
# match 'm' exactly once
grep(pattern = "m{1}", people, value = TRUE, perl = FALSE)
## [1] "emilia" "matteo" "mehmet" "rasmus"
# match 'm' zero or more times, and 't'
grep(pattern = "m*t", people, value = TRUE)
## [1] "matteo" "mehmet" "tyler"
# match 't' zero or more times, and 'm'
grep(pattern = "t*m", people, value = TRUE)
## [1] "emilia" "matteo" "mehmet" "rasmus"
# match 'm' one or more times
grep(pattern = "m+", people, value = TRUE)
## [1] "emilia" "matteo" "mehmet" "rasmus"
# match 'm' one or more times, and 't'
grep(pattern = "m+.t", people, value = TRUE)
## [1] "matteo" "mehmet"
# match 't' exactly twice
grep(pattern = "t {2}", people, value = TRUE)
## [1] "matteo"
5.3 Functions for Regular Expressions
Once we’ve describ ed how R handles some of the most common regular expression elements,
it’s time to present the functions we can use for working with regular expressions.
5.3.1 Main Regex functions
R contains a set of functions in the base package that we can use to find pattern matches.
The following table lists these functions with a brief description:
Regular Expression Functions in R
Function Purpose Characteristic
grep() finding regex matches which elements are matched (index or value)
grepl() finding regex matches which elements are matched (TRUE & FALSE)
regexpr() finding regex matches positions of the first match
gregexpr() finding regex matches positions of all matches
regexec() finding regex matches hybrid of regexpr() and gregexpr()
sub() replacing regex matches only first match is replaced
gsub() replacing regex matches all matches are replaced
strsplit() splitting regex matches split vector according to matches
The first five functions listed in the previous table are used for finding pattern matches in
character vectors. The goal is the same for all these functions: finding a match. The
difference between them is in the format of the output. The next two functions —sub()
and gsub() — are used for substitution: looking for matches with the purpose of replacing
them. The last function, strsplit(), is used to split elements of a character vector into
substrings according to regex matches.
Basically, all regex functions require two main arguments: a pattern (i.e. regular expression),
and a text to match. Each function has other additional arguments but the main ones are a
pattern and some text. In particular, the pattern is basically a character string containing
a regular expression to be matched in the given text.
You can check the documentation of all the grep()-like functions by typing help(grep) (or
alternatively ?grep).
# help documentation for main regex functions
help(grep)
5.3.2 Regex functions in stringr
The R package stringr also provides several functions for regex operations (see table below).
More specifically, stringr provides pattern matching functions to detect, locate, extract,
match, replace and split strings.
Regex functions in stringr
Function Description
str detect() Detect the presence or absence of a pattern in a string
str extract() Extract first piece of a string that matches a pattern
str extract all() Extract all pieces of a string that match a pattern
str match() Extract first matched group from a string
str match all() Extract all matched groups from a string
str locate() Locate the position of the first occurence of a pattern in a string
str locate all() Locate the position of all occurences of a pattern in a string
str replace() Replace first occurrence of a matched pattern in a string
str replace all() Replace all occurrences of a matched pattern in a string
str split() Split up a string into a variable number of pieces
str split fixed() Split up a string into a fixed number of pieces
One of the important things to keep in mind is that all pattern matching functions in stringr
have the following general form:
str_function(string, pattern)
The common characteristic is that they all share the first two arguments: a string vector
to be processed and a single pattern (i.e. regular expression) to match.
5.3.3 Complementary matching functions
Together with the primary grep()-like functions, R has other related matching functions
such as regmatches(), match(), pmatch(), charmatch(). The truth is that regmatches()
is the only function that is designed to work with regex patterns. The other matching
functions don’t work with regular expressions but we can use them to match terms (e.g.
words, argument names) within a character vector.
Complementary Matching Functions
Function Purpose Characteristic
regmatches() extract or replace matches use with data from regexpr(),
gregexpr() or regexec()
match() value matching finding positions of (first) matches
pmatch() partial string matching finding positions
charmatch() similar to pmatch() finding positions
5.3.4 Accessory functions accepting regex patterns
Likewsie, R contains other functions that interact or accept regex patterns: apropos(),
ls(), browseEnv(), glob2rx(), help.search(), list.files(). The main purpose of these
functions is to search for R objects or files, but they can take a regex pattern as input.
Accessory Functions
Function Description
apropos() find objects by (partial) name
browseEnv() browse objects in environment
glob2rx() change wildcard or globbing pattern into Regular Expression
help.search() search the help system
list.files() list the files in a directory/folder

teststring<- "test dfer reqr erq erq qdag"
grep(pattern = "[ei]", teststring, value = TRUE)

library(stringr)

shopping_list <- c("apples x4", "bag of flour", "bag of sugar", "milk x2")
str_extract(shopping_list, "\\d")
str_extract(shopping_list, "[a-z]+")
str_extract(shopping_list, "[a-z]{1,4}")
str_extract(shopping_list, "\\b[a-z]{1,4}\\b")

# Extract all matches
shopping_list <- c("apples x4", "bag of flour", "bag of sugar", "milk x2")

str_extract_all(shopping_list, "[a-z]+")
str_extract_all(shopping_list, "\\b[a-z]+\\b")
str_extract_all(shopping_list, "\\d")

# Simplify results into character matrix
str_extract_all(shopping_list, "\\b[a-z]+\\b", simplify = TRUE)
str_extract_all(shopping_list, "\\d", simplify = TRUE)

# Extract all words
str_extract_all("This is, suprisingly, a sentence.", boundary("word"))



regmatches {base}	R Documentation
Extract or Replace Matched Substrings

Description

Extract or replace matched substrings from match data obtained by regexpr, gregexpr or regexec.

Usage

regmatches(x, m, invert = FALSE)
regmatches(x, m, invert = FALSE) <- value
Arguments

x	
a character vector

m	
an object with match data

invert	
a logical: if TRUE, extract or replace the non-matched substrings.

value	
an object with suitable replacement values for the matched or non-matched substrings (see Details).

Details

If invert is FALSE (default), regmatches extracts the matched substrings as specified by the match data. For vector match data (as obtained from regexpr), empty matches are dropped; for list match data, empty matches give empty components (zero-length character vectors).

If invert is TRUE, regmatches extracts the non-matched substrings, i.e., the strings are split according to the matches similar to strsplit (for vector match data, at most a single split is performed).

If invert is NA, regmatches extracts both non-matched and matched substrings, always starting and ending with a non-match (empty if the match occurred at the beginning or the end, respectively).

Note that the match data can be obtained from regular expression matching on a modified version of x with the same numbers of characters.

The replacement function can be used for replacing the matched or non-matched substrings. For vector match data, if invert is FALSE, value should be a character vector with length the number of matched elements in m. Otherwise, it should be a list of character vectors with the same length as m, each as long as the number of replacements needed. Replacement coerces values to character or list and generously recycles values as needed. Missing replacement values are not allowed.

Value

For regmatches, a character vector with the matched substrings if m is a vector and invert is FALSE. Otherwise, a list with the matched or/and non-matched substrings.

For regmatches<-, the updated character vector.

Examples

x <- c("A and B", "A, B and C", "A, B, C and D", "foobar")
pattern <- "[[:space:]]*(,|and)[[:space:]]"
## Match data from regexpr()
m <- regexpr(pattern, x)
regmatches(x, m)
regmatches(x, m, invert = TRUE)
## Match data from gregexpr()
m <- gregexpr(pattern, x)
regmatches(x, m)
regmatches(x, m, invert = TRUE)

## Consider
x <- "John (fishing, hunting), Paul (hiking, biking)"
## Suppose we want to split at the comma (plus spaces) between the
## persons, but not at the commas in the parenthesized hobby lists.
## One idea is to "blank out" the parenthesized parts to match the
## parts to be used for splitting, and extract the persons as the
## non-matched parts.
## First, match the parenthesized hobby lists.
m <- gregexpr("\\([^)]*\\)", x)
## Write a little utility for creating blank strings with given numbers
## of characters.
blanks <- function(n) strrep(" ", n)
## Create a copy of x with the parenthesized parts blanked out.
s <- x
regmatches(s, m) <- Map(blanks, lapply(regmatches(s, m), nchar))
s
## Compute the positions of the split matches (note that we cannot call
## strsplit() on x with match data from s).
m <- gregexpr(", *", s)
## And finally extract the non-matched parts.
regmatches(x, m, invert = TRUE)



6.1 Pattern Finding Functions
Let’s begin by reviewing the first five grep() -like functions grep() , grepl() , regexpr() ,
gregexpr() , and regexec() . The goal is the same for all these functions: finding a match.
The difference between them is in the format of the output. Essentially these functions require
two main arguments: a pattern (i.e. regular expression), and a text to match. The basic
usage for these functions is:
grep(pattern, text)
grepl(pattern, text)
regexpr(pattern, text)
gregexpr(pattern, text)
regexec(pattern, text)
Each function has other additional arguments but the important thing to keep in mind are
a pattern and some text.

6.1.1 Function grep()
grep() is perhaps the most basic functions that allows us to match a pattern in a string
vector. The first argument in grep() is a regular expression that specifies the pattern to
match. The second argument is a character vector with the text strings on which to search.
The output is the indices of the elements of the text vector for which there is a match. If no
matches are found, the output is an empty integer vector.
# some text
text = c("one word", "a sentence", "you and me", "three two one")
# pattern
pat = "one"
# default usage
grep(pat, text)
## [1] 1 4
As you can see from the output in the previous example, grep() returns a numeric vector.
This indicates that the 1st and 4th elements contained a match. In contrast, the 2nd and
the 3rd elements did not.
We can use the argument value to modify the way in which the output is presented. If we
choose value = TRUE, instead of returning the indices, grep() returns the content of the
string vector:
# with 'value' (showing matched text)
grep(pat, text, value = TRUE)
## [1] "one word" "three two one"
Another interesting argument to play with is invert. We can use this parameter to obtain
unmatches strings by setting its value to TRUE
# with 'invert' (showing unmatched parts)
grep(pat, text, invert = TRUE)
## [1] 2 3
# same with 'values'
grep(pat, text, invert = TRUE, value = TRUE)
## [1] "a sentence" "you and me"
In summary, grep() can be used to subset a character vector to get only the elements
containing (or not containing) the matched pattern.
6.1.2 Function grepl()
The function grepl() enables us to perform a similar task as grep(). The difference resides
in that the output are not numeric indices, but logical (TRUE / FALSE). Hence you can think
of grepl() as grep-logical. Using the same text string of the previous examples, here’s the
behavior of grepl():
# some text
text = c("one word", "a sentence", "you and me", "three two one")
# pattern
pat = "one"
# default usage
grepl(pat, text)
## [1] TRUE FALSE FALSE TRUE
Note that we get a logical vector of the same length as the character vector. Those elements
that matched the pattern have a value of TRUE; those that didn’t match the pattern have a
value of FALSE.
6.1.3 Function regexpr()
To find exactly where the pattern is found in a given string, we can use the regexpr()
function. This function returns more detailed information than grep() providing us:
a) which elements of the text vector actually contain the regex pattern, and
b) identifies the position of the substring that is matched by the regular expression pattern.
# some text
text = c("one word", "a sentence", "you and me", "three two one")
# default usage
regexpr("one", text)
## [1] 1 -1 -1 11
## attr(,"match.length")
## [1] 3 -1 -1 3
## attr(,"useBytes")
## [1] TRUE
At first glance the output from regexpr() may look a bit messy but it’s very simple to
interpret. What we have in the output are three displayed elements. The first element is an
integer vector of the same length as text giving the starting positions of the first match. In
this example the number 1 indicates that the pattern "one" starts at the position 1 of the
first element in text. The negative index -1 means that there was no match; the number 11
indicates the position of the substring that was matched in the fourth element of text.
The attribute "match.length" gives us the length of the match in each element of text.
Again, a negative value of -1 means that there was no match in that element. Finally,
the attribute "useBytes" has a value of TRUE which means that the matching was done
byte-by-byte rather than character-by-character.
6.1.4 Function gregexpr()
The function gregexpr() does practically the same thing as regexpr(): identify where a
pattern is within a string vector, by searching each element separately. The only difference
is that gregexpr() has an output in the form of a list. In other words, gregexpr() returns
a list of the same length as text, each element of which is of the same form as the return
value for regexpr(), except that the starting positions of every (disjoint) match are given.
# some text
text = c("one word", "a sentence", "you and me", "three two one")
# pattern
pat = "one"
# default usage
gregexpr(pat, text)
## [[1]]
## [1] 1
## attr(,"match.length")
## [1] 3
## attr(,"useBytes")
## [1] TRUE
##
## [[2]]
## [1] -1
## attr(,"match.length")
## [1] -1
## attr(,"useBytes")
## [1] TRUE
##
## [[3]]
## [1] -1
## attr(,"match.length")
## [1] -1
## attr(,"useBytes")
## [1] TRUE
##
## [[4]]
## [1] 11
## attr(,"match.length")
## [1] 3
## attr(,"useBytes")
## [1] TRUE
6.1.5 Function regexec()
The function regexec() is very close to gregexpr() in the sense that the output is also a
list of the same length as text. Each element of the list contains the starting position of the
match. A value of -1 reflects that there is no match. In addition, each element of the list
has the attribute "match.length" giving the lengths of the matches (or -1 for no match):
# some text
text = c("one word", "a sentence", "you and me", "three two one")
# pattern
pat = "one"
# default usage
regexec(pat, text)
## [[1]]
## [1] 1
## attr(,"match.length")
## [1] 3
##
## [[2]]
## [1] -1
## attr(,"match.length")
## [1] -1
##

## [[3]]
## [1] -1
## attr(,"match.length")
## [1] -1
##
## [[4]]
## [1] 11
## attr(,"match.length")
## [1] 3
Example from Sp ector
# handy function to extract matched term
x = regexpr(pat, text)
substring(text, x, x + attr(x, "match.length") - 1)
## [1] "one" "" "" "one"
# with NA
regexpr(pat, c(text, NA))
## [1] 1 -1 -1 11 NA
## attr(,"match.length")
## [1] 3 -1 -1 3 NA
6.2 Pattern Replacement Functions
Sometimes finding a pattern in a given string vector is all we want. However, there are
o ccasions in which we might also b e interested in replacing one pattern with another one.
For this purpose we can use the substitution functions sub() and gsub() . The difference
between sub() and gsub() is that the former replaces only the first occurrence of a pattern
whereas the latter replaces all occurrences.
The replacement functions require three main arguments: a regex pattern to be matched,
a replacement for the matched pattern, and the text where matches are sought. The basic
usage is:
sub(pattern, replacement, text)
gsub(pattern, replacement, text)
6.2.1 Replacing first o ccurrence with sub()
The function sub() replaces the first occurrence of a pattern in a given text. This means
that if there is more than one occurrence of the pattern in each element of a string vector,
only the first one will be replaced. For example, suppose we have the following text vector
containing various strings:
Rstring = c("The R Foundation",
"for Statistical Computing",
"R is FREE software",
"R is a collaborative project")
Imagine that our aim is to replace the pattern "R" with a new pattern "RR". If we use sub()
this is what we obtain:
# string
Rstring = c("The R Foundation",
"for Statistical Computing",
"R is FREE software",
"R is a collaborative project")
# substitute 'R' with 'RR'
sub("R", "RR", Rstring)
## [1] "The RR Foundation" "for Statistical Computing"
## [3] "RR is FREE software" "RR is a collaborative project"
As you can tell, only the first occurrence of the letter R is replaced in each element of the
text vector. Note that the word FREE in the third element also contains an R but it was not
replaced. This is because it was not the first occurrence of the pattern.
6.2.2 Replacing all occurrences with gsub()
To replace not only the first pattern occurrence, but all of the occurrences we should use
gsub() (think of it as general substition). If we take the same vector Rstring and patterns
of the last example, this is what we obtain when we apply gsub()
# string
Rstring = c("The R Foundation",
"for Statistical Computing",
"R is FREE software",
"R is a collaborative project")

# substitute
gsub("R", "RR", Rstring)
## [1] "The RR Foundation" "for Statistical Computing"
## [3] "RR is FRREE software" "RR is a collaborative project"
The obtained output is almost the same as with sub(), except for the third element in
Rstring. Now the occurence of R in the word FREE is taken into account and gsub() changes
it to FRREE.
6.3 Splitting Character Vectors
Besides the operations of finding patterns and replacing patterns, another common task is
splitting a string based on a pattern. To do this R comes with the function strsplit()
which is designed to split the elements of a character vector into substrings according to
regex matches.
If you check the help documentation —help(strsplit)— you will see that the basic usage
of strsplit() requires two main arguments:
strsplit(x, split)
x is the character vector and split is the regular expression pattern. However, in order to
keep the same notation that we’ve been using with the other grep() functions, it is better
if we think of x as text, and split as pattern. In this way we can express the usage of
strsplit() as:
strsplit(text, pattern)
One of the typical tasks in which we can use strsplit() is when we want to break a string
into individual components (i.e. words). For instance, if we wish to separate each word
within a given sentence, we can do that specifying a blank space " " as splitting pattern:
# a sentence
sentence = c("R is a collaborative project with many contributors")
# split into words
strsplit(sentence, " ")
## [[1]]
## [1] "R" "is" "a" "collaborative"
## [5] "project" "with" "many" "contributors"
Another basic example may consist in breaking apart the p ortions of a telephone numb er by
splitting those sets of digits joined by a dash "-"
# telephone numbers
tels = c("510-548-2238", "707-231-2440", "650-752-1300")
# split each number into its portions
strsplit(tels, "-")
## [[1]]
## [1] "510" "548" "2238"
##
## [[2]]
## [1] "707" "231" "2440"
##
## [[3]]
## [1] "650" "752" "1300"
6.4 Functions in stringr
In the previous chapter we briefly presented the functions of the R package stringr for
regular expressions. As we mentioned, all the stringr functions share a common usage
structure:
str_function(string, pattern)
The main two arguments are: a string vector to be processed , and a single pattern (i.e.
regular expression) to match. Moreover, all the function names begin with the prefix str ,
followed by the name of the action to be performed. For example, to locate the position of
the first occurence, we should use str locate() ; to locate the positions of all matches we
should use str locate all() .
6.4.1 Detecting patterns with str detect()
For detecting whether a pattern is present (or absent) in a string vector, we can use the
function str detect() . Actually, this function is a wraper of grepl() :
# some objects
some_objs = c("pen", "pencil", "marker", "spray")
# detect phones
str_detect(some_objs, "pen")
## [1] TRUE TRUE FALSE FALSE
# select detected macthes
some_objs[str_detect(some_objs, "pen")]
## [1] "pen" "pencil"
As you can see, the output of str detect() is a boolean vector (TRUE/FALSE) of the same
length as the specified string. You get a TRUE if a match is detected in a string, FALSE
otherwise. Here’s another more elaborated example in which the pattern matches dates of
the form day-month-year:
# some strings
strings = c("12 Jun 2002", " 8 September 2004 ", "22-July-2009 ",
"01 01 2001", "date", "02.06.2000",
"xxx-yyy-zzzz", "$2,600")
# date pattern (month as text)
dates = "([0-9] {1,2})[- .]([a-zA-Z]+)[- .]([0-9] {4})"
# detect dates
str_detect(strings, dates)
## [1] TRUE TRUE TRUE FALSE FALSE FALSE FALSE FALSE
6.4.2 Extract first match with str extract()
For extracting a string containing a pattern, we can use the function str extract(). In
fact, this function extracts the first piece of a string that matches a given pattern. For
example, imagine that we have a character vector with some tweets about Paris, and that
we want to extract the hashtags. We can do this simply by defining a #hashtag pattern like
#[a-zA-Z] {1}
# tweets about 'Paris'
paris_tweets = c(
"#Paris is chock-full of cultural and culinary attractions",
"Some time in #Paris along Canal St.-Martin famous by #Amelie",
"While you're in #Paris, stop at cafe: http://goo.gl/yaCbW",
"Paris, the city of light")
# hashtag pattern

hash = "#[a-zA-Z] {1, }"
# extract (first) hashtag
str_extract(paris_tweets, hash)
## [1] "#Paris" "#Paris" "#Paris" NA
As you can see, the output of str extract() is a vector of same length as string. Those
elements that don’t match the pattern are indicated as NA. Note that str extract() only
matches the first pattern: it didn’t extract the hashtag "#Amelie".
6.4.3 Extract all matches with str extract all()
In addition to str extract(), stringr also provides the function str extract all(). As
its name indicates, we use str extract all() to extract all patterns in a vector string.
Taking the same string as in the previous example, we can extract all the hashtag matches
like so:
# extract (all) hashtags
str_extract_all(paris_tweets, "#[a-zA-Z] {1, }")
## [[1]]
## [1] "#Paris"
##
## [[2]]
## [1] "#Paris" "#Amelie"
##
## [[3]]
## [1] "#Paris"
##
## [[4]]
## character(0)
Compared to str extract(), the output of str extract all() is a list of same length as
string. In addition, those elements that don’t match the pattern are indicated with an
empty character vector character(0) instead of NA.
6.4.4 Extract first match group with str match()
Closely related to str extract() the package stringr offers another extracting function:
str match(). This function not only extracts the matched pattern but it also shows each of

the matched groups in a regex character class pattern.
# string vector
strings = c("12 Jun 2002", " 8 September 2004 ", "22-July-2009 ",
"01 01 2001", "date", "02.06.2000",
"xxx-yyy-zzzz", "$2,600")
# date pattern (month as text)
dates = "([0-9] {1,2})[- .]([a-zA-Z]+)[- .]([0-9] {4})"
# extract first matched group
str_match(strings, dates)
## [,1] [,2] [,3] [,4]
## [1,] "12 Jun 2002" "12" "Jun" "2002"
## [2,] "8 September 2004" "8" "September" "2004"
## [3,] "22-July-2009" "22" "July" "2009"
## [4,] NA NA NA NA
## [5,] NA NA NA NA
## [6,] NA NA NA NA
## [7,] NA NA NA NA
## [8,] NA NA NA NA
Note that the output is not a vector but a character matrix. The first column is the complete
match, the other columns are each of the captured groups. For those unmatched elements,
there is a missing value NA.
6.4.5 Extract all matched groups with str match all()
If what we’re looking for is extracting all patterns in a string vector, instead of using
str extract() we should use str extract all() :
# tweets about 'Paris'
paris_tweets = c(
"#Paris is chock-full of cultural and culinary attractions",
"Some time in #Paris along Canal St.-Martin famous by #Amelie",
"While you're in #Paris, stop at cafe: http://goo.gl/yaCbW",
"Paris, the city of light")
# match (all) hashtags in 'paris_tweets'
str_match_all(paris_tweets, "#[a-zA-Z] {1, }")
## [[1]]

## [,1]
## [1,] "#Paris"
##
## [[2]]
## [,1]
## [1,] "#Paris"
## [2,] "#Amelie"
##
## [[3]]
## [,1]
## [1,] "#Paris"
##
## [[4]]
## character(0)
Compared to str match(), the output of str match all() is a list. Note al also that each
element of the list is a matrix with as many rows as hashtag matches. In turn, those elements
that don’t match the pattern are indicated with an empty character vector character(0)
instead of a NA.
6.4.6 Locate first match with str locate()
Besides detecting, extracting and matching regex patterns, stringr allows us to locate oc
curences of patterns. For locating the position of the first occurence of a pattern in a string
vector, we should use str locate().
# locate position of (first) hashtag
str_locate(paris_tweets, "#[a-zA-Z] {1, }")
## start end
## [1,] 1 6
## [2,] 14 19
## [3,] 17 22
## [4,] NA NA
The output of str locate() is a matrix with two columns and as many rows as elements in
the (string) vector. The first column of the output is the start position, while the second
column is the end position.
In the previous example, the result is a matrix with 4 rows and 2 columns. The first row
corresponds to the hashtag of the first tweet. It starts at position 1 and ends at position
6. The second row corresponds to the hashtag of the second tweet; its start position is the

14th character, and its end p osition is the 19th character. The fourth row corresp onds to the
fourth tweet. Since there are no hashtags the values in that row are NA’s.
6.4.7 Lo cate all matches with str locate all()
To locate not just the first but all the occurence patterns in a string vector, we should use
str locate all() :
# locate (all) hashtags in 'paris_tweets'
str_locate_all(paris_tweets, "#[a-zA-Z] {1, }")
## [[1]]
## start end
## [1,] 1 6
##
## [[2]]
## start end
## [1,] 14 19
## [2,] 54 60
##
## [[3]]
## start end
## [1,] 17 22
##
## [[4]]
## start end
Compared to str locate() , the output of str locate all() is a list of the same length as
the provided string. Each of the list elements is in turn a matrix with two columns. Those
elements that don’t match the pattern are indicated with an empty character vector instead
of an NA.
Looking at the obtained result from applying str locate all() to paris tweets, you can
see that the second element contains the start and end positions for both hashtags #Paris
and #Amelie. In turn, the fourth element appears empty since its associated tweet contains
no hashtags.
6.4.8 Replace first match with str replace()
For replacing the first occurrence of a matched pattern in a string, we can use str replace() .
Its usage has the following form:

str_replace(string, pattern, replacement)
In addition to the main 2 inputs of the rest of functions, str replace() requires a third
argument that indicates the replacement pattern.
Say we have the city names of San Francisco, Barcelona, Naples and Paris in a vector. And
let’s suppose that we want to replace the first vowel in each name with a semicolon. Here’s
how we can do that:
# city names
cities = c("San Francisco", "Barcelona", "Naples", "Paris")
# replace first matched vowel
str_replace(cities, "[aeiou]", ";")
## [1] "S;n Francisco" "B;rcelona" "N;ples" "P;ris"
Now, suppose that we want to replace the first consonant in each name. We just need to
modify the pattern with a negated class:
# replace first matched consonant
str_replace(cities, "[^aeiou]", ";")
## [1] ";an Francisco" ";arcelona" ";aples" ";aris"
6.4.9 Replace all matches with str replace all()
For replacing all occurrences of a matched pattern in a string, we can use str replace all().
Once again, consider a vector with some city names, and let’s suppose that we want to replace
all the vowels in each name:
# city names
cities = c("San Francisco", "Barcelona", "Naples", "Paris")
# replace all matched vowel
str_replace_all(cities, pattern = "[aeiou]", ";")
## [1] "S;n Fr;nc;sc;" "B;rc;l;n;" "N;pl;s" "P;r;s"
Alternatively, to replace all consonants with a semicolon in each name, we just need to change
the pattern with a negated class:
# replace all matched consonants
str_replace_all(cities, pattern = "[^aeiou]", ";")
## [1] ";a;;;;a;;i;;o" ";a;;e;o;a" ";a;;e;" ";a;i;"

6.4.10 String splitting with str split()
Similar to strsplit(), stringr gives us the function str split() to separate a character
vector into a number of pieces. This function has the following usage:
str_split(string, pattern, n = Inf)
The argument n is the maximum number of pieces to return. The default value (n = Inf)
implies that all possible split positions are used.
Let’s see the same example of strsplit() in which we wish to split up a sentence into
individuals words:
# a sentence
sentence = c("R is a collaborative project with many contributors")
# split into words
str_split(sentence, " ")
## [[1]]
## [1] "R" "is" "a" "collaborative"
## [5] "project" "with" "many" "contributors"
Likewise, we can break apart the portions of a telephone number by splitting those sets of
digits joined by a dash "-"
# telephone numbers
tels = c("510-548-2238", "707-231-2440", "650-752-1300")
# split each number into its portions
str_split(tels, "-")
## [[1]]
## [1] "510" "548" "2238"
##
## [[2]]
## [1] "707" "231" "2440"
##
## [[3]]
## [1] "650" "752" "1300"
The result is a list of character vectors. Each element of the string vector corresponds to an
element in the resulting list. In turn, each of the list elements will contain the split vectors
(i.e. number of pieces) occurring from the matches.

In order to show the use of the argument n, let’s consider a vector with flavors "chocolate",
"vanilla", "cinnamon", "mint" , and "lemon". Suppose we want to split each flavor name
defining as pattern the class of vowels:
# string
flavors = c("chocolate", "vanilla", "cinnamon", "mint", "lemon")
# split by vowels
str_split(flavors, "[aeiou]")
## [[1]]
## [1] "ch" "c" "l" "t" ""
##
## [[2]]
## [1] "v" "n" "ll" ""
##
## [[3]]
## [1] "c" "nn" "m" "n"
##
## [[4]]
## [1] "m" "nt"
##
## [[5]]
## [1] "l" "m" "n"
Now let’s modify the maximum number of pieces to n = 2. This means that str split()
will split each element into a maximum of 2 pieces. Here’s what we obtain:
# split by first vowel
str_split(flavors, "[aeiou]", n = 2)
## [[1]]
## [1] "ch" "colate"
##
## [[2]]
## [1] "v" "nilla"
##
## [[3]]
## [1] "c" "nnamon"
##
## [[4]]
## [1] "m" "nt"
##
## [[5]]

## [1] "l" "mon"
6.4.11 String splitting with str split fixed()
In addition to str split(), there is also the str split fixed() function that splits up a
string into a fixed number of pieces. Its usage has the following form:
str_split_fixed(string, pattern, n)
Note that the argument n does not have a default value. In other words, we need to specify
an integer to indicate the number of pieces.
Consider again the same vector of flavors, and the letter "n" as the pattern to match. Let’s
see the behavior of str split fixed() with n = 2.
# string
flavors = c("chocolate", "vanilla", "cinnamon", "mint", "lemon")
# split flavors into 2 pieces
str_split_fixed(flavors, "n", 2)
## [,1] [,2]
## [1,] "chocolate" ""
## [2,] "va" "illa"
## [3,] "ci" "namon"
## [4,] "mi" "t"
## [5,] "lemo" ""
As you can tell, the output is a character matrix with as many columns as n = 2. Since
"chocolate" does not contain any letter "n", its corresponding value in the second column
remains empty "". In contrast, the value of the second column associated to "lemon" is also
empty. But this is because this flavor is split up into "lemo" and "".
If we change the value n = 3, we will obtain a matrix with three columns:
# split favors into 3 pieces
str_split_fixed(flavors, "n", 3)
## [,1] [,2] [,3]
## [1,] "chocolate" "" ""
## [2,] "va" "illa" ""
## [3,] "ci" "" "amon"
## [4,] "mi" "t" ""
## [5,] "lemo" "" ""

strsplit("req erq dfa cv ga dfd"," ")
sentence = c("R is a collaborative project with many contributors")
# split into words
strsplit(sentence, " ")

Practical Applications
This chapter is dedicated to show some practical examples that involve handling and pro
cessing strings in R. The main idea is to put in practice all the material covered so far and
get a grasp of the variety of things we can do in R.
We will describe four typical examples. The examples are not exhaustive but just represen
tative:
1. reversing a string
2. matching email addresses
3. matching html elements (href’s and img’s anchors)
4. some stats and analytics of character data
7.1 Reversing a string
Our first example has to do with reversing a character string. More precisely, the objective
is to create a function that takes a string and returns it in reversed order. The trick of this
exercise depends on what we understand with the term reversing. For some people, reversing
may be understood as simply having the set of characters in reverse order. For other people
instead, reversing may be understood as having a set of words in reverse order. Can you see
the distinction?
Let’s consider the following two simple strings:
• "atmosphere"
• "the big bang theory"
The first string is formed by one single word (atmosphere). The second string is formed
by a sentence with four words (the big bang theory). If we were to reverse b oth strings by
characters we would get the following results:
• "erehpsomta"
• "yroeht gnab gib eht"
Conversely, if we were to reverse the strings by words, we would obtain the following output:
• "atmosphere"
• "theory bang big the"
For this example we will implement a function for each typ e of reversing op eration.
7.1.1 Reversing a string by characters
The first case for reversing a string is to do it by characters. This implies that we need to
split a given string into its different characters, and then we need to concatenate them back
together in reverse order. Let’s try to write a first function:
# function that reverses a string by characters
reverse_chars <- function(string)
{
# split string by characters
string_split = strsplit(string, split = "")
# reverse order
rev_order = nchar(string):1
# reversed characters
reversed_chars = string_split[[1]][rev_order]
# collapse reversed characters
paste(reversed_chars, collapse="")
}
Let’s test our reversing function with a character and numeric vectors:
# try 'reverse_chars'
reverse_chars("abcdefg")
## [1] "gfedcba"
# try with non-character input
reverse_chars(12345)
## Error: non-character argument
As you can see, reverse chars() works fine when the input is in "character" mode. How
ever, it complains when the input is "non-character". In order to make our function more
robust, we can force the input to be converted as character. The resulting code is given as:
# reversing a string by characters
reverse_chars <- function(string)
{
string_split = strsplit(as.character(string), split = "")
reversed_split = string_split[[1]][nchar(string):1]
paste(reversed_split, collapse="")
}
Now if we try our modified function, we get the expected results:
# example with one word
reverse_chars("atmosphere")
## [1] "erehpsomta"
# example with a several words
reverse_chars("the big bang theory")
## [1] "yroeht gnab gib eht"
Moreover, it also works with non-character input:
# try 'reverse_chars'
reverse_chars("abcdefg")
## [1] "gfedcba"
# try with non-character input
reverse_chars(12345)
## [1] "54321"
If we want to use our function with a vector (more than one element), we can combine it
with the lapply() function as follows:
# reverse vector (by characters)
lapply(c("the big bang theory", "atmosphere"), reverse_chars)
## [[1]]
## [1] "yroeht gnab gib eht"
##
## [[2]]
## [1] "erehpsomta"
7.1.2 Reversing a string by words
The second typ e of reversing op eration is to reverse a string by words. In this case the
procedure involves splitting up a string by words, re-arrange them in reverse order, and
paste them back in one sentence. Here’s how we can defined our reverse words() function:
# function that reverses a string by words
reverse_words <- function(string)
{
# split string by blank spaces
string_split = strsplit(as.character(string), split = " ")
# how many split terms?
string_length = length(string_split[[1]])
# decide what to do
if (string_length == 1) {
# one word (do nothing)
reversed_string = string_split[[1]]
} else {
# more than one word (collapse them)
reversed_split = string_split[[1]][string_length:1]
reversed_string = paste(reversed_split, collapse = " ")
}
# output
return(reversed_string)
}
The first step inside reverse words() is to split the string according to a blank space
pattern " ". Then we are counting the number of components resulting from the splitting
step. Based on this information there are two options. If there is only one word, then there
is nothing to do. If we have more than one words, then we need to re-arrenge them in reverse
order and collapse them in a single string.
Once we have defined our function, we can try it on the two string examples to check that it
works as expected:
# examples
reverse_words("atmosphere")
## [1] "atmosphere"
reverse_words("the big bang theory")
## [1] "theory bang big the"
Similarly, to use our function on a vector with more than one element, we should call it
within the lapply() function as follows:
# reverse vector (by words)
lapply(c("the big bang theory", "atmosphere"), reverse_words)
## [[1]]
## [1] "theory bang big the"
##
## [[2]]
## [1] "atmosphere"
7.2 Matching e-mail addresses
The second practical example that we will discuss consists of matching an email address. We
will work with usual email addresses having one (or a similar variant) of the following forms:
somename@email.com
somename99@email.com
some.name@email.com
some.name@an-email.com
some.name@an.email.com
Since our goal is to match an email address, this implies that we need to define a corresponding
regex pattern. If we look at the previous email forms it is possible to see that they have a
general structure that can be broken into three parts. The first part is the username (e.g.
somename99). The second part is an @ symbol. The third part is the domain name (e.g.
an.email.com).
The username pattern can be defined as:
^([a-z0-9_\\.-]+)
The username pattern starts with a caret ^ to indicate the beginning of the string. Then we
have a group indicated with parentheses. It matches one or more lowercase letters, numbers,
underscores, dots, or hyphens.
The domain name pattern can be defined as:
([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$
The domain name should be one or more lowercase letters, numbers, underscores, dots, or
hyphens. Then another (escaped) dot, followed by an extension of two to six letters or dots.
And finally the end of the string ($).

The complete regular expression pattern (in R) for an email address is:
"^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
Let’s test our pattern with a minimalist example:
# pattern
email_pat = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+) \\. ([a-z\\.] {2,6})$"
# string that matches
grepl(pattern = email_pat, x = "gaston@abc.com")
## [1] TRUE
Here is another more real example:
# another string that matches
grep(pattern = email_pat, x = "gaston.sanchez@research-center.fr")
## [1] 1
However, if we have a “long” TLD (top-level domain) exceeding six letters, the pattern won’t
match, like in the next example:
# unmatched email (TLD too long)
grep(pattern = email_pat, x = "gaston@abc.something")
## integer(0)
Now let’s apply the email pattern to test whether several strings match or not:
# potential email addresses
emails = c(
"simple@example.com",
"johnsmith@email.gov",
"marie.curie@college.edu",
"very.common@example.com",
"a.little.lengthy.but.ok@dept.example.com",
"disposable.style.email.with+symbol@example.com",
"not_good@email.address")
# detect pattern
str_detect(string=emails, pattern=email_pat)
## [1] TRUE TRUE TRUE TRUE TRUE FALSE FALSE
Note that the two last elements in emails are not well defined email addresses (they don’t
match the espicified pattern). The fifth address contains five sets of strings including a

+ symbol. In turn, the sixth address has a long domain name (email.address) in which
address exceeds six letters.
7.3 Matching HTML elements
For our third example we will deal with some basic handling of HTML tags. We’ll take the
webpage for the R mailing lists: http://www.r-project.org/mail.html
If you visit the previous webpage you will see that there are four general mailing lists devoted
to R:
• R-announce is where major announcements about the development of R and the
availability of new code.
• R-packages is a list of announcements on the availability of new or enhanced con
tributed packages
• R-help is the main R mailing list for discussion about problems and solutions using R
• R-devel is a list intended for questions and discussion about code development in R
Additionally, there are several specific Special Interest Group (SIG) mailing lists. The
following table shows the first 5 groups:
First 5 Special Interest Groups (SIG) in R
Name Description
R-SIG-Mac Special Interest Group on Mac ports of R
R-sig-DB SIG on Database Interfaces
R-SIG-Debian Special Interest Group for Debian ports of R
R-sig-dynamic-models Special Interest Group for Dynamic Simulation Models
R-sig-Epi R for epidemiological data analysis
As a simple example, suppose we wanted to get the href attributes of all the SIG links. For
instance, the href attribute of the R-SIG-Mac link is:
https://stat.ethz.ch/mailman/listinfo/r-sig-mac
In turn the href attribute of the R-sig-DB link is:
https://stat.ethz.ch/mailman/listinfo/r-sig-db
If we take a peek at the html source-code of the webpage, we’ll see that all the links can be
found on lines like this one:

<td><a href="https://stat.ethz.ch/mailman/listinfo/r-sig-mac">
<tt>R-SIG-Mac</tt></a></td>
7.3.1 Getting SIG links
The first step is to create a vector of character strings that will contain the lines of the mailing
lists webpage. We can create this vector by simply passing the URL name to readLines():
# read html content
mail_lists = readLines("http://www.r-project.org/mail.html")
Once we’ve read the HTML content of the R mailing lists webpage, the next step is to define
our regex pattern that matches the SIG links.
'^.*<td> *<a href="(https.*)">.*$'
Let’s examine the proposed pattern. By using the caret (^) and dollar sign ($) we can
describe our pattern as an entire line. Next to the caret we match anything zero or more
times followed by a <td> tag. Then there is a blank space matched zero or more times,
followed by an anchor tag with its href attribute. Note that we are using double quotation
marks to match the href attribute ("(https.*)"). Moreover, the entire regex pattern is
surrounded by single quotations marks ' ' . Here is how we can get the SIG links:
# SIG's href pattern
sig_pattern = '^.*<td> *<a href="(https.*)">.*$'
# find SIG href attributes
sig_hrefs = grep(sig_pattern, mail_lists, value = TRUE)
# let's see first 5 elements (shorten output)
shorten_sigs = rep("", 5)
for (i in 1:5) {
shorten_sigs[i] = toString(sig_hrefs[i], width=70)
}
shorten_sigs
## [1] " <td><a href=\"https://stat.ethz.ch/mailman/listinfo/r-sig-mac\">...."
## [2] " <td><a href=\"https://stat.ethz.ch/mailman/listinfo/r-sig-db\"><...."
## [3] " <td><a href=\"https://stat.ethz.ch/mailman/listinfo/r-sig-debia...."
## [4] " <td><a href=\"https://stat.ethz.ch/mailman/listinfo/r-sig-dynam...."
## [5] " <td><a href=\"https://stat.ethz.ch/mailman/listinfo/r-sig-epi\">...."
We need to get rid of the extra html tags. We can easily extract the names of the note files
using the sub() function (since there is only one link per line, we don’t need to use gsub(),

	although we could).
# get first matched group
sub(sig_pattern, " \\1", sig_hrefs)
## [1] "https://stat.ethz.ch/mailman/listinfo/r-sig-mac"
## [2] "https://stat.ethz.ch/mailman/listinfo/r-sig-db"
## [3] "https://stat.ethz.ch/mailman/listinfo/r-sig-debian"
## [4] "https://stat.ethz.ch/mailman/listinfo/r-sig-dynamic-models"
## [5] "https://stat.ethz.ch/mailman/listinfo/r-sig-epi"
## [6] "https://stat.ethz.ch/mailman/listinfo/r-sig-ecology"
## [7] "https://stat.ethz.ch/mailman/listinfo/r-sig-fedora"
## [8] "https://stat.ethz.ch/mailman/listinfo/r-sig-finance"
## [9] "https://stat.ethz.ch/mailman/listinfo/r-sig-geo"
## [10] "https://stat.ethz.ch/mailman/listinfo/r-sig-gr"
## [11] "https://stat.ethz.ch/mailman/listinfo/r-sig-gui"
## [12] "https://stat.ethz.ch/mailman/listinfo/r-sig-hpc"
## [13] "https://stat.ethz.ch/mailman/listinfo/r-sig-jobs"
## [14] "https://stat.ethz.ch/mailman/listinfo/r-sig-mixed-models"
## [15] "https://stat.ethz.ch/mailman/listinfo/r-sig-mediawiki"
## [16] "https://stat.ethz.ch/mailman/listinfo/r-sig-networks"
## [17] "https://stat.ethz.ch/mailman/listinfo/r-sig-phylo"
## [18] "https://stat.ethz.ch/mailman/listinfo/r-sig-qa"
## [19] "https://stat.ethz.ch/mailman/listinfo/r-sig-robust"
## [20] "https://stat.ethz.ch/mailman/listinfo/r-sig-s"
## [21] "https://stat.ethz.ch/mailman/listinfo/r-sig-teaching"
## [22] "https://stat.ethz.ch/mailman/listinfo/r-sig-wiki"
As you can see, we are using the regex pattern \\1 in the sub() function. Generally speaking
\\N is replaced with the N-th group specified in the regular expression. The first matched
group is referenced by \\1. In our example, the first group is everything that is contained in
the curved brackets, that is: (https.*) , which are in fact the links we are looking for.
7.4 Text Analysis of BioMed Central Journals
For our last application we will work analyzing some text data. We will analyze the catalog
of journals from the BioMed Central (BMC), a scientific publisher that specializes in
open access journal publication. You can find more informaiton of BMC at: http://www.
biomedcentral.com/about/catalog
The data with the journal catalog is available in csv format at: http://www.biomedcentral.
com/journals/biomedcentraljournallist.txt
To imp ort the data in R we can read the file with read.table() . Just specify the URL
location of the file and pass it to read.table() . Don’t forget to set the arguments sep =
"," and stringsAsFactors = FALSE
# link of data set
url = "http://www.biomedcentral.com/journals/biomedcentraljournallist.txt"
# read data (stringsAsFactors=FALSE)
biomed = read.table(url, header = TRUE, sep = ",", stringsAsFactors = FALSE)
We can check the structure of the data with the function str() :
# structure of the dataset
str(biomed, vec.len = 1)
## 'data.frame': 336 obs. of 7 variables:
## $ Publisher : chr "BioMed Central Ltd" ...
## $ Journal.name : chr "AIDS Research and Therapy" ...
## $ Abbreviation : chr "AIDS Res Ther" ...
## $ ISSN : chr "1742-6405" ...
## $ URL : chr "http://www.aidsrestherapy.com" ...
## $ Start.Date : int 2004 2011 ...
## $ Citation.Style: chr "BIOMEDCENTRAL" ...
As you can see, the data frame biomed has 336 observations and 7 variables. Actually, all
the variables except for Start.Date are in character mode.
7.4.1 Analyzing Journal Names
We will do a simple analysis of the journal names. The goal is to study what are the more
common terms used in the title of the journals. We are going to keep things at a basic
level but for a more formal (and sophisticated) analysis you can check the package tm —text
mining— (by Ingo Feinerer).
To have a better idea of what the data looks like, let’s check the first journal names.
# first 5 journal names
head(biomed$Journal.name, 5)
## [1] "AIDS Research and Therapy"
## [2] "AMB Express"
## [3] "Acta Neuropathologica Communications"
## [4] "Acta Veterinaria Scandinavica"
## [5] "Addiction Science & Clinical Practice"
As you can tell, the fifth journal "Addiction Science & Clinical Practice" has an am
persand & symbol. Whether to keep the ampersand and other punctutation symbols depends
on the objectives of the analysis. In our case, we will remove those elements.
Prepro cessing
The preprocessing steps implies to get rid of the punctuation symbols. For convenient reasons
it is always recommended to start working with a small subset of the data. In this way we
can experiment at a small scale until we are confident with the right manipulations. Let’s
take the first 10 journals:
# get first 10 names
titles10 = biomed$Journal.name[1:10]
titles10
## [1] "AIDS Research and Therapy"
## [2] "AMB Express"
## [3] "Acta Neuropathologica Communications"
## [4] "Acta Veterinaria Scandinavica"
## [5] "Addiction Science & Clinical Practice"
## [6] "Agriculture & Food Security"
## [7] "Algorithms for Molecular Biology"
## [8] "Allergy, Asthma & Clinical Immunology"
## [9] "Alzheimer's Research & Therapy"
## [10] "Animal Biotelemetry"
We want to get rid of the ampersand signs &, as well as other punctuation marks. This can be
done with str replace all() and replacing the pattern [[:punct:]] with empty strings
"" (don’t forget to load the stringr package)
# remove punctuation
titles10 = str_replace_all(titles10, pattern = "[[:punct:]]", "")
titles10
## [1] "AIDS Research and Therapy"
## [2] "AMB Express"
## [3] "Acta Neuropathologica Communications"
## [4] "Acta Veterinaria Scandinavica"
## [5] "Addiction Science Clinical Practice"
## [6] "Agriculture Food Security"
## [7] "Algorithms for Molecular Biology"
## [8] "Allergy Asthma Clinical Immunology"
## [9] "Alzheimers Research Therapy"

## [10] "Animal Biotelemetry"
We succesfully replaced the punctuation symb ols with empty strings, but now we have extra
whitespaces. To remove the whitespaces we will use again str replace all() to replace any
one or more whitespaces \\s+ with a single blank space " ".
# trim extra whitespaces
titles10 = str_replace_all(titles10, pattern = " \\s+", " ")
titles10
## [1] "AIDS Research and Therapy"
## [2] "AMB Express"
## [3] "Acta Neuropathologica Communications"
## [4] "Acta Veterinaria Scandinavica"
## [5] "Addiction Science Clinical Practice"
## [6] "Agriculture Food Security"
## [7] "Algorithms for Molecular Biology"
## [8] "Allergy Asthma Clinical Immunology"
## [9] "Alzheimers Research Therapy"
## [10] "Animal Biotelemetry"
Once we have a better idea of how to preprocess the journal names, we can proceed with all
the 336 titles.
# remove punctuation symbols
all_titles = str_replace_all(biomed$Journal.name, pattern = "[[:punct:]]", "")
# trim extra whitespaces
all_titles = str_replace_all(all_titles, pattern = " \\s+", " ")
The next step is to split up the titles into its different terms (the output is a list).
# split titles by words
all_titles_list = str_split(all_titles, pattern = " ")
# show first 2 elements
all_titles_list[1:2]
## [[1]]
## [1] "AIDS" "Research" "and" "Therapy"
##
## [[2]]
## [1] "AMB" "Express"

Summary statistics
So far we have a list that contains the words of each journal name. Wouldn’t b e interes ting to
know more ab out the distribution of the numb er of terms in each title? This means that we
need to calculate how many words are in each title. To get these numb ers let’s use length()
within sapply(); and then let’s tabulate the obtained frequencies:
# how many words per title
words_per_title = sapply(all_titles_list, length)
# table of frequencies
table(words_per_title)
## words_per_title
## 1 2 3 4 5 6 7 8 9
## 17 108 81 55 33 31 6 4 1
We can also express the distribution as percentages, and we can get some summary statistics
with summary()
# distribution
100 * round(table(words_per_title)/sum(words_per_title), 4)
## words_per_title
## 1 2 3 4 5 6 7 8 9
## 1.50 9.56 7.17 4.87 2.92 2.74 0.53 0.35 0.09
# summary
summary(words_per_title)
## Min. 1st Qu. Median Mean 3rd Qu. Max.
## 1.00 2.00 3.00 3.36 4.00 9.00
Looking at summary statistics we can say that almost 10% of journal names have 2 words.
Likewise, the median number of words per title is 3 words.
Interestingly the maximum value is 9 words. What is the journal with 9 terms in its title?
We can find the longest journal name as follows:
# longest journal
all_titles[which(words_per_title == 9)]
## [1] "Journal of Venomous Animals and Toxins including Tropical Diseases"
7.4.2 Common words
Rememb er that our main goal with this example is to find out what words are the most
common in the journal titles. To answer this question we first need to create something like
a dictionary of words. How do get such dictionary? Easy, we just have to obtain a vector
containing all the words in the titles:
# vector of words in titles
title_words = unlist(all_titles_list)
# get unique words
unique_words = unique(title_words)
# how many unique words in total
num_unique_words = length(unique(title_words))
num_unique_words
## [1] 441
Applying unique() to the vector title words we get the desired dictionary of terms, which
has a total of 441 words.
Once we have the unique words, we need to count how many times each of them appears in
the titles. Here’s a way to do that:
# vector to store counts
count_words = rep(0, num_unique_words)
# count number of occurences
for (i in 1:num_unique_words) {
count_words[i] = sum(title_words == unique_words[i])
}
We can examine the obtained frequencies with a simple table:
# table of frequencies
table(count_words)
## count_words
## 1 2 3 4 5 6 7 9 10 12 13 16 22 24 28 30 65 67
## 318 61 24 8 5 7 1 2 2 2 1 2 1 1 1 1 1 1
## 83 86
## 1 1
The top 30 words
For illustration purp oses let’s examine which are the top 30 common words.
# index values in decreasing order
top_30_order = order(count_words, decreasing = TRUE)[1:30]
# top 30 frequencies
top_30_freqs = sort(count_words, decreasing = TRUE)[1:30]
# select top 30 words
top_30_words = unique_words[top_30_order]
To visualize the top 30 words we can plot them with a barchart using barplot():
# barplot
barplot(top_30_freqs, border = NA, names.arg = top_30_words,
las = 2, ylim = c(0,100))
Journal
of
BMC
and
Research
Medicine
Health
Biology
Clinical
International
Medical
Molecular
in
Science
Cell
Cancer
Disorders
Systems
Therapy
for
Environmental
Diseases
Surgery
Translational
Oncology
Practice
Annals
Policy
Cardiovascular
Biomedical
0
20
40
60
80
100
Wordcloud
To finish this section let’s try another visualization output by using a wordcloud, also known
as tag cloud. To get this type of graphical display we’ll use the package wordcloud (by Ian Fel
	lows). If you haven’t downloaded the package rememb er to install it with install.packages()
# installing wordcloud
install.packages("wordcloud")
# load wordcloud
library(wordcloud)
To plot a tag cloud with just need to use the function wordcloud(). The most basic usage
of this function has the following form:
wordcloud(words, freq}
It requires two main arguments: a character vector of words and a numeric vector freq with
the frequency of the words. In our example, the vector of words corresponds to the vector
unique words. In turn, the vector of frequencies corresponds to count words. Here’s the
code to plot the wordcloud with those terms having a minimun frequency of 6.
# wordcloud
wordcloud(unique_words, count_words, scale=c(8,.2), min.freq=6,
max.words=Inf, random.order=FALSE, rot.per=.15)


# #####################################################
R> objects()
[1] "CPS1985" "Journals" "cps" "cps2" "cps_bkde"
[6] "cps_lm" "cps_rq" "i" "j_lm"
which returns a character vector of length 9 telling us that there are currently
nine objects, resulting from the introductory session.
However, this cannot be the complete list of available objects, given that
some objects must already exist prior to the execution of any commands,
among them the function objects() that we just called. The reason is that
the search list, which can be queried by
R> search()
[1] ".GlobalEnv" "package:KernSmooth"
[3] "package:quantreg" "package:SparseM"
[5] "package:AER" "package:survival"
[7] "package:splines" "package:strucchange"
[9] "package:sandwich" "package:lmtest"
[11] "package:zoo" "package:car"
[13] "package:stats" "package:graphics"
[15] "package:grDevices" "package:utils"
[17] "package:datasets" "package:methods"
[19] "Autoloads" "package:base"


comprises not only the global environment ".GlobalEnv" (always at the first
position) but also several attached packages, including the base package at its
end. Calling objects("package:base") will show the names of more than a
thousand objects defined in base, including the function objects() itself.
Objects can easily be created by assigning a value to a name using the
assignment operator <-. For illustration, we create a vector x in which the
number 2 is stored:

objects("package:base")

File management
To query the working directory, use getwd() , and to change it, setwd() . If
an R session is started in a directory that has .RData and/or .Rhistory files,
these will automatically be loaded. Saved workspaces from other directories
can be loaded using the function load() . Analogously, R objects can be saved
(in binary format) by save() . To query the files in a directory, dir() can be
used.

1.4 Getting Help
R is well-documented software. Help on any function may be accessed using
either ? or help() . Thus
R> ?options
R> help("options")
both open the help page for the command options() . At the bottom of
a help page, there are typically practical examples of how to use that
function. These can easily be executed with the example() function; e.g.,
example("options") or example("lm") .
If the exact name of a command is not known, as will often be the
case for beginners, the functions to use are help.search() and apropos() .
help.search() returns help files with aliases or concepts or titles matching a
“pattern”using fuzzy matching. Thus, if help on options settings is desired but
the exact command name, here options() , is unknown, a search for objects
containing the pattern“option”might be useful. help.search("option") will
return a (long) list of commands, data frames, etc., containing this pattern,
including an entry
options(base) Options Settings
providing the desired result. It says that there exists a command options()
in the base package that provides options settings.
Alternatively, the function apropos() lists all functions whose names include the pattern entered. As an illustration,

R> apropos("help")
[1] "help" "help.search" "help.start"
provides a list with only three entries, including the desired command help().
Note that help.search() searches through all installed packages, whereas
apropos() just examines the objects currently in the search list.
Vignettes
On a more advanced level, there are so-called vignettes. They are PDF files
generated from integrated files containing both R code and documentation (in
LATEX format) and therefore typically contain commands that are directly ex
ecutable, reproducing the analysis described. This book was written by using
the tools that vignettes are based on. vignette() provides a list of vignettes
in all attached packages. (The meaning of “attached” will be explained in
Section 2.5.) As an example, vignette("strucchange-intro", package =
"strucchange") opens the vignette accompanying the package strucchange.
It is co-authored by the authors of this book and deals with testing, monitor
ing, and dating of structural changes in time series regressions. See Chapter 7
for further details on vignettes and related infrastructure.
Demos
There also exist“demos”for certain tasks. A demo is an interface to run some
demonstration R scripts. Type demo() for a list of available topics. These
include "graphics" and "lm.glm", the latter providing illustrations on linear
and generalized linear models. For beginners, running demo("graphics") is
highly recommended.
Manuals, FAQs, and publications
R also comes with a number of manuals:
• An Introduction to R
• R Data Import/Export
• R Language Definition
• Writing R Extensions
• R Installation and Administration
• R Internals
Furthermore, there are several collections of frequently asked questions
(FAQs) at http://CRAN.R-project.org/faqs.html that provide answers to
general questions about R and also about platform-specific issues on Microsoft
Windows and Mac OS X.
Moreover, there is an online newsletter named R News, launched in 2001.
It is currently published about three times per year and features, among other

