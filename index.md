---
title: "Analysis of the mtcars dataset"
author: "Aman Sinha"
highlighter: highlight.js
job: Reproducible Pitch Presentation
knit: slidify::knit2slides
mode: selfcontained
github:
  user:amansinha16
  repo:developing-data-products
hitheme: tomorrow
subtitle: variables and MPG
framework: io2012
widgets: bootstrap
 
---



### See the Regression Models Course Project  

- URL: *https://github.com/amansinha16*
- Find here all the data that have been use for this presentation and also for the first part of the data Science Project: "First, you will create a Shiny application and deploy it on Rstudio's servers.Second, you will use Slidify or Rstudio Presenter to prepare a reproducible pitch presentation about your application."

-"Since the beginning of the Data Science Specialization, we've noticed the unbelievable passion students have about our courses and the generosity they show toward each other on the course forums. A couple students have created quality content around the subjects we discuss, and many of these materials are so good we feel that they should be shared with all of our students."


---

## mtcars dataset

### Motor Trend Car Road Tests

> This reproducible pitch presentation is linked to an application designed for a company to reduce cost on car rental expenses.
>The app developed for the first part of the assignment is avalilable at: URL: *https://amansinha.shinyapps.io/serve*
>Source code for ui.R and server.R files are available on the GitHub at:URL: *https://github.com/amansinha16/developing-data-products*
>The mtcars dataset is included in R


### Source


```r
library(datasets)
head(mtcars, 3)
```

```
##                mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4     21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag 21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710    22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
```

---

## mtcars dataset - Format

**A data frame with 32 observations on 11 variables.**

| Index | Field | Detail |
------- | ----- | ------ |
| [, 1] | mpg | Miles/(US) gallon |
| [, 2]  | cyl | Number of cylinders |
| [, 3]	| disp | Displacement (cu.in.) |
| [, 4]	| hp | Gross horsepower |
| [, 5]	| drat | Rear axle ratio |
| [, 6]	| wt | Weight (lb/1000) |
| [, 7]	| qsec | 1/4 mile time |
| [, 8]	| vs | V/S |
| [, 9]	| am | Transmission (0 = automatic, 1 = manual) |
| [,10]	| gear | Number of forward gears |
| [,11]	| carb | Number of carburetors |

---

## Analysis - main code

```r
library(shiny)
library(datasets)
library(dplyr)

shinyServer(function(input, output) {

    # To filter cars based on features
    output$table <- renderDataTable({
        disp_seq <- seq(from = input$disp[1], to = input$disp[2], by = 0.1)
        hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
        data <- transmute(mtcars, Car = rownames(mtcars), MilesPerGallon = mpg, 
                          GasolineExpenditure = input$dis/mpg*input$cost,
                          Cylinders = cyl, Displacement = disp, Horsepower = hp, 
                          Transmission = am)
        data <- filter(data, GasolineExpenditure <= input$gas, Cylinders %in% input$cyl, 
                       Displacement %in% disp_seq, Horsepower %in% hp_seq, Transmission %in% input$am)
        data <- mutate(data, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
        data <- arrange(data, GasolineExpenditure)
        data
    }, options = list(lengthMenu = c(5, 15, 30), pageLength = 30))
})


```

