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
ui <- tagList(
    theme = shinytheme("slate"),
    # Application title
    navbarPage(
      # theme = "cerulean",  # <--- To use a theme, uncomment this
      "shinythemes",
      tabPanel("Navbar 1",
        sidebarPanel(
          fileInput("file", "File input:"),
          textInput("txt", "Text input:", "general"),
          sliderInput("slider", "Slider input:", 1, 100, 30),
          tags$h5("Default actionButton:"),
          actionButton("action", "Search"),

          tags$h5("actionButton with CSS class:"),
          actionButton("action2", "Action button", class = "btn-primary")
        ),
        mainPanel(
          tabsetPanel(
            tabPanel("Tab 1",
              h4("Table"),
              tableOutput("table"),
              h4("Verbatim text output"),
              verbatimTextOutput("txtout"),
              h1("Header 1"),
              h2("Header 2"),
              h3("Header 3"),
              h4("Header 4"),
              h5("Header 5")
            ),
            tabPanel("Tab 2", "This panel is intentionally left blank"),
            tabPanel("Tab 3", "This panel is intentionally left blank")
          )
        )
      ),
      tabPanel("Navbar 2", "This panel is intentionally left blank"),
      tabPanel("Navbar 3", "This panel is intentionally left blank")
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
