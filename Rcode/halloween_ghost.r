library(ggplot2)

radius <- 1
theta <- seq(0, 1 * pi, length = 2000)
x= radius * sin(theta)

radius1 <- pi/16
theta1 <- seq(0, pi/16 * pi, length = 2000)
x1= radius1 * sin(theta)

theta2 <- seq(0, pi/16 * pi, length = 2000) + pi/4
x2= radius1 * sin(theta)

theta3 <- seq(0, pi/16 * pi, length = 2000) + pi/4+pi/4
x3= radius1 * sin(theta)

theta4 <- seq(0, pi/16 * pi, length = 2000) + pi/4+pi/4+pi/4
x4= radius1 * sin(theta)

x0 <- c(x, x1, x2, x3, x4)
theta0 <- c(theta, theta1, theta2, theta3, theta4)

eye_radius <- 0.05
eye_theta <- seq(-1 * pi, 1 * pi, length = 2000)

eye_x1= eye_radius * sin(eye_theta) + 0.6
eye_y1= eye_radius * cos(eye_theta) + pi/3

eye_x2= eye_radius * sin(eye_theta) + 0.6
eye_y2= eye_radius * cos(eye_theta) + pi/3+pi/3

theta_smile <- subset(theta, theta>=(pi/2-0.4))
theta_smile <- subset(theta_smile, theta_smile<=(pi/2+0.4))
x_smile= radius * -sin(theta_smile) + 1.3

x0 <- c(x, x1, x2, x3, x4, eye_x1, eye_x2, x_smile)
theta0 <- c(theta, theta1, theta2, theta3, theta4, eye_y1, eye_y2, theta_smile)

df<- data.frame(theta0, x0)

ggplot(data=df, aes(x=theta0, y=x0)) + geom_point() + theme_classic()
