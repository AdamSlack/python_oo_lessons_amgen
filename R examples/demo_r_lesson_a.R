# 
# R demonstration of Standard Procedural code.
# 


library(ggplot2)
library(reshape2)

cars <- c('Punto', 'Golf', 'Jazz')
colour <- c('beige', 'gold', 'neon pink')
fuel <- c(100,100,100) # inital fuel tank percent full
ppm <- c(10,20,5) # percent per mile fuel usage

remaining <- c()
miles <- 3

for (i in 1:length(fuel)) {
  remaining <- c(remaining, (fuel[i] - (ppm[i]*3)))
}

car_frame <- data.frame(cars, fuel, remaining)
car_frame.m <- melt(car_frame, id.vars='cars')

ggplot(car_frame.m, aes(cars, value)) +   
  geom_bar(aes(fill = variable), position = "dodge", stat="identity")