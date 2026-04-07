#' Display an image with white background replaced by cream
#'
#' Drop-in replacement for knitr::include_graphics() that uses magick
#' to swap white backgrounds to the site's cream color (#FAFAF5).
#'
#' @param path Path to the image file
#' @param bg   Replacement background color (default: site cream)
#' @param fuzz Tolerance for "white" matching (0-100, default 10)
include_image <- function(path, bg = "#FAFAF5", fuzz = 10) {
  img <- magick::image_read(path)
  img <- magick::image_transparent(img, "white", fuzz = fuzz)
  img <- magick::image_background(img, bg)
  img <- magick::image_flatten(img)
  img
}
