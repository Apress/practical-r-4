## Interrater Statistics
## Original Article in http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3402032/
##
## Enter Data
data <- read.csv("PATH_TO_CSV_FILE");
## Take out Test Data
data <- data[-c(1:5),]
data <- data[,c(3:7)]
names(data) <- c("Rater","Pronunciation1","Breaks1","Pronunciation2","Breaks2");
library(reshape)
library(irr)
mdata <- melt(data,id.vars="Rater");
mdata$video <- NA;
mdata$video <- ifelse(mdata$variable == "Pronunciation1","EasyEmma",mdata$video);
mdata$video <- ifelse(mdata$variable == "Breaks1","EasyEmma",mdata$video);
mdata$video <- ifelse(is.na(mdata$video),"HardEmma",mdata$video);
mdata$score <- NA;
mdata$score <- ifelse(mdata$variable == "Pronunciation1","Pronunciation",mdata$score);
mdata$score <- ifelse(mdata$variable == "Pronunciation2","Pronunciation",mdata$score);
mdata$score <- ifelse(is.na(mdata$score),"Breaks",mdata$score);
mdata <- mdata[,-2]
## Pronunciation Data Only
pro <- subset(mdata,score == "Pronunciation");
br <- subset(mdata,score=="Breaks");
easyemma <- subset(mdata,video == "EasyEmma");
hardemma <- subset(mdata,video == "HardEmma");
pro <- pro[,-4];
br <- br[,-4];
easyemma <- easyemma[,-3];
hardemma <- hardemma[,-3];
pro <- cast(pro,video~Rater);
br <- cast(br,video~Rater);
easyemma <- cast(easyemma,score~Rater);
hardemma <- cast(hardemma,score~Rater);
# Looking at task, pronunciation or breaks. Higher correlation = easier to rate
print(head(pro));
print(icc(pro,model="oneway",type="consistency",unit="single"));
print(head(br));
print(icc(br,model="oneway",type="consistency",unit="single"));
print(head(easyemma));
print(icc(easyemma,model="oneway",type="consistency",unit="single"));
print(head(hardemma));
print(icc(hardemma,model="oneway",type="consistency",unit="single"));