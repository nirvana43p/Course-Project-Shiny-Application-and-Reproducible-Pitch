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
