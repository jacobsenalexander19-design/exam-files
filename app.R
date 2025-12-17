library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("Reexam"),
  textOutput("fetchDataOutput")
)

# Define Server
server <- function(input, output) {
  
  # Function to fetch data
  fetchData <- function() {
    if (file.exists("/.dockerenv")) {
      num <- as.numeric((gsub("\\.", "", system("curl -s ifconfig.me", intern = TRUE))))
      output <- paste0(num, ".XX", collapse = "")
      return(output)
    } else {
      num <- as.numeric((gsub("\\.", "", system("curl -s ifconfig.me", intern = TRUE))))
      output <- paste0(num, ".YY", collapse = "")
      return(output)
    }
  }
  
  # Output of fetchData
  output$fetchDataOutput <- renderText({
    fetchData()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
