################################################################################
## Shiny server.r
################################################################################

## -----------------------------------------------------------------------------
## RUN WHEN APP IS LAUNCHED
## -----------------------------------------------------------------------------

## load libraries
library('maps')
library('shiny')
library('mapproj')
library('RColorBrewer')

## load data
load('./data/mapdata.rda')

## load other r files
source('mapfunction.r')

## list of years
years <- seq(1997,2012,1)

## create legend labels; colors
colors <- rev(brewer.pal(10,'RdBu'))

## -----------------------------------------------------------------------------
## RUN NEW USER VISITS THE APPLICATION
## -----------------------------------------------------------------------------

shinyServer(function(input, output) {

    ## -------------------------------------------------------------------------
    ## RUN WHEN WIDGET IS CHANGED
    ## -------------------------------------------------------------------------
   
    dataInput <- reactive({
        ## get sample type: all, public, 4-yr public, 2-yr public
        sch <- switch(input$sample1,
                      'All colleges' = 1,
                      'Public colleges' = 2,
                      'Public four year colleges' = 3, 
                      'Public two year colleges' = 4)

        ## get boundary type: all vs instate
        cross <- switch(input$sample2,
                        'Across state lines' = 2,
                        'Compare within state only' = 3)

        ## get year
        yr <- input$year

        ## get associated colors
        color <- cross + 4

        ## get index to subset
        index <- (d[,5] == sch & d[,4] == yr)

        ## subset data
        data <- d[index,][,c(1,cross,5,color)]
    })

    output$map <- renderPlot({

        ## make map
        makemap(dataInput(),colors)
      
    }, bg = 'transparent')
        
})
