Developing Data Products - Reproducible Pitch
========================================================
author: Ivan Avalos
date: 08 March, 2021
autosize: true

Reproducible Pitch
========================================================

In this presentation we used Rstudio Presenter to prepare
a reproducible pitch presentation about our shiny application.

The shiny application is in this link:

<https://nirvana43p.shinyapps.io/app_project/>

The files ui.R and server.R are in my github repositorie

<https://github.com/nirvana43p/Course-Project-Shiny-Application-and-Reproducible-Pitch.git>



Data used for shiny application
========================================================


```r
str(iris)
```

```
'data.frame':	150 obs. of  5 variables:
 $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
 $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
 $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
 $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
 $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
```

ui.R file
========================================================


```r
library(shiny)

shinyUI(
    navbarPage("Shiny Application",
               tabPanel("Linear Regression Analysis",
                        fluidPage(
                            titlePanel("Linear Regression Analysis Between Variables Of Iris Plant Dataset"),
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput("outcome", "Outcome:",
                                                c("Sepal Length" = "Sepal.Length",
                                                  "Sepal Width" = "Sepal.Width",
                                                  "Petal.Length" = "Petal.Length",
                                                  "Petal.Width" = "Petal.Width"
                                                )),

                                    selectInput("predictor", "Predictor:",
                                                c("Petal Length" = "Petal.Length",
                                                  "Petal Width" = "Petal.Width",
                                                  "Sepal Length" = "Sepal.Length",
                                                  "Sepal Width" = "Sepal.Width"
                                                )),

                                    strong("Species:"),

                                    checkboxInput("setosa", "setosa", TRUE),
                                    checkboxInput("versicolor", "versicolor", TRUE),
                                    checkboxInput("virginica", "virginica", TRUE)

                                ),

                                mainPanel(
                                    h3(textOutput("caption")),

                                    tabPanel("Linear Regression Model",
                                             plotOutput("fitPlot"),
                                             verbatimTextOutput("fit")
                                    )

                                )
                            )
                        )
               ),
               tabPanel("Iris Plant Dataset",

                        h3("Description"),
                        helpText("This famous (Fisher's or Anderson's) iris data set gives the measurements in centimeters of the variables sepal length and width and petal length and width, respectively, for 50 flowers from each of 3 species of iris.",
                                 "The species are Iris setosa, versicolor, and virginica."),

                        h3("Format"),
                        helpText("iris is a data frame with 150 cases (rows) and 5 variables (columns) named Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, and Species."),

                        p("Source from R Documentation")
               ),
               tabPanel("About the app",
                        h2("Linear Regression Between Variables Of Iris Plant Dataset"),
                        hr(),
                        h3("Description"),
                        helpText("The Objective of this app is to fit several linear models between variables of the iris plant dataset."),
                        h3("Note"),
                        helpText("You should choose a different variables for the outcome and predictor. For instance, if you choose Sepal Length as an outcome, you should not choose Sepal Length as a predictor."),

               ),
               tabPanel("Github repository",
                        a("https://github.com/nirvana43p/Course-Project-Shiny-Application-and-Reproducible-Pitch.git"),
                        hr(),
                        p("In my Github repository are the ui.R and server.R files of this app"),

               )
    )
)
```

server.R file
========================================================


```r
library(shiny)

shinyServer(function(input, output) {

    getSpecies <- reactive({
        species <- character()
        if (input$setosa){
            species <- c(species, "setosa")
        }
        if (input$virginica){
            species <- c(species, "virginica")
        }
        if (input$versicolor){
            species <- c(species, "versicolor")
        }

        species

    })

    formula <- reactive({
        paste(input$predictor,"~", input$outcome)
    })

    fit <- reactive({
        species <- getSpecies()
        subIris <- subset(iris, Species %in% species)
        lm(as.formula(formula()), data=subIris)
    })

    output$caption <- renderText({
        formula()
    })

    output$fit <- renderPrint({
        summary(fit())
    })

    output$fitPlot <- renderPlot({
        species <- getSpecies()
        subIris <- subset(iris, Species %in% species)
        with(subIris, {
            plot(as.formula(formula()), col = subIris$Species, pch = 19)
            abline(fit(), col=2)
        })
    })






})
```
