require(ggmap)
require(maptools)
require(gpclib)
require(sp)
require(dplyr)
require(shiny)

gpclibPermit()

shp <- readShapeSpatial("/srv/shiny-server/birds/shp/AR1212_CurrentDistributionAllSpecies.shp", IDvar="EngName", proj4string = CRS("+proj=tmerc +lat_0=53.5 +lon_0=-8 +k=1.000035 +x_0=200000 +y_0=250000 +a=6377340.189 +b=6356034.447938534 +units=m +no_defs"))
trans_shp <- spTransform(shp, CRS("+proj=longlat +datum=WGS84"))
bird_data <- fortify(trans_shp)

bird_names = as.vector(levels(as.factor(bird_data$id)))
base_map <- qmap("Ireland", zoom = 7,maptype = "satellite", width=1400, height=1400)

shinyServer(function(input, output){
    output$birdSelector <- renderUI({
        selectInput("bird",
                    label = "Choose A bird species",
                    choices= bird_names)})
    
                output$map <- renderPlot({
                    base_map +
                        geom_polygon(
                            aes(x=long, y=lat, group = group),          
                            data=filter(bird_data, id == input$bird), alpha=.3, size=.1, fill = 'blue') +
                            ggtitle(paste("\nDistrubtion of", input$bird)) 

                })
            }
            )
