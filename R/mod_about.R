#' about UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom sessioninfo session_info
#'
#' @author Rico Derks
#'
mod_about_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(column = 12,
               h3("Issues"),
               p("If you have any ideas to extend this shiny app please send me an email. If you have any issue please send me an email or go to the ",
                 a("issue tracker.", href = "http://github.com/ricoderks/PeptideLIb/issues", target = "_blank"),
                 "Cheers, Rico")
      ),
      fluidRow(column = 12,
               h3("Session info"),
               verbatimTextOutput(ns("about_session"))
      )
    )
  )
}

#' about Server Functions
#'
#' @noRd
mod_about_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # session info part
    output$about_session <- renderPrint({
      sessioninfo::session_info()
    })
  })
}
