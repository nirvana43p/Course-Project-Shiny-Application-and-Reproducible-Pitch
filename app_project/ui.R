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
