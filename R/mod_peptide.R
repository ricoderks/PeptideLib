#' peptide UI Function
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
mod_peptide_ui <- function(id){
  ns <- NS(id)
  tagList(
    uiOutput(outputId = ns("message"),
             style = "color:red"),
    textInput(inputId = ns("peptide_sequence"),
              label = "Peptide sequence: "),
    hr(),
    htmlOutput(outputId = ns("peptide_parts")),
    uiOutput(outputId = ns("peptide_result"))
  )
}

#' peptide Server Functions
#'
#' @noRd
#'
#' @importFrom openxlsx write.xlsx
#'
#' @author Rico Derks
#'
mod_peptide_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # keep track of all variables
    r <- reactiveValues(message = NULL,
                        peptide_sequence = NULL,
                        all_peptides = NULL)

    # show the peptide sequence in parts
    output$peptide_parts <- renderUI({
      req(input$peptide_sequence)

      r$peptide_sequence <- input$peptide_sequence
      # get all the peptide sequences
      tryCatch(expr = {
        r$all_peptides <- create_peptides(pep_seq = r$peptide_sequence)
        r$message <- NULL

        # show parts
        p("First part: ", r$all_peptides$first, br(),
          "Middle part: ", r$all_peptides$middle, br(),
          "Last part: ", r$all_peptides$last)
      },
      error = function(e) {
        r$all_peptides <- NULL
        r$message <- "Incorrect peptide sequence!"

        # make sure nothing is shown here
        return(NULL)
      })
    })

    # show result
    output$peptide_result <- renderUI({
      req(r$all_peptides)

      hr()
      downloadButton(outputId = ns("download_excel"),
                     label = "Download...")
    })

    # download handler
    output$download_excel <- downloadHandler(
      filename = function() {
        paste0(r$peptide_sequence, ".xlsx")
      },
      content = function(file) {
        write.xlsx(x = r$all_peptides$all_peptides,
                   file = file)
      }
    )

    # show messages
    output$message <- renderUI({
      req(r$message)

      p(r$message)
    })

  })
}
