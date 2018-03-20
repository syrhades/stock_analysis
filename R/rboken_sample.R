library(rbokeh)
h <- figure(width = 600, height = 400) %>%
  ly_hist(eruptions, data = faithful, breaks = 40, freq = FALSE) %>%
  ly_density(eruptions, data = faithful)
h

http://hafen.github.io/rbokeh/index.html

p <- figure() %>%
  ly_points(Sepal.Length, Sepal.Width, data = iris,
    color = Species, glyph = Species,
    hover = list(Sepal.Length, Sepal.Width))
p



z <- lm(dist ~ speed, data = cars)
p <- figure(width = 600, height = 600) %>%
  ly_points(cars, hover = cars) %>%
  ly_lines(lowess(cars), legend = "lowess") %>%
  ly_abline(z, type = 2, legend = "lm")
p

h <- figure(width = 600, height = 400) %>%
  ly_hist(eruptions, data = faithful, breaks = 40, freq = FALSE) %>%
  ly_density(eruptions, data = faithful)
h




from math import pi

import pandas as pd

from bokeh.plotting import figure, show, output_file
from bokeh.sampledata.stocks import MSFT

df = pd.DataFrame(MSFT)[:50]
df["date"] = pd.to_datetime(df["date"])

inc = df.close > df.open
dec = df.open > df.close
w = 12*60*60*1000 # half day in ms

TOOLS = "pan,wheel_zoom,box_zoom,reset,save"

p = figure(x_axis_type="datetime", tools=TOOLS, plot_width=1000, title = "MSFT Candlestick")
p.xaxis.major_label_orientation = pi/4
p.grid.grid_line_alpha=0.3

p.segment(df.date, df.high, df.date, df.low, color="black")
p.vbar(df.date[inc], w, df.open[inc], df.close[inc], fill_color="#D5E1DD", line_color="black")
p.vbar(df.date[dec], w, df.open[dec], df.close[dec], fill_color="#F2583E", line_color="black")

output_file("candlestick.html", title="candlestick.py example")


show(p)  # open a browser



from bokeh.plotting import figure, show, output_file

output_file('vbar.html')

p = figure(plot_width=400, plot_height=400)
p.vbar(x=[1, 2, 3], width=0.5, bottom=0,
       top=[1.2, 2.5, 3.7], color="firebrick")

show(p)



p <- figure() %>%
  ly_points(Sepal.Length, Sepal.Width, data = iris,
    # color = Species, glyph = Species,
    hover = list(Sepal.Length, Sepal.Width))
p

library(maps)
data(world.cities)
caps <- subset(world.cities, capital == 1)
caps$population <- prettyNum(caps$pop, big.mark = ",")
figure(width = 800, height = 450, padding_factor = 0) %>%
  ly_map("world", col = "gray") %>%
  ly_points(long, lat, data = caps, size = 5,
    hover = c(name, country.etc, population))

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


p <- figure(title = "Volcano", padding_factor = 0) %>%
  ly_image(volcano) %>%
  ly_contour(volcano)
p

figure(ylab = "Height (inches)", width = 600) %>%
  ly_boxplot(voice.part, height, data = lattice::singer)

  figure(legend_location = "top_left") %>%
  ly_quantile(Sepal.Length, group = Species, data = iris)



  wa_cancer <- droplevels(subset(latticeExtra::USCancerRates, state == "Washington"))
## y axis sorted by male rate
ylim <- levels(with(wa_cancer, reorder(county, rate.male)))

figure(ylim = ylim, width = 700, height = 600, tools = "") %>%
  ly_segments(LCL95.male, county, UCL95.male,
    county, data = wa_cancer, color = NULL, width = 2) %>%
  ly_points(rate.male, county, glyph = 16, data = wa_cancer)



df1<-frm_read_stock(157)

figure(width=1200, height=500)%>%
ly_lines(date,close,df1)
x_axis(label = "Date", format = list(months = "%b"))%>%




, x_axis_type="datetime"


p.line(df['date'], df['close'], color='navy', alpha=0.5)

show(p)