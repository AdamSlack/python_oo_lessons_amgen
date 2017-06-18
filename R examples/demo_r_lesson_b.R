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

pad_lengths <- function(...) {
  arguments <- list(...)
  lengths < c()
  for(arg in arguments) {
    lengths <- c(lengths, length(arg))
  }
  maxlen <- max(arguments)
  
  level_args <- list()
  
  for(arg in arguments){
    level_args[length(level_args)] <- arg[1:maxlength]
  }
  
  return(level_args)
}

# tracking the fuel usage of Jazz
jazz_fuel_hist <- drive_car(100, 7.5, 10)

# tracking the fuel usage of Golf
golf_fuel_hist <- drive_car(100, 2, 10)
golf_fuel_hist <- c(golf_fuel_hist, drive_car(golf_fuel_hist[length(golf_fuel_hist)], 5, 10))

# tracking the fuel usage of punto
punto_fuel_hist <- drive_car(100, 10, 20)
punto_fuel_hist <- refuel_car(punto_fuel_hist, 70)
punto_fuel_hist <- c(punto_fuel_hist, drive_car(70, 10, 20))



padded_data <- pad_lengths(punto_fuel_hist, golf_fuel_hist, jazz_fuel_hist)

car_frame <- t(data.frame(punto = punto_fuel_hist[1:maxlen], golf = golf_fuel_hist[1:maxlen], jazz = jazz_fuel_hist[1:maxlen]))
car_frame.m <- melt(car_frame, id.vars="Var1", value.name ="value", variable.name = "Var2")


ggplot(car_frame.m, aes(x=Var2, y=value, group=Var1, colour = Var1)) +   
  geom_line() + geom_point()

