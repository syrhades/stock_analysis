vol_plot <- plot_ly(df_vols ,x=~adj_price,y=~sum_vol,name="sum_vol") %>%
  add_bars%>%
  add_trace(y=~sum_vol_delta,type="bar",name="sum_vol_delta")


vol_plot2 <- plot_ly(df_vols ,y=~adj_price,x=~sum_vol,name="sum_vol") %>%
  add_bars%>%
  add_trace(x=~sum_vol_delta,type="bar",name="sum_vol_delta")
# vol_plot2 not ok



x <- lapply(1:3, function(i) { list(a=i,b=i^2) })
     list.stack(x)

require(graphics)
     
plot(cars, main = "lowess(cars)")
lines(lowess(cars), col = 2)
lines(lowess(cars, f = .2), col = 3)
legend(5, 120, c(paste("f = ", c("2/3", ".2"))), lty = 1, col = 2:3


####################################3
# main part
####################################3
frm_main1<-function(){
  # debugonce(frm_plotly_GMMA)
  frm_plotly_GMMA(600237,"2016/")
  frm_plotly_lm(600237,"2016/")
  frm_lm_predict_stock_oneplot(600166,"2016/",seq(10,60,5))
  frm_lm_predict_stock_oneplot(600237,"2016/2016-05",seq(20,40,10))
  frm_lm_predict_stock_oneplot(600237,"2016/2016-05",seq(20,40,10))
  frm_lm_predict_stock_oneplot(630,"2016/",seq(20,40,10))
  frm_lm_predict_stock_oneplot(698,"2016/",seq(20,40,10))
  frm_lm_predict_stock_oneplot(698,"2017/",seq(20,40,10))
  subplot(plot_ohlc, 
      plotvol, 
      plot3,
      nrows = 3, 
      margin = 0.01,
      # heights=c(0.7,0.3),
      shareX = TRUE
      )

  plotlm %>%matplot(type = "l",pch = 1:10)
  plotlm[,-1] %>%boxplot

  library(plotly)

  trace_0 <- rnorm(100, mean = 5)
  trace_1 <- rnorm(100, mean = 0)
  trace_2 <- rnorm(100, mean = -5)
  x <- c(1:100)

  data <- data.frame(x, trace_0, trace_1, trace_2)

  p <- plot_ly(data, x = ~x) %>%
    add_trace(y = ~trace_0, name = 'trace 0',mode = 'lines') %>%
    add_trace(y = ~trace_1, name = 'trace 1', mode = 'lines+markers') %>%
    add_trace(y = ~trace_2, name = 'trace 2', mode = 'markers')
}


 # char_cmd1 <- sprintf("roll_data$%s",deparse(substitute(col1)))
  # char_cmd2 <- sprintf("roll_data$%s",deparse(substitute(col2)))
  # vec1 <- eval(parse(text=char_cmd1))
  # vec2 <- eval(parse(text=char_cmd2))
  # vec2 <- eval(sprintf("roll_data$%s",deparse(substitute(col2))))
  # matrix_vol <- frm_roll_restructure(xtsobj,deparse(substitute(col1)),width)
  # matrix_price <- frm_roll_restructure(xtsobj,deparse(substitute(col2)),width)
# eval(parse(text=char_cmd))
# frm_roll_restructure(xtsobj,as.name(substitute(col1)),width)


# # xts_cor <- frm_roll_cor(xts157,close,vol,90)

# xts_cor <- frm_roll_FUN_2_vars_v3(xts157,close,vol,90,by =90)
# df_cor <- xts_cor %>% frm_xts2df(NA)
# subplot1 <- plot_ly(data=df157,x=~date,y=~close) %>%add_lines
# subplot2 <- plot_ly(data=df_cor,x=~date,y=~close_vol,type="bar") #%>%add_lines
# subplot(subplot1,subplot2,
#               nrows = 2,
#               shareX=T
#               )
# # show minus cor value
# merge(xts_cor[xts_cor <0]%>%frm_xts2df(NA),xts157%>%frm_xts2df(NA))

rollapply(seat, width = 36,
  FUN = function(z) coef(lm(y ~ y1 + y12, data = as.data.frame(z))),
  by.column = FALSE, align = "right")
debugonce(rollapply)


xts_cor3 <- frm_roll_FUN_2_vars_v2(xts157,close,vol,50,cor)

xts_cor2 <- rollapply(xts157[,c("vol","close")],width=50,
                      by= 50,
                      FUN= function(z) cor(z[,1],z[,2]),
                      # na.rm = TRUE,
                      # fill = NA,
                      by.column = F,
                       align = "right"
          ) %>% na.omit


debugonce(frm_roll_FUN_2_vars_v3)
frm_roll_FUN_2_vars_v3(xts157,close,vol,50,cor)


df157  <- frm_read_stock(stockid)
  xts157 <- frm_df2xts(df157)[scope]
  df157 <- frm_xts2df(xts157)

  xts_cor <- frm_roll_FUN_2_vars_v3(xts157,close,vol,width=width,by =1,align="right",cor)
  df_cor <- xts_cor %>% frm_xts2df(NA)
  # show minus cor value
  df_minus <- merge(xts_cor[xts_cor <0] %>% frm_xts2df(NA),xts157 %>% frm_xts2df(NA))#%>%head #%>% print


  subplot1 <- plot_ly(data=df157,x=~date,y=~close) %>%
    add_lines%>%
    add_markers(data=df_minus,x=~date,y=~adj_price,size=~vol)
  subplot2 <- plot_ly(data=df_cor,x=~date,y=~close_vol,type="bar") #%>%add_lines

  
  subplot(subplot1,subplot2,
              nrows = 2,
              shareX=T
              )



frm_lm_cor_stock(698,"2010/",seq(20,40,10),20)

frm_xts_roll_percent_rank(xts157,20) %>% head

With Cass Sunstein, Nudge: Improving Decisions about Health, Wealth and Happiness, Yale University Press (2008).

With Shlomo Benartzi, Post, T., Van den Assem, MJ., Baltussen, G and Thaler, Richard H. , “Deal or No Deal? Decision Making Under Risk in a Large-Payoff Game Show,” American Economic Review 98 (1), 38-71 (2008).

"Naïve Diversification in Defined Contribution Savings Plans," American Economics Review (2001).

With Shlomo Benartzi, "How Much is Investor Autonomy Worth?," Journal of Finance (2002).

With Owen Lamont, "Can the Stock Market Add and Subtract? Mispricing in Tech Stock Carve-outs," Journal of Political Economy (2003).

With Cass R. Sunstein, "Libertarian Paternalism is not an Oxymoron," University of Chicago Law Review (2004).

With Shlomo Benartzi, "Save More Tomorrow: Using Behavioral Economics in Increase Employee Savings," Journal of Political Economy (2004).


frm_lm_cor_stock(600237,"2016/2016-05",seq(20,40,10),20)

