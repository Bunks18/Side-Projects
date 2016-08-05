pressure %>% 
  ggvis(~temperature, ~pressure) %>% 
  layer_lines(:='skyblue') %>% layer_points()




pressure %>% 
  ggvis(~temperature, ~pressure, shape := "triangle-up") %>% 
  layer_lines(stroke := "skyblue") %>% 
  layer_points()



pressure %>% 
  ggvis(~temperature, ~pressure, strokeOpacity :=.05, strokeWidth:=5, stroke :='skyblue') %>% 
  layer_lines() %>% 
  layer_points(fill = ~temperature, shape := "triangle-up", size := 300)



# Add a layer of points to the graph below.
pressure %>% 
  ggvis(~temperature, ~pressure, stroke :='skyblue') %>% 
  layer_lines() %>% layer_points()

# Copy and adapt the solution to the first instruction below so that only the lines layer uses a skyblue stroke.

pressure %>% 
  ggvis(~temperature, ~pressure) %>% 
  layer_lines(stroke :='skyblue') %>% layer_points()


# Rewrite the code below so that only the points layer uses the shape property.
pressure %>% 
  ggvis(~temperature, ~pressure) %>% 
  layer_lines(stroke := "skyblue") %>% 
  layer_points(shape :='triangle-up')


# Refactor the code for the graph below to make it as concise as possible
pressure %>% 
  ggvis(~temperature, ~pressure,  strokeWidth:=5, stroke :='skyblue') %>% 
  layer_lines(strokeOpacity :=.05) %>% 
  layer_points(fill = ~temperature, strokeOpacity := .05, shape := "triangle-up", size := 300)