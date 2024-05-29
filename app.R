library(shiny)
library(shinyjs)
# Define UI
ui <- fluidPage(
  useShinyjs(), 
  includeCSS("styles.css"), 
  includeHTML("ui.html"), 
)
# Define Server
server <- function(input, output, session) {
  observe({
    runjs('$("#btn_calculate").click(function() { Shiny.setInputValue("btn_calculate_clicked", true); });')
  })
  observeEvent(input[["btn_calculate_clicked"]], {
    input_number <- as.numeric(input$input_number)
    
    if (is.na(input_number)) {
      runjs('$("#result").text("请输入有效的数字");')
    } else {
      result <- input_number * 2
      runjs(paste('$("#result").text(', result, ');', sep = ''))
      runjs('Shiny.setInputValue("btn_calculate_clicked", false);')
    }
  })
}

# Run the Shiny App
shinyApp(ui, server)
