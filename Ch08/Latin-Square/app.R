library(shiny)
library(magic)

ui <- fluidPage(
    titlePanel("Latin Square Generator"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("steps",
                        "Number of steps:",
                        min = 1,
                        max = 10,
                        value = 3)
        ),
        mainPanel(
           tableOutput("latin")
        )
    )
)
server <- function(input, output) {
    output$latin <- renderTable({
        rlatin(input$steps)
        })
}
# Run the application 
shinyApp(ui = ui, server = server)
