It is also possible to explicitly request a range of times via this index-based
subsetting, using the ISO-recommended ¡°/¡± as the range seperater. The basic
form is ¡°from/to¡±, where both from and to are optional. If either side is missing,
it is interpretted as a request to retrieve data from the beginning, or through
the end of the data object.
Another benefit to this method is that exact starting and ending times need
not match the underlying data - the nearest available observation will be re
turned that is within the requested time period.
The following example shows how to extract the entire month of March
2007 - without having to manually identify the index positions or match the
underlying index type. The results have been abbreviated to save space.
> matrix_xts['2007-03']
Open High Low Close
2007-03-01 50.81620 50.81620 50.56451 50.57075
2007-03-02 50.60980 50.72061 50.50808 50.61559
2007-03-03 50.73241 50.73241 50.40929 50.41033
2007-03-04 50.39273 50.40881 50.24922 50.32636
2007-03-05 50.26501 50.34050 50.26501 50.29567

matrix_xts['/2007-01-07']
first(matrix_xts, '1 week')
first(last(matrix_xts, '1 week'), '3 days')

> indexClass(matrix_xts)
[1] "Date"
> indexClass(convertIndex(matrix_xts, 'POSIXct'))
[1] "POSIXct" "POSIXt"



# Two variables
df <- read.table(header=T, text='
 cond yval
    A 2
    B 2.5
    C 1.6
')

# Three variables
df2 <- read.table(header=T, text='
 cond1 cond2 yval
    A      I 2
    A      J 2.5
    A      K 1.6
    B      I 2.2
    B      J 2.4
    B      K 1.2
    C      I 1.7
    C      J 2.3
    C      K 1.9
')