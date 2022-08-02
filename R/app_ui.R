#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom utils packageVersion
#' @importFrom waiter useWaiter
#' @noRd
#'
#' @author Rico Derks
#'
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    waiter::useWaiter(),
    tags$style(
      ".waiter-overlay-content{
      color: black;
    }"
    ),
    # Your application UI logic
    navbarPage(
      title = paste0("PeptideLib | v", utils::packageVersion("PeptideLib")),
      id = "navbar",
      tabPanel(
        title = "Peptide",
        mod_peptide_ui(id = "peptide")
      ),
      tabPanel(
        title = "Settings",
        mod_settings_ui(id = "settings")
      ),
      navbarMenu(
        title = "Help",
        tabPanel(
          title = "Help",
          mod_help_ui(id = "help")
        ),
        tabPanel(
          title = "About",
          mod_about_ui(id = "about")
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
#'
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "PeptideLib"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
