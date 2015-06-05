library(shiny)
library(shinydashboard)

header <- dashboardHeader(title = "Statistical Skier")

sidebar <- dashboardSidebar(
  selectInput("type","Event Type",
              choices = c('Distance','Sprint'),
              selected = 'Distance'),
  dateInput("date",
            label = "Date yyyy-mm-dd",
            value = Sys.Date()),
  sliderInput("Kfactor",
              "Volatility:",
              min = 0,
              max = 1,
              value = 0.5,
              step = 0.01,
              ticks = FALSE),
  hr(),
  submitButton("Calculate Ratings")
  )

body <- dashboardBody(
  fluidRow(
    column(width = 6,
           dataTableOutput("men")),
    column(width = 6,
           dataTableOutput("wom"))
    )
  )

dashboardPage(header,sidebar,body)