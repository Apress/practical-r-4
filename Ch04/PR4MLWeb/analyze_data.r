library("lme4");
library("lmerTest");
library("psych");
library("reshape2");
data <- read.csv(file="pr4example_proc.csv");
## Some basic descriptive statistics
table(data$boxname)
by(data$boxtime,data$boxname,describe)


## Inferential Stats 
data <- subset(data,event == "mouseout");
data$boxtime.c <- data$boxtime - mean(data$boxtime);
data$boxtime.c.scaled <- data$boxtime.c / 1000;

## Does the time spent viewing a box predict which choice the person will make?
fit <- glmer(mlchoice=="catbtn" ~ (1|id) + boxtime.c.scaled%in%boxname,data=data,family=binomial);
summary(fit);

## Do people open certain boxes later than others?
fit2 <- lmer(relcount ~ (1|id) + boxname,data=data);
summary(fit2);
?isSingular

fit2 <- lm(relcount ~ boxname,data=data);
summary(fit2);

## Do cat lovers avoid looking at anti-cat information?
data$hit <- 1;
data_wide <- dcast(data,id + choice ~ boxname, value.var="hit");
fit3 <- lm(choice=="catbtn" ~ con1 + con2 + con3 + pro1 + pro2 + pro3, data=data_wide);
summary(fit3);
