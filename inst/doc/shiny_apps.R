## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(sortable)

## ---- echo=FALSE--------------------------------------------------------------
library(htmltools)
tags$div(
  class = "shiny-app-frame",
  tags$iframe(
    src = "https://andrie-de-vries.shinyapps.io/sortable_rank_list_app/",
    width = "100%",
    height = 450
    )
)

## ---- echo=FALSE--------------------------------------------------------------
library(htmltools)
tags$div(
  class = "shiny-app-frame",
  tags$iframe(
    src = "https://andrie-de-vries.shinyapps.io/sortable_bucket_list_app/",
    width = "100%",
    height = 650
    )
)

