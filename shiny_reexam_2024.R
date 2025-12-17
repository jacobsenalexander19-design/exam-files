library(shiny)
library(dplyr)
library(ggplot2)

# Load health data
health = read.csv("reexam_2024.csv")

# Define UI for the application
ui <- fluidPage(
  navbarPage("Health Data Analysis",
             theme = bslib::bs_theme(bootswatch = "lux"),
                 # First panel: Plot of Storm       Data
             tabPanel("Plot",
                      # Application title
                      # Sidebar layout with a input and output definitions
                      sidebarLayout(
                      sidebarPanel(
                        # Create a dropdown menu to choose the analysis type
                        selectInput("x_axis", 
                                    label = "Choose Measure for X-axis:",
                                    choices = c("Age", "House_Hold_Income", "BMI", "Pulse", "Cholesterol"),
                                    selected = "General_Health"),
                        selectInput("y_axis", 
                                    label = "Choose Measure for Y-axis:",
                                    choices = c("Age", "House_Hold_Income", "BMI", "Pulse", "Cholesterol"),
                                    selected = "BMI"),
                        checkboxInput("trend_line", "Add trend line"),
                        selectInput("categorical", 
                                    label = "Choose a Group Measure:",
                                    choices = c("Gender", "Work", "MaritalStatus", "Education", 
                                                "SleepTrouble", "Diabetes", "General_Health"),
                                    selected = "General_Health"),
                  
                      ),
                      
                      # Main panel for displaying the plots and tables
                      mainPanel(
                        h3("Health Data Overview"),
                        plotOutput("health_plot")
                      ))
              ),
             tabPanel("Overview",
                      sidebarLayout(
                        sidebarPanel(
                          # Inputs for filtering data
                          selectInput("measures_summary", "Select Summary Measures", choices = colnames(health), selected = colnames(health), multiple = TRUE),
                        ),
                        mainPanel(
                          # Additional information or output in main panel
                          h4("Health Data Summary"),
                          verbatimTextOutput("summary")
                        )
                      )
             )
  )
)

# Define server logic required to create plots and summaries
server <- function(input, output) {

  
  # Plot
  output$health_plot <- renderPlot({
    ggplot(health, aes(x = .data[[input$x_axis]], y = .data[[input$y_axis]]))+
      geom_point(aes(color= .data[[input$categorical]]), alpha = 0.3) +
      labs(title = sprintf("Analysing %s and %s",input$x_axis, input$y_axis), x = input$x_axis, y = input$y_axis) +
      theme_minimal() +
      theme(legend.title = element_blank()) +
      viridis::scale_color_viridis(discrete = TRUE) +
      if(input$trend_line){geom_smooth(aes(group=.data[[input$categorical]],color= .data[[input$categorical]]),method="loess", se = FALSE, na.rm = TRUE)}
  })
  
  # Overview summary of the weather data
  output$summary <- renderPrint({
    health_select <- health %>%
      select(input$measures_summary)
    
    summary(health_select)
  })

}

# Run the application
shinyApp(ui = ui, server = server)
