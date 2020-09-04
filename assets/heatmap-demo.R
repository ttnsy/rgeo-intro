library(leaflet)
library(leaflet.extras)

california <- read.csv('data_input/california_housing.csv')

norm <- function(x){
  return((max(x)-x)/(max(x)-min(x)))
}

# Sample because too huge
california <- california[sample(nrow(california),1000),] %>%
  mutate(median_house_value.n = norm(median_house_value))



leaflet(california) %>%
  addProviderTiles(providers$CartoDB.DarkMatter) %>%
  addHeatmap(lng = ~longitude, lat = ~latitude,
             intensity = ~median_house_value.n,
             radius = 20,
             blur=40)