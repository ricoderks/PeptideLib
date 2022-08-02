#' help UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#'
#' @author Rico Derks
#'
mod_help_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      h3("Help"),
      HTML("<p>This Shiny app will create a combinatorial peptide library from a peptide sequence you entered.
        The peptide needs to have a certain format. It should contain at least 2 X's separated by other
        amino acids, e.g. PTEDAV<b>X</b>PP<b>X</b>ELLK. The X will be replaced by amino acids and the app will
        generate all possible solutions.</p> ")
    )
  )
}

#' help Server Functions
#'
#' @noRd
mod_help_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}
