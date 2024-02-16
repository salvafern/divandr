#' Setup divandr
#'
#' This function initializes Julia and the DIVAnd.jl package.
#' The first time will be long since it includes precompilation.
#' Additionally, this will install Julia and the required packages
#' if they are missing.
#'
#' @param pkg_check logical, check for DIVAnd.jl package and install if necessary
#' @param ... Parameters are passed down to JuliaCall::julia_setup
#'
#' @examples
#'
#' \dontrun{ ## divandr_setup() is time-consuming and requires Julia+DIVAnd.jl
#' library(divandr)
#'
#' diva_setup()
#'
#' }
#'
#' @export
diva_setup <- function (pkg_check=TRUE,...){
  julia <- JuliaCall::julia_setup(installJulia=TRUE,...)
  if(pkg_check){
    # JuliaCall::julia_install_package_if_needed("Statistics")
    # JuliaCall::julia_install_package_if_needed("NCDatasets")
    JuliaCall::julia_install_package_if_needed("DIVAnd")
  }
  JuliaCall::julia_library("DIVAnd")
}
