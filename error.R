library(shiny)
library(ggplot2)
library(dplyr)

### Remember to set YOUR working directory.
# setwd("G:/My Drive/AU/Teaching/2025/Data_Management_and_Data_Visualization/Examples")

biopics <- read.csv("biopics.csv")

biopics <- biopics %>%
  mutate(box_office = gsub("\\$", "", box_office)) %>%
  mutate(box_office = gsub("m", "", box_office)) %>%
  mutate(box_office = gsub("-", "", box_office))%>%
  mutate(box_office = as.numeric(box_office))

categoricalVars <- c("country", "type_of_subject", "subject_sex")

ui <- fluidPage(
  
  plotOutput("movie_plot"),
  sliderInput("year_filter",
              "Select Lowest Year",
              min = 1915,
              max=2014,
              value = 1915,
              sep = ""),
  selectInput(
    inputId = "color_selecting", 
    label = "Select Categorical Variable",
    choices = categoricalVars,
    selected = 1)
)

server <- function(input, output) {
  
  biopics_filtered <- reactive({
    
    biopics %>%
      filter(year_release < input$year_filter) 
    
  })
  
  output$movie_plot <- renderPlot({
    
    ggplot(biopics_filtered()) +
      aes(x=year_release,
          y=box_offices, 
          color=.data[[input$color_select]]) +
      
      geom_point 
  })
  
}

shinyApp(ui = ui, server = server)










# Help: 
# color_selecting -> color_select 
# box_offices -> box_office 
# geom_point -> geom_point()
# < -> >
