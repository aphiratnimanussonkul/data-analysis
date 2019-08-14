#lab 4 Linear Regression
#create data
#rep() => Replicate Elements of Vectors and List

year <- rep(2008:2010, each = 4)
#Result
# 1	2008
# 2	2008
# 3	2008
# 4	2008
# 5	2009
# 6	2009
# 7	2009
# 8	2009
# 9	2010
# 10	2010
# 11	2010
# 12	2010

quarter <- rep(1:4, 3)
#quart คือไตรมาส
#Result
# 1	1
# 2	2
# 3	3
# 4	4
# 5	1
# 6	2
# 7	3
# 8	4
# 9	1
# 10	2
# 11	3
# 12	4

cpi <- c(162.2, 164.6, 166.5, 166.0, 166.2, 167.0, 168.6, 169.5, 171.0, 172.1, 173.3, 174.0)

plot(cpi, xaxt="n", ylab = "CPI", xlab = " ") #ylab, xlab = label

axis(1, labels = paste(year,quarter,sep = "Q"), at = 1:12, las = 3)

#show correlation between CPI and other variable (year, quarter)
cor(year, cpi)
#Result 0.9096316 => year cpi very close to have coorelation each other

cor(quarter, cpi)
#Result 0.3738028 => quarter and cpi have coorelation a little bit


#Create regeression model
fit <- lm(cpi ~ year + quarter)
fit

#Predict
(cpi2011 <- fit$coefficients[[1]] + fit$coefficients[[2]]*2011 + fit$coefficients[[3]]*(1:4))

#Show detail lm 
attributes(fit)
# $names
# [1] "coefficients"  "residuals"     "effects"       "rank"          "fitted.values" "assign"        "qr"            "df.residual"   "xlevels"       "call"         
# [11] "terms"         "model"        
# 
# $class
# [1] "lm"

fit$coefficients


#show Error 
residuals(fit)
# 1           2           3           4           5           6           7           8           9          10          11          12 
# -0.57916667  0.65416667  1.38750000 -0.27916667 -0.46666667 -0.83333333 -0.40000000 -0.66666667  0.44583333  0.37916667  0.41250000 -0.05416667 

summary(fit)


plot(fit)

#show plot 3d
library(scatterplot3d)
#X = year, Y = quarter, Z = cpi
s3d <- scatterplot3d(year, quarter, cpi, hightlight.3d = T, type = "h", lab = c(2,3))
s3d$plane3d(fit)


#User model to predic CPI 2011
data2011 <- data.frame(year=2011, quarter = 1:4)
cpi2011 <- predict(fit, newdata = data2011)

#rep(1,12) gen number 1 for 12 
style <- c(rep(1,12), rep(2,4))
# 1	1
# 2	1
# 3	1
# 4	1
# 5	1
# 6	1
# 7	1
# 8	1
# 9	1
# 10	1
# 11	1
# 12	1
# 13	2
# 14	2
# 15	2
# 16	2

plot(c(cpi, cpi2011), xaxt="n", ylab = "CPI", xlab = " ", pch = style, col = style)

axis(1, at = 1:16, las = 3, labels = c(paste(year, quarter, sep = "Q"), "2011Q1", "2011Q2", "2011Q3", "2011Q4"))


#Logistic Regression

#Generalize Linear Regression (GLM)
data("bodyfat", package = "TH.data")
myFormular <- DEXfat ~ age + waistcirc + hipcirc + elbowbreadth + kneebreadth

bodyfat.glm <- glm(myFormular, family = gaussian("log"), data = bodyfat)

summary(bodyfat.glm)

pred <- predict(bodyfat.glm, type = "response")
#type คือการกำนหนดการ predict ค่า default คือเชิงเส้น response คือระบุว่าเป็น response variable
#if family = "gaussian("identity") จะได้ Model ที่คล้ายกับ linear และสามารถระบุ family = bionomial("logit") เพื่อระบุว่าเป็น logistic regression

plot(bodyfat$DEXfat, pred, xlab = "Observed Values", ylab = "Predicted Values")
#Create line between plot
abline(a=0, b=1)


#Non-Linear Regression
#Non linear Regression จะ plot เส้นี่ไม่ใช่เส้นตรง ให้ใกล้เคียงข้อมูลทุกตัวให้มากที่สุด



