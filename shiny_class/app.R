#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
# Cheatsheet
# https://shiny.posit.co/r/articles/start/cheatsheet/

library(shiny)
library(shinythemes)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
    theme = shinytheme("slate"),
    # Application title
    titlePanel("Teste"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            checkboxGroupInput("especies", "Espécies",
                               choices = c("setosa", "virginica", "versicolor"),
                               selected = c("setosa", "virginica", "versicolor")
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
          fluidRow(
            h1("Histograma"),
            plotOutput("distPlot", width = "60%", height = 200)
          ),
          fluidRow(
            h1("Gráfico de espalhamento"),
            plotOutput("distPlot2", width = "60%", height = 200)
          )
            
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
      iris %>% 
        filter(Species %in% input$especies) %>%
        # draw the histogram with the specified number of bins
        ggplot(aes(x = Sepal.Length, color = Species, fill = Species))+
        geom_density(alpha = 0.4)+
        theme_bw()
    })
    output$distPlot2 <- renderPlot({
        # generate bins based on input$bins from ui.R
        
        # draw the histogram with the specified number of bins
        
      iris %>% 
        filter(Species %in% input$especies) %>% 
        ggplot(aes(x = Sepal.Length, y = Sepal.Width, color = Species))+
        geom_point()+
        theme_bw()
      
    })
    
    # Lendo arquivo
    
    df <- read.csv("data/Pokemon_full.csv")
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)
