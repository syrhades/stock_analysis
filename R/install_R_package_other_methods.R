 最后找出的成功方法是自己下载source文件包，本地安装。使用命令：

install.packages('/tmp/quantstrat_0.7.8.tar.gz',repos=NULL,typ

e='source')


http://r-forge.r-project.org/R/?group_id=316

https://zhuanlan.zhihu.com/p/20232919?columnSlug=scientific-invest









首发于 科学投资 登录 写文章 如何搭建量化投资研究系统之三（工具篇quantstrat） 王喆 · 1 年前

    本篇「科学投资」文章来自知友 @徐瑞龙 的投稿。希望越来越多读者能够投稿给「科学投资」专栏或公众号（kexuetouzi）。

    这已经是该系列的第三篇文章，前两篇请见下： 如何搭建量化投资研究系统？（数据篇） - 科学投资 -
    知乎专栏如何搭建量化投资研究系统？（工具篇之quantmod） - 科学投资 - 知乎专栏


“谋定而后动，知止而有得”。

成功的投资离不开事先的谋划研究和事后的及时止损。量化投资研究系统中非常重要一个的部分就是投资策略的测试、评估和优化。先前的《工具篇之quantmod》只是解
决了金融数据可视化的问题，通过经验观察获得的想法和灵感必须经过严格测试和筛选才能上升为策略。下面介绍如何在R中使用quantstrat包测试交易策略，做到“
谋定而后动”。 quantstrat简介

quantstrat全称为Quantitative Strategy Model Framework，设计目标是在R中为测试交易策略、模拟交易系统提供支持，
quantstrat是TradeAnalytics项目一个重要组成部分。quantstrat可以看做是quantmod的升级版本，弥补了quantmod在交
易策略构建、回测方面的不足。不过quantstrat目前还处在开发中，没有发布正式版本，要安装使用的话，请参考下面的链接：R-Forge:
TradeAnalytics: R Development Page。

就复杂程度而言，quantstrat确实超出quantmod很多，所以在介绍quantstrat的使用方法之前，读者先要对测试交易策略有宏观上的理解。

通常来讲，一个高度系统化的程序，其本质是在模拟现实。要模拟交易策略的话，先要考虑现实中执行交易策略会碰到哪些概念和问题。首先是交易对象，比如股票和期货合约；
第二是账户管理；第三是策略本身；第四是策略触发交易行为；第五是最终结果的绩效评估。那么，quantstrat是如何处理好这几个方面的？借用软件工程上的概念，
答案是“高内聚，低耦合”。实际上，quantstrat并不是一个大包大揽的、独立的R包，而是基于若干包的集合体，其中FinancialInstrument包
用来管理交易对象；blotter包用来管理账户信息；PerformanceAnalytics包用来评估交易策略；quantstrat包自身负责制定策略和模拟
交易行为。 quantstrat实践

言归正传，下面用一个完整的例子介绍quantstrat的使用。测试的交易策略很简单，当价格向上突破10月SMA时全资买入；当价格向下突破10月SMA时全部卖
出。选取平安银行为交易对象，时间段设定为2004-01-01至2015-09-01，10万元进场，期间不对账户注资或撤资。

一、数据准备

连接《数据篇》中建立的数据库，提取交易数据和复权信息，对数据做前复权和月度化处理。代码如下：

library(quantstrat)

library(stringr)

library(RMySQL)

# 一、数据准备 ----

# 1.交易数据 ----

conn <- dbConnect(drv = MySQL(), user = "用户名",

daname = "数据库名", password = "密码")

dbSendQuery(conn = conn, statement = "set names GBK;")

data <- dbGetQuery(conn = conn,

statement = "select date, open, high, low, close, voturnover

from iQI.equity_trading where code = '000001';")

PAYH <- xts(x = data[, -1], order.by =as.POSIXct(data[, 1]))

colnames(PAYH) <- str_c("PAYH.", c("Open", "High", "Low", "Close", "Volume"))

# 2.复权因子 ----

ref <- dbGetQuery(conn = conn,

statement = "select date, factor from

iQI.equity_rehabilitation where code = '000001';")

ref <- xts(x = ref[,2], order.by = as.POSIXct(ref[,1]))

# 3.复权调整 ----

date.intersect <- intersect(x = index(PAYH), y = index(ref))

PAYH <- PAYH[which(index(PAYH) %in% date.intersect),]

ref <- ref[which(index(ref) %in% date.intersect),]

ref[length(ref)]

# 2015-09-11 93.659

PAYH <- adjustOHLC(x = PAYH, ratio = ref/93.659)

PAYH <- PAYH["2004-01-01::2015-09-01"]

PAYH <- to.monthly(PAYH, indexAt = "endof", drop.time = FALSE)

chartSeries(PAYH)

处理后的交易数据

二、策略初始化

这一部分为交易策略设置基本的参数，包括起始时间、金额等，并为策略配置相应的账户、投资组合等必要组件。代码如下：

# 1.系数和数据的初始化 ----

initDate = "2003-12-31" #账户的初始化时间应早于测试策略的开始时间

startDate = "2004-01-01"

endDate = "2015-09-01"

initEq = 100000 #账户初始资金

currency("RMB") #设置货币

stock("PAYH", currency="RMB", multiplier=1) #产生“股票对象”PAYH

# 2.配置账户和策略 ----

my.strategy <- "SMAstrat" #为简化起见，策略、投资组合和账户的名字统一为SMAstrat

rm.strat(my.strategy) #如果需要的话清除之前运行的结果

#设置投资组合，包含股票PAYH

initPortf(name = my.strategy, symbols = "PAYH", initDate = initDate,

currency = "RMB")

#设置账户，管理资金和股票

initAcct(name = my.strategy, portfolios = my.strategy, initDate = initDate,

initEq = initEq, currency = "RMB")

#设置交易指令簿，管理交易信息

initOrders(portfolio = my.strategy, symbols = "PAYH", initDate = initDate)

#生成名为SMAstrat的策略对象

strategy(name = my.strategy, store = TRUE)

三、设置策略

这一步配置策略的具体细节。严格地讲，quantstrat是一个“基于信号的交易策略”模拟系统，quantstrat中的策略由三大部分组成：指标、信号和交易规
则。指标产生信号，信号触发交易，交易规则决定交易结果，在quantstrat中配置交易策略正是对应这三个部分进行的。代码如下：

# 1.添加指标 ----

add.indicator(strategy = my.strategy,#指定策略

name = "SMA", #指标调用名为SMA的函数

arguments = list(x = quote(Cl(mktdata)), n = 10),#SMA的参数设置

label = "SMA")#计算出的指标命名为SMA

在quantstrat中需要使用特定的“信号函数”根据指标产生交易信号，这里的策略是由两线交叉产生信号的，所以用函数sigCrossover。还存在其他的信
函函数如sigThreshold、sigComparison，分别对应不同的信号产生方式，也可以自定义信号函数。

# 2.添加信号 ----

# 信号：Close向上突破SMA

add.signal(strategy = my.strategy,

name = "sigCrossover",#调用信号函数sigCrossover，下面是函数参数

arguments = list(columns = c("Close", "SMA"), relationship = "gt"),

label = "Cl.gt.SMA")#计算出的信号命名为Cl.gt.SMA

# columns指明产生信号所需的数据，即Close和上面算出的指标SMA

# relationship指明数据间的关系，gt标示“大于”

# 信号：Close向下突破SMA

add.signal(strategy = my.strategy,

name = "sigCrossover",

arguments = list(columns = c("Close", "SMA"),relationship = "lt"),

label = "Cl.lt.SMA")

交易规则是策略中比较复杂的一部分，要设置规则使其根据信号确定买卖方向和数量。quantstrat中负责执行交易规则的默认“规则函数”是ruleSignal，
用户通过配置ruleSignal的参数来设置交易规则。

# 3.添加交易规则 ----

# 函数osPercentEquity根据账户中的一定比例的资金和当前价格确定要交易的股票数量，

# 默认情形是全资(trade.percent = 1.0)

osPercentEquity <- function(timestamp, orderqty, portfolio, symbol,

ruletype, trade.percent = 1.0, ...)



# 更新投资组合信息

updatePortf(Portfolio=portfolio, Dates=paste0('::', as.Date(timestamp)))

#获取到当前为止交易带来的损益情况

trading.pl <- sum(getPortfolio(portfolio)$summary$Net.Trading.PL)

# initEq + trading.pl = 可用金额

total.equity <- initEq + trading.pl

tradeSize <- total.equity * trade.percent

ClosePrice <- as.numeric(Cl(mktdata[timestamp,]))

orderqty <- sign(orderqty) * round(tradeSize/ClosePrice)

return(orderqty)



# 买入规则

add.rule(strategy = my.strategy,

name = "ruleSignal", #规则函数ruleSignal，下面是其参数

arguments = list(sigcol = "Cl.gt.SMA",#依据的信号

sigval = TRUE,#触发交易的信号值

orderqty = 100,#交易量，orderqty会交给osFUN函数处理

ordertype = "market",#市价下单

orderside = "long",#多头状态

osFUN = "osPercentEquity"),#确定下单数量的函数

type = "enter")#enter表示账户中加入了股票资产（不论空头还是多头）

# 卖出规则

add.rule(strategy = my.strategy,

name = "ruleSignal",

arguments = list(sigcol = "Cl.lt.SMA",

sigval = TRUE,

orderqty = "all",#全部卖出

ordertype = "market",

orderside = "long"),#卖出先前买入的股票，而非“卖空”，所以依然是多头状态

type = "exit")#exit表示账户中减少了股票资产（不论空头还是多头）

四、执行交易策略

配置完毕就可以运行策略了。

# 1.执行策略 ----

applyStrategy(strategy = my.strategy, #使用的策略

portfolios = my.strategy,#使用的投资组合

symbols = "PAYH")

# 2.更新账户信息 ----

updatePortf(Portfolio = my.strategy)

updateAcct(name = my.strategy)

updateEndEq(Account = my.strategy)

下面是部分交易结果：

2005-08-31 00:00:00 PAYH 55185 @ 1.812080（以1.81买入55185份）

2005-09-27 00:00:00 PAYH -55185 @ 1.675374（以1.67卖出55185份）

2005-12-30 00:00:00 PAYH 51770 @ 1.785902（以1.78买入51770份）

2006-07-31 00:00:00 PAYH -51770 @ 1.954603（以1.95卖出51770份）



五、策略的绩效分析

通过查看相关账户里的信息可以对策略的表现水平做出评价，getTxns函数可以查看交易细节；getAccount函数查看账户信息，包括资产变化水平，交易损益等
等；如果交易涉及若干只股票的话，getPortfolio函数可以查看每只股票对应的账户信息。

下面把策略执行的状况展示出来。

# 1.策略的执行情况 ----

my.theme <- chart_theme()

my.theme$col$dn.col <-'lightgreen'

my.theme$col$up.col <-'pink'

my.theme$col$dn.border <-'lightgreen'

my.theme$col$up.border <-'pink'

chart.Posn(Portfolio = my.strategy, Symbol = "PAYH", theme = my.theme)

add_SMA(n = 10, col = "blue", lwd = 2)

策略的执行状况

图中最上面一部分是交易数据和SMA指标，红色的小三角标示出卖出时间和价格，绿色的小三角标示出买入时间和价格；第二部分是账户中的股票数量，即仓位信息；第三部分
中的绿色曲线是去除初始投资后的净损益，红色曲线是损益的回撤。

下面比较一下SMAstrat策略和“买入持有”策略。

# 2.比较收益率----

my.return <- getAccount(Account = my.strategy)$summary$End.Eq / initEq

# 第一笔交易发生在2005-08-31，所以截取2005-08-31以来的数据

Cl <- Cl(PAYH["2005-08-31::"])

Cl.r <- Cl / coredata(Cl)[1]

comp <- cbind(my.return["2005-08::"], Cl.r)

colnames(comp) <- c("SMAstrat", "Buy&Hold")

chart.TimeSeries(comp,

legend.loc = "topleft",

colors = c("green", "red"),

xlab = "时间", ylab = "收益", main = "历史收益",

type = "o", pch = 20)

SMAstrat和“买入持有”策略的比较

图中可以看出SMAstrat的择时操作使其略优于“买入持有”，这主要得益于下跌时的止损行为，不过在价格变动不明显的阶段（例如10年10月至12年10月），“
磨线现象”给SMAstrat带来了损失。 总结

最后总结一下quantstrat的使用。首先，设置基本的参数，如时间、初始资产等；接着，配置交易要用到的交易对象、投资组合、账户和策略等；第三步，按照
“指标-信号-规则”的顺序配置策略；第四步，执行策略并评估结果。

先前的例子介绍了quantstrat最基本最简单的使用，当然，quantstrat的功能远不止如此，量化投资研究也远不止这样简单。quantstrat中的智
能化下单，止损机制，策略的参数优化，全面细致的绩效评估，一揽子策略测试等等高级内容今后会陆续向读者介绍。

在未来的「科学投资」文章中，我们会介绍更多科学的投资方法，帮助您实现资产的稳健增值，期待您关注「科学投资」微信公众号和知乎专栏阅读更多「科学投资」文章！最后
再次感谢本篇文章的作者@徐瑞龙 。 欢迎关注「科学投资 」微信公众号：kexuetouzi

量化交易金融金融 IT 分享 举报 87 刘佳路 罗星 yang wang 李亦章 豆包儿酱 文章被以下专栏收录

    科学投资

    有验证的投资 进入专栏

6 条评论

    进与退 太高端完全看不懂 1 年前 姚晔舟 这几天在玩quantstrat，正需要类似osPercentEquity的按资金比例决定order
    size的函数。谢谢。 1 年前 非凡猫 我的回测系统是自己写的，确实比使用现有的框架灵活实用的多。 1 年前 查看对话 流水 回复 非凡猫
    为了正确处理复权分红涨跌停限制等，同是自己写，只是数据处理比较占时间，回测也比较耗时…… 1 年前 Wang Eddy 如何收藏？ 1 年前 1 赞
    Michael Lee 请问 交易费用在哪里设置？ 9 个月前

推荐阅读

    关于在美国金融工程硕士专业找工作的问题

    本篇「科学投资」文章来自知友@杨柯敏 （杨柯敏主页）的投稿。希望越来越多读者能够投稿给「科学投资」专栏或公众号（kexuetouzi）。类似的文…
    查看全文 李腾 · 1 年前 发表于 科学投资 「大数据基金」在股市大跌中的表现如何？

    一、导语「科学投资」专栏曾在6月份的文章中评测过大数据基金（文章链接：评测「大数据基金」，是噱头还是未来？ - 科学投资 - 知乎专栏），…
    查看全文 王喆 · 2 年前 发表于 科学投资 中超93后巡礼——“将门虎子”高准翼

    提起高准翼，中国的老球迷都会这样介绍他，“这是高仲勋的儿子”。因为在上个世纪90年代，高仲勋不仅是延边乃至整个吉林足球的代表性人物，在… 查看全文
    创冰DATA · 1 个月前 · 编辑精选 中国式胖娃娃，很多都是肥胖症——现象、知识和误区

    新年之际，家家户户过年张贴的年画，总有个胖娃娃。他们手持莲子，怀抱鲤鱼，大圆脸总是笑咧咧的。这些胖娃娃，在年画界，真是个网红了。这些… 查看全文
    baobaotu · 15 天前 · 编辑精选 发表于 元宝心



    quantstrat-package {quantstrat} R Documentation Quantitative Strategy
Model Framework

Description

Transaction-oriented infrastructure for constructing trading systems and
simulation. Provides support for multi-asset class and multi-currency
portfolios for backtesting and other financial research. Still in heavy
development.

Details

quantstrat provides a generic infrastructure to model and backtest signal-
based quantitative strategies. It is a high-level abstraction layer (built on
xts, FinancialInstrument, blotter, etc.) that allows you to build and test
strategies in very few lines of code. quantstrat is still under heavy
development but is being used every day on real portfolios. We encourage you
to send contributions and test cases to the project forums.

Generic Signal-Based Strategy Modeling

A signal-based strategy model first generates indicators. Indicators are
quantitative values derived from market data (e.g. moving averages, RSI,
volatility bands, channels, momentum, etc.). Indicators should be applied to
market data in a vectorized (for fast backtesting) or streaming (for live
execution) fashion, and are assumed to be path-independent (i.e. they do not
depend on account / portfolio characteristics, current positions, or trades).

The interaction between indicators and market data are used to generate
signals (e.g. crossovers, thresholds, multiples, etc.). These signals are
points in time at which you may want to take some action, even though you may
not be able to. Like indicators, signals may be applied in a vectorized or
streaming fashion, and are assumed to be path-independent.

Rules use market data, indicators, signals, and current account / portfolio
characteristics to generate orders. Notice that rules about position sizing,
fill simulation, order generation / management, etc. are separate from the
indicator and signal generation process. Unlike indicators and signals, rules
are generally evaluated in a path-dependent fashion (path-independent rules
are supported but are rare in real life) and are aware of all prior market
data and current positions at the time of evaluation. Rules may either
generate new or modify existing orders (e.g. risk management, fill, rebalance,
entry, exit).

How quantstrat Models Strategies

quantstrat uses FinancialInstrument to specify instruments (including their
currencies) and uses blotter to keep track of transactions, valuations, and
P&amp;amp;L across portfolios and accounts.

Indicators are often standard technical analysis functions like those found in
TTR; and signals are often specified by the quantstrat sig* functions (i.e.
sigComparison, sigCrossover, sigFormula, sigPeak, sigThreshold). Rules are
typically specified with the quantstrat ruleSignal function.

The functions used to specify indicators, signals, and rules are not limited
to those mentioned previously. The name parameter to add.indicator,
add.signal, and add.rule can be any R function. Because the supporting
toolchain is built using xts objects, custom functions will integrate most
easily if they return xts objects.

The strategy model is created in layers and makes use of delayed execution.
This means strategies can be applied–unmodified–to several different
portfolios. Before execution, quantstrat strategy objects do not know what
instruments they will be applied to or what parameters will be passed to them.

For example, indicator parameters such as moving average periods or thresholds
are likely to affect strategy performance. Default values for parameters may
(optionally) be set in the strategy object, or set at call-time via the
parameters argument of applyStrategy (parameters is a named list, used like
the arguments lists).

quantstrat models orders, which may or may not become transactions. This
provides a lot of extra ability to evaluate how the strategy is actually
working, not working, or could be improved. For example, the performance of
strategies are often affected by how often resting limit orders are changed /
replaced / canceled. An order book allows the quantitative strategist to
examine market conditions at the time these decisions are made. Also, the
order history allows for easy computation of things that are important for
many strategies, like order-to-fill ratios.

Argument Matching

Many places in quantstrat apply arguments passed in the strategy
specification, the parameters list, or in ... to an indicator, signal, or rule
function. These arguments are matched in this order, with the last math
overriding. Specifically, this order is:

the arguments=list(...) assigned to each indicator, signal, or rule

the parameters=list{...} applied when applyStrategy is called

any additional arguments passed in ... in the call to applyStrategy

Author(s)

Peter Carl, Brian G. Peterson, Joshua Ulrich, Garrett See, Yu Chen

Maintainer: Brian G. Peterson <brian@braverock.com>

See Also

quantmod, blotter, FinancialInstrument, blotter, PerformanceAnalytics
