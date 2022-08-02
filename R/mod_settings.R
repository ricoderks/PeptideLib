#' settings UI Function
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
mod_settings_ui <- function(id){
  ns <- NS(id)
  tagList(
    checkboxGroupInput(inputId = ns("amino_acids"),
                       label = "Amino acids to use for X: ",
                       choiceNames = c("Glycine", "Alanine", "Serine", "Proline", "Valine",
                                       "Threonine", "Leucine", "Isoleucine", "Asparagine", "Aspartic acid",
                                       "Glutamine", "Lysine", "Glutamic acid", "Methionine", "Histidine",
                                       "Phenylalanine", "Arginine", "Tyrosine", "Tryptophan", "Cysteine"),
                       choiceValues = c("G", "A", "S", "P", "V",
                                        "T", "L", "I", "N", "D",
                                        "Q", "K", "E", "M", "H",
                                        "F", "R", "Y", "W", "C"),
                       selected = c("G", "A", "S", "P", "V",
                                    "T", "L", "I", "N", "D",
                                    "Q", "K", "E", "M", "H",
                                    "F", "R", "Y", "W"))
  )
}

#' settings Server Functions
#'
#' @param r reactiveValue to keep track off everything
#'
#' @noRd
#'
#' @author Rico Derks
#'
mod_settings_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    observe({
      req(input$amino_acids)

      r$amino_acids <- input$amino_acids
    })
  })
}
