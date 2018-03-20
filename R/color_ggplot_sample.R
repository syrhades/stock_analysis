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

ggplot(df, aes(x=cond, y=yval)) + 
    geom_line(aes(group=1), colour="#000099") +  # Blue lines
    geom_point(size=3, colour="#CC0000")         # Red dots
    
# Equivalent to above; but move "colour=cond2" into the global aes() mapping
ggplot(df2, aes(x=cond1, y=yval, colour=cond2)) + 
    geom_line(aes(group=cond2)) +
    geom_point(size=3)
    
    

# The palette with grey:
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# The palette with black:
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# To use for fills, add
  scale_fill_manual(values=cbPalette)

# To use for line and point colors, add
  scale_colour_manual(values=cbPalette)
# Generate some data
set.seed(133)
df <- data.frame(xval=rnorm(50), yval=rnorm(50))

# Make color depend on yval
ggplot(df, aes(x=xval, y=yval, colour=yval)) + geom_point()

# Use a different gradient
ggplot(df, aes(x=xval, y=yval, colour=yval)) + geom_point() + 
    scale_colour_gradientn(colours=rainbow(4))