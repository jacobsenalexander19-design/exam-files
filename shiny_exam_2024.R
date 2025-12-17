# Load required libraries
library(shiny)
library(ggthemes)
library(dplyr)
library(ggplot2)
library(viridis)

weather <- read.csv("exam.csv")

weather <- weather %>%
  mutate(date = as.Date(strptime(paste(as.character(Year), 
                                              as.character(Month),
                                              as.character(Day), "1", sep="-"), 
                                        format = "%Y-%m-%d"), format = "%Y-%m-%d"))

weather <- weather %>%
  mutate(
    datetime = as.POSIXct(paste(Year, Month, Day, Time, "00", sep = "-"), 
                          format = "%Y-%m-%d-%H-%M", tz = "UTC")
  )



# UI: Define the layout using navbarPage
ui <- navbarPage("Storms Data Analysis",
                 #theme = bslib::bs_theme(bootswatch = "lux"),
                 # First panel: Plot of Storm Data
                 tabPanel("Plot",
                          sidebarLayout(
                            sidebarPanel(
                              # Controls for the plot (like Storm_Category and Year filter)
                              sliderInput("year_plot", "Select Year", 
                                          min = min(weather$Year), 
                                          max = max(weather$Year),
                                          sep = "",
                                          ticks = FALSE,
                                          value = c(min(weather$Year), max(weather$Year)), step = 1),
                              selectInput("metric", 
                                          "Select Metric", 
                                          choices = c("Wind_Speed", "Pressure", "Diameter_of_Tropical_Storm", "Force_of_Hurricane"), 
                                          selected = "Wind_Speed"),
                              selectInput("category_plot", 
                                          "Select Storm Category", 
                                          choices = c("1", "2", "3", "4", "5"), 
                                          multiple = TRUE),
                            ),
                            mainPanel(
                              # Output plot for storm intensity
                              plotOutput("stormPlot")
                            )
                          )
                 ),

                 # Second panel: Overview (Summary of data)
                 tabPanel("Overview",
                          sidebarLayout(
                            sidebarPanel(
                              # Inputs for filtering data
                              selectInput("measures_summary", "Select Summary Measures", choices = colnames(weather), selected = colnames(weather), multiple = TRUE),
                            ),
                            mainPanel(
                              # Additional information or output in main panel
                              h4("Storms Data Summary"),
                              verbatimTextOutput("summary")
                            )
                          )
                 )
)

# Server: Define the logic for rendering the UI
server <- function(input, output) {

  # Overview summary of the weather data
  output$summary <- renderPrint({
    storms_select <- weather %>%
      select(input$measures_summary)
    
    summary(storms_select)
  })
  
  filtered_storms <- reactive({

      weather %>%
        filter(Year >= input$year_plot[1] & Year <= input$year_plot[2],
               Storm_Category  %in% input$category_plot)
  })
  
  # Plot the storm intensity over time based on filtered data
  output$stormPlot <- renderPlot({
    filtered_storms_data <- filtered_storms()
    
    ggplot(filtered_storms_data, aes(x = datetime, y = .data[[input$metric]])) +
      #geom_smooth(method="loess", color="steelblue") +
      geom_smooth(method = "loess", se = FALSE, aes(group = Storm_Category, color = factor(Storm_Category)) )+
      geom_point(aes(color = factor(Storm_Category)), size = 1) +
      labs(title = "Storm Intensity Over Time", x = "\nTime", y = paste(gsub("_"," ", input$metric), "\n")) +
      scale_color_viridis(discrete = TRUE, name="Storm Category") +
      theme_minimal()

  })
}

# Run the Shiny app
shinyApp(ui, server)

