# Add a layer of points to the graph below.
pressure %>% 
  ggvis(~temperature, ~pressure, stroke := "skyblue") %>% 
  layer_lines() %>% layer_points()

# Copy and adapt the solution to the first instruction below so that only the lines layer uses a skyblue stroke.

pressure %>% 
  ggvis(~temperature, ~pressure) %>% 
  layer_lines(stroke := "skyblue") %>% layer_points()


# Rewrite the code below so that only the points layer uses the shape property.
pressure %>% 
  ggvis(~temperature, ~pressure) %>% 
  layer_lines(stroke := "skyblue") %>% 
  layer_points(shape := "triangle-up")

# Refactor the code for the graph below to make it as concise as possible

pressure %>% 
  ggvis(~temperature, ~pressure, stroke :='skyblue', strokeOpacity := 0.5, strokeWidth := 5) %>% 
  layer_lines() %>% 
  layer_points( fill = ~temperature, 
                shape := "triangle-up", 
                size := 300)

pressure %>%
  ggvis(~temperature, ~pressure) %>%
  layer_model_predictions(model = 'lm')



pressure %>
  ggvis(~temperature, ~pressure) %>% layer_lines(strokeOpacity := 0.5) 





pressure %>%
  ggvis(~temperature, ~pressure) %>% layer_points() %>% layer_lines(opacity := 0.5) %>%
  layer_model_predictions(model = 'lm', stroke := 'skyblue')

?layer_model_predictions()




pressure %>%
  ggvis(~temperature, ~pressure) %>% layer_points() %>% layer_lines(opacity := 0.5) %>%
  layer_model_predictions(model = 'lm', stroke := 'skyblue')


pressure %>% 
  ggvis(~temperature, ~pressure) %>%
  layer_lines(opacity := 0.5) %>%
  layer_points() %>%
  layer_model_predictions(model = "lm", stroke := "navy") %>%
  layer_smooths(stroke := "skyblue")







pressure %>% 
  ggvis(~temperature, ~pressure, shape := "circle") %>% 
  layer_lines(stroke := "orange", strokeDash := 5, strokeWidth := 5) %>% 
  layer_points(size := 100, fill := "lightgreen") %>%
  layer_smooths(stroke := "darkred")
