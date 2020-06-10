install.packages("RMySQL");
library("RMySQL");
username <- "pr4";
password <- "pr4";
database <- "pr4-database";
dbconn <- dbConnect(MySQL(), user=username, password=password, dbname=database, host="127.0.0.1", port=33306);
dbListTables(dbconn);
results <- dbSendQuery(dbconn, 'select * from secretstuff');
data = fetch(results, n=-1);
data
dbClearResult(results);
data = dbGetQuery(dbconn, "SELECT * FROM secretstuff");
data