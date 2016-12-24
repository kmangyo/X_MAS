#ploty 패키지를 설치합니다. 
#install.packages("plotly")

library(plotly)

#3D 플롯이기 때문에 x,y,x를 만듭니다.
#x,y는 정규분포를 따르는 랜덤숫자를 생성합니다.
#z는 낮은 숫자가 많은 치우친 베타푼포를 따르는 랜덤숫자를 생성합니다.
#이를 3D 플롯으로 만들면 대략 원뿔 모양의 분포가 만들어 집니다.
x<-rnorm(10000,.5,3)
y<-rnorm(10000,.5,3)
z<-rbeta(10000,.5,7)

#크리스마스 트리는 녹색나무와 트리의 장식물의 조합이니 적당히 만들어진 값들을 분류하도록 합니다.
#20%정도는 장식으로 나머지 80%는 나뭇잎으로 씁니다.
color<-runif(10000, min=0, max=1)
color<-ifelse(color<=.2,1,0)

#편의를 위해 위의 값들을 data.frame으로 만듭니다.
df<-data.frame(x,y,z,color)

#나뭇잎과 장식의 색이 1,0 두가지면 심심하니까 적절한 색의 변화를 위해 랜덤값을 조금씩 +,-합니다.
df$color<-df$color+runif(nrow(df), min=-.1, max=.3)

#개별 플롯의 size값을 넣어줍니다. 나중에 최상단에 위치할 별(?)을 위한 작업입니다.
df$size <-c(rep(1,nrow(df))
            
#적절히 색도 넣었지만, 랜덤으로 생성된 숫자들이기 때문에 원뿔이 깔끔하지 않습니다.
#삼각형을 그리는 대략적인 함수를 만들어 아웃라이어를 제거하도록 합니다.
df$z1<-ifelse(x<0,x*0.05+0.5,x*-0.05+0.5)
df$z2<-ifelse(y<0,y*0.05+0.5,y*-0.05+0.5)
df$TF<-with(df,ifelse(z>z1|z>z2,1,0))

df<-subset(df,df$TF==0)

#z의 가장 큰값, x,y의 중앙값 근처에 별(?)을 위치시킵니다. (원뿔의 제일 꼭대기) 색과 크기도 다르게 설정합니다.
star<-c(z=max(df$z)-.005,x=median(df$x)-.005,y=median(df$y)-.005,color=1.5,size=5,z1=NA,z2=NA,TF=NA)
df<-rbind(df,star)

#녹색, 노란색(장식), 붉은색(별)을 기본으로 3D 플롯을 만듭니다. 트리 완성.
p <- plot_ly(df, x = ~x, y = ~y, z = ~z, color = ~color, colors = c('#009916', '#ffff00','#ea0056'), 
             size = ~size, marker = list(symbol = c('diamond'), sizemode = c('diameter')),sizes = c(7, 20)) %>% layout(title = 'X-mas Tree')
p

#plotly에 공유합니다.
Sys.setenv("plotly_username"="XXXX")
Sys.setenv("plotly_api_key"="XXXX")

plotly_POST(p, filename = "xmas_tree")
            
#메리크리스마스!
