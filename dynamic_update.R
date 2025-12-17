library(shiny)

# Updating input ####
ui <- fluidPage(
  numericInput("min", "Minimum", 0),
  numericInput("max", "Maximum", 3),
  sliderInput("n", "n", min = 0, max = 3, value = 1)
)
server <- function(input, output, session) {
  observeEvent(input$min, {
    updateSliderInput(inputId = "n", min = input$min)
  })
  observeEvent(input$max, {
    updateSliderInput(inputId = "n", max = input$max)
  })
}

shinyApp(ui = ui, server = server)

# Resetting inputs ####

ui <- fluidPage(
  sliderInput("x1", "x1", value = 0, min = -10, max = 10),
  sliderInput("x2", "x2", value = 0, min = -10, max = 10),
  sliderInput("x3", "x3", value = 0, min = -10, max = 10),
  actionButton("reset", "Reset")
)

server <- function(input, output, session) {
  observeEvent(input$reset, {
    updateSliderInput(inputId = "x1", value = 0)
    updateSliderInput(inputId = "x2", value = 0)
    updateSliderInput(inputId = "x3", value = 0)
  })
}

shinyApp(ui = ui, server = server)

#Dynamic visibility ####

parameter_tabs <- tabsetPanel(
  id = "params",
  type = "hidden",
  tabPanel("normal",
           numericInput("mean", "mean", value = 1),
           numericInput("sd", "standard deviation", min = 0, value = 1)
  ),
  tabPanel("uniform",
           numericInput("min", "min", value = 0),
           numericInput("max", "max", value = 1)
  ),
  tabPanel("exponential",
           numericInput("rate", "rate", value = 1, min = 0),
  )
)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("dist", "Distribution",
                  choices = c("normal", "uniform", "exponential")
      ),
      numericInput("n", "Number of samples", value = 100),
      parameter_tabs,
    ),
    mainPanel(
      plotOutput("hist")
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$dist, {
    updateTabsetPanel(inputId = "params", selected = input$dist)
  })
  
  sample <- reactive({
    switch(input$dist,
           normal = rnorm(input$n, input$mean, input$sd),
           uniform = runif(input$n, input$min, input$max),
           exponential = rexp(input$n, input$rate)
    )
  })
  output$hist <- renderPlot(hist(sample()), res = 96)
}

shinyApp(ui = ui, server = server)

# renderUI and uiOutput ####

ui <- fluidPage(
  textInput("label", "label"),
  selectInput("type", "type", c("slider", "numeric")),
  uiOutput("numeric")
)
server <- function(input, output, session) {
  output$numeric <- renderUI({
    if (input$type == "slider") {
      sliderInput("dynamic", input$label, value = 0, min = 0, max = 10)
    } else {
      numericInput("dynamic", input$label, value = 0, min = 0, max = 10)
    }
  })
}
shinyApp(ui = ui, server = server)