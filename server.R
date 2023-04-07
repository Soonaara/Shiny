#final shiny
library(shiny)

r <- 1000

# Define server logic required to draw a histogram
shinyServer(
  
  function(input, output, session) {
    
    rv <- reactiveValues(sample = NULL,
                         all.means = NULL)
    
    output$myPlot <- renderPlot({
      
      distType <- input$Distribution
      
      size <- input$sampleSize
      
      randomVec <- switch(input$Distribution,
                          "Normal" = matrix(rnorm(size*r, mean = as.numeric(input$mean), sd=as.numeric(input$sd)), r),
                          "Exponential" = matrix(rexp(size*r, rate = 1/as.numeric(input$lambda)), r)
      )
      
      rv$sample <- as.numeric(randomVec[1, ])
      rv$all.means <- as.numeric(apply(randomVec, 1, mean))
      
      
      par(mfrow=c(2,2), oma=c(0,0,5,0))

      hist(rv$all.means, main="Sampling Distribution of the Mean",
           ylab="Frequency",xlab="Mean",col=3)
      mtext("Distribution simulation", outer=TRUE, cex=3)
      # Create a histogram
      hist(rv$sample, freq = FALSE, main = "Histogram and Density",xlab="Mean")
      
      # Calculate density
      dx <- density(rv$sample)
      
      # Add density
      lines(dx, lwd = 2, col = "red")
      
    }   , height=660, width=900)
  } 
  
)
