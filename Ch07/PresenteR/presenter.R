# Run your analysis
install.packages(reshape)
install.packages(irr)
library(reshape)
library(irr)
mdata <- read.csv(file="mdata.csv",header=T); mdata <- mdata[,-1] #Shortcut
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

# Install the officer package.
install.packages("officer");

# load package
library("officer");

# read Powerpoint Presentation
presentation <- read_pptx(path="powerpoint.pptx");

# Add new slide
presentation <- add_slide(presentation, layout="Title and Content", master="SavonVTI");
# Modify new slide to have a title.
presentation <- on_slide(presentation, index=2)
presentation <- ph_with(presentation, value = "Activity", location = ph_location_type(type = "title"))
presentation <- ph_with(presentation, value = c("We’re going to watch 2 videos. I’m providing you with the paragraph that Emma (Age 6.5) is reading. Count…", "The number of errors in pronunciation (broken down by video)","The number of breaks in reading flow (broken down by video)"), location = ph_location_type(type = "body"))

presentation <- add_slide(presentation, layout="Title and Content", master="SavonVTI");
presentation <- on_slide(presentation, index=3)
presentation <- ph_with(presentation, value = "Overall Ratings of Pronunciation", location = ph_location_type(type = "title"))
presentation <- ph_with(presentation, value = pro,  location = ph_location_label(ph_label = "Content Placeholder 2") )

presentation <- add_slide(presentation, layout="Title and Content", master="SavonVTI");
presentation <- on_slide(presentation, index=4)
presentation <- ph_with(presentation, value = "Overall Ratings of Breaks", location = ph_location_type(type = "title"))
presentation <- ph_with(presentation, value = br,  location = ph_location_label(ph_label = "Content Placeholder 2") )

proicc <- icc(pro,model="oneway",type="consistency",unit="single");
bricc <- icc(br,model="oneway",type="consistency",unit="single");
presentation <- add_slide(presentation, layout="Title and Content", master="SavonVTI");
presentation <- on_slide(presentation, index=5)
presentation <- ph_with(presentation, value = "Results of the ICC Calculations", location = ph_location_type(type = "title"))
presentation <- ph_with(presentation, value = c(sprintf("The Pronunciation ICC is %s, with an ANOVA results of F(%s,%s)=%s, p = %s", round(proicc$value, digits=2), round(proicc$df1, digits=2), round(proicc$df2, digits=2), round(proicc$Fvalue, digits=2), round(proicc$p.value, digits=2)),sprintf("The Breaks ICC is %s, with an ANOVA results of F(%s,%s)=%s, p = %s", round(bricc$value, digits=2), round(bricc$df1, digits=2), round(bricc$df2, digits=2), round(bricc$Fvalue, digits=2), round(bricc$p.value, digits=2))), location = ph_location_type(type = "body"))

# Write new presentation
print(presentation, target="completed-powerpoint.pptx");
