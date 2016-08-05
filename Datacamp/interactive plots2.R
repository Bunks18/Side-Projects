mtcars %>% 
  ggvis(~mpg, ~wt, 
        fill := input_radiobuttons(label = "Choose color:", 
                                   choices = c("black", "red", "blue", "green"))) %>% 
  layer_points()


fill_text <- input_text(label = "Choose color", value = "black")


mtcars %>% 
  ggvis(~mpg, ~wt, 
        fill := fill_text) %>% 
  layer_points()


?input_text


mtcars %>% 
  ggvis(~mpg, ~wt, 
        fill := input_select(label = "Choose fill variable:", 
          map = as.name)) %>% 
  layer_points()
  
  1+1
  
  
  
  
  fill_text<-input_text(label = 'Choose color:', value = names(mtcars))
                        
mtcars %>%    
  ggvis(~mpg, ~wt, 
 fill := fill_text) %>% 
layer_points()




mtcars %>% 
  ggvis(~mpg, ~wt, 
        fill := input_text(label = "Choose color", value = "black")) %>% 
          layer_points()



mtcars %>% 
  ggvis(~mpg, ~wt, 
        fill := input_text(label = "Choose color", value = "black")) %>% 
  layer_points()




mtcars %>% 
  ggvis(~mpg, ~wt, 
        fill := input_texthttps://campus.datacamp.com/(label = "Choose color", value = "black")) %>% 
  layer_points()


# Map the fill property to a select box that returns variable names
mtcars %>% 
  ggvis(~mpg, ~wt, fill := input_select(choices = names(mtcars))) %>% 
  layer_points()






# Change the radiobuttons widget to a text widget 
mtcars %>% 
  ggvis(~mpg, ~wt, 
        fill := input_text(label = "Choose color:", 
                           value = "black")) %>% 
  layer_points()

# Map the fill property to a select box that returns variable names
mtcars %>% 
  ggvis(~mpg, ~wt, 
        fill = input_select(label = "Choose fill variable:", 
                            choices = names(mtcars), map = as.name)) %>% 
  layer_points()