install.packages("rvest");
library("rvest");
addr <- "https://nces.ed.gov/collegenavigator/?s=MS&pg=2&id=175616"
page <- read_html(addr);
nodes <- html_nodes(page,".tabular td");
totfaculty <- html_text(nodes)[2]
paste("The total number of faculty are",totfaculty);
header <- html_nodes(page,".headerlg");