library(plotly)
library(dplyr)

# make sphere. references are below
# http://mathworld.wolfram.com/SpherePointPicking.html
# https://stackoverflow.com/questions/34539268/plot-points-on-a-sphere-in-r

n <- 10000
theta <- runif(n,0,2*pi)
u0 <- runif(n,-1,1)
x0 <- sqrt(1-u0^2)*cos(theta)
y0 <- sqrt(1-u0^2)*sin(theta)
z0 <- u0
sphere1 <- data.frame(x=x0*2+5,y=y0*2+5,z=z0*2+2)
sphere2 <- data.frame(x=x0+5,y=y0+5,z=z0+5)

sphere <- rbind(sphere1, sphere2)
sphere$colors <-c('#f2f2f2')
sphere$symbol <-c('circle')
sphere$size <- 10

plot_ly(sphere, x = ~x, y = ~y, z = ~z, 
        marker=list(size= ~sphere$size, opacity=.9, color=sphere$colors, symbol=sphere$symbol)) %>% layout(paper_bgcolor='rgb(193, 222, 255)')  %>% layout(title = 'Snow Man')

# make nose and eye
x <- c(5,5, 
       rep(5, length(seq(5.2,5.3,.02))),5.2,4.8, # nose and eye
       3.5,6.5)
y <- c(5,6,
       seq(5.2,5.3,.02),5.2,5.2, # nose and eye
       6.5,3.5)
z <- c(1.2,1.1,
       rep(5.1, length(seq(5.2,5.3,.02))),5.315,5.315, # nose and eye
       1.12,1.12)
size <-c(1,1,
         rep(10, length(seq(5.2,5.3,.02))),10,10, # nose and eye
         1,1)
colors <-c('#ffffff','#ffffff',
           rep('#f97c00', length(seq(5.2,5.3,.02))),'#3a3a3a','#3a3a3a', # nose and eye
           '#ffffff','#ffffff')
symbol <-c('circle','circle',
           rep('circle', length(seq(5.2,5.3,.02))),'circle','circle',
           'circle','circle')

face <- data.frame(x,y,z,size,colors,symbol)

plot_ly(face, x = ~x, y = ~y, z = ~z, 
        marker=list(size= ~ face$size, opacity=.9, color= face$colors, symbol= face$symbol)) %>% layout(paper_bgcolor='rgb(193, 222, 255)')  %>% layout(title = 'Snow Man')

# make smile
x1 <- seq(-pi,0,.2)
z1 <- sin(x1)*.1

x2 <- (x1*-.1)+4.85
z2 <- z1+4.6
y2 <- rep(5.2,length(z2))

smile <- data.frame(x=x2,y=y2,z=z2, size=rep(8, length(z2)), colors=rep(c('#f90000'),length(z2)), symbol=rep(c('circle'),length(z2)))

# make smile face
smile_face <- rbind(face, smile)
plot_ly(smile_face, x = ~x, y = ~y, z = ~z, 
        marker=list(size= ~smile_face$size, opacity=.9, color=smile_face$colors, symbol=smile_face$symbol)) %>% layout(paper_bgcolor='rgb(193, 222, 255)')  %>% layout(title = 'Snow Man')

# snow man !!
snowman <-rbind(sphere, face, smile)

p <- plot_ly(snowman, x = ~x, y = ~y, z = ~z, 
             marker=list(size= ~snowman$size, opacity=.9, color=snowman$colors, symbol=snowman$symbol)) %>% layout(paper_bgcolor='rgb(193, 222, 255)')  %>% layout(title = 'Snow Man')
p

# merry christmas!
Sys.setenv("plotly_username"="XXXX")
Sys.setenv("plotly_api_key"="XXXX")

plotly_POST(p, filename = "snow_man_xmas")
