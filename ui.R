

shinyUI(fluidPage(
    titlePanel("Irish Bird Viewer"),

    sidebarLayout(
        sidebarPanel(
            helpText("View The Distributions of Birds In Ireland"),

            uiOutput("birdSelector")),
            mainPanel(
                plotOutput("map")
                )
            )
        
    ))

            
