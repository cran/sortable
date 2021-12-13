## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- echo=FALSE--------------------------------------------------------------
library(htmltools)
tags$div(
  class = "shiny-app-frame",
  tags$iframe(
    src = "https://andrie-de-vries.shinyapps.io/sortable_group_list_app/",
    width = "100%",
    height = 550
    )
)

## ----echo=FALSE, cache=FALSE--------------------------------------------------
knitr::read_chunk(
  system.file("shiny-examples/group_list/app.R", package = "sortable")
)

## ----group-list-app, eval=FALSE-----------------------------------------------
#  ## Example shiny app with grouped lists
#  
#  library(shiny)
#  library(sortable)
#  
#  ui <- fluidPage(
#    tags$head(
#      tags$style(HTML(".bucket-list-container {min-height: 350px;}"))
#    ),
#    fluidRow(
#      column(
#        width = 12,
#        # choose list of variable names to send to bucket list
#        radioButtons(
#          inputId = "variableList",
#          label   = "Choose your variable list",
#          choices = c(
#            "names(mtcars)" = "names(mtcars)",
#            "state.name" = "state.name"
#            )
#        ),
#        # input text to subset variable names
#        textInput(
#          inputId = "subsetChooseListText",
#          label   = "You can subset the input list by typing here",
#          value   = ""
#        ),
#        div(
#          # class value is current default class value for container
#          class = "bucket-list-container default-sortable",
#          "Drag the items in any desired bucket",
#          div(
#            # class value is current default class value for list
#            class = "default-sortable bucket-list bucket-list-horizontal",
#            # need to make sure the outer div size is respected
#            # use the current default flex value
#            column(
#              width = 4,
#              uiOutput("selection_list", style = "flex:1 0 100px;")
#            ),
#            column(
#              width = 4,
#              rank_list(
#                text = "to here",
#                labels = list(),
#                input_id = "rank_list_2",
#                options = sortable_options(group = "mygroup")
#              )),
#            column(
#              width = 4,
#              rank_list(
#                text = "and also here",
#                labels = list(),
#                input_id = "rank_list_3",
#                options = sortable_options(group = "mygroup")
#              )
#            )
#          )
#        ),
#        uiOutput("dragAndDropList")
#      )
#    ),
#    fluidRow(
#      column(
#        width = 12,
#        tags$b("Result"),
#        column(
#          width = 12,
#  
#          tags$p("input$rank_list_1"),
#          verbatimTextOutput("results_1"),
#  
#          tags$p("input$rank_list_2"),
#          verbatimTextOutput("results_2"),
#  
#          tags$p("input$rank_list_3"),
#          verbatimTextOutput("results_3")
#        )
#      )
#    )
#  )
#  
#  server <- function(input, output) {
#  
#    # initialize reactive values
#    varList <- reactive({
#      req(input$variableList)
#      if (input$variableList == "state.name") {
#        state.name
#      } else {
#        names(mtcars)
#      }
#    })
#  
#    subsetChooseList <- reactive({
#      items <- varList()
#      pattern <- input$subsetChooseListText
#      if (nchar(pattern) < 1) {
#        return(items)
#      }
#      items[
#        grepl(
#          x = items,
#          pattern = input$subsetChooseListText,
#          ignore.case = TRUE
#        )
#      ]
#    })
#  
#    output$selection_list <- renderUI({
#      labels <- subsetChooseList()
#  
#      # remove already chosen items
#      labels <- labels[!(
#        labels %in% input$rank_list_2 |
#          labels %in% input$rank_list_3
#      )]
#      rank_list(
#        text = "Drag from here",
#        labels = labels,
#        input_id = "rank_list_1",
#        options = sortable_options(group = "mygroup")
#      )
#    })
#  
#    # visual output for debugging
#    output$results_1 <- renderPrint(input$rank_list_1)
#    output$results_2 <- renderPrint(input$rank_list_2)
#    output$results_3 <- renderPrint(input$rank_list_3)
#  
#  }
#  
#  
#  shinyApp(ui, server)

