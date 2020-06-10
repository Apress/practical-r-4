# This script gathers information from a variety of web sources and creates
# two daily briefing files. One suitable for email, rendered in Markdown, and one plaintext, suitable to have
# read by a smart assistant.

# Sources

# Weather from OpenWeatherMap.org (You'll need to add your own API key)
#install.packages("owmr")
library('owmr')
Sys.setenv(OWM_API_KEY = "a91bb498c90bcd09f445039a88474ec5")
weather <- get_current(zip="38733", units="imperial")
weather$main$temp

# Get Stock quotes from quantmod/tidyquant
#install.packages("tidyquant")
library("tidyquant")
dji <- getQuote("^DJI") #Get Current Dow Jones Industrial Average
aapl <- getQuote("AAPL")
goog <- getQuote("GOOG")

# News Headlines from NewsAPI.org (You'll need to get your own API key from newsapi.org)
library("jsonlite")
url <- "http://newsapi.org/v2/top-headlines?country=us&apiKey=05d1eea12c8343eaae7e8fad5c6220a6" # Customize as you like, see newsapi.org for examples
news.df <- fromJSON(url); # we now have a dataframe with the top 20 headlines and links.

# Daily Inspiration Quote from TheySaidSo.com
url <- "http://quotes.rest/qod.json?category=inspire"
quote.df <- fromJSON(url); # We now have a dataframe with a quote


# Calendar info from Google Calendar
devtools::install_github("andrie/gcalendr")
timezoneoffset <- -4 #Set to your distance from UTC
library(gcalendr)
calendar_auth(email="examples@gmail.com",path="client_secret.json")
my_cal_id <- "examples@gmail.com"
events <- calendar_events(my_cal_id, days_in_past = 0, days_in_future = 1)
events <- events[order(events[,3]),] #Sort so that events are in order of occurance, otherwise will be alphabetical!

## Plaintext Output

txt <- paste("This is your automated daily briefing for ",format(Sys.time(),'%a %b %d %Y'),"! Today the high temperature will be",sep="")
txt <- paste(txt,as.character(round(weather$main$temp,digits=0)))
txt <- paste(txt," degrees and ",weather$weather$main,".",sep="")
# Calendar Block
txt <- paste(txt,sprintf("You have %s events today.",nrow(events)))
txt <- paste(txt,"The first event,", events$summary[1], ",starts at",format(events$start_datetime[1]+timezoneoffset*60*60,'%H:%M'))
i <- nrow(events)-1
txt <- paste(txt,sprintf(".The remaining %s events are: ",sprintf(as.character(i))))
j <- 2
while (j <= nrow(events)) {
  txt <<- (paste(txt,ifelse(j == nrow(events)," and ",""),events$summary[j]," at ",format(events$start_datetime[j]+timezoneoffset*60*60,'%H:%M'),
                 ifelse(j == nrow(events),".",","),sep=""));
  j <<- j+1
}
# Stock Block
txt <- paste(txt," In stock news, the Dow Jones closed at ",as.character(dji$Last)," a change of ",as.character(round(dji$`% Change`,digits=2))," percent.",sep="")
if (aapl$Change > 0) { txt <<- paste(txt,"Apple Stock increased") } else { txt <<- paste(txt,"Apple stock decreased") }
txt <- paste(txt,as.character(round(abs(aapl$`% Change`),digits=2)), " percent. Google stock ")
if (goog$Change > 0) { txt <<- paste(txt,"increased") } else { txt <<- paste(txt,"decreased") }
txt <- paste(txt,as.character(round(abs(goog$`% Change`),digits=2)), " percent.")
# World News Block
txt <- paste(txt,"In world news, the top 3 headlines and their sources are:",news.df$articles$title[1],"followed by",news.df$articles$title[2],"and finally",news.df$articles$title[3])
# Optionally, include news.df$articles$url at the bottom of your text briefing so you can easily get to the full story.
# Inspirational Quote Block
txt <- paste(txt,". Finally, to wrap up your briefing, today's inspirational quote comes from ",quote.df$contents$quotes$author[1], "and is '", quote.df$contents$quotes$quote[1],"'. That's today's briefing, have a great day, Jon")

## Write to file
fileDB <-file("db.txt")
writeLines(txt, fileDB)
close(fileDB)

## Save image so that daily-briefing.Rmd can use it when it executes.
save.image("daily-brief")

## Write the Markdown Version
knitr::knit(input="daily-briefing.Rmd")

## Write the HTML version
library(markdown)
markdownToHTML("daily-briefing.md",output = "daily-briefing.html")
