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
    actionButton(inputId = ns("calculate_peptide"),
                 label = "Calculate"),
    htmlOutput(outputId = ns("amino_acids")),
    hr(),
    htmlOutput(outputId = ns("peptide_parts")),
    uiOutput(outputId = ns("peptide_result"))
  )
}

#' peptide Server Functions
#'
#' @noRd
#'
#' @param r reactiveValue to keep track off everything
#'
#' @importFrom openxlsx write.xlsx
#' @importFrom waiter waiter_show waiter_hide spin_ball transparent
#'
#' @author Rico Derks
#'
mod_peptide_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # show the peptide sequence in parts
    output$peptide_parts <- renderUI({
      req(r$all_peptides)

      # show parts
      p("First part: ", r$all_peptides$first, br(),
        "Middle part: ", r$all_peptides$middle, br(),
        "Last part: ", r$all_peptides$last)
    })

    # check if button is clicked
    observe({
      req(input$peptide_sequence)

      r$peptide_sequence <- input$peptide_sequence
      # get all the peptide sequences
      tryCatch(expr = {
        # start waiter, set color to null for transparent background
        waiter::waiter_show(html = tagList(waiter::spin_ball(),
                                           h3("Loading...")),
                            color = waiter::transparent(0.5))
        r$all_peptides <- create_peptides(pep_seq = r$peptide_sequence,
                                          aa = r$amino_acids)
        r$message <- NULL
        waiter::waiter_hide()


      },
      error = function(e) {
        r$all_peptides <- NULL
        r$message <- "Incorrect peptide sequence!"
        # stop the waiter when there is an error
        waiter::waiter_hide()

        # make sure nothing is shown here
        return(NULL)
      })
    }) |>
      bindEvent(input$calculate_peptide)

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

    # show which amino acids will be used
    output$amino_acids <- renderUI({
      req(r$amino_acids)

      p(paste0("Amino acids used for X: ", paste0(r$amino_acids, collapse = "")))
    })

    # show messages
    output$message <- renderUI({
      req(r$message)

      p(r$message)
    })

  })
}
