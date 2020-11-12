#' SCI Colours
#'
#' Internal function containing the info of the different SCI colours
sci_colours <- c(
  `navy blue`     = "#003e74",
  `seagrass`      = "#00b3c4",
  `forest green`  = "#009945",
  `lilac`         = "#a6519a",
  `slate grey`    = "#a5abbd",
  `light blue`    = "#dff2fd",

  `Pantone 696C`  = "#a05163",
  `Pantone 7421C` = "#6c1f35",
  `Pantone 444C`  = "#727788",
  `Pantone 663C`  = "#f1f1e6",
  `Pantone 564C`  = "#80c6ab",
  `Pantone 340C`  = "#008c63",
  `Pantone 7711C` = "#0290a1",
  `Pantone 7461C` = "#1877bd",
  `Pantone 393C`  = "#f3eb75",
  `Pantone 135C`  = "#fcc55f",
  `Pantone 486C`  = "#f39472",
  `Pantone 190C`  = "#ed6d91",
  `Pantone 7676C` = "#785da4",

  # the following colours are the same as the Pantone ones above but with different names
  `pink1`         = "#a05163",
  `pink2`         = "#6c1f35",
  `grey`          = "#727788",
  `ivory`         = "#f1f1e6",
  `green1`        = "#80c6ab",
  `green2`        = "#008c63",
  `blue1`         = "#0290a1",
  `blue2`         = "#1877bd",
  `yellow`        = "#f3eb75",
  `orange1`       = "#fcc55f",
  `orange2`       = "#f39472",
  `pink`          = "#ed6d91",
  `purple`        = "#785da4",

  # the following are the old colours with shades of blue that were for prevalence categories
  `light intensity`    = "#DEEBF7",
  `moderate intensity` = "#9ECAE1",
  `heavy intensity`    = "#3182BD")

#' Function to extract SCI colours as hex codes
#'
#' @param ... Character names of sci_colours
#'
#' @export sci_cols
sci_cols <- function(...) {
  cols <- c(...)

  if (is.null(cols))
    return (sci_colours)

  sci_colours[cols]
}


#' SCI Colour Palettes
#'
#' Function that binds sci_cols definitions into palettes
#'
#' @rdname sci_cols
#' @export
sci_palettes <- list(
  `main`          = sci_cols("pink1", "pink2", "grey", "ivory", "green1","green2", "blue1",
                             "blue2", "yellow", "orange1", "orange2", "pink", "purple",
                             "navy blue", "seagrass", "forest green", "lilac", "slate grey","light blue"),
  `primary`       = sci_cols("navy blue", "seagrass", "forest green", "lilac", "slate grey","light blue"),
  `secondary`     = sci_cols("pink1", "pink2", "grey",  "green1","green2", "blue1",
                             "blue2", "yellow", "orange1", "orange2", "pink", "purple"),
  `yesno`         = sci_cols( "green2","orange2"),
  `gender`        = sci_cols("green1", "orange1"),
  `catBlue2`      = sci_cols("light intensity", "heavy intensity"),
  `catBlue3`      = sci_cols("light intensity", "moderate intensity", "heavy intensity"),
  `alt_cat`       = sci_cols("moderate intensity", "heavy intensity")
)


#' Return function to interpolate a SCI colour palette
#'
#' @param palette Character name of palette in sci_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
#' @examples
#' sci_pal(palette= "secondary")(2)
#'
#' @rdname sci_cols
#' @export
sci_pal <- function(palette = "main", reverse = FALSE, ...) {
  pal <- sci_palettes[[palette]]

  if (reverse) pal <- rev(pal)

  colorRampPalette(pal, ...)
}

#' Colour scale constructor for SCI colours
#'
#' @param palette Character name of palette in sci_palettes
#' @param discrete Boolean indicating whether colour aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_colour_gradientn(), used respectively when discrete is TRUE or FALSE
#'
#' @examples
#' library(ggplot2)
#' library(sciColours)
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4) +  scale_colour_sci()
#'
#' @rdname sci_cols
#' @export
scale_colour_sci <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- sci_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("colour", paste0("sci_", palette), palette = pal, ...)
  } else {
    scale_colour_gradientn(colours = pal(256), ...)
  }
}

#' Fill scale constructor for SCI colours
#'
#' @param palette Character name of palette in sci_palettes
#' @param discrete Boolean indicating whether colour aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE
#'
#' @examples
#' library(ggplot2)
#' library(sciColours)
#' ggplot(mpg, aes(manufacturer, fill = manufacturer)) +
#'   geom_bar() +
#'   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
#'   scale_fill_drsimonj(palette = "mixed", guide = "none")
#'
#' @rdname sci_cols
#' @export
scale_fill_sci <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- sci_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("fill", paste0("sci_", palette), palette = pal, ...)
  } else {
    scale_fill_gradientn(colours = pal(256), ...)
  }
}
