
# install.packages("pryr",repos="http://mirrors.ustc.edu.cn/CRAN/")            # 加载pryr包
# install.packages("Quandl")
# install.packages("R6")              # 加载R6包
# install.packages("stringr")
# source("/media/syrhades/DAA4BB34A4BB11CD/install_r_package.R")
#install.packages("iterators")
#install.packages("scrape")
install.packages("xtsExtra",repos="http://mirrors.ustc.edu.cn/CRAN/")

install.packages("data.table")
install.packages("devtools")
install.packages("DiagrammeR")
install.packages("dplyr")
install.packages("fBasics")
install.packages("ggplot2")
install.packages("htmlTable")
install.packages("hwriter")
install.packages("plyr")
install.packages("Quandl")
install.packages("quantmod")
install.packages("scales")
install.packages("sqldf")
install.packages("stringi")
install.packages("TTR")
install.packages("XML")
install.packages("xts")


sudo apt-get install libcairo2-dev libxt-dev
install.packages("Cairo",repos="http://mirrors.ustc.edu.cn/CRAN/")


sudo aptitude install libcurl4-openssl-dev
sudo aptitude install libssl-dev

install.packages("curl",repos="http://mirrors.ustc.edu.cn/CRAN/")
sudo apt-get install libxml2-dev
install.packages("XML",repos="http://mirrors.ustc.edu.cn/CRAN/")
install.packages("Quandl",repos="http://mirrors.ustc.edu.cn/CRAN/")

sudo cp python3.5-config python2.7-config
install.packages("PythonInR",repos="http://mirrors.ustc.edu.cn/CRAN/")
install.packages("rPython",repos="http://mirrors.ustc.edu.cn/CRAN/")
install.packages("XRPython",repos="http://mirrors.ustc.edu.cn/CRAN/")

library(devtools)
install_github("quandl/quandl-r")

install.packages("devtools",repos="http://mirrors.ustc.edu.cn/CRAN/")
install.packages("rbokeh",repos="http://mirrors.ustc.edu.cn/CRAN/")
install.packages("highcharter",repos="http://mirrors.ustc.edu.cn/CRAN/")
install.packages("dygraphs",repos="http://mirrors.ustc.edu.cn/CRAN/")
install.packages("shinydashboard",repos="http://mirrors.ustc.edu.cn/CRAN/")

install.packages("corrgram",lib=.libPaths()[3])

devtools::install_github("lchiffon/REmap")   #开发者/包名
install.packages('githubinstall')
library(githubinstall)
githubinstall('REmap')

[chengmo@centos5 shell]$ ls test.sh test1.sh 1>suc.txt 2>err.txt


http://blog.chinaunix.net/uid-9687384-id-1998469.html
http://bokeh.pydata.org/en/latest/
BokehJS Standalone¶

If you would like to use BokehJS as a standalone JavaScript library, there are two easy ways to get any published release.

First, released versions of BokehJS is available for download from CDN at pydata.org, under the following naming scheme:

http://cdn.pydata.org/bokeh/release/bokeh-x.y.z.min.js
http://cdn.pydata.org/bokeh/release/bokeh-widgets-x.y.z.min.js

for the BokehJS JavaScript files, and:

http://cdn.pydata.org/bokeh/release/bokeh-x.y.z.min.css
http://cdn.pydata.org/bokeh/release/bokeh-widgets-x.y.z.min.css

for the BokehJS CSS files.

The "-widgets" files are only necessary if you are using any of the widgets built into Bokeh in bokeh.models.widgets in your documents.

As a concrete example, the links for version 0.12 are:

    http://cdn.pydata.org/bokeh/release/bokeh-0.12.0.min.js
    http://cdn.pydata.org/bokeh/release/bokeh-widgets-0.12.0.min.js

and

    http://cdn.pydata.org/bokeh/release/bokeh-0.12.0.min.css
    http://cdn.pydata.org/bokeh/release/bokeh-widgets-0.12.0.min.css



winetricks mfc42 


wine 缺少 MFC42.DLL MSVCP60.dll 的解决
 
错误信息：
fixme:process:SetProcessDEPPolicy (1): stub
fixme:process:SetProcessDEPPolicy (1): stub
fixme:win:DisableProcessWindowsGhosting : stub
fixme:exec:SHELL_execute flags ignored: 0x00000100
err:module:import_dll Library MFC42.DLL (which is needed by L"C:\\users\\b456\\Temp\\is-SMTU5.tmp\\install.exe") not found
err:module:LdrInitializeThunk Main exe initialization for L"C:\\users\\b456\\Temp\\is-SMTU5.tmp\\install.exe" failed, status c0000135


解决方法：
运行 winetricks mfc42 



path.package() %>% llply(function(x) grep(pattern="chart", x, value = TRUE))
path.package() %>% llply(function(x) grep(pattern="rbokeh", x, value = TRUE))%>% l_ply(print)
/home/syrhades/R/x86_64-pc-linux-gnu-library/3.2/rbokeh


在游戏过程中回车, 直接输入: 

power overwhelming =无敌 星际争霸秘籍 
operation CWAL=快速建筑生产 
show me the money =10,000 单位的矿物和高能瓦斯 
the gathering = psionic stuff 法力能量无限 
game over man =立即游戏失败 
noglues =敌人无法施行魔法 
staying alive =任务无法完成 
there is no cow level =完成目前所执行的任务 
whats mine is mine =矿产无限 
breathe deep =瓦斯无限 
something for nothing =打开所有可生产的选项 
black sheep wall =地图全开 
medieval man =单位无限生产 
modify the phase variance =拥有生产所有建筑物的能力 
war aint what it used to be =关闭战争迷雾 
food for thought =拥有在补给限制下无限制造单位的能力 

跳关: 
输入 ophelia 然后按下 enter 
再打入你想选择的关卡名称 

特技: 

Terran: 
Stim Packs = 损10 Damage的兴奋剂(可以增加攻击力和机动力) 
LockDown = 锁定机械系敌人 
ShockWave = 震动波(损敌我的energy, 和神族的电浆护盾) 
Spider Mines =蜘蛛诡雷 
Scanner Sweep = 范围扫瞄器(暴露隐形单位) 
Def. Matrix =方阵护盾 
Irradiate 放射线(对虫族的所有部队及神族的地面部队有效)固定目标范围 
YaMaTo Gun = 大和巨炮 
Cloaking field = 隐形(Air) 
P.Cloaking =隐形(Earth) 

Protoss: 
Psionic Storm = 迷幻风暴 
Hallucination =幻象0002(产生与指定目标相同的两个幻象) 
Recall =唤回部队 
Stasis Field = 凝滞场(冻结战场~~~)忽略有效兵力 

Zerg: Infestation = 群袭 
SpawnBroodling = 体外伏寄(专对地面部队的必杀寄生虫)还会残留两只小虫 
Dark Swarm =群集(掩护) 
Plague =疫病(严重损伤)但不会死 Consume = 把自军部队吸引 
energy+50 Ensnare = 陷诱(异光黏液)暴露隐形单位 Parasite = 寄生侦察虫




Z:\media\syrhades\新加卷\export


星际争霸 兵种技能效果
主要是人族的科技球,虫族的皇后和蝎子,神族的电兵和红球.....
所有的技能效果
尤其是虫族的蝎子,他的那个雾到底有什么用,怎么破解
menglhcool | 浏览 3326 次
发布于2008-01-04 09:32
最佳答案

主要是人族的科技球,虫族的皇后和蝎子,神族的电兵和红球..... 
所有的技能效果 
科技球
力墙
力墙就象魔兽世界里面的牧师加的保护或圣骑士加的无敌.只能用来吸收一定伤害.
EMP振荡波 
被击中的部队MP全部消失，若是神族的能量罩还会全部消失。 
辐射 
被击中的生物部队血会不断减少，直到死亡为止。且会传染给附近的部队。

皇后
寄生虫
侦察用，被寄生的单位，只有主宰才可以控制和见到，只有使用医疗兵才或把宿主杀掉才可解除. 
诱捕
喷出粘液使敌军的速度和攻击大减,范围之内友军也会被减速.
产卵 
射出寄生虫把敌人一下子吃掉，此项技能对虫族和人类的所有地面部队有效.
感染
女王的技能，把人类的基地感染，造出恐怖的自杀式部队.
 
蝎子
黑雾 
喷出红色虫群使敌人的远程攻击失败,带溅射的单位例外.
消灭 
吃掉同伴来恢复能源 
瘟疫(俗称一滴血)
喷出腐蚀性粘液，对敌军的单位和建筑物都能作出很大的伤害,但是不能伤害神族的能量罩.
 
圣堂武士(电兵)
闪电风暴
可对付空中部队，地面部队，隐形单位和埋藏地底的敌军，尤其对付数量越多的敌军.?? 
幻觉
制造幻想，可以分散敌军的攻击力. 

暗影执政官(红球)
魔法反馈 
只能对有能量的部队有效，把敌军的能量化为受伤点数，使敌军受伤并失去所有的能量? 
精神控制
控制敌军的心灵，使敌人归降 
大旋涡
使敌军丧失一切能力，只对生物有效，时间很短.

破蝎子也比较简单啊.如果你是P,就出狂战士、暗黑圣堂武士或执政官,如果你是T.火枪和坦克也是黑雾的杀手.特别是火枪.如果别人用黑雾.小狗肯定多.

本回答由提问者推荐
评论 14 0

q84589799

采纳率：18% 擅长： 游戏 软件共享 武汉市
其他回答
科技球有防护罩!D.对付神的E.震荡波.L是毒.一般毒Z的成群飞龙或吊蜘蛛.

电兵有点.对付Z的口水和狗.~还有复制.那可以用P的时候复制abote进去转换而不怕被打掉.

红球有一个技能是把Z的东西定住. 好打.有一个是C.召唤.~

蝎子的雾是可以放远程的攻击.但是如tank的群攻不行.可以用闪电破.还可以用近战的破.! 蝎子还有一个是血.每次去4滴还是几滴的血.他可以吃狗.口水.牛能补气.~
欧阳开师 | 发布于2008-01-03 22:44
评论 0 0
1楼一看就是虫族不是内行~其实蝎子的雾是有深刻含义的~在里面的进身部队是无敌的~但是在里面饿地蝎~是最无敌的~远距离进距离都拿他没有办法~可是魔法对雾里面所有的东西都有用~比如闪电拉等魔法OK？
TM拉王 | 发布于2008-01-03 22:00
评论 2 0






其他1条回答
为您推荐：
其他类似问题

    2012-12-02 求星际争霸1.08所有建筑升级作用，以及兵种技能效果 最好图... 11
    2013-02-08 新手，星际争霸1里面的兵种技能给解释一下啊。 4
    2014-06-24 星际争霸1兵种技能详解 1
    2010-01-08 我想知道星际争霸虫族每个兵种的技能到底是干什么的 12
    2013-08-20 星际争霸1各族兵种技能详解 5

更多相关星际争霸技能的问题 >
星际争霸的相关知识

    2010-06-16 星际争霸1兵种介绍 165
    2007-11-17 星际争霸神族技能快捷键 10
    2011-07-13 星际争霸2下载 36
    2010-08-19 星际争霸2地图包下载 48
    2007-11-02 星际争霸所有兵种介绍 135

更多关于星际争霸的知识 >
网友都在找：
星际争霸兵种相克
等待您来回答

    2回答 我女朋友一般是8号来月经，但是我在上个月的27号和她做爱，没...
    3回答 初来乍到，各位兄台是否能帮我一个忙呢，借我 20.￥，过个几... 100
    2回答 车里有一大半93号汽油没用完 直接加了92号汽油 对车有没有影...
    4回答 你的名字百度云盘
    2回答 有私人贷款吗？不查任何东西的，征信有问题
    3回答 叫我帮忙又不相信我，有句话是怎么说来着？还是一段词！是什...
    2回答 求你的名字百度云盘
    3回答 HOW WE WOULO MAKE LOYE是什么意思
    2回答 轮胎烂了，是要补胎，还是换一个
    4回答 我想要找一个我喜欢的也喜欢我的怎么那么难？
    2回答 三星s6曲屏有哪些零件组成
    2回答 求你的名字百度云资源，高清版的 10
    7回答 喜欢一个男生 他从不主动找我聊天 但是和他聊天感觉很愉快 有...
    3回答 王牌逗王牌高清百度云 免费的来 谢谢！ 10
    2回答 红尘残梦心依然。这句话啥意思？

更多等待您来回答的问题 >
登录

还没有百度账号？
立即注册
知道日报
全部文章
放进眼里，盐水一冲，视力提高三...
相关搜索
wifi星际争霸2单机版星际争霸游戏
更多星际争霸游戏的百度推广结果>>
关于星际争霸游戏百度为您推荐更多优质结果,放心搜索,有V有保障.

    网页星际争霸
    星际争霸游戏

精彩知识在知道

    百度知道品牌合作指南
    【真相问答机】，揭穿流言！
    免费领取《知道日报》主题专刊
    知道大数据，用数据解读生活点滴

    新手帮助
        如何答题
        获取采纳
        使用财富值
    玩法介绍
        知道商城
        知道团队
        行家认证
        高质量问答
    投诉建议
        举报不良信息
        意见反馈
        投诉侵权信息

©2016 Baidu   使用百度前必读  |  知道协议  |  百度知道品牌合作
分享
任务列表
返回顶部


