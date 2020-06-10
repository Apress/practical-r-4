# Get Top hot Reddit Thread
install.packages("jsonlite")
install.packages("later")
library("jsonlite")
library("later")

# Track the change of the top hot
gettophot <- function() {
  hot <- "https://www.reddit.com/hot/.json"
  hot.df <- fromJSON(hot);
  return(hot.df$data$children$data$title[1])
}
tracktophot <- function() {
  ifelse(!exists("tophothist"),tophothist <<- gettophot(),"") #If it doesn't exist, start tracking it.
  same <- tophothist == gettophot()
  if (!same) {
    tophothist <<- gettophot()
    cat("\n at ",format(Sys.time(),"%a %b %d %X %Y"), " New Top Hot: ", gettophot())
  }
  cancelfunc <<- later(tracktophot,3600)
}

tracktophot()