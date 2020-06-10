# Monitor the number of emails sent on the internet, alert me when it's above 130 billion
library("pushoverr")
library(rvest)
library(later)
set_pushover_app(token="ad7w7uqezs9zav81yesd7znjhazgsz1")
set_pushover_user(user="GnoBrXCawlXUwcBSCGkQKBUgC1IMSO")


# This Function downloads the live stats, and checks them. It then
# notifies you if the number of emails sent is above 130,000,000,000
checkmail <- function() {
system("./phantomjs get_internetlivestats.js")
page <- read_html("livestats.html")
node <- html_nodes(page,"span")
# The number we want, Emails sent Today, is element 22
# html_text(node)[22]
num.emails <- as.numeric(gsub(",","",html_text(node)[22]))
# we can now alert if that number is above our critical cutoff (130 billion, 130,000,000,000)
if (num.emails > 130000000000)
{ pushover(message = "It's Above!") } else { pushover(message = "It's Still Below!") }
cancelfunc <<- later(checkmail,300)
}

checkmail()


# This modified function downloads the live stats, and checks them. It then
# notifies you if the number of emails sent is above 130,000,000,000
# It also will require that you acknowledge it or it will keep sending
checkmail <- function() {
  system("./phantomjs get_internetlivestats.js")
  page <- read_html("livestats.html")
  node <- html_nodes(page,"span")
  # The number we want, Emails sent Today, is element 22
  # html_text(node)[22]
  num.emails <- as.numeric(gsub(",","",html_text(node)[22]))
  # we can now alert if that number is above our critical cutoff (130 billion, 130,000,000,000)
  if (num.emails > 130000000000)
  { if (exists("msg")) {
    if (!is.acknowledged((msg$receipt))) {
    pushover(message = "It's Still Above, and No One Acknowledged") } else { pushover(message = "It's Above, but someone has acknowledged. No Further messages until it trips again."); rm("msg", pos = ".GlobalEnv"); } 
  } else { msg <<- pushover_emergency(message = "It's Above!") } }
    cancelfunc <<- later(checkmail,300)
}

checkmail()
