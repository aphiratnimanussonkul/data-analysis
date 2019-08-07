#save data and load data
a <- 1:10
save(a, file="./a.Rdata")
rm(a)
load("./a.Rdata")
print(a)

#connect data from .csv file
var1 <- 1:5
var2 <- (1:5) / 10
var3 <- c("R", "and", "Data Mining", "Example", "Case Studies")
#create data.frame
df1 <- data.frame(var1, var2, var3)
#change column name
names(df1) <- c("VaricableInt", "VariableReal", "VariableChar")
#save df1 to .csv file
write.csv(df1, "./a.dfData.csv", row.names = FALSE)
#load df2 from .csv file
df2 <- read.csv("./a.dfData.csv")
print(df2)

#connect excel file
library(RODBC)
filename <- "data/dummyData.xls"
xlsfile <- odbcConnetExcel(filename, readOnly = FALSE)
sqlSave(xlsfile, a, rowsname = FALSE)
b <- sqlFetch(xlsfile, "a")
odbcClose(xlsfile)

