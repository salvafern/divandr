#' Setup divandr
#'
#' This function initializes Julia and the DIVAnd.jl package.
#' The first time will be long since it includes precompilation.
#' Additionally, this will install Julia and the required packages
#' if they are missing.
#'
#' @param pkg_check logical, check for DIVAnd.jl package and install if necessary
#' @param ... Parameters are passed down to JuliaCall::julia_setup()
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

  # Check LD_PRELOAD
  ld_preload <- Sys.getenv("LD_PRELOAD", unset = NA_character_)

  ld_preload_is_not_set <- is.na(ld_preload)
  if(ld_preload_is_not_set) stop('`Sys.getenv("LD_PRELOAD")` is not set. Did you update the `.bashrc` file?')

  ld_preload_does_not_exists <- !file.exists(ld_preload)
  if(ld_preload_does_not_exists) stop(paste0('`Sys.getenv("LD_PRELOAD")` is `', ld_preload, '` but this path does not exists.'))

  julia <- JuliaCall::julia_setup(installJulia=TRUE,...)
  if(pkg_check){
    JuliaCall::julia_install_package_if_needed("Statistics")
    JuliaCall::julia_install_package_if_needed("NCDatasets")
    JuliaCall::julia_install_package_if_needed("DIVAnd")
  }
  JuliaCall::julia_library("DIVAnd")
}

#' DIVAnd Interpolation
#'
#' @param x numerical. Vector (1D), Matrix (2D) or Array (ND) with data
#' @param f
#' @param n numerical. Set the interpolation grid: increase the value to have
#' a finer resolution
#' @param len
#' @param epsilon2
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Start up DIVAnd and Julia
#' diva_setup()
#'
#' # Create 1D data
#' x <- c(0.0, 0.2, 0.4, 0.6, 0.8, 1.0, 1.1)
#' f <- sin(x*6)
#'
#' # Set resolution via number of points
#' n <- 30
#'
#' # Analysis parameters
#' # Correlation length
#' len <- 0.1
#'
#' # Obs. error variance normalized by the background error variance
#' epsilon2 <- 0.1
#'
#' # Run
#' output <- diva_run(x, f, n, len, epsilon2)
#' output
#' }
diva_run <- function(x, f, n, len, epsilon2){

  # Set the interpolation grid: increase the value of n to have a finer resolution
  xi <- seq(0, 1, length.out=n)

  # True field (normally unknown)
  fref <- sin(xi * 6)

  # Mask: all points are valid points
  mask <- !logical(length(xi))

  # Metrics: pm is the inverse of the resolution along the 1st dimension
  pm <- rep(1, length(xi)) / (xi[2]-xi[1])

  # From R variable to Julia variable
  # (maybe possible to do it differently)
  JuliaCall::julia_assign("pm", pm)
  JuliaCall::julia_assign("xi", xi)
  JuliaCall::julia_assign("x", x)
  JuliaCall::julia_assign("f", f)
  JuliaCall::julia_assign("len", len)
  JuliaCall::julia_assign("mask", mask)
  JuliaCall::julia_assign("epsilon2", epsilon2)

  # DIVAnd execution
  JuliaCall::julia_command("fi, s = DIVAndrun(mask, (pm,) ,(xi,), (x,), f, len, epsilon2; alphabc=0);")

  # From Julia variable to R variable
  fi = JuliaCall::julia_eval("fi")

  fi
}

