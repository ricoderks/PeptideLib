# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
########################################
#### CURRENT FILE: ON START SCRIPT #####
########################################

## Fill the DESCRIPTION ----
## Add meta data about your application
##
## /!\ Note: if you want to change the name of your app during development,
## either re-run this function, call golem::set_golem_name(), or don't forget
## to change the name in the app_sys() function in app_config.R /!\
##
golem::fill_desc(
  pkg_name = "PeptideLib", # The Name of the package containing the App
  pkg_title = "An R package to create an combinatorial peptide library", # The Title of the package containing the App
  pkg_description = "An R package to create an combinatorial peptide library. The results are exported to an Excel file.", # The Description of the package containing the App
  author_first_name = "Rico", # Your First Name
  author_last_name = "Derks", # Your Last Name
  author_email = "r.j.e.derks@lumc.nl", # Your Email
  repo_url = "https://github.com/ricoderks/PeptideLib" # The URL of the GitHub Repo (optional)
)

## Set {golem} options ----
golem::set_golem_options()

## Create Common Files ----
## See ?usethis for more information
usethis::use_gpl3_license() # You can set another license here
usethis::use_readme_rmd(open = TRUE)
# Note that `contact` is required since usethis version 2.1.5
# If your {usethis} version is older, you can remove that param
# usethis::use_code_of_conduct(contact = "Golem User")
usethis::use_lifecycle_badge("Experimental")
usethis::use_news_md(open = FALSE)

## Use git ----
usethis::use_git()

## Init Testing Infrastructure ----
## Create a template for tests
golem::use_recommended_tests()

## Favicon ----
# If you want to change the favicon (default is golem's one)
golem::use_favicon() # path = "path/to/ico". Can be an online file.
# golem::remove_favicon() # Uncomment to remove the default favicon

## Add helper functions ----
golem::use_utils_ui(with_test = TRUE)
golem::use_utils_server(with_test = TRUE)

# You're now set! ----

# go to dev/02_dev.R
rstudioapi::navigateToFile("dev/02_dev.R")
