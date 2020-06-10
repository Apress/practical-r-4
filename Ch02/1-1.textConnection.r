OurData = ("
Student	Pretest	Posttest
A 25 27
B 23 23
C 21 22
D 23 29
E 23 24
F 21 19
")
Data = read.table(textConnection(OurData),header=T)
t.test(Data$Pretest,Data$Posttest,paired=T)