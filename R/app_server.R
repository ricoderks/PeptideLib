#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
#'
#' @author Rico Derks
#'
app_server <- function(input, output, session) {
  # Your application server logic

  # keep track of all variables
  r <- reactiveValues(message = NULL,
                      peptide_sequence = NULL,
                      all_peptides = NULL,
                      amino_acids = NULL)

  # peptide functionality
  mod_peptide_server(id = "peptide",
                     r = r)

  # settings functionality
  mod_settings_server(id = "settings",
                      r = r)

  # about functionality
  mod_about_server(id = "about")
}
