library(shiny)

# # The simpliest
# ui <- fluidPage(
#   "Hello, chicos!"
# )
# server <- function(input, output, session) {
# }
# shinyApp(ui, server)


# # Some inputs but no outputs
# ui <- fluidPage(
#   selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
#   verbatimTextOutput("summary"),
#   tableOutput("table")
# )
# server <- function(input, output, session) {
# }
# shinyApp(ui, server)


# # Now with output behaviour
# ui <- fluidPage(
#   selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
#   verbatimTextOutput("summary"),
#   tableOutput("table")
# )
# server <- function(input, output, session) {
#   output$summary <- renderPrint({
#     dataset <- get(input$dataset, "package:datasets")
#     summary(dataset)
#   })
# 
#   output$table <- renderTable({
#     dataset <- get(input$dataset, "package:datasets")
#     dataset
#   })
# }
# shinyApp(ui, server)


# # I don't like repeated code
# ui <- fluidPage(
#   selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
#   verbatimTextOutput("summary"),
#   tableOutput("table")
# )
# server <- function(input, output, session) {
#   dataset <- reactive({
#     get(input$dataset, "package:datasets")
#   })
# 
#   output$summary <- renderPrint({
#     summary(dataset())
#   })
# 
#   output$table <- renderTable({
#     dataset()
#   })
# }
# shinyApp(ui, server)


# ####### Exercise 1: Create an app that greets the user by name
# ui <- fluidPage(
#   textInput("name", "What's your name?"),
#   textOutput("greeting")
# )
# server <- function(input, output, session) {
#   output$greeting <- renderText({
#     paste0("Hello ", input$name)
#   })
# }
# shinyApp(ui, server)


# numericInput("age", "How old are you?")
# 
# tableOutput("mortgage")
# renderPlot("histogram", {
#   hist(rnorm(1000))
# }, res = 96)


# ####### Exercise 2: Where is the problem?
# ui <- fluidPage(
#   sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
#   "then x times 5 is",
#   textOutput("product")
# )
# server <- function(input, output, session) {
#   output$product <- renderText({
#     input$x * 5
#   })
# }
# shinyApp(ui, server)


####### Exercise 3: Now we need an application where there will be two sliderInputs to make x*y

# ui <- fluidPage(
#   sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
#   sliderInput("y", label = "If y is", min = 1, max = 50, value = 5),
#   "then...",
#   textOutput("product")
# )
# server <- function(input, output, session) {
#   output$product <- renderText({
#     input$x * input$y
#   })
# }
# shinyApp(ui, server)

####### Exercise 4: reactive expression times

# ui <- fluidPage(
#   sliderInput("x", "If x is", min = 1, max = 50, value = 30),
#   sliderInput("y", "and y is", min = 1, max = 50, value = 5),
#   "then, (x * y) is", textOutput("product"),
#   "and, (x * y) + 5 is", textOutput("product_plus5"),
#   "and (x * y) + 10 is", textOutput("product_plus10")
# )
# 
# server <- function(input, output, session) {
#   output$product <- renderText({
#     product <- input$x * input$y
#     product
#   })
#   output$product_plus5 <- renderText({
#     product <- input$x * input$y
#     product + 5
#   })
#   output$product_plus10 <- renderText({
#     product <- input$x * input$y
#     product + 10
#   })
# }
# shinyApp(ui, server)


# ###### Exercise 5: What is wrong?
# library(ggplot2)
# datasets <- data(package = "ggplot2")$results[c(2, 4, 10), "Item"]
# 
# ui <- fluidPage(
#   selectInput("dataset", "Dataset", choices = datasets),
#   verbatimTextOutput("summary"),
#   plotOutput("plot")
# )
# 
# server <- function(input, output, session) {
#   dataset <- reactive({
#     get(input$dataset, "package:ggplot2")
#   })
#   output$summary <- renderPrint({
#     summary(dataset())
#   })
#   output$plot <- renderPlot({
#     plot(dataset())
#   }, res = 96)
# }
# shinyApp(ui, server)

######## Common widgets
# # Text
# ui <- fluidPage(
#   textInput("nombre", "Dame tu nombre"),
#   passwordInput("contrasena", "Escribe tu password"),
#   textAreaInput("Description", "Cuentame un poco sobre ti"),
#   textOutput("respuesta")
# )
# server <- function(input, output, session) {
#   output$respuesta <-  renderText({
#         paste("Hola ", input$nombre, ", ya accediste, y lo que me cuentas sobre ti es: ", input$Description)
#       })
# }
# shinyApp(ui, server)


# # Numeric with an util example
# ui <- fluidPage(
#   numericInput("numero", "Selecciona tu edad", value = 18, min = 15, max = 85, step = 5),
#   selectInput("otherNumber", "Selecciona tu edad", choices = seq(15, 85, 1), multiple = TRUE),
#   sliderInput("numPelis", "¿Cuántas peliculas vas a ver?", value = 2, min = 2, max = 10, step = 2, pre = "^", sep = ",",
#               animate = TRUE),
#   sliderInput("n_breaks", label = "Number of bins:",
#               min = 10, max = 50, value = 10, step = 1, animate = T),
# 
#   sliderInput("bw_adjust", label = "Bandwidth adjustment:",
#               min = 0.2, max = 2, value = 1, step = 0.2),
#   sliderInput("numSeats", "¿Cuántos asienteos vas a reservar?", value = c(5,7), min = 2, max = 10),
#   "Estas son tus opciones",
#   textOutput("respuesta"),
#   plotOutput("plot")
# )
# server <- function(input, output, session) {
#   output$respuesta <-  renderText({
#             paste(input$otherNumber, sep = ", ")
#           })
#   output$plot <- renderPlot({
#     hist(faithful$eruptions, probability = TRUE, breaks = as.numeric(input$n_breaks),
#          xlab = "Duration (minutes)", main = "Geyser eruption duration")
# 
#     dens <- density(faithful$eruptions, adjust = input$bw_adjust)
#     lines(dens, col = "blue")
#   })
# 
# }
# shinyApp(ui, server)

#To Sliders: https://shiny.rstudio.com/articles/sliders.html

# #Dates
# ui <- fluidPage(
#   dateInput("born", "¿Cuándo naciste?", daysofweekdisabled = c(0,1), min = "2020-12-01", max = "2021-01-01"),
#   dateRangeInput("vacaciones", "Cuando quieres ir de vacaciones"),
#   "Naciste el día",
#   textOutput("Fecha")
# )
# server <- function(input, output, session) {
#   output$Fecha <-  renderText({
#                 paste(input$born, sep = ", ")
#               })
# }
# shinyApp(ui, server)

# #Options
# ui <- fluidPage(
#   selectInput("born", "¿Cuándo naciste?", seq(as.Date("2020-12-21"), as.Date("2020-12-31"),by = 1), multiple = T),
#   radioButtons("Options", "Cómo te sientes", 
#                choiceNames = list(icon("angry"), icon("smile"), icon("sad-tear")), 
#                choiceValues = list("Enojadísimo", "Feliz", "Bien-Sad")),
#   checkboxGroupInput("Coffee", label = "Selecciona los ingredientes de tu café", choices = c("Leche deslactosa", "Crema batida", "Leche de almendras", "Azucar", "Jarabe")),
#   "Selecciona el tamaño de tu café",
#   checkboxInput("Coffee",  "Chico", value = T),
#   checkboxInput("Coffee", "Grande"),
#   "Naciste el día",
#   textOutput("Fecha"),
#   "Y tu perro se llama",
#   textOutput("dog")
# )
# server <- function(input, output, session) {
#   output$Fecha <-  renderText({
#                 paste(input$born, sep = ", ")
#               })
#   output$dog <-  renderText({
#     paste(input$Options)
#   })
# }
# shinyApp(ui, server)

# 
# #Files
# ui <- fluidPage(
#   fileInput("file", label = NULL,  buttonLabel = "Selecciona tu archivo..."),
#   tableOutput("archivo")
# )
# server <- function(input, output, session) {
#   output$archivo <- renderTable({
#     head(input$file)
#     })
# }
# shinyApp(ui, server)


# #Buttons
# ui <- fluidPage(
#   "Presiona tu opción",
#   actionButton("Cafe", "Café", class = "btn btn-info"),
#   actionButton("Té", "Té" ,icon = icon("cocktail"), class = "btn btn-danger"),
# )
# server <- function(input, output, session) {
# }
# shinyApp(ui, server)


# #Files1
# ui <- fluidPage(
#   h1("Archivos"),
#   p("La función", code("fileInput()", style = "color:blue"),"regresa un data frame con 4 columnas:"),
#   p("-", code("name"), ": El nombre original del archivo."),
#   p("-", code("size"), ": El tamaño del archivo (El valor por defecto es 5MB pero podemos cambiar eso modificando las opciones generales del Shiny:", code("options(shyni.maxRequestSize = 10 * 1024^2)).")),
#   p("-",code("type"), ": 'El tipo' del archivo."),
#   p("-", code("datapath"), ": La dirección del archivo"), hr(),
#   fileInput("file", label = "Aquí puedes agregar tu archivo",  buttonLabel = "Selecciona tu archivo..."),
#   tableOutput("archivo"),
#   hr(),
#   p("Entonces, para mostrar el data frame vamos a tomar el ", code("datapath"), "del archivo y cargar los datos desde esta."),
#   p("Podemos utilizar funciones de", code("readr"), "pero vamos utilizar algo más rápido: ", a("vroom", href="https://www.tidyverse.org/blog/2019/05/vroom-1-0-0/")),
#   verbatimTextOutput("message"),
#   tableOutput("archivoRead")
# )
# server <- function(input, output, session) {
#   output$archivo <- renderTable(head(input$file))
#   output$message <- renderPrint({
#     cat("vroom::vroom(archivo$file$datapath, delim = \",\")")
#   })
#   output$archivoRead <- renderTable({
#     head(vroom::vroom(input$file$datapath, delim = ","), n = 10)
#   })
# }
# shinyApp(ui, server)


# #ConditionalFiles
# ui <- fluidPage(
#   h1("Archivos"),
#   p("La función", code("fileInput()", style = "color:blue"),"regresa un data frame con 4 columnas:"),
#   p("-", code("name"), ": El nombre original del archivo."),
#   p("-", code("size"), ": El tamaño del archivo (El valor por defecto es 5MB pero podemos cambiar eso modificando las opciones generales del Shiny:", code("options(shyni.maxRequestSize = 10 * 1024^2)).")),
#   p("-",code("type"), ": 'El tipo' del archivo."),
#   p("-", code("datapath"), ": La dirección del archivo"), hr(),
#   fileInput("file", label = "Aquí puedes agregar tu archivo",  buttonLabel = "Selecciona tu archivo..."),
#   tableOutput("archivo"),
#   hr(),
#   p("Entonces, para mostrar el data frame vamos a tomar el ", code("datapath"), "del archivo y cargar los datos desde esta."),
#   p("Podemos utilizar funciones de", code("readr"), "pero vamos utilizar algo más rápido: ", a("vroom", href="https://www.tidyverse.org/blog/2019/05/vroom-1-0-0/")),
#   verbatimTextOutput("message"),
#   tableOutput("archivoRead")
# )
# server <- function(input, output, session) {
#   output$archivo <- renderTable(head(input$file))
#   output$message <- renderPrint({
#     cat("data <- reactive({\n
# \treq(input$file)\n
# \t ext <- tools::file_ext(input$file$name)\n
# \t switch(ext,\n
# \t\t csv = vroom::vroom(input$file$datapath, delim = \",\"),\n
# \t\t tsv = vroom::vroom(input$file$datapath, delim = \"\t\"),\n
# \t\t validate(\"Invalid file; Please upload a .csv or .tsv file\")\n
# \t)")
#   })
#   data <- reactive({
#     req(input$file)
# 
#     ext <- tools::file_ext(input$file$name)
#     switch(ext,
#            csv = vroom::vroom(input$file$datapath, delim = ","),
#            tsv = vroom::vroom(input$file$datapath, delim = "\t"),
#            validate("Invalid file; Please upload a .csv or .tsv file")
#     )
#   })
#   output$archivoRead <- renderTable({
#     head(data(), n = 10)
#   })
# }
# shinyApp(ui, server)

# # #DownloadFiles
# ui <- fluidPage(
#   fileInput("file", label = "Aquí puedes agregar tu archivo",  buttonLabel = "Selecciona tu archivo..."),
#   downloadButton("Descarga1", label = "Descargar"),
#   downloadLink("Descarga2", label = "Descargar"),
#   tableOutput("archivoRead")
# )
# server <- function(input, output, session) {
#   data <- reactive({
#     req(input$file)
# 
#     ext <- tools::file_ext(input$file$name)
#     switch(ext,
#            csv = vroom::vroom(input$file$datapath, delim = ","),
#            tsv = vroom::vroom(input$file$datapath, delim = "\t"),
#            validate("Invalid file; Please upload a .csv or .tsv file")
#     )
#   })
#   output$archivoRead <- renderTable({
#     head(data(), n = 10)
#   })
#   #Aquí no hay dowloadRender
#   output$Descarga1 <- downloadHandler(
#     filename = function() {
#       paste0(input$file, ".csv")
#     },
#     content = function(file){
#       write.csv(data(), file)
#     }
#   )
#   output$Descarga2 <- downloadHandler(
#     filename = function() {
#       paste0(input$file, ".csv")
#     },
#     content = function(file){
#       write.csv(data(), file)
#     }
#   )
# }
# shinyApp(ui, server)

#Design: Rows and Columns
# ui <- fluidPage(
#   fluidRow(column(width = 4,
#                   numericInput("numero", "Selecciona tu edad", value = 18, min = 15, max = 85, step = 5),
#                   selectInput("otherNumber", "Selecciona tu edad", choices = seq(15, 85, 1), multiple = TRUE),
#                   sliderInput("numPelis", "¿Cuántas peliculas vas a ver?", value = 2, min = 2, max = 10, step = 2, pre = "^", sep = ",",
#                               animate = TRUE)), 
#            column(width = 2, offset = 3,
#                   sliderInput("n_breaks", label = "Number of bins:",
#                               min = 10, max = 50, value = 10, step = 1, animate = T),
#                   
#                   sliderInput("bw_adjust", label = "Bandwidth adjustment:",
#                               min = 0.2, max = 2, value = 1, step = 0.2),
#                   sliderInput("numSeats", "¿Cuántos asienteos vas a reservar?", value = c(5,7), min = 2, max = 10))),
#   fluidRow( "Estas son tus opciones",
#              textOutput("respuesta"),
#              plotOutput("plot"))
# )
# server <- function(input, output, session) {
#   output$respuesta <-  renderText({
#             paste(input$otherNumber, sep = ", ")
#           })
#   output$plot <- renderPlot({
#     hist(faithful$eruptions, probability = TRUE, breaks = as.numeric(input$n_breaks),
#          xlab = "Duration (minutes)", main = "Geyser eruption duration")
# 
#     dens <- density(faithful$eruptions, adjust = input$bw_adjust)
#     lines(dens, col = "blue")
#   })
# 
# }
# shinyApp(ui, server)

# #SideBar
# ui <- fluidPage(
#   sidebarLayout(
#     sidebarPanel(numericInput("numero", "Selecciona tu edad", value = 18, min = 15, max = 85, step = 5),
#                   selectInput("otherNumber", "Selecciona tu edad", choices = seq(15, 85, 1), multiple = TRUE),
#                   sliderInput("numPelis", "¿Cuántas peliculas vas a ver?", value = 2, min = 2, max = 10, step = 2, pre = "^", sep = ",",
#                               animate = TRUE),
#                   sliderInput("n_breaks", label = "Number of bins:",
#                               min = 10, max = 50, value = 10, step = 1, animate = T),
#                   sliderInput("bw_adjust", label = "Bandwidth adjustment:",
#                               min = 0.2, max = 2, value = 1, step = 0.2),
#                   sliderInput("numSeats", "¿Cuántos asienteos vas a reservar?", value = c(5,7), min = 2, max = 10)),
#   mainPanel( "Estas son tus opciones",
#             textOutput("respuesta"),
#             plotOutput("plot")))
# )
# server <- function(input, output, session) {
#   output$respuesta <-  renderText({
#     paste(input$otherNumber, sep = ", ")
#   })
#   output$plot <- renderPlot({
#     hist(faithful$eruptions, probability = TRUE, breaks = as.numeric(input$n_breaks),
#          xlab = "Duration (minutes)", main = "Geyser eruption duration")
#     
#     dens <- density(faithful$eruptions, adjust = input$bw_adjust)
#     lines(dens, col = "blue")
#   })
#   
# }
# shinyApp(ui, server)

## Hacer ejemplos con tab

#Panel condicional

# if (interactive()) {
#   ui <- fluidPage(
#     sidebarPanel(
#       selectInput("plotType", "Plot Type",
#                   c(Scatter = "scatter", Histogram = "hist")
#       ),
#       # Only show this panel if the plot type is a histogram
#       conditionalPanel(
#         condition = "input.plotType == 'hist'",
#         selectInput(
#           "breaks", "Breaks",
#           c("Sturges", "Scott", "Freedman-Diaconis", "[Custom]" = "custom")
#         ),
#         # Only show this panel if Custom is selected
#         conditionalPanel(
#           condition = "input.breaks == 'custom'",
#           sliderInput("breakCount", "Break Count", min = 1, max = 50, value = 10)
#         )
#       )
#     ),
#     mainPanel(
#       plotOutput("plot")
#     )
#   )
#   
#   server <- function(input, output) {
#     x <- rnorm(100)
#     y <- rnorm(100)
#     
#     output$plot <- renderPlot({
#       if (input$plotType == "scatter") {
#         plot(x, y)
#       } else {
#         breaks <- input$breaks
#         if (breaks == "custom") {
#           breaks <- input$breakCount
#         }
#         
#         hist(x, breaks = breaks)
#       }
#     })
#   }
#   
#   shinyApp(ui, server)
# }
# 
