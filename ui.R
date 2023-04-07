#Final shiny

library(shiny)
library(shinydashboard)


ui <- dashboardPage(
  dashboardHeader(
    title = "Selection"),
  
  dashboardSidebar(
    
    helpText('Choose distribution, sample size, mean value and STD.'),
    
    selectInput("Distribution", "Please Select Distribution Type",
                choices = c("Normal", "Exponential")),
    
    sliderInput("sampleSize", "Select Sample Size: ", min=10, max=1000, value=50, step=10),
    
    conditionalPanel(condition = "input.Distribution == 'Normal'",
                     textInput("mean", "Select the Mean", 0),
                     textInput("sd", "Select Standard Deviation", 1)),
    
    conditionalPanel(condition = "input.Distribution == 'Exponential'",
                     textInput("lambda", "Select Exponential Lambda", 1))

  ),
  
  dashboardBody(
    
    plotOutput("myPlot")
    
  )
  
)
