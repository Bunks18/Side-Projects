
library(magrittr); library(ggvis)

faithful %>% 
  ggvis(~waiting, ~eruptions, fillOpacity := 0.5, 
        shape := input_select(label = "Choose shape:", 
                              choices = c("circle", "square", "cross", 
                                          "diamond", "triangle-up", "triangle-down")), 
        fill := "black") %>% 
  layer_points()

# Add radio buttons to control the fill of the plot
mtcars %>% 
  ggvis(~mpg, ~wt,
        fill := input_select(label = "Choose color:",
                             choices = c('black', 'orange', 'blue', 'green'))) %>% 
          layer_points()
        
faithful %>% 
  ggvis(~waiting, ~eruptions, fillOpacity := 0.5, 
        fill := input_select(label = "Choose color:", 
                             choices = c("black", "red", "blue","green"))) %>% 
  layer_points()



faithful %>% 
  ggvis(~waiting, ~eruptions, fillOpacity := 0.5, 
        shape := input_select(label = "Choose shape:", 
                              choices = c("circle", "square", "cross", 
                                          "diamond", "triangle-up", "triangle-down")), 
        fill := input_select(label = "Choose color:", 
                             choices = c("black", "red", "blue","green"))) %>% 
  layer_points()


mtcars %>% 
  ggvis(~mpg, ~wt,
        fill := input_select(label = "Choose color:",
                             choices = c("black","green"))) %>% 
  layer_points()



mtcars %>% 
  ggvis(~mpg, ~wt,
        fill := input_radiobuttons(label = "Choose color:",
                                   choices = c("black","red", 'blue',
                                               'green'))) %>% 
  layer_points()