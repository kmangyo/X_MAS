#ploty 패키지를 설치합니다. 
#install.packages("plotly")

library(plotly)

#
x<-rnorm(10000,.5,3)
y<-rnorm(10000,.5,3)
z<-rbeta(10000,.5,7)
color<-runif(10000, min=0, max=1)
color<-ifelse(color<=.2,1,0)

df<-data.frame(x,y,z,color)
df$color<-df$color+runif(nrow(df), min=-.1, max=.3)
df$size <-c(rep(1,nrow(df)-1),1.1)

df$z1<-ifelse(x<0,x*0.05+0.5,x*-0.05+0.5)
df$z2<-ifelse(y<0,y*0.05+0.5,y*-0.05+0.5)
df$TF<-with(df,ifelse(z>z1|z>z2,1,0))

df<-subset(df,df$TF==0)

star<-c(z=max(df$z)-.005,x=median(df$x)-.005,y=median(df$y)-.005,color=1.5,size=5,z1=NA,z2=NA,TF=NA)

df<-rbind(df,star)

p <- plot_ly(df, x = ~x, y = ~y, z = ~z, color = ~color, colors = c('#009916', '#ffff00','#ea0056'), 
             size = ~size, marker = list(symbol = c('diamond'), sizemode = c('diameter')),sizes = c(7, 20)) %>% layout(title = 'X-mas Tree')
p

Sys.setenv("plotly_username"="XXXX")
Sys.setenv("plotly_api_key"="XXXX")

plotly_POST(p, filename = "xmas_tree")
