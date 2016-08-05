
mtcars %>% 
  ggvis(~mpg, ~wt, 
        fill := input_select(label = "Choose fill variable:", 
                             choices = c(names(mtcars)), map = as.name)) %>% 
  layer_points()


?input_numeric

library(ggvis)
?input_numeric()


fill_text <- input_text(label = "Point color", value = "red")
mtcars %>% ggvis(~wt, ~mpg, fill := fill_text) %>% layer_bars()

fill_numeric<-input_numeric(label = 'Choose a bindiwth', value = )


# Map the bindwidth to a numeric field ("Choose a binwidth:")
mtcars %>% 
  ggvis(~mpg) %>% 
  layer_histograms(width :=input_numeric(label = 'Choose a binwidth:', value = 1))

# Map the binwidth to a slider bar ("Choose a binwidth:") with the correct specifications
mtcars %>% 
  ggvis(~mpg) %>% 
  layer_histograms(width :=input_slider(label = 'Choose a binwidth:', min = 1 , max = 20) )
