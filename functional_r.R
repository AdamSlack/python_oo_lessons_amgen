# Function Factory 

# 'Power' function generator
power <- function(exp) {
  return(
    function(x) {
      return(x^exp)
    }
  )
}

# Example 'Power' usage
square <- power(2)
square(4)

cube <- power(3)
cube(4)


# <<- operator... Mutable State

# The function created in 'new_counter' is a closure, typically the environment
# that holds the closure is only temporary. This means that 'i' created in the 'new_counter' level
# would be forgotten about when the closure is returned.
# by utilising '<<-' the function will look into the environment that held the closure to find
# a variable that matched with the same name.

# Counter Generator
new_counter <- function() {
  i <- 0
  function() {
    i <<- i + 1
    return(i)
  }
}

# Example usage
counter_one <- new_counter()
counter_two <- new_counter()

counter_one()
counter_one()
counter_two()
counter_one()
counter_two()

# first class functions.
# as Functions are treated as first class citizens, you can store them in lists.
# this subsequently means that you can use 'lapply' to iterate over a list of functions.

# list of anonymous functions - each remove missing values.
anonList <- list(
  sum = function(x, ...) sum(x, ..., na.rm = TRUE),
  mean = function(x, ...) mean(x, ..., na.rm = TRUE),
  median = function(x, ...) stats::median(x, ..., na.rm = TRUE)
)

# apply this function to all elements in anonList...
lapply(anonList, function(f) f(1:10))
# each function 'f' is passed to the lambda function that returns the evaluation
# of the current function 'f' when passed '1:10' as its parameter value.

