# Load necessary libraries
library(shiny)
library(shinyBS)
library(ggplot2)
library(dplyr)
library(DT)
library(shinythemes)
library(PerformanceAnalytics)

# Load Titanic dataset from the Titanic package
titanic_train <- read.csv("titanic_case.csv")

# Preprocess the Titanic data for convenience
titanic_train$Survived <- factor(titanic_train$Survived, labels = c("No", "Yes"))
titanic_train$Pclass <- factor(titanic_train$Pclass, labels = c("1st Class", "2nd Class", "3rd Class"))
titanic_train$Sex <- factor(titanic_train$Sex)
titanic_train$Embarked <- factor(titanic_train$Embarked, levels = c("C", "Q", "S"), labels = c("Cherbourg", "Queenstown", "Southampton"))

# Define UI
ui <- fluidPage(
  theme = shinytheme("lumen"),
  
  # Application title
  titlePanel("Titanic Dataset Analysis"),
  
  # Navbar layout with pages
  navbarPage("Titanic Dashboard",
             
             # Page 1: Survival by Demographics
             tabPanel("Survival by Demographics",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("sex", "Select Sex", choices = c("All", levels(titanic_train$Sex))),
                          selectInput("pclass", "Select Class", choices = c("All", levels(titanic_train$Pclass))),
                          selectInput("embarked", "Select Embarkation Port", choices = c("All", levels(titanic_train$Embarked)))
                        ),
                        mainPanel(
                          plotOutput("demographic_plot"),
                          bsTooltip(id = "demographic_plot", 
                                    title = "This chart shows survival rates by sex, class, and embarkation port.", 
                                    placement = "left", 
                                    trigger = "hover")
                        )
                      )
             ),
             
             # Page 2: Fare vs Survival
             tabPanel("Fare vs Survival",
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("fare_range", "Select Fare Range", 
                                      min = min(titanic_train$Fare, na.rm = TRUE), 
                                      max = max(titanic_train$Fare, na.rm = TRUE), 
                                      value = c(0, max(titanic_train$Fare, na.rm = TRUE)))
                        ),
                        mainPanel(
                          plotOutput("fare_plot"),
                          p("This chart shows the relationship between fare and survival.")
                        )
                      )
             ),
             
             # Page 3: Age and Survival
             tabPanel("Age and Survival",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("actual_or_prob", "Actual survival or Probability", c("Actual", "Probability"), "Actual"),
                          sliderInput("age_range", "Select Age Range", 
                                      min = min(titanic_train$Age, na.rm = TRUE), 
                                      max = max(titanic_train$Age, na.rm = TRUE), 
                                      value = c(0, max(titanic_train$Age, na.rm = TRUE)))
                        ),
                        mainPanel(
                          plotOutput("age_plot"),
                          p("This chart shows the survival rate based on age.")
                        )
                      )
             ),
             
             # Page 4: Correlation Analysis
             tabPanel("Correlation Analysis",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("corr_variable", "Features to correlate",
                                      c("Fare","SibSp", "Male", "SurvivalP", "Parch", "Age"), 
                                      multiple = TRUE)
                        ),
                        mainPanel(
                          plotOutput("correlationmatrix")
                        )
                      )
             ),
             
             # Page 5: Exploratory Data Analysis (Summary Stats & Table)
             tabPanel("Summary Stats Table",
                      sidebarLayout(
                        sidebarPanel(
                          p("Explore basic summary statistics and the full dataset.")
                        ),
                        mainPanel(
                          DTOutput("summary_table"),
                          p("This table displays the full dataset with sortable columns for further analysis.")
                        )
                      )
             )
  )
)

# Define server logic
server <- function(input, output) {
  
  # 1. Survival by Demographics plot
  demographic_df <- reactive({
    filtered_data <- titanic_train
    if(input$sex != "All") {
      filtered_data <- filtered_data %>% filter(Sex == input$sex)
    }
    if(input$pclass != "All") {
      filtered_data <- filtered_data %>% filter(Pclass == input$pclass)
    }
    if(input$embarked != "All") {
      filtered_data <- filtered_data %>% filter(Embarked == input$embarked)
    }
    return(filtered_data)
    })
  
  output$demographic_plot <- renderPlot({
    ggplot(demographic_df(), aes(x = Survived, fill = Pclass)) +
      geom_bar(position = "dodge") +
      facet_wrap(~ Sex) +
      labs(title = "Survival by Demographics", x = "Survival Status", y = "Count")
  })
  
  # 2. Fare vs Survival plot
  output$fare_plot <- renderPlot({
    filtered_data <- titanic_train %>% filter(Fare >= input$fare_range[1] & Fare <= input$fare_range[2])
    ggplot(filtered_data, aes(x = Fare, y = SurvivalP)) +
      geom_jitter(aes(color = Pclass), width = 0.2, height = 0.05) +
      labs(title = "Fare vs Survival", x = "Fare", y = "Survival Probability")
  })
  
  # 3. Age vs Survival plot
  output$age_plot <- renderPlot({
    filtered_data <- titanic_train %>% filter(Age >= input$age_range[1] & Age <= input$age_range[2])
    if (input$actual_or_prob == "Actual"){
      ggplot(filtered_data, aes(x = Age, fill = Survived)) +
        geom_histogram(binwidth = 2, position = "dodge", alpha = 0.7) +
        labs(title = "Age Distribution of Survivors vs Non-Survivors", x = "Age", y = "Count")
      }
    else if (input$actual_or_prob == "Probability"){
      ggplot(filtered_data, aes(x = Age, y = SurvivalP)) +
        geom_point() +
        labs(title = "Age Distribution of Survivors vs Non-Survivors", x = "Age", y = "Count")
    }
  })
  
  # 4. Correlation Analysis (heatmap)
  
  correlate <- reactive({
    req(length(input$corr_variable) > 1)
    corrdata <- titanic_train[, input$corr_variable]
    return(corrdata)
  })
  
  output$correlationmatrix <- renderPlot(chart.Correlation(correlate(), histogram=TRUE, pch=19))
  
  # 5. Exploratory Data Analysis (Summary Table)
  output$summary_table <- renderDT({
    datatable(titanic_train, options = list(pageLength = 10, searchable = TRUE))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
