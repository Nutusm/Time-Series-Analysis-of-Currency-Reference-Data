df=read.csv("Data.csv")
df=df[,2:6]
DY1=diff(df[,2])  #y(t)-y(t-1)
DY2=diff(df[,3])
DY3=diff(df[,4])
DY4=diff(df[,5])
library(fpp2)
autoplot(ts(DY1))+ylab("US Dollar")
autoplot(ts(DY2))+ylab("Pound Sterling")
autoplot(ts(DY3))+ylab("Euro")
autoplot(ts(DY4))+ylab("Japanese Yen")

library(dplyr)
library(lubridate)
DY1=append(DY1,0)
DY2=append(DY2,0)
DY3=append(DY3,0)
DY4=append(DY4,0)
USD=data.frame(DY1)
notrend_data=data.frame(DY1, DY2, DY3, DY4)
df <- df %>% mutate(USD_diff=notrend_data$DY1, pound_diff=notrend_data$DY2, euro_diff=notrend_data$DY3, yen_diff=notrend_data$DY4)
dates=df$Date
dates <- as.POSIXct(dates, format = "%d-%m-%Y")
df <- df %>% mutate(month = month(Date), Year=format(dates, format="%Y"))
notrend_data <- notrend_data %>% mutate(Date = dates)
notrend_data <- notrend_data %>% mutate(month = month(Date), Year=format(dates, format="%Y"))
df_month <- notrend_data %>% group_by(month, Year) %>% summarise(sum_USD = sum(DY1), sum_pound=sum(DY2), sum_euro=sum(DY3), sum_yen=sum(DY4))
df_month_new <- df_month[order(df_month$Year),]
row.names(df_month_new) = NULL


