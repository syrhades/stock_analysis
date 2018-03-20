p <- figure() %>%
  ly_points(Sepal.Length, Sepal.Width, data = iris,
    color = Species, glyph = Species,
    hover = list(Sepal.Length, Sepal.Width))
p
#######################

z <- lm(dist ~ speed, data = cars)
p <- figure(width = 600, height = 600) %>%
  ly_points(cars, hover = cars) %>%
  ly_lines(lowess(cars), legend = "lowess") %>%
  ly_abline(z, type = 2, legend = "lm")
p

#######################
h <- figure(width = 600, height = 400) %>%
  ly_hist(eruptions, data = faithful, breaks = 40, freq = FALSE) %>%
  ly_density(eruptions, data = faithful)
h
#######################
# prepare data
elements <- subset(elements, !is.na(group))
elements$group <- as.character(elements$group)
elements$period <- as.character(elements$period)

# add colors for groups
metals <- c("alkali metal", "alkaline earth metal", "halogen",
  "metal", "metalloid", "noble gas", "nonmetal", "transition metal")
colors <- c("#a6cee3", "#1f78b4", "#fdbf6f", "#b2df8a", "#33a02c",
  "#bbbb88", "#baa2a6", "#e08e79")
elements$color <- colors[match(elements$metal, metals)]
elements$type <- elements$metal

# make coordinates for labels
elements$symx <- paste(elements$group, ":0.1", sep = "")
elements$numbery <- paste(elements$period, ":0.8", sep = "")
elements$massy <- paste(elements$period, ":0.15", sep = "")
elements$namey <- paste(elements$period, ":0.3", sep = "")

# create figure
p <- figure(title = "Periodic Table", tools = c("resize", "hover"),
  ylim = as.character(c(7:1)), xlim = as.character(1:18),
  xgrid = FALSE, ygrid = FALSE, xlab = "", ylab = "",
  height = 445, width = 800) %>%

# plot rectangles
ly_crect(group, period, data = elements, 0.9, 0.9,
  fill_color = color, line_color = color, fill_alpha = 0.6,
  hover = list(name, atomic.number, type, atomic.mass,
    electronic.configuration)) %>%

# add symbol text
ly_text(symx, period, text = symbol, data = elements,
  font_style = "bold", font_size = "10pt",
  align = "left", baseline = "middle") %>%

# add atomic number text
ly_text(symx, numbery, text = atomic.number, data = elements,
  font_size = "6pt", align = "left", baseline = "middle") %>%

# add name text
ly_text(symx, namey, text = name, data = elements,
  font_size = "4pt", align = "left", baseline = "middle") %>%

# add atomic mass text
ly_text(symx, massy, text = atomic.mass, data = elements,
  font_size = "4pt", align = "left", baseline = "middle")

p

#######################
library(maps)
data(world.cities)
caps <- subset(world.cities, capital == 1)
caps$population <- prettyNum(caps$pop, big.mark = ",")
figure(width = 800, height = 450, padding_factor = 0) %>%
  ly_map("world", col = "gray") %>%
  ly_points(long, lat, data = caps, size = 5,
    hover = c(name, country.etc, population))


#######################
orstationc <- read.csv("http://geog.uoregon.edu/bartlein/old_courses/geog414s05/data/orstationc.csv")

gmap(lat = 44.1, lng = -120.767, zoom = 6, width = 700, height = 600) %>%
  ly_points(lon, lat, data = orstationc, alpha = 0.8, col = "red",
    hover = c(station, Name, elev, tann))
#######################
p <- figure(width = 800, height = 400) %>%
  ly_lines(date, Freq, data = flightfreq, alpha = 0.3) %>%
  ly_points(date, Freq, data = flightfreq,
    hover = list(date, Freq, dow), size = 5) %>%
  ly_abline(v = as.Date("2001-09-11"))
p

#######################
tools <- c("pan", "wheel_zoom", "box_zoom", "box_select", "reset")
nms <- expand.grid(names(iris)[1:4], rev(names(iris)[1:4]), stringsAsFactors = FALSE)
splom_list <- vector("list", 16)
for(ii in seq_len(nrow(nms))) {
  splom_list[[ii]] <- figure(width = 200, height = 200, tools = tools,
    xlab = nms$Var1[ii], ylab = nms$Var2[ii]) %>%
    ly_points(nms$Var1[ii], nms$Var2[ii], data = iris,
      color = Species, size = 5, legend = FALSE)
}
grid_plot(splom_list, ncol = 4, same_axes = TRUE, link_data = TRUE)

#######################
figure() %>% ly_hexbin(rnorm(10000), rnorm(10000))
#######################
doubles <- read.csv("https://gist.githubusercontent.com/hafen/77f25b556725b3d0066b/raw/10f0e811f09f2b9f0f9ccfb542e296dfac2761d4/doubles.csv")

ly_baseball <- function(x) {
  base_x <- c(90 * cos(pi/4), 0, 90 * cos(3 * pi/4), 0)
  base_y <- c(90 * cos(pi/4), sqrt(90^2 + 90^2), 90 * sin(pi/4), 0)
  distarc_x <- lapply(c(2:4) * 100, function(a)
    seq(a * cos(3 * pi/4), a * cos(pi/4), length = 200))
  distarc_y <- lapply(distarc_x, function(x)
    sqrt((x[1]/cos(3 * pi/4))^2 - x^2))

  x %>%
    ## boundary
    ly_segments(c(0, 0), c(0, 0), c(-300, 300), c(300, 300), alpha = 0.4) %>%
    ## bases
    ly_crect(base_x, base_y, width = 10, height = 10,
      angle = 45*pi/180, color = "black", alpha = 0.4) %>%
    ## infield/outfield boundary
    ly_curve(60.5 + sqrt(95^2 - x^2),
      from = base_x[3] - 26, to = base_x[1] + 26, alpha = 0.4) %>%
    ## distance arcs (ly_arc should work here and would be much simpler but doesn't)
    ly_multi_line(distarc_x, distarc_y, alpha = 0.4)
}

figure(xgrid = FALSE, ygrid = FALSE, width = 630, height = 540,
  xlab = "Horizontal distance from home plate (ft.)",
  ylab = "Vertical distance from home plate (ft.)") %>%
  ly_baseball() %>%
  ly_hexbin(doubles, xbins = 50, shape = 0.77, alpha = 0.75, palette = "Spectral10")

#######################
p <- figure(title = "Volcano", padding_factor = 0) %>%
  ly_image(volcano) %>%
  ly_contour(volcano)
p
#######################
# get data on number of CRAN packages over time (from Ecdat)
packages <- read.csv("https://gist.githubusercontent.com/hafen/117d731ad93c03bd5ec0079cbb38ab94/raw/04e7dc3aed1c6f5d82b1bb21460c0b589ef09d96/rpackages.csv",
  colClasses = c("numeric", "Date", "integer", "character"))

figure(data = packages) %>%
  ly_points(Date, Packages, hover = c(Version, Date, Packages)) %>%
  y_axis(log = TRUE)
#######################
url <- c("http://bokeh.pydata.org/en/latest/_static/images/logo.png",
  "http://developer.r-project.org/Logo/Rlogo-4.png")

ss <- seq(0, 2*pi, length = 13)[-1]
ws <- runif(12, 2.5, 5) * rep(c(1, 0.8), 6)

imgdat <- data.frame(
  x = sin(ss) * 10, y = cos(ss) * 10,
  w = ws, h = ws * rep(c(1, 0.76), 6),
  url = rep(url, 6)
)

p <- figure(xlab = "x", ylab = "y", height = 450) %>%
  ly_image_url(x, y, w = w, h = h, image_url = url, data = imgdat,
    anchor = "center") %>%
  ly_lines(sin(c(ss, ss[1])) * 10, cos(c(ss, ss[1])) * 10,
    width = 15, alpha = 0.1)
p


#######################
figure(ylab = "Height (inches)", width = 600) %>%
  ly_boxplot(voice.part, height, data = lattice::singer)

#######################
figure(legend_location = "top_left") %>%
  ly_quantile(Sepal.Length, group = Species, data = iris)
#######################
wa_cancer <- droplevels(subset(latticeExtra::USCancerRates, state == "Washington"))
## y axis sorted by male rate
ylim <- levels(with(wa_cancer, reorder(county, rate.male)))

figure(ylim = ylim, width = 700, height = 600, tools = "") %>%
  ly_segments(LCL95.male, county, UCL95.male,
    county, data = wa_cancer, color = NULL, width = 2) %>%
  ly_points(rate.male, county, glyph = 16, data = wa_cancer)

#######################
p <- ly_points(p, cars$speed, cars$dist)
#######################
p <- figure() %>%
  ly_points(cars$speed, cars$dist)
#######################
p <- figure() %>%
  ly_points(cars$speed, cars$dist) %>%
  ly_abline(-17.6, 3.9)
p
#######################
p <- figure() %>%
  ly_points(speed, dist^2, data = cars)

#######################
figure() %>%
  ly_points(speed, data = cars)

  figure() %>%
  ly_points(cars)
#######################
figure() %>%
  ly_points(speed, dist, data = cars, hover = c(speed, dist))

#######################
figure() %>%
  ly_points(cars, color = "red", size = 20)

#######################
n <- nrow(cars)
ramp <- colorRampPalette(c("red", "blue"))(n)
figure() %>%
  ly_points(cars, color = ramp, size = seq_len(n))

#######################
attribute 	description
fill_color 	color to use to fill the glyph with - a hex code (with no alpha) or any of the 147 named CSS colors, e.g ‘green’, ‘indigo’
fill_alpha 	transparency value between 0 (transparent) and 1 (opaque)
line_color 	color to use to stroke lines with - a hex code (with no alpha) or any of the 147 named CSS colors, e.g ‘green’, ‘indigo’
line_width 	stroke width in units of pixels
line_alpha 	transparency value between 0 (transparent) and 1 (opaque)
line_join 	how path segments should be joined together ‘miter’ ‘round’ ‘bevel’
line_cap 	how path segments should be terminated ‘butt’ ‘round’ ‘square’
line_dash 	array of integer pixel distances that describe the on-off pattern of dashing to use

figure() %>%
  ly_points(cars, fill_color = "blue", line_color = "black")

#######################
figure() %>%
  ly_points(cars) %>%
  ly_lines(lowess(cars), color = "red", width = 2)

#######################

  point_types()
  figure() %>%
  ly_points(cars, glyph = 12)
#######################
figure() %>%
  ly_lines(lowess(cars), type = 2)
#######################
figure() %>%
  ly_points(Sepal.Length, Sepal.Width, data = iris, color = Species)
#######################
figure() %>%
  ly_points(Sepal.Length, Sepal.Width, data = iris,
    color = Species, glyph = Species)
#######################
figure() %>%
  ly_points(Sepal.Length, Sepal.Width, data = iris,
    color = Petal.Width)

#######################
co2dat <- data.frame(
  y = co2,
  x = floor(time(co2)),
  m = rep(month.abb, 39))

figure() %>%
  ly_lines(x, y, group = m, data = co2dat)
figure(xlim = c(1958, 2010)) %>%
  ly_lines(x, y, color = m, data = co2dat)  
#######################
z <- lm(dist ~ speed, data = cars)
figure(width = 600, height = 600) %>%
  ly_points(cars, hover = cars, legend = "data") %>%
  ly_lines(lowess(cars), legend = "lowess") %>%
  ly_abline(z, type = 2, legend = "lm")

#######################
figure() %>%
  ly_lines(seq(as.Date("2012-01-01"),
    as.Date("2012-12-31"), by="days"), rnorm(366)) %>%
  x_axis(label = "Date", format = list(months = "%b"))

figure() %>%
  ly_points(rnorm(10), rnorm(10) * 10000) %>%
  y_axis(number_formatter = "numeral", format = "0,000")
#######################
figure() %>%
  ly_points(Sepal.Length, Sepal.Width, data = iris, color = Species) %>%
  tool_box_select() %>%
  tool_lasso_select()
#######################
idx <- split(1:150, iris$Species)
figs <- lapply(idx, function(x) {
  figure(width = 300, height = 300) %>%
    ly_points(Sepal.Length, Sepal.Width, data = iris[x, ],
      hover = list(Sepal.Length, Sepal.Width))
})

# 1 row, 3 columns
grid_plot(figs)

#######################
 Initialize a Bokeh figure
Usage

figure(data = NULL, width = NULL, height = NULL, title = NULL, xlab = NULL, ylab = NULL, xlim = NULL, ylim = NULL, padding_factor = 0.07, xgrid = TRUE, ygrid = TRUE, xaxes = "below", yaxes = "left", legend_location = "top_right", tools = c("pan", "wheel_zoom", "box_zoom", "reset", "save", "help"), theme = getOption("bokeh_theme"), toolbar_location = "above", h_symmetry = TRUE, v_symmetry = FALSE, logo = NULL, lod_factor = 10, lod_interval = 300, lod_threshold = NULL, lod_timeout = 500, webgl = FALSE, ...)


#######################
figure() %>% ly_points(1:10)

#######################
# custom hover
mtcars$model <- row.names(mtcars)
figure() %>%
  ly_points(disp, mpg, data = mtcars, color = cyl,
    hover = "This <strong>@model</strong><br>has @hp horsepower!")


#######################
z <- lm(dist ~ speed, data = cars)
p <- figure() %>%
  ly_points(cars, hover = cars) %>%
  ly_lines(lowess(cars), legend = "lowess") %>%
  ly_abline(z, type = 2, legend = "lm", width = 2)
p

#######################
# abline with mixed axes for h and v
figure() %>%
  ly_points(1:26, letters) %>%
  ly_abline(h = "j") %>%
  ly_abline(v = 10)
#######################
figure() %>%
  ly_points(1:10) %>%
  ly_abline(v = 1:10) %>%
  ly_abline(h = 1:10)

figure() %>%
  ly_points(0:10) %>%
  ly_abline(0, seq(0, 1, by = 0.1))

z <- lm(dist ~ speed, data = cars)
p <- figure() %>%
  ly_points(cars, hover = cars) %>%
  ly_lines(lowess(cars), legend = "lowess") %>%
  ly_abline(z, type = 2, legend = "lm", width = 2)
p
#######################
chippy <- function(x) sin(cos(x)*exp(-x/2))
figure(width = 800) %>%
  ly_curve(chippy, -8, 7, n = 2001)


#######################
figure() %>%
  ly_bar(variety, data = lattice::barley) %>%
  theme_axis("x", major_label_orientation = 90)

#######################
# total yield per variety
figure() %>%
  ly_bar(variety, yield, data = lattice::barley, hover = TRUE) %>%
  theme_axis("x", major_label_orientation = 90)
#######################
# swap axes and add hover
figure() %>%
  ly_bar(yield, variety, data = lattice::barley, hover = TRUE)
#######################
# stack by year
figure() %>%
  ly_bar(variety, yield, color = year, data = lattice::barley, hover = TRUE) %>%
  theme_axis("x", major_label_orientation = 90)


#######################
# proportional bars
figure() %>%
  ly_bar(variety, yield, color = year,
    data = lattice::barley, position = "fill", width = 1) %>%
  theme_axis("x", major_label_orientation = 90) %>%
  set_palette(discrete_color = pal_color(c("red", "blue")))

#######################
# swap axes and use different palette
figure() %>%
  ly_bar(yield, variety, color = year,
    data = lattice::barley, position = "fill") %>%
  set_palette(discrete_color = pal_color(c("red", "blue")))

#######################
# side by side bars
figure() %>%
  ly_bar(variety, yield, color = year,
    data = lattice::barley, position = "dodge") %>%
  theme_axis("x", major_label_orientation = 90)
#######################
# use a different theme
figure() %>%
  ly_bar(variety, yield, color = year,
    data = lattice::barley, position = "dodge") %>%
  theme_axis("x", major_label_orientation = 90)


#######################
figure() %>%
  ly_points(rexp(1000), rexp(1000)) %>%
  x_axis(label = "x", log = TRUE) %>%
  y_axis(label = "y", log = TRUE)

#######################
figure() %>%
  ly_points(2 ^ (1:10)) %>%
  y_axis(log = 2)

#######################
# disable scientific tick labels
figure() %>%
  ly_points(rnorm(10), rnorm(10) / 1000) %>%
  y_axis(use_scientific = FALSE)

#######################
# specify datetime tick labels
# the appropriate datetime units are automatically chosen
big_range <- seq(as.Date("2012-01-01"), as.Date("2012-12-31"), by = "days")
small_range <- seq(as.Date("2012-01-01"), as.Date("2012-02-01"), by = "days")

figure() %>%
  ly_lines(big_range, rnorm(366)) %>%
  x_axis(label = "Date", format = list(months = "%b-%Y", days = "%d"))
#######################
figure() %>%
  ly_lines(small_range, rnorm(32)) %>%
  x_axis(label = "Date", format = list(months = "%b-%Y", days = "%d"))
#######################
# specify numeric tick labels
figure() %>%
  ly_points(rnorm(10), rnorm(10) * 10000) %>%
  y_axis(number_formatter = "numeral", format = "0,000")
#######################
figure() %>%
  ly_points(rnorm(10), rnorm(10) * 100) %>%
  y_axis(number_formatter = "printf", format = "%0.1f%%")
#######################

# get data from Duluth site in 'barley' data
du <- subset(lattice::barley, site == "Duluth")

# plot with default ranges
p <- figure(width = 600) %>%
  ly_points(yield, variety, color = year, data = du)
p
#######################
# y axis is alphabetical

# manually set x and y axis (y in order of 1932 yield)
p %>%
  x_range(c(20, 40)) %>%
  y_range(du$variety[order(subset(du, year == 1932)$yield)])
#######################
figure() %>%
  ly_points(rexp(1000), rexp(1000)) %>%
  x_axis(label = "x", log = TRUE) %>%
  y_axis(label = "y", log = TRUE)
#######################
figure() %>%
  ly_points(2 ^ (1:10)) %>%
  y_axis(log = 2)
#######################
# specify datetime tick labels
# the appropriate datetime units are automatically chosen
big_range <- seq(as.Date("2012-01-01"), as.Date("2012-12-31"), by = "days")
small_range <- seq(as.Date("2012-01-01"), as.Date("2012-02-01"), by = "days")

figure() %>%
  ly_lines(big_range, rnorm(366)) %>%
  x_axis(label = "Date", format = list(months = "%b-%Y", days = "%d"))
#######################
figure() %>%
  ly_points(1:10) %>%
  x_range(callback = console_callback()) %>%
  y_range(callback = console_callback())

#######################
# hover over the blue points and make the orange points move
figure(title = "hover a blue point") %>%
  ly_points(1:10, lname = "blue", lgroup = "g1") %>%
  ly_points(2:12, lname = "orange", lgroup = "g1") %>%
  tool_hover(custom_callback(
    code = "debugger;if(cb_data.index['1d'].indices.length > 0)
    orange_data.get('data').x[cb_data.index['1d'].indices] += 0.1
    orange_data.trigger('change')", "orange"), "blue")

#######################
rbokehOutput(outputId, width = "100%", height = "400px")
#######################

## Not run: 
# library("shiny")
# library("rbokeh")
# 
# ui <- fluidPage(
#   rbokehOutput("rbokeh")
# )
# 
# server <- function(input, output, session) {
#   output$rbokeh <- renderRbokeh({
#     # Use invalidateLater() and jitter() to add some motion
#     invalidateLater(1000, session)
#     figure() %>%
#       ly_points(jitter(cars$speed), jitter(cars$dist))
#   })
# }
# 
# shinyApp(ui, server)
# 
# 
# library("shiny")
# library("rbokeh")
# 
# ui <- fluidPage(
#   rbokehOutput("rbokeh", width = 500, height = 540),
#   textOutput("x_range_text")
# )
# 
# server <- function(input, output, session) {
#   output$rbokeh <- renderRbokeh({
#     figure() %>% ly_points(1:10) %>%
#       x_range(callback = shiny_callback("x_range"))
#   })
# 
#   output$x_range_text <- reactive({
#     xrng <- input$x_range
#     if(!is.null(xrng)) {
#       paste0("factors: ", xrng$factors, ", start: ", xrng$start,
#         ", end: ", xrng$end)
#     } else {
#       "waiting for axis event..."
#     }
#   })
# }
# 
# shinyApp(ui, server)
# ## End(Not run)


#######################
#######################
