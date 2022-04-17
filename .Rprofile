if (interactive()) {
    try(utils::loadhistory("~/.Rhistory"))

  .Last <- function() try(utils::savehistory("~/.Rhistory"))
}

refresh_columns <- function () {
    cols <- Sys.getenv("COLUMNS")
    if (cols == "") { cols <- 163
    }
    options(width = cols)
}

refresh_columns()

dev.cm <- function(width, height) {
    # dev.new in cm
    # I would prefer px, but that requires knowing the screen pixel density...
    usa_bs_width <- width * 0.3937
    usa_bs_height <- height * 0.3937
    dev.new(width = usa_bs_width, height= usa_bs_height)
 }

pall <- function(args) { do.call(print, append(list(args), list(n=Inf)))}
  
  eye_care <- ggplot2::theme_dark() + ggplot2::theme(plot.background = ggplot2::element_rect(fill = "grey30"), text= ggplot2::element_text(colour="grey90"), axis.text=ggplot2::element_text(colour="grey90"), legend.background = ggplot2::element_rect(fill = "grey30"))
