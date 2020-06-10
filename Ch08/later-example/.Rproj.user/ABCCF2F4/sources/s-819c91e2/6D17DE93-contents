install.packages("later")
install.packages("jsonlite")
install.packages("curl")
library("later")
library("jsonlite")

gettoptil <- function() {
toptil <- "https://reddit.com/r/todayilearned/top/.json?count=20"
top.df <- fromJSON(toptil);
later(gettoptil,900) #Have this function call itself every 900 seconds (15 min).
return(cat("\n at ",format(Sys.time(),"%a %b %d %X %Y"), "the top TIL was: ",top.df$data$children$data$title[1]))
}

gettoptil() #Start the loop.

# This loop will run until you restart the R session.
