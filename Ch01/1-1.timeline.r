install.packages("timelineS"); # Run this line if you have not installed the library yet.
library("timelineS");
events <- data.frame(
	"Events" = c(
		"R Mailing Lists Start",
		"Package Installation & Update via CRAN",
		"1.0 Released",
		"useR! 2004 Conference",
		"R Highlighted in New York Times",
		"RStudio Released",
		"Microsoft buys Revolution Analytics"), 
	"Event_Dates" = c(
		"1997-04-01",
		"1999-10-07",
		"2000-02-29",
		"2004-05-20",
		"2009-01-06",
		"2011-02-28",
		"2015-01-23"));
events$Event_Dates <- as.Date(events$Event_Dates);
timelineS(events, main = "R Timeline");