# Build a histogram of the waiting variable of the faithful data set.

library(magrittr)
library(ggvis)
faithful %>% 
  ggvis(~waiting) %>% layer_histograms( width = 2)

# Build the same histogram, but with a binwidth (width argument) of 5 units
faithful %>% 
  ggvis(~waiting) %>% layer_histograms( width = 5)


# Transform the code below: just compute the bins instead of plotting a histogram
faithful %>% compute_bin(~eruptions)
#faithful %>% ggvis(~waiting) %>% layer_histograms(width = 5)

# Combine the solution to the first challenge with layer_rects() to build a histogram

faithful %>% compute_bin(~eruptions) %>% ggvis() %>% layer_rects(x =~xmin_,x2= ~xmax_, y = 0, y2 = ~count_) 


# Transform the code below: just compute the bins instead of plotting a histogram
faithful %>% compute_bin(~waiting, width = 5 )

# Combine the solution to the first challenge with layer_rects() to build a histogram

faithful %>% compute_bin(~waiting) %>% ggvis() %>% layer_rects(x = ~xmin_, x2= ~xmax_, y = 0, y2 = ~count_)


### density plots 

?compute_density
faithful %>% compute_density(~waiting) %>% ggvis()



mtcars %>% ggvis(~mpg) %>% compute_density(~mpg, n = 5) %>%
  layer_points(~pred_, ~resp_)

names(faithful)




# Combine compute_density() with layer_lines() to make a density plot of the waiting variable.
faithful %>% compute_density(~waiting) %>% ggvis(~pred_, ~resp_) %>% layer_lines()

# Build a density plot directly using layer_densities. Use the correct variables and properties.
faithful %>% ggvis(~waiting, fill := "green") %>% layer_densities()



# Complete the code to plot a bar graph of the cyl factor.
mtcars %>% ggvis(~factor(cyl)) %>% layer_bars()

# Adapt the solution to the first challenge to just calculate the count values. No plotting!

mtcars %>% compute_count(~factor(cyl))


# Both ggvis and dplyr are loaded into the workspace

# Change the code to plot a unique smooth line for each value of the cyl variable.
mtcars %>% group_by(cyl) %>% ggvis(~mpg, ~wt, stroke = ~factor(cyl)) %>% layer_smooths()

# Adapt the graph to contain a separate density for each value of cyl.
mtcars %>% group_by(cyl) %>% ggvis(~mpg) %>% layer_densities()

# Copy and alter the solution to the second challenge to map the fill property to a categorical version of cyl.

mtcars%>% group_by(cyl) %>% ggvis(~mpg) %>% layer_densities(fill = ~factor(cyl))


# Alter the graph
mtcars %>% group_by(cyl, am) %>% ggvis(~mpg, fill = ~interaction(cyl, am)) %>% layer_densities()
