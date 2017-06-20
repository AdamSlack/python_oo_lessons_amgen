# 
# R demonstration of R6 Classes.
# 

library(R6)

Car <- R6Class('Car',
               public = list(
                 # PUBLIC DATA MEMBERS
                 name = NULL,
                 fuel_usage = NULL,
                 current_speed = 0,
                 current_tank = 0,

                 ## CLASS CONSTRUCTOR
                 initialize = function(name, max_speed, max_tank, current_tank) {
                   self$name          <- name
                   self$fuel_usage    <- c(current_tank)
                   self$current_tank  <- current_tank
                   private$max_speed  <- max_speed
                   private$max_tank   <- max_tank
                 },
                 
                 ## GETTERS
                 get_max_speed = function() {
                   return(private$max_speed )
                 },
                 
                 get_max_tank = function() {
                   return(private$max_speed)
                 },
                 
                 ## PUBLIC METHODS
                 drive = function(mph, distance, mpg) {
                   if(mph > private$max_speed) {
                     mph <- private$max_speed
                   }
                   mpm <- mph/60
                   journey_time <- distance/mpm
                   gallons_used <- distance/mpg
                   gallon_pm <- gallons_used/journey_time

                   for(i in 1:journey_time) {
                     self$current_tank = self$current_tank - gallon_pm
                     
                     if(self$current_tank < 0) {
                       self$current_tank = 0 # only spend fuel if there was fuel to spend.
                     }
                     self$fuel_usage <- c(self$fuel_usage, self$current_tank)  
                   }
                   return(self$fuel_usage)
                 },
                 
                 refuel = function(gallons_added) {
                   self$current_tank <- self$current_tank + gallons_added
                   if(self$current_tank > private$max_tank) {
                     self$current_tank <- private$max_tank
                   }
                   self$fuel_usage <- c(self$fuel_usage, self$current_tank)
                 }
               ),
               private = list(
                 # PRIVATE DATA MEMBERS
                 max_speed=NULL,
                 max_tank=NULL
               ))


DrivePlotProducer <- R6Class('PlotProducer',
                             
                             public = list(
                               car_names = c(),
                               
                               pad_lengths = function(...) {
                                 arguments <- list(...)
                                 max_length <- max(lengths(arguments))
                                 
                                 args <- lapply(arguments, function(x, max_len) {
                                   length(x) <- max_length
                                   return(x)
                                 }, max_len = max_length)
                                 return(args)
                               },
                               
                               create_data_frame = function(...) {
                                 car_data <- list(...)
                                 
                                 padded_fuel <- do.call(self$pad_lengths, car_data)
                                 car_frame <- data.frame(padded_fuel)
                                 colnames(car_frame) <- self$car_names
                                 
                                 car_frame.m <- melt(t(car_frame), id.vars="Cars", 
                                                     value.name ="Fuel",
                                                     variable.name = "Time")
                                 colnames(car_frame.m) <- c('Cars', 'Time', 'Fuel')
                                 return(car_frame.m)
                               },
                               
                               create_plot = function(...) {
                                 car_objects <- list(...)
                                 fuel_usages <- lapply(car_objects, function(x){return(x$fuel_usage)})
                                 self$car_names <- lapply(car_objects, function(x){return(x$name)})
                                 car_frame <- do.call(self$create_data_frame, fuel_usages)
                                 
                                return(ggplot(car_frame, aes(x = Time,
                                                                             y = Fuel,
                                                                             group  = Cars,
                                                                             colour = Cars)) +   
                                   geom_line() + geom_point())
                               }
                             )
                          )

plot_producer <- DrivePlotProducer$new()

golf <- Car$new('Golf', 100, 10, 3)
golf$drive(10,10,10)
golf$drive(mph=40, distance=10, mpg=30)

jazz <- Car$new('Jazz', 200, 10, 10)
jazz$drive(30, 2, 40)
jazz$drive(40, 1, 38)
jazz$drive(70, 10, 44)
jazz$drive(110, 60, 30)

fiat <- Car$new('Fiat', 90, 8, 1)
fiat$drive(30, 3, 1)
fiat$refuel(5)
fiat$drive(30, 0.5, 1)
fiat$drive(40, 5, 40)
fiat$drive(30, 2, 45)
fiat$drive(60, 10, 45)

plot_producer$create_plot(golf, jazz, fiat)
