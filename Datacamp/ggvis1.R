# The ggvis packages is loaded into the workspace already

# Change the code below to make a graph with red points
mtcars %>% ggvis(~wt, ~mpg, fill := "red") %>% layer_points("red")

# Change the code below draw smooths instead of points
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths

# Change the code below to make a graph containing both points and a smoothed summary line
mtcars %>% ggvis(~wt, ~mpg) %>% layer_points() %>% layer_smooths

Wage %>% ggvis(~age, ~wage) %>% layer_points() %>% layer_smooths 


# Make a scatterplot of the pressure dataset
pressure %>% ggvis(~temperature,~pressure) %>% layer_points()

# Adapt the code you wrote for the first challenge: show bars instead of points

pressure %>% ggvis(~temperature, ~pressure) %>% layer_bars()


# Adapt the code you wrote for the first challenge: show lines instead of points
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()

# Adapt the code you wrote for the first challenge: map the fill property to the temperature variable

pressure %>% ggvis(~temperature, ~pressure, fill = ~temperature) %>% layer_points()


# Extend the code you wrote for the previous challenge: map the size property to the pressure variable


pressure %>% ggvis(~temperature, ~pressure, fill = ~temperature, size = ~pressure) %>% layer_points()



names(iris)
iris %>%
  ggvis(~Petal.Width, ~Petal.Length,
        fill = 'red',
        size = ~Sepal.Width)


iris %>%
  ggvis(x = ~Petal.Width,
        y = ~Petal.Length,
        ) %>% layer_points


# Change the code to set the fills using pressure$black. pressure$black is loaded into workspace.
pressure %>% 
  ggvis(~temperature, ~pressure, 
        fill := ~black) %>% 
  layer_points()

# Plot the faithful data as described in the second instruction

faithful %>%
  ggvis(x= ~waiting, 
        y = ~eruptions,
        size = ~eruptions,
        fill := 'blue',
        stroke := 'black',
        opacity := .5) %>%
  layer_points()


# Plot the faithful data as described in the third instruction
faithful %>%
  ggvis( x = ~waiting,
         y = ~eruptions, 
         size := 100,
         fill := 'red',
         fillOpacity = ~eruptions,
         stroke := 'red',
         shape := 'cross') %>%
  layer_points()

??strokeDash



# Change the code below to use the lines mark
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines()

# Set the properties described in the second instruction in the graph below
pressure %>% ggvis(~temperature, ~pressure) %>% layer_lines(stroke :='red',
                                                            strokeWidth := 2,
                                                            strokeDash := 6)
