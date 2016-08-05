# change the third line of code to plot a map of Texas
library("maps")
texas <- ggplot2::map_data("state", region = "texas")
texas %>% ggvis(~long, ~lat) %>% layer_paths()

# Same plot, but set the fill property of the texas map to dark orange

texas %>% ggvis(~long, ~lat) %>% layer_paths(fill := 'darkorange')


faithful %>%
  compute_model_prediction(eruptions ~ waiting, model = "lm")



faithful %>%
  compute_model_prediction(eruptions ~ waiting, model = "lm")

# Compute the x and y coordinates for a loess smooth line that predicts mpg with the wt
mtcars %>% 
  compute_smooth(mpg ~ wt)




# Use 'ggvis()' and 'layer_lines()' to plot the results of compute smooth
mtcars %>% compute_smooth(mpg ~ wt) %>% ggvis(~pred_, ~resp_) %>% layer_lines()
library(ggvis)
Wage %>% ggvis(~wage, ~age) %>% layer_smooths() %>% layer_points()

# Recreate the graph you coded above with 'ggvis()' and 'layer_smooths()' 
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths() %>% layer_points()

# Extend the code for the second plot and add 'layer_points()' to the graph
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points() %>% layer_smooths()


###