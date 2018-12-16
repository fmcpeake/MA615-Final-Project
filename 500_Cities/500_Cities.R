library(shiny)
library(leaflet)
library(sp)
library(magrittr)
library(maps)
library(htmltools)
library(rgdal)
library(data.table)
library(tidyverse)
library(shiny)
library(ggplot2)
library(plotly) 
library(shinydashboard)
library(ggmap)
library(tidyr)
library(htmltools)
Cities500 <- read_csv("500_Cities_CDC.csv")
### Getting coordinates of cities
Cities500$Address <- 0
Cities500$Address <- paste(Cities500$PlaceName, Cities500$StateAbbr, "United States")
coordinates <- read.table(text=gsub('[()]', '', Cities500$Geolocation), 
           sep=",", col.names=c('Latitute', 'Longitude'))
Cities500 <- cbind(Cities500, coordinates)

### Making labels for each City
Cities500$label <- paste("<p>", Cities500$PlaceName, ", ", Cities500$StateAbbr, "</p>",
                         "<p>", "Obesity", ": ", Cities500$OBESITY_AdjPrev, "</p>",
                         "<p>", "Cancer", ": ", Cities500$CANCER_AdjPrev, "</p>",
                         "<p>", "Smoking", ": ", Cities500$CSMOKING_AdjPrev, "</p>")
### Making the map
map <- leaflet() %>%
  addTiles() %>%
  setView(lat = 39.8283, lng = -98.5795, zoom = 4)%>%
  addCircleMarkers(lng = Cities500$Longitude, 
                   lat = Cities500$Latitute, 
                   radius = 2,  
                   label = lapply(Cities500$label, HTML))

ui <- dashboardPage(
  skin = "blue",
  dashboardHeader(title = "Obesity, Cancer, and Smoking Adjusted Previlence"),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(box(width = 12, leafletOutput(outputId = "mymap")))
  ))




server <- function(input, output) {
   
  
   output$mymap <- renderLeaflet({
  
       
       leaflet() %>%
         addTiles() %>%
         setView(lat = 39.8283, lng = -98.5795, zoom = 4)%>%
         addCircleMarkers(lng = Cities500$Longitude, 
                          lat = Cities500$Latitute, 
                          radius = 2,  
                          label = lapply(Cities500$label, HTML)) 
       
       
       })
   }

# Run the application 
shinyApp(ui = ui, server = server)

#library(rsconnect)
#rsconnect::setAccountInfo(name='fmcpeake', token='D14B1D5543885ABE5116215CB4D25F10', secret='K05qSZKyX1ehMpW/jS+9vRqP7f9NDywAjGOCXxwn')
#rsconnect::deployApp('C:/Users/Fionnuala/Desktop/RClass/Final Project/MA615-Final-Project') 
