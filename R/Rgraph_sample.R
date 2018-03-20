plot(pressure)
text(150, 600,
"Pressure (mm Hg)\nversus\nTemperature (Celsius)")

barplot()
rect()
col, fg,
and bg
border
rect
mtext
col.axis, col.lab, col.main
col.sub
gamma

colours()
rgb(1, 0, 0)

col2rgb

An alternative way to provide an RGB color specification is to provide a
string of the form "#RRGGBB", where each of the pairs RR, GG, BB consist of
two hexadecimal digits giving a value in the range zero (00) to 255 (FF). In
this specification, the color red is given as "#FF0000".

There is also an hsv() function for specifying a color as a Hue-Saturation
Value (HSV) triplet. The terminology of color spaces is fraught, but roughly
speaking: hue corresponds to a position on the rainbow, from red (0),
through orange, yellow, green, blue, indigo, to violet (1); saturation deter
mines whether the color is dull or bright; and value determines whether the
color is light or dark. The HSV specification for the (very bright) color red is
hsv(0, 1, 1). The function rgb2hsv() converts a color specification from
RGB to HSV.

There is also a convertColor() function for converting colors between dif
ferent color spaces, including the CIELAB and CIELUV color spaces[46], in
which a unit distance represents a perceptually constant change in color. The
hcl() function allows colors to be specified directly as polar coordinates within
CIELUV (as a hue, chroma, and luminance triplet). This is like a perceptually
uniform version of HSV.∗ Ross Ihaka’s colorspace package[31] provides an
alternative set of functions for generating, converting, and combining colors
in a sophisticated manner in a wide variety of color spaces.
One final way to specify a color is simply as an integer index into a predefined
set of colors. The predefined set of colors can be viewed and modified using
the palette() function. In the default palette, red is specified as the integer
2.


rainbow() Colors vary from red through orange, yellow,
green, blue, and indigo, to violet.
heat.colors() Colors vary from white, through orange, to red.
terrain.colors() Colors vary from white, through brown, to green.
topo.colors() Colors vary from white, through brown then green,
to blue.
cm.colors() Colors vary from light blue, through white, to light
magenta.
grey() or gray() A set of shades of grey.

channel (e.g., rgb(1, 0, 0, 0.5) specifies a semitransparent red), or a color
can be specified as a string beginning with a "#" and followed by eight hexadecimal digits. In the latter case, the last two hexadecimal digits specify an
alpha value in the range 0 to 255 (e.g., "#FF000080" specifies a semitransparent red).

hcl(seq(0, 360, length=7)[-7], 50, 60)

RColorBrewer
colorRamp
colorRampPalette

These settings can only be controlled via arguments to the functions rect(),
polygon(), hist(), barplot(), pie(), and legend() (and not via par())


There are five graphics state settings for controlling the appearance of lines.
The lty setting describes the type of line to draw (solid, dashed, dotted, ...),
the lwd setting describes the width of lines, and the ljoin, lend, and lmitre
settings control how the ends and corners in lines are drawn (see below).

Specifying line types
R graphics supports a fixed set of predefined line types, which can be specified
by name, such as "solid" or "dashed", or as an integer index (see Figure
3.6). In addition, it is possible to specify customized line types via a string of
digits. In this case, each digit is a hexadecimal value that indicates a number
of “units” to draw either a line or a gap. Odd digits specify line lengths and
even digits specify gap lengths. For example, a dotted line is specified by
lty="13", which means draw a line of length one unit then a gap of length
three units. A unit corresponds to the current line width, so the result scales
with line width, but is device-dependent. Up to four such line-gap pairs can

Specifying line ends and joins
When drawing thick lines, it becomes important to select the style that is
used to draw corners (joins) in the line and the ends of the line. R provides
three styles for both cases: there is an lend setting to control line ends, which
can be "round" or flat (with two variations on flat, "square" or "butt"); and
there is an ljoin setting to control line joins, which can be "mitre" (pointy),
"round", or "bevel". The differences are most easily demonstrated visually
(see Figure 3.7).
When the line join style is "mitre", the join style will automatically be con
verted to "bevel" if the angle at the join is too small. This is to avoid
excessively pointy joins. The point at which the automatic conversion occurs
is controlled by a setting called lmitre, which specifies the ratio of the length
of the mitre divided by the line width. The default value is 10, which means
that the conversion occurs for joins where the angle is less than 11 degrees.
Other standard values are 2, which means that conversion occurs at angles less
than 60 degrees, and 1.414, which means that conversion occurs for angles
less than 90 degrees. The minimum mitre limit value is 1.
These settings can only be specified via par() (not as arguments to high
level or low-level graphics functions) and not all devices will respect them
(especially the line mitre limit).
It is important to remember that line join styles influence the corners on
rectangles and polygons as well as joins in lines.

3.2.3 Text
There are a large number of traditional graphics state settings for controlling
the appearance of text. The size of text is controlled via ps and cex; the font
is controlled via font and family; the justification of text is controlled via
adj; and the angle of rotation is controlled via srt.
There is also an ann setting, which indicates whether titles and axis labels
should be drawn on a plot. This is intended to apply to high-level functions,
but is not guaranteed to work with all such functions (especially functions
from add-on graphics packages). There are examples of the use of ann as an
argument to high-level plotting functions in Section 3.4.

# frm_eval_call_list(graphics::plot,x=mtcars$mpg,y=mtcars$mpg)
# frm_eval_call_list("plot",x=mtcars$mpg,y=mtcars$mpg)



frm_eval_call_list("graphics::plot",x=mtcars$mpg,y=mtcars$mpg)
`graphics::plot`(list(x = c(21, 21, 22.8, 21.4, 18.7, 18.1, 14.3,
24.4, 22.8, 19.2, 17.8, 16.4, 17.3, 15.2, 10.4, 10.4, 14.7, 32.4,
30.4, 33.9, 21.5, 15.5, 15.2, 13.3, 19.2, 27.3, 26, 30.4, 15.8,
19.7, 15, 21.4), y = c(21, 21, 22.8, 21.4, 18.7, 18.1, 14.3,
24.4, 22.8, 19.2, 17.8, 16.4, 17.3, 15.2, 10.4, 10.4, 14.7, 32.4,
30.4, 33.9, 21.5, 15.5, 15.2, 13.3, 19.2, 27.3, 26, 30.4, 15.8,
19.7, 15, 21.4)))

frm_eval_call_list(graphics::plot,x=mtcars$mpg,y=mtcars$mpg)
Browse[2]> Call
(function (x, y, ...)
UseMethod("plot"))(x = c(21, 21, 22.8, 21.4, 18.7, 18.1, 14.3,
24.4, 22.8, 19.2, 17.8, 16.4, 17.3, 15.2, 10.4, 10.4, 14.7, 32.4,
30.4, 33.9, 21.5, 15.5, 15.2, 13.3, 19.2, 27.3, 26, 30.4, 15.8,
19.7, 15, 21.4), y = c(21, 21, 22.8, 21.4, 18.7, 18.1, 14.3,
24.4, 22.8, 19.2, 17.8, 16.4, 17.3, 15.2, 10.4, 10.4, 14.7, 32.4,
30.4, 33.9, 21.5, 15.5, 15.2, 13.3, 19.2, 27.3, 26, 30.4, 15.8,
19.7, 15, 21.4))

