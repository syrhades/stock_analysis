library("jsonlite")
## Warning: package 'jsonlite' was built under R version 3.3.1
toJSON(hc$x$hc_opts, pretty = TRUE, auto_unbox = TRUE)

http://www.cnblogs.com/tgzhu/category/863370.html


readRDS("C:/Users/carlos/Documents/R/win-library/3.3/highcharter/Meta/data.rds")

hc

• chart: This has confiurations for the top-level chart properties such as
layouts, dimensions, events, animations, and user interactions
• series: This is an array of series objects (consisting of data and specifi
options) for single and multiple series, where the series data can be specifid
in a number of ways


• xAxis/yAxis/zAxis: This has confiurations for all the axis properties such
as labels, styles, range, intervals, plotlines, plot bands, and backgrounds
• tooltip: This has the layout and format style confiurations for the series
data tool tips
• drilldown: This has confiurations for drilldown series and the ID fild
associated with the main series
• title/subtitle: This has the layout and style confiurations for the chart
title and subtitle
• legend: This has the layout and format style confiurations for the
chart legend
• plotOptions: This contains all the plotting options, such as display,
animation, and user interactions, for common series and specifi series types
• exporting: This has confiurations that control the layout and the function
of print and export features

http://api.highcharts.com
chart: {
 renderTo: 'container',
 type: ...
 marginTop: 10,
 marginRight: 0,
 spacingLeft: 30,
 spacingBottom: 0
 },

 Chart label properties
Chart labels such as xAxis.title, yAxis.title, legend, title, subtitle, and
credits share common property names, as follows:
• align: This is for the horizontal alignment of the label. Possible keywords are
'left' , 'center' , and 'right' . As for the axis title, it is 'low' , 'middle' ,
and 'high' .
• floating: This is to give the label position a flating effect on the plot area.
Setting this to true will cause the label position to have no effect on the
adjacent plot area's boundary.
• margin: This is the margin setting between the label and the side of the plot
area adjacent to it. Only certain label types have this setting.
• verticalAlign: This is for the vertical alignment of the label. The keywords
are 'top' , 'middle' , and 'bottom' .
• x: This is for horizontal positioning in relation to alignment.
• y: This is for vertical positioning in relation to alignment.
As for the labels' x and y positioning, they are not used for absolute positioning
within the chart. They are designed for fie adjustment with the label alignment. The
following diagram shows the coordinate directions, where the center represents the
label location:

title: {
text: 'Web browsers ...',
align: 'left'
},
subtitle: {
text: 'From 2008 to present',
align: 'right',
y: 15
},

title: {
text: 'Web browsers statistics'
},
subtitle: {
text: 'From 2008 to present',
verticalAlign: 'top',
y: 60
},

legend: {
align: 'right',
verticalAlign: 'middle',
layout: 'vertical'
},

legend: {
 align: 'right',
 verticalAlign: 'middle',
 layout: 'vertical',
 borderWidth: 1,
 borderRadius: 3
 },

 yAxis: {
 title: {
 text: 'Percentage %',
 rotation: 0,
 y: -15,
 margin: -70,
 align: 'high'
 },
 min: 0
 },

 legend: {
enabled: false
},
credits: {
position: {
align: 'left'
},
text: 'Joe Kuan',
href: 'http://joekuan.wordpress.com'
},


chart: {
spacingBottom: 30,
....
},
credits: {
position: {
align: 'left',
x: 20,
y: -7
},
},

chart: {
 renderTo: 'container',
 // border and plotBorder settings
 borderWidth: 2,
 .....
 },
 title: {
 text: 'Web browsers statistics,
 },


 chart: {
renderTo: 'container',
// border and plotBorder settings
.....
spacingTop: 0
},
title: {

	text: null,
margin: 0,
y: 0
}


chart: {
renderTo: 'container',
// border and plotBorder settings .....
},

title: {
text: 'Web browsers statistics',
verticalAlign: 'bottom'
},


title: {
text: 'Web browsers statistics',
verticalAlign: 'bottom',
y: -90
},

legend: {
 margin: 70,
 y: -10
 },



 chart: {
renderTo: 'container',
height: 250,
spacingRight: 20
},
title: {
text: 'Market Data: Nasdaq 100'
},
subtitle: {
text: 'May 11, 2012'
},
xAxis: {
categories: [ '9:30 am', '10:00 am', '10:30 am',
'11:00 am', '11:30 am', '12:00 pm',
'12:30 pm', '1:00 pm', '1:30 pm',
'2:00 pm', '2:30 pm', '3:00 pm',
'3:30 pm', '4:00 pm' ],
labels: {
step: 3
}
},
yAxis: {
title: {
text: null
}
},
legend: {
enabled: false
},
credits: {
enabled: false
},
series: [{
name: 'Nasdaq',
color: '#4572A7',
data: [ 2606.01, 2622.08, 2636.03, 2637.78, 2639.15,
2637.09, 2633.38, 2632.23, 2632.33, 2632.59,
2630.34, 2626.89, 2624.59, 2615.98 ]
}]


yAxis: {
title: {
text: null
},
tickInterval: 10,
minorTickInterval: 5,
minorGridLineColor: '#ADADAD',
minorGridLineDashStyle: 'dashdot'
}


To make the graph even more presentable, we add a striping effect with shading
using alternateGridColor. Then, we change the interval line color, gridLineColor,
to a similar range with the stripes. The following code snippet is added into the yAxis
confiuration:
gridLineColor: '#8AB8E6',
alternateGridColor: {
linearGradient: {
x1: 0, y1: 1,
x2: 1, y2: 1
},
stops: [ [0, '#FAFCFF' ],
[0.5, '#F5FAFF'] ,
[0.8, '#E0F0FF'] ,
[1, '#D6EBFF'] ]
}
We will discuss the color gradient later in this chapter. The following is the graph
with the new shading background:


lineWidth: 2,
 lineColor: '#92A8CD',
 tickWidth: 3,
 tickLength: 6,
 tickColor: '#92A8CD',
minorTickLength: 3,
minorTickWidth: 1,
minorTickColor: '#D8D8D8'



xAxis: {
type: 'datetime',
labels: {
formatter: function() {
return Highcharts.dateFormat('%I:%M %P', this.
value);
},
},
gridLineDashStyle: 'dot',
gridLineWidth: 1,
tickInterval: 60 * 60 * 1000,
lineWidth: 2,
lineColor: '#92A8CD',
tickWidth: 3,
tickLength: 6,
tickColor: '#92A8CD',
},

#############################
xAxis: {
 ....
 labels: {
 formatter: ...,
 y: 17
 },
 .....
 minPadding: 0.02,
 offset: 1
 }

 ###########################

 yAxis: {
 ... ,
 plotLines: [{
 value: 2606.01,
 width: 2,
 color: '#821740',
label: {
text: 'Lowest: 2606.01',
style: {
color: '#898989'
}
}
}, {
value: 2639.15,
width: 2,
color: '#4A9338',
label: {
text: 'Highest: 2639.15',
style: {
color: '#898989'
}
}
}]
}


plotLines: [{
... ,
label: {
... ,
x: 25
},
zIndex: 1
}, {
... ,
label: {
... ,
x: 130
},
zIndex: 1
}]



plotBands: [{
 from: 2606.01,
 to: 2615.98,
 label: {
 text: '▲ 9.97 (0.38%)',
 align: 'center',
 style: {
 color: '#007A3D'
 }
 },
zIndex: 1,
color: {
linearGradient: {
x1: 0, y1: 1,
x2: 1, y2: 1
},
stops: [ [0, '#EBFAEB' ],
[0.5, '#C2F0C2'] ,
[0.8, '#ADEBAD'] ,
[1, '#99E699']
]
}
}]



plotBands: [{
 from: 2606.01,
 to: 2615.98,
 label: {
 text: '▲ 9.97 (0.38%)',
 align: 'center',
 style: {
 color: '#007A3D'
 }

 },
zIndex: 1,
color: {
linearGradient: {
x1: 0, y1: 1,
x2: 1, y2: 1
},
stops: [ [0, '#EBFAEB' ],
[0.5, '#C2F0C2'] ,
[0.8, '#ADEBAD'] ,
[1, '#99E699']
]
}
}]

http://www.alt-codes.net

#############################
chart: ... ,
title: {
text: 'Market Data: Nasdaq & Dow Jones'
},
subtitle: ... ,
xAxis: ... ,
credits: ... ,
yAxis: {
title: {
text: null
},
minorGridLineColor: '#D8D8D8',
minorGridLineDashStyle: 'dashdot',
gridLineColor: '#8AB8E6',
alternateGridColor: {
linearGradient: {
x1: 0, y1: 1,
x2: 1, y2: 1
},
stops: [ [0, '#FAFCFF' ],
[0.5, '#F5FAFF'] ,
[0.8, '#E0F0FF'] ,
[1, '#D6EBFF'] ]
},
lineWidth: 2,
lineColor: '#92A8CD',
tickWidth: 3,
tickLength: 6,
tickColor: '#92A8CD',
minorTickLength: 3,
minorTickWidth: 1,
minorTickColor: '#D8D8D8'
},
series: [{
name: 'Nasdaq',
color: '#4572A7',
data: [ [ Date.UTC(2012, 4, 11, 9, 30), 2606.01 ],
[ Date.UTC(2012, 4, 11, 10), 2622.08 ],
[ Date.UTC(2012, 4, 11, 10, 30), 2636.03 ],
...
]
}, {
name: 'Dow Jones',
color: '#AA4643',
data: [ [ Date.UTC(2012, 4, 11, 9, 30), 12598.32 ],
[ Date.UTC(2012, 4, 11, 10), 12538.61 ],
[ Date.UTC(2012, 4, 11, 10, 30), 12549.89 ],
...
]
}]


yAxis: [{
 title: {
 text: 'Nasdaq'
 },
 }, {
 title: {
 text: 'Dow Jones'
 },
 opposite: true
 }],

 series: [{
name: 'Nasdaq',
color: '#4572A7',
yAxis: 0,
data: [ ... ]
}, {
name: 'Dow Jones',
color: '#AA4643',
yAxis: 1,
data: [ ... ]
}]


xAxis: {
... ,
minPadding: 0.02,
maxPadding: 0.02
},
yAxis: [{
title: {
text: 'Nasdaq'
},
lineWidth: 2,
lineColor: '#4572A7',
tickWidth: 3,
tickLength: 6,
tickColor: '#4572A7'
}, {
title: {
text: 'Dow Jones'
},

opposite: true,
lineWidth: 2,
lineColor: '#AA4643',
tickWidth: 3,
tickLength: 6,
tickColor: '#AA4643'
}],


######################
series: [{
 name: 'Nasdaq',
 pointStart: Date.UTC(2012, 4, 11, 9, 30),
 pointInterval: 30 * 60 * 1000,
 data: [{
 // First data point
 y: 2606.01,
 marker: {
 symbol: 'url(./sun.png)'
 }
 }, 2622.08, 2636.03, 2637.78,
 {
 // Highest data point
 y: 2639.15,
 dataLabels: {
 enabled: true
 },
 marker: {
 fillColor: '#33CC33',
 radius: 5
 }
 }, 2637.09, 2633.38, 2632.23, 2632.33,
 2632.59, 2630.34, 2626.89, 2624.59,
 {
 // Last data point
 y: 2615.98,
 marker: {
 symbol: 'url(./moon.png)'
 }
 }]
 }]


 chart.type
series[x].type
plotOptions.series.{seriesProperty}
plotOptions.{series-type}.{seriesProperty}
series[x].{seriesProperty}
plotOptions.points.events.*
series[x].data[y].events.*
plotOptions.series.marker.*
series[x].data[y].marker.*

########################

chart: {
 renderTo: 'container',
 height: 250,
 spacingRight: 30
 },
 title: {
 text: 'Market Data: Nasdaq 100'
 },
 subtitle: {
 text: '2011 - 2012'
 },
 xAxis: {
categories: [ 'Jan', 'Feb', 'Mar', 'Apr',
'May', 'Jun', 'Jul', 'Aug',
'Sep', 'Oct', 'Nov', 'Dec' ],
labels: {
y: 17
},
gridLineDashStyle: 'dot',
gridLineWidth: 1,
lineWidth: 2,
lineColor: '#92A8CD',
tickWidth: 3,
tickLength: 6,
tickColor: '#92A8CD',
minPadding: 0.04,
offset: 1
},
yAxis: [{
title: {
text: 'Nasdaq index'
},
min: 2000,
minorGridLineColor: '#D8D8D8',
minorGridLineDashStyle: 'dashdot',
gridLineColor: '#8AB8E6',
alternateGridColor: {
linearGradient: {
x1: 0, y1: 1,
x2: 1, y2: 1
},
stops: [ [0, '#FAFCFF' ],
[0.5, '#F5FAFF'] ,
[0.8, '#E0F0FF'] ,
[1, '#D6EBFF'] ]
},
lineWidth: 2,
lineColor: '#92A8CD',
tickWidth: 3,
tickLength: 6,
tickColor: '#92A8CD'
}, {
title: {
text: 'Volume'
},
lineWidth: 2,
lineColor: '#3D96AE',
tickWidth: 3,
tickLength: 6,
tickColor: '#3D96AE',
opposite: true
}],
credits: {
enabled: false
},
plotOptions: {
column: {
stacking: 'normal'
},
line: {
zIndex: 2,
marker: {
radius: 3,
lineColor: '#D9D9D9',
lineWidth: 1
},
dashStyle: 'ShortDot'
}
},
series: [{
name: 'Monthly High',
// Use stacking column chart - values on
// top of monthly low to simulate monthly
// high
data: [ 98.31, 118.08, 142.55, 160.68, ... ],
type: 'column',
color: '#4572A7'
}, {
name: 'Monthly Low',
data: [ 2237.73, 2285.44, 2217.43, ... ],
type: 'column',
color: '#AA4643'
}, {
name: 'Open (Start of the month)',
data: [ 2238.66, 2298.37, 2359.78, ... ],
color: '#89A54E'
}, {
	name: 'Close (End of the month)',
data: [ 2336.04, 2350.99, 2338.99, ... ],
color: '#80699B'
}, {
name: 'Volume',
data: [ 1630203800, 1944674700, 2121923300, ... ],
yAxis: 1,
type: 'column',
stacking: null,
color: '#3D96AE'
}]
}

##################
tooltip : {
shape: 'square',
crosshairs: [{
color: '#5D5D5D',
dashStyle: 'dash',
width: 2
}, {
color: '#5D5D5D',
dashStyle: 'dash',
width: 2
}]
},

<span style="color:{series.color}">{series.name}</span>:
<b>{point.y}</b><br/>



tooltip : {
useHTML: true,
shape: 'square',
headerFormat: '<table><thead><tr>' +
'<th style="border-bottom: 2px solid #6678b1; color:
#039" ' +
'colspan=2 >{point.key}</th></tr></thead><tbody>',
pointFormat: '<tr><td style="color: {series.color}">' +
'<img src="./series_{series.index}.png" ' +
'style="vertical-align:text-bottom; margin-right: 5px" >'
+
'{series.name}: </td><td style="text-align: right; color:
#669;">' +
'<b>{point.y}</b></td></tr>',
footerFormat: '</tbody></table>'
},

formatter: function() {
return '<span style="color:#039;font-weight:bold">' +
this.point.category +
'</span><br/><span style="color:' +
this.series.color + '">' + this.series.name +
'</span>: <span style="color:#669;font-weight:bold">'
+
this.point.y + '</span>';
}

##############
shared: true,
useHTML: true,
shape: 'square',
headerFormat: '<table><thead><tr><th colspan=2 >' +
'{point.key}</th></tr></thead><tbody>',
pointFormat: '<tr><td style="color: {series.color}">' +
'{series.name}: </td>' +
'<td style="text-align: right; color: #669;"> '
'<b>{point.y}</b></td></tr>',
footerFormat: '</tbody></table>'
##############################
shared: true,
shape: 'square',
formatter: function() {
return '<span style="color:#039;font-weight:bold">' +
this.x + '</span><br/>' +
this.points.map(function(point, idx) {
return '<span style="color:' + point.series.color +
'">' + point.series.name +
'</span>: <span style="color:#669;font
weight:bold">' +
Highcharts.numberFormat((idx == 0) ? point.total
: point.y) + '</span>';
}).join('<br/>');
}


##################
$(document).ready(function() {
 Highcharts.getOptions().colors[0] = {
 linearGradient: { x1: 0, y1: 0, x2: 1, y2: 0 },
 stops: [ [ 0, '#4572A7' ],
 [ 0.7, '#CCFFFF' ],
 [ 1, '#4572A7' ] ]
 };
 var chart = new Highcharts.Chart({ ...

 	###################

 	series: [{
 type: 'column',
 name: 'Web browsers',
 colorByPoint: true,
 data: [{
 name: 'Chrome', y: 55.8, drilldown: 'chrome'
 }, {
 name: 'Firefox', y: 26.8, drilldown: 'firefox',
 }, {
 name: 'Internet Explorer', y: 9, drilldown: 'ie'
 }, {
 name: 'Safari', y: 3.8
 }]
 }],

 ##########################
 var chart = new Highcharts.Chart({
 chart: {
 renderTo: 'container'
 },
 title: {
 text: 'Population ages 65 and over (% of total)'
 },
 credits: {
position: {
align: 'left',
x: 20
},
text: 'Data from The World Bank'
},
yAxis: {
title: {
text: 'Percentage %'
}
},
xAxis: {
categories: ['1980', '1981', '1982', ... ],
labels: {
step: 5
}
},
series: [{
name: 'Japan - 65 and over',
data: [ 9, 9, 9, 10, 10, 10, 10 ... ]
}]
});


 series: [{
lineWidth: 6,
name: 'Japan',
data: [ 9, 9, 9, 10, 10, 10, 10 ... ]
}, {
Name: 'Singapore',
data: [ 5, 5, 5, 5, ... ]
}, {
// Norway, Brazil, and South Africa series data...
...
}]


###############
plotOptions: {
series: {
marker: {
enabled: false
}
}
},
series: [{
marker: {
enabled: true
},
name: 'Japan - 65 and over',
type: 'spline',
data: [ 9, 9, 9, ... ]
}, {



	#######################
plotOptions: {
line: {
negativeColor: 'red'
}
},
series: [{
type: 'line',
color: '#0D3377',
marker: {
enabled: false
},
pointStart: 2004,
data:[ 2.9, 2.8, 2.4, 3.3, 4.7,
2.3, 1.1, 1.0, -0.3, -2.1
]
}]


##################
yAxis: {
title: { text: null },
min: 0,
max: 4,
plotLines: [{
value: 2,
width: 3,
color: '#6FA031',
zIndex: 1,
label: {
text: 'ECB....',
....
}
}]
},
xAxis: { type: 'datetime' },
plotOptions: {
line: { lineWidth: 3 }
},
series: [{
type: 'line',
name: 'EU Inflation (harmonized), year-over-year (%)',
color: '#0D3377',
marker: { enabled: false },
data:[
[ Date.UTC(2011, 8, 1), 3.3 ],
[ Date.UTC(2011, 9, 1), 3.3 ],
[ Date.UTC(2011, 10, 1), 3.3 ],
....




plotOptions: {
 line: {
 lineWidth: 3,
 negativeColor: 'red',
 threshold: 2
 }
 },



 yAxis: { ....
 gridLineWidth: 0,
 lineWidth: 1,
 }



 yAxis: { ....
title: {
text: '(%)',
rotation: 0,
x: 10,
y: 5,
align: 'high'
},
}

xAxis: { ....
 lineColor: '#CC2929',
 lineWidth: 4,
 tickWidth: 0,
 offset: 2
 }

 title: {
text: 'Population ages 65 and over (% of total) -
Japan ',
margin: 40,
align: 'right',
style: {fontFamily: 'palatino'
}
}


After that, we are going to modify the whole series presentation, so we fist change
the chart.type property from 'line'  to 'areaspline' . Notice that setting the
properties inside this series object will overwrite the same properties defied in
plotOptions.areaspline and so on in plotOptions.series.
Since so far there is only one series in the graph, there is no need to display the
legend box. We can disable it with the showInLegend property. We then smarten
the area part with a gradient color and the spline with a darker color:

series: [{
 showInLegend: false,
 lineColor: '#145252',
 fillColor: {
 linearGradient: {
 x1: 0, y1: 0,
 x2: 0, y2: 1
 },
 stops:[ [ 0.0, '#248F8F' ] ,
 [ 0.7, '#70DBDB' ],
 [ 1.0, '#EBFAFA' ] ]
 },
 data: [ ... ]
 }]

 plotOptions: {
series: {
marker: {
enabled: false
}
}
},
series: [{ ...,
data:[ 9, 9, 9, ...,

{ marker: {
radius: 2,
lineColor: '#CC2929',
lineWidth: 2,
fillColor: '#CC2929',
enabled: true
},
y: 14
}, 15, 15, 16, ... ]
}]


series: [{ ...,
 data:[ 9, 9, 9, ...,
 { marker: {
 ...
 },
 dataLabels: {
 enabled: true,
 borderRadius: 3,
 borderColor: '#CC2929',
 borderWidth: 1,
 y: -23,
 formatter: function() {
 return "Rank: 15th";
 }
 },
 y: 14
 }, 15, 15, 16, ... ]
 }]


 chart: {
 renderTo: 'container',
 spacingBottom: 30,
 backgroundColor: '#EAEAEA'
 },

 series: [{
name: 'project data',
type: 'spline',
showInLegend: false,
lineColor: '#145252',
dashStyle: 'Dash',
data: [ [ 2015, 26 ], [ 2016, 26.5 ],
... [ 2024, 28.5 ] ]
}]


series: [{
name: 'real data',
type: 'areaspline',
....
}, {
name: 'project data',
type: 'spline',
....
}]

####################
series: [{
 name: 'Ages 65 and over',
 type: 'areaspline',
 lineColor: '#145252',
 pointStart: 1980,
fillColor: {
....
},
data: [ 9, 9, 9, 10, ...., 23 ]
}, {
name: 'Ages 0 to 14',
// default type is line series
step: true,
pointStart: 1980,
data: [ 24, 23, 23, 23, 22, 22, 21,
20, 20, 19, 18, 18, 17, 17, 16, 16, 16,
15, 15, 15, 15, 14, 14, 14, 14, 14, 14,
14, 14, 13, 13 ]
}]

############
name: 'Ages 0 to 14',
type: 'areaspline',
pointStart: 1980,
data: [ 24, 23, 23, ... ]

plotOptions: {
areaspline: {
stacking: 'normal'
}
}


##################
plotOptions: {
series: {
marker: {
enabled: false
},
stacking: 'normal'
}
},
series: [{
name: 'Ages 65 and over',
....
}, {
name: 'Ages 0 to 14',
....
}, {
name: 'Ages 15 to 64',
type: 'areaspline',
pointStart: 1980,
stacking: null,
data: [ 67, 67, 68, 68, .... ]
}]




#################################

Overlapped column chart

plotOptions: {
 series: {
 pointPadding: -0.2,
 groupPadding: 0.3
 }
 },
 #################################
Stacking and grouping a column chart

 plotOptions: {
column: {
stacking: 'normal'
}
},
series: [{
name: 'UK',
data: [ 4351, 4190, 4028, .... ],
stack: 'Europe'
}, {
name: 'Germany',
data: [ 11894, 11957, 12140, ... ],
stack: 'Europe'
}, {
name: 'S.Korea',
data: [ 3763, 4009, 4132, ... ],
stack: 'Asia'
}, {name: 'Japan',
data: [ 34890, 36339, 37248, ... ],
stack: 'Asia'
}]

Mixing the stacked and single columns


plotOptions: {
column: {
stacking: 'normal'
}
},
series: [{
name: 'UK',
data: [ 4351, 4190, 4028, .... ]
}, {
name: 'Germany',
data: [ 11894, 11957, 12140, ... ]
}, {
name: 'S.Korea',
data: [ 3763, 4009, 4132, ... ]
}, {
name: 'Japan',
data: [ 34890, 36339, 37248, ... ]
}, {
name: 'US',
data: [ 98655, 97125, 98590, ... ],
stacking: null  ### important
}
}]

Comparing the columns in stacked percentages

plotOptions: {
 column: {
 stacking: 'percent'
 }
 }

 Adjusting column colors and data labels



xAxis: {
 categories: [
 'United States', 'Japan',
 'South Korea', ... ],
 labels: {
 rotation: -45,

 align: 'right'
}
},

yAxis: {
title: ... ,
type: 'logarithmic'
},

#############

plotOptions: {
 column: {
 colorByPoint: true,
 dataLabels: {
 enabled: true,
 rotation: -90,
 y: 25,
 color: '#F4F4F4',
 formatter: function() {
 return
 Highcharts.numberFormat(this.y, 0);
 },
 x: 10,
 style: {
 fontWeight: 'bold'
 }
 }
 }
 },

Introducing bar charts

 chart: {
 .... ,
 type: 'column',
 inverted: true
 },
 xAxis: {
 categories: [ 'United States',
 'Japan', 'South Korea', ... ]
 },
 yAxis: {
 .... ,
 labels: {
 rotation: -45,
 align: 'right'
 }
 },




 xAxis: {
 categories: [ 'United States',
 'Japan', 'South Korea', ... ]
 },
 yAxis: {
 .... ,
 labels: {
 rotation: -45,
 align: 'right'
 }
 },


 plotOptions: {
 column: {

 	..... ,
dataLabels: {
enabled: true,
color: '#F4F4F4',
x: -50,
y: 0,
formatter: ....,
style: ...
}
}


Giving the bar chart a simpler look

yAxis: {
title: {
text: null
},
labels: {
	enabled: false
},
gridLineWidth: 0,
type: 'logarithmic'
},



xAxis: {
categories: [ 'United States', 'Japan',
'South Korea', ... ],
lineWidth: 0,
tickLength: 0,
labels: {
align: 'left',
x: 0,
y: -13,
style: {
fontWeight: 'bold'
}
}
},

chart: {
renderTo: 'container',
type: 'column',
spacingLeft: 20,
plotBackgroundImage: 'chartBg.png',
inverted: true
},
title: {
text: null
},


Constructing a mirror chart
chart: {
 renderTo: 'container',
 type: 'column',
 borderWidth: 1
},
title: {
text: 'Number of Patents Granted'
},
credits: { ... },
xAxis: {
categories: [ '2001', '2002', '2003', ... ]
},
yAxis: {
title: {
text: 'No. of Patents'
}
},
plotOptions: {
series: {
stacking: 'normal'
}
},
series: [{
name: 'UK',
data: [ 4351, 4190, 4028, ... ]
}, {
name: 'China',
data: [ -265, -391, -424, ... ]
}]



chart: {
.... ,
type: 'bar'
},
xAxis: [{
categories: [ '2001', '2002', '2003', ... ]
}, {
categories: [ '2001', '2002', '2003', ... ],
opposite: true,
linkedTo: 0
}],
yAxis: {
.... ,
labels: {
formatter: function() {
return
Highcharts.numberFormat(Math.abs(this.value), 0);
}
}
},


Extending to a stacked mirror chart

series: [{
 name: 'UK',
 data: [ 4351, 4190, 4028, ... ],
 dataLabels : {
enabled: true,
backgroundColor: '#FFFFFF',
x: 40,
formatter: function() {
return
Highcharts.numberFormat(Math.abs(this.total), 0);
},
style: {
fontWeight: 'bold'
}
}
}, {
name: 'Germany',
data: [ 11894, 11957, 12140, ... ]
}, {
name: 'S.Korea',
data: [ -3763, -4009, -4132, ... ],
dataLabels : {
enabled: true,
x: -48,
backgroundColor: '#FFFFFF',
formatter: function() {
return
Highcharts.numberFormat(Math.abs(this.total), 0);
},
style: {
fontWeight: 'bold'
}
}
}, {
name: 'Japan',
data: [ -34890, -36339, -37248, ... ]
}]

Converting a single bar chart into a
horizontal gauge chart
chart: {
 renderTo: 'container',
 type: 'bar',
 plotBorderWidth: 2,
 plotBackgroundColor: '#D6D6EB',
 plotBorderColor: '#D8D8D8',
 plotShadow: true,
 spacingBottom: 43,
 width: 350,
 height: 120
 },

 xAxis: {
categories: [ 'US' ],
tickLength: 0
},
yAxis: {
title: {
text: null
},
labels: {
y: 20
},
min: 0,
max: 100,
tickInterval: 20,
minorTickInterval: 10,
tickWidth: 1,
tickLength: 8,
minorTickLength: 5,
minorTickWidth: 1,
minorGridLineWidth: 0
},


series: [{
borderColor: '#7070B8',
borderRadius: 3,
borderWidth: 1,
color: {
linearGradient:
{ x1: 0, y1: 0, x2: 1, y2: 0 },
stops: [ [ 0, '#D6D6EB' ],
[ 0.3, '#5C5CAD' ],
[ 0.45, '#5C5C9C' ],
[ 0.55, '#5C5C9C' ],
[ 0.7, '#5C5CAD' ],
[ 1, '#D6D6EB'] ]
},
pointWidth: 50,
data: [ 48.9 ]
}]


Sticking the charts together

chart: {
renderTo: 'container',
type: 'pie',
borderWidth: 1,
borderRadius: 5
},
title: {
text: 'Number of Software Games Sold in 2011 Grouped by
Publishers',
},
credits: {
...
},
series: [{
data: [ [ 'Nintendo', 54030288 ],
[ 'Electronic Arts', 31367739 ],
... ]
}]



########################
Confiuring the pie with sliced off sections
plotOptions: {
pie: {
slicedOffset: 20,
allowPointSelect: true,
dataLabels: {
style: {
width: '140px'
},
formatter: function() {
var str = this.point.name + ': ' +
Highcharts.numberFormat(this.y, 0);
return str;
}
}
}
},


series: [{
 data: [ {
 name: 'Nintendo',
 y: 54030288,
 sliced: true,
 dataLabels: {
 style: {
 fontWeight: 'bold'
 }
 }
 }, [ 'Electronic Arts', 31367739 ],
 [ 'Activision', 30230170 ], .... ]
 }]


 Plotting multiple pies in a chart – multiple
series

plotOptions:{
 pie: {
 ....,
 size: '75%'
 }
 },
 series: [{
 center: [ '25%', '50%' ],
 data: [ [ 'Nintendo', 54030288 ],
 [ 'Electronic Arts', 31367739 ],
 .... ]
 }, {center: [ '75%', '50%' ],
dataLabels: {
formatter: function() {
var str = this.point.name + ': ' +
Highcharts.numberFormat(this.percentage, 0) + '%';
return str;
}
},
data: [ [ 'Xbox', 80627548 ],
[ 'PS3', 64788830 ],
.... ]
}]

# #首先对集合A,B,C赋值
# > A<-1:10
# > B<-seq(5,15,2)
# > C<-1:5
# > #求A和B的并集
# > union(A,B)
#  [1]  1  2  3  4  5  6  7  8  9 10 11 13 15
# > #求A和B的交集
# > intersect(A,B)
# [1] 5 7 9
# > #求A-B
# > setdiff(A,B)
# [1]  1  2  3  4  6  8 10
# > #求B-A
# > setdiff(B,A)
# [1] 11 13 15
# > #检验集合A,B是否相同
# > setequal(A,B)
# [1] FALSE
# > #检验元素12是否属于集合C
# > is.element(12,C)
# [1] FALSE
# > #检验集合A是否包含C
# > all(C%in%A)
# [1] TRUE
# > all(C%in%B)
# [1] FALSE
page 156 173


eurkpw <- getSymbols("EUR/KPW", src="oanda", auto.assign = F)

dates <- as.Date(c("2015-05-08", "2015-09-12"), format = "%Y-%m-%d")
highchart(type = "stock") %>% 
  hc_title(text = "Charting some Symbols") %>% 
  hc_subtitle(text = "Data extracted using quantmod package") %>% 
  hc_add_series_xts(usdjpy, id = "usdjpy") %>% 
  hc_add_series_xts(eurkpw, id = "eurkpw") %>% 
  hc_add_series_flags(dates,
                      title = c("E1", "E2"), 
                      text = c("Event 1", "Event 2"),
                      id = "usdjpy") %>% 
  hc_add_theme(hc_theme_flat()) 

  data(unemployment)
data(uscountygeojson)

dclass <- data_frame(from = seq(0, 10, by = 2),
                     to = c(seq(2, 10, by = 2), 50),
                     color = substring(viridis(length(from), option = "C"), 0, 7))
dclass <- list.parse3(dclass)

highchart() %>% 
  hc_title(text = "US Counties unemployment rates, April 2015") %>% 
  hc_add_series_map(uscountygeojson, unemployment,
                    value = "value", joinBy = "code") %>% 
  hc_colorAxis(dataClasses = dclass) %>% 
  hc_legend(layout = "vertical", align = "right",
            floating = TRUE, valueDecimals = 0,
            valueSuffix = "%") %>% 
  hc_mapNavigation(enabled = TRUE) 