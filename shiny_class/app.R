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
    
    # Application title
    navbarPage(
      theme = shinytheme("united"),
      # theme = "cerulean",  # <--- To use a theme, uncomment this
      "shinythemes",
      tabPanel("Iris",
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
      ),
      tabPanel("Pokemon", 
                
               sidebarPanel(
                 fileInput("arquivo", label = "Selecione seu arquivo pokemon"),
                 checkboxGroupInput("pokemontype", "Tipo",
                                    choices = NULL,
                                    selected = NULL
                 ),
                  radioButtons("attribute",
                               "Atributo",
                               choices = c("attack", "defense", "speed", "hp", "All"),
                               selected = "All"
                  )
               ),
               mainPanel(
                 h1("Atributos dos Pokemons"),
                 plotOutput("plotpokemon", width = "80%", height = 400)
               )
                 
               
      ),
      tabPanel("Navbar 3", "This panel is intentionally left blank")
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  # Lendo arquivo
  
  df <- reactive({
    if(!is.null(input$arquivo))
      read.csv(input$arquivo$datapath)
    else
      NULL

  })
  
  # 
  observe({
    
    if(!is.null(df()))
      updateCheckboxGroupInput(
        session = getDefaultReactiveDomain(),
        "pokemontype",
        label = "Tipo",
        choices = unique(df()$type)[order(unique(df()$type))],
        selected = unique(df()$type)
      )
    
  })
  
  
  

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
    

    output$plotpokemon <- renderPlot({
      # generate bins based on input$bins from ui.R
      if(!is.null(df()))
        df() %>%
          filter(is.null(input$pokemontype) | type %in% input$pokemontype) %>%
          select(type, hp, attack, defense, speed) %>%
          pivot_longer(2:5, names_to = "medida", values_to = "value") %>%
          filter(input$attribute == "All" | medida == input$attribute) %>%
          # draw the histogram with the specified number of bins
          ggplot(aes(x = type, y = value, color = type, fill = type))+
          geom_boxplot(alpha = 0.4)+
          facet_wrap(.~medida, nrow = 2)+
          theme_bw()+
          theme(
            axis.text.x = element_blank()
          )
      else
        ggplot()
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
