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

  # peptide functionality
  mod_peptide_server(id = "peptide")

  # about functionality
  mod_about_server(id = "about")
}
