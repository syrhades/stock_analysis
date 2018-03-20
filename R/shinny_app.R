sudo grep --colour "aptit" *
install_r_package.R

# https://vimeo.com/rstudioinc/review/131218530/212d8a5a7a#t=0m0s
# http://shiny.rstudio.com/
https://cran.r-project.org/web/packages/available_packages_by_name.html


http://shiny.rstudio.com/tutorial/lesson1/
http://shiny.rstudio.com/articles/layout-guide.html
http://shiny.rstudio.com/articles/html-tags.html
http://shiny.rstudio.com/articles/tag-glossary.html
http://shiny.rstudio.com/articles/layout-guide.html
runApp("shinny_app1")


In the script below, output$text1 matches textOutput("text1") in your ui.R script.


render function 	creates
renderImage 	images (saved as a link to a source file)
renderPlot 	plots
renderPrint 	any printed output
renderTable 	data frame, matrix, other table like structures
renderText 	character strings
renderUI 	a Shiny tag object or HTML

http://shiny.rstudio.com/tutorial/lesson5/

In this lesson, you created your first reactive Shiny app. Along the way, you learned to

    use an *Output function in the ui.R script to place reactive objects in your Shiny app
    use a render* function in the server.R script to tell Shiny how to build your objects
    surround R expressions by braces, {}, in each render* function
    save your render* expressions in the output list, with one entry for each reactive object in your app.
    create reactivity by including an input value in a render* expression



Here’s what we’ve learned so far:

    The server.R script is run once, when you launch your app
    The unnamed function inside shinyServer is run once each time a user visits your app
    The R expressions inside render* functions are run many times. Shiny runs them once each time a user changes a widget.

How can you use this information?

Source scripts, load libraries, and read data sets at the beginning of server.R outside of the shinyServer function. Shiny will only run this code once, which is all you need to set your server up to run the R expressions contained in shinyServer.

Define user specific objects inside shinyServer’s unnamed function, but outside of any render* calls. These would be objects that you think each user will need their own personal copy of. For example, an object that records the user’s session information. This code will be run once per user.

Only place code that Shiny must rerun to build an object inside of a render* function. Shiny will rerun all of the code in a render* chunk each time a user changes a widget mentioned in the chunk. This can be quite often.

You should generally avoid placing code inside a render function that does not need to be there. The code will slow down the entire app.



###################################################################


To create a single-file app, create a new directory (for example, newdir/) and place a file called app.R in the directory. To run it, call runApp("newdir").

print(source("test.R"))


> setwd('~/sdcard/shinny_app1')
> print(source("app.R"))


To create your own Shiny app:

    Make a directory named for your app.

    Save your app’s server.R and ui.R script inside that directory.

    Launch the app with runApp or RStudio’s keyboard shortcuts.

    Exit the Shiny app by clicking escape.


Recap

You can create more complicated Shiny apps by loading R Scripts, packages, and data sets.

Keep in mind:

    The directory that server.R appears in will become the working directory of the Shiny app
    Shiny will run code placed at the start of server.R, before shinyServer, only once during the life of the app.
    Shiny will run code placed inside shinyServer multiple times, which can slow the app down.

You also learned that switch is a useful companion to multiple choice Shiny widgets. Use switch to change the values of a widget into R expressions.

As your apps become more complex, they can become inefficient and slow. Lesson 6 will show you how to build fast, modular apps with reactive expressions.

Recap

You can create more complicated Shiny apps by loading R Scripts, packages, and data sets.

Keep in mind:

    The directory that server.R appears in will become the working directory of the Shiny app
    Shiny will run code placed at the start of server.R, before shinyServer, only once during the life of the app.
    Shiny will run code placed inside shinyServer multiple times, which can slow the app down.

You also learned that switch is a useful companion to multiple choice Shiny widgets. Use switch to change the values of a widget into R expressions.

As your apps become more complex, they can become inefficient and slow. Lesson 6 will show you how to build fast, modular apps with reactive expressions.

Let’s summarize this behavior

    A reactive expression saves its result the first time you run it.

    The next time the reactive expression is called, it checks if the saved value has become out of date (i.e., whether the widgets it depends on have changed).

    If the value is out of date, the reactive object will recalculate it (and then save the new result).

    If the value is up-to-date, the reactive expression will return the saved value without doing any computation.

You can use this behavior to prevent Shiny from re-running unnecessary code. Consider how a reactive expression will work in the new stockVis app below.


    an input value in the objects’s render* function changes, or
    a reactive expression in the objects’s render* function becomes obsolete


Think of reactive expressions as links in a chain that connect input values to output objects. The objects in output will respond to changes made anywhere downstream in the chain. (You can fashion a long chain because reactive expressions can call other reactive expressions).

Only call a reactive expression from within a reactive or a render*function. Why? Only these R functions are equipped to deal with reactive output, which can change without warning. In fact, Shiny will prevent you from calling reactive expressions outside of these functions.
Recap

You can make your apps faster by modularizing your code with reactive expressions.

    A reactive expression takes input values, or values from other reactive expressions, and returns a new value
    Reactive expressions save their results, and will only re-calculate if their input has changed
    Create reactive expressions with reactive({ })
    Call reactive expressions with the name of the expression followed by parentheses ()
    Only call reactive expressions from within other reactive expressions or render* functions

You can now create sophisticated, streamlined Shiny apps. The final lesson in this tutorial will show you how to share your apps with others.

http://shiny.rstudio.com/tutorial/lesson6/


setwd('~/sdcard)
# run app
runApp("~/sdcard/shinny_test")
# > print(source("app.R"))

runApp("~/sdcard/shinny_test", display.mode = "showcase")
runApp("e:/shinny_stock", display.mode = "showcase")
runApp("/media/syrhades/DAA4BB34A4BB11CD/shiny-examples-master/008-html", display.mode = "showcase")

# http://nvd3.org/examples/discreteBar.html

http://jsfiddle.net/api/post/jquery/1.4/
runApp("e:/shiny-examples-master/063", display.mode = "showcase")


# refence function sample
runApp("/media/syrhades/DAA4BB34A4BB11CD/shiny-examples-master/012-datatables", display.mode = "showcase")
runApp("/media/syrhades/DAA4BB34A4BB11CD/shiny-examples-master/016-knitr-pdf/", display.mode = "showcase")
runApp("/media/syrhades/DAA4BB34A4BB11CD/shiny-examples-master/019-mathjax/", display.mode = "showcase")
runApp("/media/syrhades/DAA4BB34A4BB11CD/shiny-examples-master/020-knit-html/", display.mode = "showcase")
runApp("/media/syrhades/DAA4BB34A4BB11CD/shiny-examples-master/060-retirement-simulation/", display.mode = "showcase")
runApp("/media/syrhades/DAA4BB34A4BB11CD/shiny-examples-master/097-plot-interaction-article-2/", display.mode = "showcase")
runApp("/media/syrhades/DAA4BB34A4BB11CD/shiny-examples-master/088-action-pattern1/", display.mode = "showcase")
runApp("/media/syrhades/DAA4BB34A4BB11CD/shiny-examples-master/054-nvd3-line-chart-output/", display.mode = "showcase")

https://www.rdocumentation.org/
runApp("D:\\shinny_stock", display.mode = "showcase")
runApp("e:\\shinny_stock_fx", display.mode = "showcase")


grep -n '^[0-9]' stocklist2.log
grep '^[0-9]' stocklist2.log
grep -E '^[[:digit:]]{6}' stocklist2.log > stocklist2.log




http://data.eastmoney.com/notice/NoticeStock.aspx?stockcode=002269&type=1&pn=1


p +
  annotate("text", label = "plot mpg vs. wt", x = 2, y = 15, size = 8, colour = "red")


runApp("/media/syrhades/DAA4BB34A4BB11CD/shiny-examples-master/05", display.mode = "showcase")

R -e "shiny::runApp('~/shinyapp')"

http://shiny.rstudio.com/articles/help.html




Single-file Shiny apps
Added: 10 Sep 2014
By: Winston Chang

As of version 0.10.2, Shiny supports single-file applications. You no longer need to build separate server.R and ui.R files for your app; you can just create a file called app.R that contains both the server and UI components.
Example

To create a single-file app, create a new directory (for example, newdir/) and place a file called app.R in the directory. To run it, call runApp("newdir").

Your app.R file should call shinyApp() with an appropriate UI object and server function, as demonstrated below:

server <- function(input, output) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs), col = 'darkgray', border = 'white')
  })
}

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Number of observations:", min = 10, max = 500, value = 100)
    ),
    mainPanel(plotOutput("distPlot"))
  )
)

shinyApp(ui = ui, server = server)

One nice feature about single-file apps is that you can copy and paste the entire app into the R console, which makes it easy to quickly share code for others to experiment with. For example, if you copy and paste the code above into the R command line, it will start a Shiny app.
Details

The shinyApp() function returns an object of class shiny.appobj. When this is returned to the console, it is printed using the print.shiny.appobj() function, which launches a Shiny app from that object.

You can also use a similar technique to create and run files that aren’t named app.R and don’t reside in their own directory. If, for example, you create a file called test.R and have it call shinyApp() at the end, you could then run it from the console with:

print(source("test.R"))

When the file is sourced, it returns a shiny.appobj—but by default, the return value from source() isn’t printed. Wrapping it in print() causes Shiny to launch it.

This method is handy for quick experiments, but it lacks some advantages that you get from having an app.R in its own directory. When you do runApp("newdir"), Shiny will monitor the file for changes and reload the app if you reload your browser, which is useful for development. This doesn’t happen when you simply source the file. Also, Shiny Server and shinyapps.io expect an app to be in its own directory. So if you want to deploy your app, it should go in its own directory.

We love it when R users help each other, but RStudio does not monitor or answer the comments in this thread. If you'd like to get specific help, we recommend the Shiny Discussion Forum for in depth discussion of Shiny related questions and How to get help for a list of the best ways to get help with R code.




#########################################################

library(RCurl)
URL <- "https://raw.github.com/christophergandrud/d3Network/master/JSONdata/flare.json"
Flare <- getURL(URL)
# Convert to list format
Flare <- rjson::fromJSON(Flare)
# Recreate Bostock example from http://bl.ocks.org/mbostock/4063570
d3ClusterDendro(List = Flare,
file = "~/sdcard/FlareCluster.html", zoom = TRUE,
fontsize = 10, opacity = 0.9,
widthCollapse = 0.8)



data(MisLinks)
data(MisNodes)
# Create graph
htmlgraph <- d3ForceNetwork(Links = MisLinks, Nodes = MisNodes, Source = "source",
Target = "target", Value = "value", NodeID = "name",
Group = "group", opacity = 0.4)



# Fake data
Source <- c("A", "A", "A", "A", "B", "B", "C", "C", "D")
Target <- c("B", "C", "D", "J", "E", "F", "G", "H", "I")
NetworkData <- data.frame(Source, Target)
# Create graph
d3SimpleNetwork(NetworkData, height = 300, width = 700,
fontsize = 15)

https://cran.r-project.org/web/packages/V8/vignettes/v8_intro.html

https://cran.r-project.org/web/packages/V8/vignettes/v8_intro.htmlgraph

https://github.com/daattali/shinyjs/blob/master/README.md

https://github.com/daattali/shinyjs/blob/master/vignettes/shinyjs-extend.Rmd
http://www.highcharts.com/demo/line-ajax

ct$source(system.file("js/underscore.js", package="V8"))
ct$source(system.file("js/underscore.js", package="V8"))

ct$source("https://cdnjs.cloudflare.com/ajax/libs/crossfilter/1.3.11/crossfilter.min.js")
ct$source("~/sdcard/highcharts.js")
ct$source("http://code.highcharts.com/highcharts.js")
http://v1.hcharts.cn/docs/index.php?doc=basic-chart

##############################################
V8

https://cran.r-project.org/web/packages/V8/vignettes/v8_intro.html

ct <- v8()

ct$eval("var foo = 123")
ct$eval("var bar = 456")
ct$eval("foo + bar")
cat(ct$eval("JSON.stringify({x:Math.random()})"))

ct$eval("(function(x){return x+1;})(123)")

ct$source(system.file("js/underscore.js", package="V8"))
ct$source("https://cdnjs.cloudflare.com/ajax/libs/crossfilter/1.3.11/crossfilter.min.js")
ct$source("e:/highcharts.js")

ct$assign("mydata", mtcars)
ct$get("mydata")


ct$assign("foo", JS("function(x){return x*x}"))
ct$assign("bar", JS("foo(9)"))
ct$get("bar")


ct$call("_.filter", mtcars, JS("function(x){return x.mpg < 15}"))

data(diamonds, package = "ggplot2")
ct$assign("diamonds", diamonds)
ct$console()
http://pyjs.org/Download.html

vignette("develop_intro", package = "htmlwidgets")
   vignette("develop_sizing", package = "htmlwidgets")
   vignette("develop_advanced", package = "htmlwidgets")
https://cran.r-project.org/web/packages/available_packages_by_name.html

devtools::install_github('jjallaire/sigma')
sigma2 <- function (gexf, drawEdges = TRUE, drawNodes = TRUE, width = NULL, 
    height = NULL) 
{
    data <- paste(readLines(gexf), collapse = "\n")
    settings <- list(drawEdges = drawEdges, drawNodes = drawNodes)
    x <- list(data = data, settings = settings)
    return(x)
    # htmlwidgets::createWidget("sigma", x, width = width, height = height)
}
data <- system.file("examples/ediaspora.gexf.xml", package = "sigma")
sigma2(data)


devtools::create("mywidget")               # create package using devtools
setwd("mywidget")                          # navigate to package dir
htmlwidgets::scaffoldWidget("mywidget")    # create widget scaffolding
devtools::install()  


http://www.highcharts.com/docs/getting-started/your-first-chart
#####################################################3
## rmarkdown
#####################################################3


install.packages("rmarkdown")

library(rmarkdown)
render("~/sdcard/1-example.Rmd")



Sys.which("python")
```{python}
x = 'hello, python world!'
print(x.split(' '))
```

http://mc-stan.org/

```{css}
body {
  color: red;
}
```

```{js}
$('.title').remove()
```
http://api.jqueryui.com/
http://api.jquery.com/




http://rmarkdown.rstudio.com/formats.html

file:///media/syrhades/DAA4BB34A4BB11CD/Highstock-5.0.4/examples/flags-general/index.htm
runApp("E:\\shiny_stock_fx_v3")
runApp("E:\\shiny_stock_fx_hightcharts_v1")
runApp("E:\\R_shiny_call_highcharts_js_sample")





Building Inputs
Shiny comes equipped with a variety of useful input components, but as you build more ambitious applications, you may find yourself needing input widgets that we don’t include. Fortunately, Shiny is designed to let you create your own custom input components. If you can implement it using HTML, CSS, and JavaScript, you can use it as a Shiny input!

(If you’re only familiar with R and not with HTML/CSS/JavaScript, then you will likely find it tough to create all but the simplest custom input components on your own. However, other people can – and hopefully will – bundle up their custom Shiny input components as R packages and make them available to the rest of the community.)

Design the Component
The first steps in creating a custom input component is no different than in any other form of web development. You write HTML markup that lays out the component, CSS rules to style it, and use JavaScript (mostly event handlers) to give it behavior, if necessary.

Shiny input components should try to adhere to the following principles, if possible:

Designed to be used from HTML and R: Shiny user interfaces can either be written using R code (that generates HTML), or by writing the HTML directly. A well-designed Shiny input component will take both styles into account: offer an R function for creating the component, but also have thoughtfully designed and documented HTML markup.
Configurable using HTML attributes: Avoid requiring the user to make JavaScript calls to configure the component. Instead, it’s better to use HTML attributes. In your component’s JavaScript logic, you can easily access these values using jQuery (or simply by reading the DOM attribute directly).
When used in a Shiny application, your component’s HTML markup will be repeated once for each instance of the component on the page, but the CSS and JavaScript will generally only need to appear once, most likely in the <head>. For R-based interface code, you can use the functions singleton and tags$head together to ensure these tags appear once and only once, in the head. (See the full example below.)

Write an Input Binding
Each custom input component also needs an input binding, an object you create that tells Shiny how to identify instances of your component and how to interact with them. (Note that each instance of the input component doesn’t need its own input binding object; rather, all instances of a particular type of input component share a single input binding object.)

An input binding object needs to have the following methods:

find(scope)
Given an HTML document or element (scope), find any descendant elements that are an instance of your component and return them as an array (or array-like object). The other input binding methods all take an el argument; that value will always be an element that was returned from find.

A very common implementation is to use jQuery's find method to identify elements with a specific class, for example:

exampleInputBinding.find = function(scope) {
  return $(scope).find(".exampleComponentClass");
};
getId(el)
Return the Shiny input ID for the element el, or null if the element doesn't have an ID and should therefore be ignored. The default implementation in Shiny.InputBinding reads the data-input-id attribute and falls back to the element's id if not present.
getValue(el)
Return the Shiny value for the element el. This can be any JSON-compatible value.
setValue(el, value)
Set the element to the specified value. (This is not currently used, but in the future we anticipate adding features that will require the server to push input values to the client.)
subscribe(el, callback)
Subscribe to DOM events on the element el that indicate the value has changed. When the DOM events fire, call callback (a function) which will tell Shiny to retrieve the value.

We recommend using jQuery's event namespacing feature when subscribing, as unsubscribing becomes very easy (see unsubscribe, below). In this example, exampleComponentName is used as a namespace:

exampleInputBinding.subscribe = function(el, callback) {
  $(el).on("keyup.exampleComponentName", function(event) {
    callback(true);
  });
  $(el).on("change.exampleComponentName", function(event) {
    callback();
  });
};
Later on, we can unsubscribe ".exampleComponentName" which will remove all of our handlers without touching anyone else's.

The callback function optionally takes an argument: a boolean value that indicates whether the component's rate policy should apply (true means the rate policy should apply). See getRatePolicy below for more details.

unsubscribe(el)
Unsubscribe DOM event listeners that were bound in subscribe.

Example:

exampleInputBinding.unsubscribe = function(el) {
  $(el).off(".exampleComponentName");
};
getRatePolicy()
Return an object that describes the rate policy of this component (or null for default).

Rate policies are helpful for slowing down the rate at which input events get sent to the server. For example, as the user drags a slider from value A to value B, dozens of change events may occur. It would be wasteful to send all of those events to the server, where each event would potentially cause expensive computations to occur.

A rate policy slows down the rate of events using one of two algorithms (so far). Throttling means no more than one event will be sent per X milliseconds. Debouncing means all of the events will be ignored until no events have been received for X milliseconds, at which time the most recent event will be sent. This blog post goes into more detail about the difference between throttle and debounce.

A rate policy object has two members:

policy - Valid values are the strings "direct", "debounce", and "throttle". "direct" means that all events are sent immediately.
delay - Number indicating the number of milliseconds that should be used when debouncing or throttling. Has no effect if the policy is direct.
Rate policies are only applied when the callback function in subscribe is called with true as the first parameter. It's important that input components be able to control which events are rate-limited and which are not, as different events may have different expectations to the user. For example, for a textbox, it would make sense to rate-limit events while the user is typing, but if the user hits Enter or focus leaves the textbox, then the input should always be sent immediately.

Register Input Binding
Once you’ve created an input binding object, you need to tell Shiny to use it:

Shiny.inputBindings.register(exampleInputBinding, "yourname.exampleInputBinding");
The second argument is a name the user can use to change the priority of the binding. On the off chance that the user has multiple bindings that all want to claim the same HTML element as their own, this call can be used to control the priority of the bindings:

Shiny.inputBindings.setPriority("yourname.exampleInputBinding", 10);
Higher numbers indicate a higher priority; the default priority is 0. All of Shiny’s built-in input component bindings default to a priority of 0.

If two bindings have the same priority value, then the more recently registered binding has the higher priority.

Example
For this example, we’ll create a button that displays a number, whose value increases by one each time the button is clicked. Here’s what the end result will look like:

0​​​​​​​​​​​​​​​​​​​​​​​

To start, let’s design the HTML markup for this component:

<button id="inputId" class="increment btn" type="button">0</button>​​​​​​​​​​​​​​​​​​​​​​​
The CSS class increment is what will differentiate our buttons from any other kind of buttons. (The btn class is just to make the button look decent in Twitter Bootstrap.)

Now we’ll write the JavaScript that drives the button’s basic behavior:

$(document).on("click", "button.increment", function(evt) {

  // evt.target is the button that was clicked
  var el = $(evt.target);

  // Set the button's text to its current value plus 1
  el.text(parseInt(el.text()) + 1);

  // Raise an event to signal that the value changed
  el.trigger("change");
});
This code uses jQuery’s delegated events feature to bind all increment buttons at once.

Now we’ll create the Shiny binding object for our component, and register it:

var incrementBinding = new Shiny.InputBinding();
$.extend(incrementBinding, {
  find: function(scope) {
    return $(scope).find(".increment");
  },
  getValue: function(el) {
    return parseInt($(el).text());
  },
  setValue: function(el, value) {
    $(el).text(value);
  },
  subscribe: function(el, callback) {
    $(el).on("change.incrementBinding", function(e) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".incrementBinding");
  }
});

Shiny.inputBindings.register(incrementBinding);
Both the behavioral JavaScript code and the Shiny binding code should generally be run when the page loads. (It’s important that they run before Shiny initialization, which occurs after all the document ready event handlers are executed.)

The cleanest way to do this is to put both chunks of JavaScript into a file. In this case, we’ll use the path ./www/js/increment.js, which we can then access as http://localhost:8100/js/increment.js.

If you’re using an index.html style user interface, you’ll just need to add this line to your <head> (make sure it comes after the script tag that loads shiny.js):

<script src="js/increment.js"></script>
On the other hand, if you’re using ui.R, then you can define this function before the call to shinyUI:

incrementButton <- function(inputId, value = 0) {
  tagList(
    singleton(tags$head(tags$script(src = "js/increment.js"))),
    tags$button(id = inputId,
                class = "increment btn",
                type = "button",
                as.character(value))
  )
}
Then in your shinyUI page definition you can call incrementButton wherever you want an increment button rendered. Notice the line that begins with singleton will ensure that the increment.js file will be included just one time, in the <head>, no matter how many buttons you insert into the page or where you place them.



Notice the line that begins with singleton will ensure that the increment.js file will be included just one time, in the <head>, no matter how many buttons you insert into the page or where you place them.

path.package() %>% llply(function(x) grep(pattern="shiny", x, value = TRUE))

path.package() %>% llply(function(x) grep(pattern="chart", x, value = TRUE))

3.4
处理数组

var newCars = new Array("Toyota", "Honda", "Nissan");

3.5
处理有返回值的函数


install.packages("QuantTools")

https://quanttools.bitbucket.io/_site/sma_crossover.html

Rcpp::sourceCpp( 'e:/sma_crossover.cpp' )



http://www.paopaoche.net/danji/811.html

http://yihui.name/knitr/
https://www.rstudio.com/products/rpackages/
https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html
https://rstudio.github.io/DT/options.html
https://rstudio.github.io/DT/functions.html


x = strptime('2015-07-23 22:05:21', '%Y-%m-%d %H:%M:%S', tz = 'EST')
(x = x + seq(1, 1e6, length.out = 10))
##  [1] "2015-07-23 22:05:22 EST" "2015-07-25 04:57:13 EST"
##  [3] "2015-07-26 11:49:04 EST" "2015-07-27 18:40:55 EST"
##  [5] "2015-07-29 01:32:46 EST" "2015-07-30 08:24:37 EST"
##  [7] "2015-07-31 15:16:28 EST" "2015-08-01 22:08:19 EST"
##  [9] "2015-08-03 05:00:10 EST" "2015-08-04 11:52:01 EST"
DT:::DateMethods
## [1] "toDateString"       "toISOString"        "toLocaleDateString"
## [4] "toLocaleString"     "toLocaleTimeString" "toString"          
## [7] "toTimeString"       "toUTCString"
# use m = DT:::DateMethods below to see the output of all methods
m = c('toDateString', 'toLocaleDateString', 'toLocaleString', 'toUTCString')
d = as.data.frame(setNames(lapply(m, function(.) x), m))
str(d)
## 'data.frame':    10 obs. of  4 variables:
##  $ toDateString      : POSIXct, format: "2015-07-23 22:05:22" "2015-07-25 04:57:13" ...
##  $ toLocaleDateString: POSIXct, format: "2015-07-23 22:05:22" "2015-07-25 04:57:13" ...
##  $ toLocaleString    : POSIXct, format: "2015-07-23 22:05:22" "2015-07-25 04:57:13" ...
##  $ toUTCString       : POSIXct, format: "2015-07-23 22:05:22" "2015-07-25 04:57:13" ...
datatable(d, options = list(pageLength = 5, dom = 'tip')) %>%
  formatDate(1:ncol(d), m)

  datatable(iris, options = list(pageLength = 5)) %>%
  formatStyle('Sepal.Length',  color = 'red', backgroundColor = 'orange', fontWeight = 'bold')

  datatable(iris) %>% 
  formatStyle('Sepal.Length', fontWeight = styleInterval(5, c('normal', 'bold'))) %>%
  formatStyle(
    'Sepal.Width',
    color = styleInterval(c(3.4, 3.8), c('white', 'blue', 'red')),
    backgroundColor = styleInterval(3.4, c('gray', 'yellow'))
  ) %>%
  formatStyle(
    'Petal.Length',
    background = styleColorBar(iris$Petal.Length, 'steelblue'),
    backgroundSize = '100% 90%',
    backgroundRepeat = 'no-repeat',
    backgroundPosition = 'center'
  ) %>%
  formatStyle(
    'Species',
    transform = 'rotateX(45deg) rotateY(20deg) rotateZ(30deg)',
    backgroundColor = styleEqual(
      unique(iris$Species), c('lightblue', 'lightgreen', 'lightpink')
    )
  )

x = datatable(iris)
saveWidget(x, 'e:/iris-table.html')

http://www.htmlwidgets.org/
http://www.htmlwidgets.org/showcase_rbokeh.html

http://www.htmlwidgets.org/showcase_diagrammer.html
library(DiagrammeR)
grViz("
  digraph {
    layout = twopi
    node [shape = circle]
    A -> {B C D} 
  }")

library(highcharter)
highchart() %>% 
  hc_title(text = "Scatter chart with size and color") %>% 
  hc_add_serie_scatter(mtcars$wt, mtcars$mpg,
                       mtcars$drat, mtcars$hp)


###################################################

rbokeh
http://hafen.github.io/rbokeh

Bokeh is a visualization library that provides a flexible and powerful declarative framework for creating web-based plots.

library(rbokeh)
figure(width = NULL, height = NULL) %>%
  ly_points(Sepal.Length, Sepal.Width, data = iris,
    color = Species, glyph = Species,
    hover = list(Sepal.Length, Sepal.Width))


  Plotly
https://plot.ly/r/

Plotly allows you to easily translate your ggplot2 graphics to an interactive web-based version, and also provides bindings to the plotly.js graphing library.

library(plotly)
p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
            geom_bar(position = "dodge")
ggplotly(p)


d3heatmap
https://github.com/rstudio/d3heatmap

Interactive heatmaps with D3 including support for row/column highlighting and zooming.

library(d3heatmap)
d3heatmap(mtcars, scale="column", colors="Blues")


threejs
https://github.com/bwlewis/rthreejs

threejs includes a 3D scatterplot and 3D globe (you can directly manipulate the scatterplot below with the mouse).

library(threejs)
z <- seq(-10, 10, 0.01)
x <- cos(z)
y <- sin(z)
scatterplot3js(x,y,z, color=rainbow(length(z)))



visNetwork
http://dataknowledge.github.io/visNetwork

visNetwork provides an interface to the network visualization capabilties of the vis.js library.

library(visNetwork)
nodes <- data.frame(id = 1:6, title = paste("node", 1:6), 
                    shape = c("dot", "square"),
                    size = 10:15, color = c("blue", "red"))
edges <- data.frame(from = 1:5, to = c(5, 4, 6, 3, 3))
visNetwork(nodes, edges) %>%
  visOptions(highlightNearest = TRUE, nodesIdSelection = TRUE)

  http://rstudio.github.io/shinydashboard/structure.html

  http://shiny.rstudio.com/articles/building-inputs.html

  vignette("Rcpp-introduction")
  vignette("Rcpp-package")
##########################################################
  ## Not run: 
library("shiny")
library("rbokeh")

ui <- fluidPage(
  rbokehOutput("rbokeh")
)

server <- function(input, output, session) {
  output$rbokeh <- renderRbokeh({
    # Use invalidateLater() and jitter() to add some motion
    invalidateLater(1000, session)
    figure() %>%
      ly_points(jitter(cars$speed), jitter(cars$dist))
  })
}

shinyApp(ui, server)


library("shiny")
library("rbokeh")

ui <- fluidPage(
  rbokehOutput("rbokeh", width = 500, height = 540),
  textOutput("x_range_text")
)

server <- function(input, output, session) {
  output$rbokeh <- renderRbokeh({
    figure() %>% ly_points(1:10) %>%
      x_range(callback = shiny_callback("x_range"))
  })

  output$x_range_text <- reactive({
    xrng <- input$x_range
    if(!is.null(xrng)) {
      paste0("factors: ", xrng$factors, ", start: ", xrng$start,
        ", end: ", xrng$end)
    } else {
      "waiting for axis event..."
    }
  })
}

shinyApp(ui, server)

http://blog.sina.com.cn/s/blog_79f2c16f0102uzyy.html
dashboardPage(
  dashboardHeader(title = "Custom font"),
  dashboardSidebar(),
  dashboardBody(
    tags$head(tags$style(HTML('
      .main-header .logo {
        font-family: "Georgia", Times, "Times New Roman", serif;
        font-weight: bold;
        font-size: 24px;
      }
    ')))
  )
)

http://christophergandrud.github.io/d3Network/#RTTree
http://getbootstrap.com/components/#glyphicons

http://fontawesome.io/icons/