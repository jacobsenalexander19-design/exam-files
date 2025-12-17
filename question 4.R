library(shiny)
library(tidyverse)
library(lubridate)

# Define UI
ui <- fluidPage(
  titlePanel("Storms Data Analysis"), # Title matches Figure 4.1 [cite: 154]
  
  tabsetPanel(
    # --- PAGE 1: PLOT (Matches Figure 4.1) ---
    tabPanel("Plot", # Tab name [cite: 155]
             br(),
             sidebarLayout(
               sidebarPanel(
                 # 1. Slider for Year Range
                 # Range 1975-2023 matches the visual slider in Figure 4.1 [cite: 157]
                 sliderInput("year_range", "Select Year",
                             min = 1975, max = 2023, 
                             value = c(1995, 2023), # Default matching the screenshot
                             sep = ""),
                 
                 # 2. Dropdown for Metric
                 # "Pressure" is shown selected in Figure 4.1 [cite: 159]
                 selectInput("metric", "Select Metric",
                             choices = c("Pressure", "Wind_Speed", "Rain_Level"),
                             selected = "Pressure"),
                 
                 # 3. Multi-select for Storm Category
                 # Matches the input box showing "1 2 3 4 5" [cite: 161]
                 selectInput("categories", "Select Storm Category",
                             choices = c(1, 2, 3, 4, 5),
                             selected = c(1, 2, 3, 4, 5),
                             multiple = TRUE)
               ),
               
               mainPanel(
                 # Output for the scatter plot
                 plotOutput("storm_plot")
               )
             )
    ),
    
    # Placeholder for Page 2 (Overview) - we will add this next
    tabPanel("Overview",
             h3("Overview Page (To be implemented in next step)")
    )
  )
)

# Define Server
server <- function(input, output, session) {
  
  # 1. Load and Clean Data
  storm_data <- reactive({
    req(file.exists("exam.csv"))
    df <- read_csv("exam.csv")
    
    # REQUIREMENT: Create a date-time variable for the x-axis [cite: 151]
    # We combine year, month, day, and hour using lubridate
    df <- df %>%
      mutate(datetime = make_datetime(year, month, day, hour),
             Storm_Category = as.factor(Storm_Category))
    
    return(df)
  })
  
  # 2. Render the Plot
  output$storm_plot <- renderPlot({
    req(storm_data())
    
    # Filter data based on user inputs
    data_filtered <- storm_data() %>%
      filter(year >= input$year_range[1] & year <= input$year_range[2]) %>%
      filter(Storm_Category %in% input$categories)
    
    # Create the plot matching Figure 4.1
    # x-axis: Time (datetime), y-axis: User Metric, color: Storm Category
    ggplot(data_filtered, aes_string(x = "datetime", y = input$metric, color = "Storm_Category")) +
      geom_point(alpha = 0.5) +          # Scatter points
      geom_smooth(method = "loess") +    # Smooth lines seen in Figure 4.1 [cite: 163]
      labs(title = paste("Storm Intensity Over Time"), # [cite: 163]
           x = "Time", 
           y = input$metric) +
      theme_minimal()
  })
}

# Run the Application
shinyApp(ui = ui, server = server)
