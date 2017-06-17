# 
# R demonstration of Standard Procedural With some Functions
# 

library(ggplot2)
library(reshape2)

drive_car <- function(starting_tank, ppm, distance) {
  tank_changes = c() # track the fuel usage using what % remains
  for(i in 0:distance) {
    new_tank <- starting_tank - (ppm * i)
    if(new_tank >= 0) {
      tank_changes <- c(tank_changes, new_tank) # only spend fuel if there was fuel to spend.
    }
  }
  return(tank_changes) # return the fuel usage
}

# creating a function to refuel a car
refuel_car <- function(tank_changes, tank_percentage) {
  new_tank <- tank_changes[length(tank_changes)] + tank_percentage
  if(new_tank > 100) {
    new_tank <- 100 # cant have more than a 100% full tank.
  }
  return(c(tank_changes, new_tank))
}

na.padding <- function(x,len){
  return(x[1:len])
}


data_frame_ify <- function(l,...){
  maxlen <- max(sapply(l,length))
  return(data.frame(lapply(l,na.padding,len=maxlen),...))
}

cars <- c('Punto', 'Golf', 'Jazz')

jazz_fuel_hist <- drive_car(100, 7.5, 10)


golf_fuel_hist <- drive_car(100, 2, 10)
golf_fuel_hist <- c(golf_fuel_hist, drive_car(golf_fuel_hist[length(golf_fuel_hist)], 5, 10))

punto_fuel_hist <- drive_car(100, 10, 20)
punto_fuel_hist <- refuel_car(punto_fuel_hist, 100)
punto_fuel_hist <- drive_car(100, 10, 20)


maxlen <- max(length(punto_fuel_hist),length(golf_fuel_hist),length(jazz_fuel_hist))
car_frame <- data.frame(punto_fuel_hist[1:maxlen], golf_fuel_hist[1:maxlen], jazz_fuel_hist[1:maxlen])


ggplot(car_frame, aes(x=seq(0,length(car_frame$punto_fuel_hist)-1), y=punto_fuel_hist)) +   
  geom_line()

