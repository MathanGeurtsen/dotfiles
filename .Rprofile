## convenience functions

refresh_columns <- function () {
    cols <- Sys.getenv("COLUMNS")
    if (cols == "") { 
        cols <- 163
    }
    options(width = cols)
}

dev.cm <- function(width, height) {
    # dev.new in cm
    # I would prefer px, but that requires knowing the screen pixel density...
    usa_bs_width <- width * 0.3937
    usa_bs_height <- height * 0.3937
    dev.new(width = usa_bs_width, height= usa_bs_height)
 }


alert.notify <- function(text="R done") {

    filename <- Sys.getenv("NOTIFY_FILE")
    if (filename == "") {
        filename <- path.expand("~/notify") 
    }

    fileConn<-file(filename)
    write(text, fileConn)
    close(fileConn)
}

pprint <- function(obj) {
    is_tibble <- function(obj) {
        tryCatch(return(tibble::is_tibble(obj)),
        error=function(arg) return(FALSE))
    }
    if (is.data.frame(obj)) {
        if (is_tibble(obj)) {
        print(obj, n=Inf)
        } else {
        print(obj, max_row=Inf)
        }
    } else if (is.list(obj)) {
        if (is.null(names(obj))) {
            cat(unlist(obj), sep="\n")
        } else {
            
            print(obj, width=10)
        }
    } else if (is.vector(obj)) {
        if (is.null(names(obj))) {
            cat(obj, sep="\n")
        } else {
            print(obj, width=10)
        } 
    } else {
        print(obj)
    }
}

obj_type <- function(obj) {
  if (isS4(obj)) {
    return("S4")
  } else if (is(obj, 'refClass')) {
    return("refClass")
  } else {
    return("S3")
  }
}

dir <- function(obj) {
  type <- obj_type(obj)
  if (type == "S4") {
    cat("type: S4\n")
    temp <- sapply(capture.output(showMethods(class=class(obj)[1])), 
                   function(x) {
                       if (grepl("Function",x)) {
                           cat(x, "\n")}})

    cat(names(attributes(obj)), sep="\n")

  } else if (type == "S3") {
    cat("type: S3\n")
    cat(methods(class=class(obj)[1]), sep="\n")
    cat(names(attributes(obj)), sep="\n")
    cat(ls(obj, all.names=TRUE), sep="\n")

  } else {
    cat("type: refclass\n")
  }
}

unload <- function(package) {
    package <- paste0("package:", substitute(package))
    tryCatch( {
        do.call(detach, list(package, unload=T))
    },
    error=function(arg) {
        if ("invalid 'name' argument" %in% arg) {
            cat(paste0("Package '", package, "' not loaded.\n"))
        } else {
            cat(paste0("caught error: \n" ,arg, "\n"))
        }
    })
}

libs <- function() {
    library("tidyverse")
    library("magrittr")
    library("DBI")
    library("ggplot2")
}

## definitions
eye_care <- ggplot2::theme_dark() + ggplot2::theme(plot.background = ggplot2::element_rect(fill = "grey30"), text= ggplot2::element_text(colour="grey90"), axis.text=ggplot2::element_text(colour="grey90"), legend.background = ggplot2::element_rect(fill = "grey30"))


## execution
refresh_columns()

## Default repo
local({r <- getOption("repos")
       r["CRAN"] <- "https://cloud.r-project.org"
       options(repos=r)
})

## set cores for building
options(Ncpus = parallel::detectCores())

## history
if (interactive()) {
    try(utils::loadhistory("~/.Rhistory"))

  .Last <- function() try(utils::savehistory("~/.Rhistory"))
}
res <- Sys.getenv("R_HISTSIZE")
rm(res)
Sys.setenv(R_HISTSIZE = 99999)
