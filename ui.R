# ui.R script 

# This app is used for a company to reduce cost on car rental using mtcars dataset in R 

library(markdown)

shinyUI(navbarPage("Smartest way to select cars",
        tabPanel("Table",
                   
      
        sidebarLayout(
            sidebarPanel(
                helpText("Inform about your destination and your car preference"),
                numericInput('dis', 'Distance (in miles):', 50, min = 1, max = 1000),
                numericInput('cost', 'Gasoline Price (per gallon):', 2.29, min = 2, max = 4, step=0.01),
                numericInput('gas', 'Gasoline Expenses:', 50, min=1, max=1000),
                checkboxGroupInput('cyl', 'Number of cylinders:', c("Four"=4, "Six"=6, "Eight"=8), selected = c(4,6,8)),
                sliderInput('disp', 'Displacement', min=70, max=480, value=c(70,480), step=10),
                sliderInput('hp', 'Gross horsepower', min=50, max=340, value=c(50,340), step=10),
                checkboxGroupInput('am', 'Transmission:', c("Automatic"=0, "Manual"=1), selected = c(0,1))
            ),
            
            
            mainPanel(
               dataTableOutput('table')
            )
        )
),
        tabPanel("Overview",
            mainPanel(
                includeMarkdown("overview.md")
            )
        )
    )
)   
