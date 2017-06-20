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
  max_length <- max(lengths(arguments))
  args <- lapply(arguments, function(x, max_len) {
    length(x) <- max_length
    return(x)
  }, max_len = max_length)
  return(args)
}


create_data_frame <-function(car_names, ...) {
  car_data <- list(...)
  
  # create even lengthed data vectors
  padded_fuel <- do.call(pad_lengths, car_data)
  
  # produce a dataframe of the data with desired titles.
  car_frame <- data.frame(padded_fuel)
  colnames(car_frame) <- car_names
  
  # transforming data frame for plotting multiple series
  car_frame.m <- melt(t(car_frame), id.vars="Cars",
                                    value.name ="Fuel",
                                    variable.name = "Time")
  colnames(car_frame.m) <- c('Cars', 'Time', 'Fuel')
  
  return(car_frame.m)
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

# padding the car fuel data
car_data_frame <- create_data_frame(car_names = c('Punto', 'Golf', 'Jazz'),
                                   punto_fuel_hist,
                                   golf_fuel_hist,
                                   jazz_fuel_hist)
 
# plot those series using ggplot.
ggplot(car_data_frame, aes(x=Time, y=Fuel, group=Cars, colour = Cars)) +   
  geom_line() + geom_point()