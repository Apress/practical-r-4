setwd("~/Downloads") # Set to be where your files are stored.
data <- read.csv("survey_167537_R_data_file.csv", quote = "'\"", na.strings=c("", "\"\""), stringsAsFactors=FALSE, fileEncoding="UTF-8-BOM")


# LimeSurvey Field type: F
data[, 1] <- as.numeric(data[, 1])
attributes(data)$variable.labels[1] <- "id"
names(data)[1] <- "id"
# LimeSurvey Field type: DATETIME23.2
data[, 2] <- as.character(data[, 2])
attributes(data)$variable.labels[2] <- "submitdate"
names(data)[2] <- "submitdate"
# LimeSurvey Field type: F
data[, 3] <- as.numeric(data[, 3])
attributes(data)$variable.labels[3] <- "lastpage"
names(data)[3] <- "lastpage"
# LimeSurvey Field type: A
data[, 4] <- as.character(data[, 4])
attributes(data)$variable.labels[4] <- "startlanguage"
names(data)[4] <- "startlanguage"
# LimeSurvey Field type: A
data[, 5] <- as.character(data[, 5])
attributes(data)$variable.labels[5] <- "Seed"
names(data)[5] <- "q_"
# LimeSurvey Field type: F
data[, 6] <- as.numeric(data[, 6])
attributes(data)$variable.labels[6] <- "What is your gender?"
data[, 6] <- factor(data[, 6], levels=c(1,2),labels=c("Female", "Male"))
names(data)[6] <- "gender"
# LimeSurvey Field type: F
data[, 7] <- as.numeric(data[, 7])
attributes(data)$variable.labels[7] <- "How old are you?"
names(data)[7] <- "age"
# LimeSurvey Field type: F
data[, 8] <- as.numeric(data[, 8])
attributes(data)$variable.labels[8] <- "[I\'m kind of a computer geek.] Please check all that apply."
data[, 8] <- factor(data[, 8], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[8] <- "AllThatApply_geek"
# LimeSurvey Field type: F
data[, 9] <- as.numeric(data[, 9])
attributes(data)$variable.labels[9] <- "[ I recently bought a book on R] Please check all that apply."
data[, 9] <- factor(data[, 9], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[9] <- "AllThatApply_rbook"
# LimeSurvey Field type: F
data[, 10] <- as.numeric(data[, 10])
attributes(data)$variable.labels[10] <- "[ I enjoy the meme of the cat yelling at the woman.] Please check all that apply."
data[, 10] <- factor(data[, 10], levels=c(1,0),labels=c("Yes", "Not selected"))
names(data)[10] <- "AllThatApply_catyell"
# LimeSurvey Field type: F
data[, 11] <- as.numeric(data[, 11])
attributes(data)$variable.labels[11] <- "On a scale of 1-10, with 10 = I really love it and 1 = I\'m not so happy with it, how do you like our new product?"
data[, 11] <- factor(data[, 11], levels=c(1,2,3,4,5,6,7,8,9,10),labels=c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10"))
names(data)[11] <- "enjoy"
# Variable name was incorrect and was changed from  to q_ .

data <- data[,1:11] #Done to remove the last two columns that didn't actually house data.
install.packages("psych");
library("psych");
describe(data);
prop.table(table(data$gender));
prop.table(table(data$AllThatApply_geek));
prop.table(table(data$AllThatApply_rbook));
prop.table(table(data$AllThatApply_catyell));

data$enjoy <- as.numeric(data$enjoy);
fit <- lm(enjoy ~ gender + age + AllThatApply_geek + AllThatApply_rbook + AllThatApply_catyell,data=data);
summary(fit);

# Example of using tapply to get the mean of enjoy by gender
tapply(data$enjoy,data$gender,mean);

# Example of using tapply to get the mean of enjoy by gender and by AllThatApply_catyell
tapply(data$enjoy,list(data$gender,data$AllThatApply_catyell),mean);

fit2 <- lm(enjoy ~ age + AllThatApply_geek + AllThatApply_rbook + AllThatApply_catyell * gender,data=data);
summary(fit2)
