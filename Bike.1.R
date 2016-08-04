rm(list=ls())
#### download capitabl bikeshare data

temp <- tempfile()
download.file("https://s3.amazonaws.com/capitalbikeshare-data/2016-Q2-cabi-trips-history-data.zip",temp)
data <- read.csv(unz(temp, "2016-Q2-Trips-History-Data.csv"))

### inspect data
head(data$Start.date)
head(data$End.date)
str(data)

### convert duration to minutes
library(dplyr)
data<-mutate(data, Duration= ((Duration..ms./1000)/60))
# remove initial column
data <- subset(data, select = -Duration..ms.)

### Average Trip Length for Casual vs Registered Users 
summary<-data %>%
  group_by(Account.type)%>%
  summarize(Average_Trip_Length = mean(Duration),
            Count = n())
summary

#### Get Geo Locations of stations

### subset to get the stations
Stations<-subset(data, select = Start.station)

### get unique stations
Unique<-unique(Stations)

### replace & w/and
Unique$Start.station<-gsub('&', 'and', Unique$Start.station)

### Get geo coordinates 
Geoprep<-geocode(Unique$Start.station)

### create ID for join later 
Unique$ID<-1:nrow(Unique)
Geoprep$ID<-1:nrow(Geoprep)

###Get old Unique station list for join
OldUnique<-unique(Stations); OldUnique$ID<-1:nrow(OldUnique)

### Merge OldUnique with Geo
PrepMasteR<-merge(OldUnique, Geoprep, by ='ID')

### Join lat and long with Original File
Master<-merge(data, PrepMasteR, by ='Start.station')

### remove NA's
newdata <- na.omit(Master)

####bring in lubridate and recast variables
install.packages('lubridate'); library(lubridate)

Mapprep<-mutate(newdata, Date = mdy(gsub( " .*$", "", Start.date)), Time= sub(".* ", "", Start.date))
Mapprep<-mutate(Mapprep, Time = gsub(":.*$", "", Time))


### Create data set for mapping
Mapdf<-Mapprep %>%
  group_by(Start.station)%>%
  summarize(count = n(),
            lat = first(lat),
            lon = first(lon))

###create map with leaflet
install.packages('leaflet'); library(leaflet)

### create custom map template 
m <- leaflet() %>% setView(lng = -77.0369, lat = 38.9072, zoom = 12)

###create color pallet 
pal <- colorNumeric(
  palette = "Reds",
  domain = Mapdf$count
)

##create map
mymap<-m %>% addCircleMarkers(~lon, ~lat, color = ~pal(count),fillOpacity = 1, radius = 5, data = Mapdf) %>% 
  addTiles() %>% addLegend(pal = pal, title ='Count of Bikes/ Station', 
                           values = Mapdf$count, opacity = 1) %>% addProviderTiles("CartoDB.DarkMatter")
mymap
