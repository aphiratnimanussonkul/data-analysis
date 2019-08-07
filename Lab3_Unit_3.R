#Unit 3 Data Exploration
#dim() => ดูจำนวน row,  cow ของ data set
#names() => แสดงชื่อ col
#str() => แสดงข้อมูลคร่าวๆของ data frame
#attributs() => บอกชื่อ col , บอกว่าเป็นข้อมูลประเภทไหน (class) เช่น data.frame, บอกชื่อ rows
dim(iris)
#row = 150, col = 5
names(iris)
#"Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"    
str(iris)
attributes(iris)


head(iris)
#equal
iris[1:5,]

tail(iris)
#equal
iris[145:150, ]

#show specifies column
iris[1:10, "Sepal.Length"]
#OR
iris$Sepal.Length[1:10]


#การพิจารณาข้อมูลแต่ละคอลัมน์
#summary() => บอกค่า min,max, median, 1st quartile, 3rd quartil ของแต่ละคอลัมน์
summary(iris)
# Sepal.Length    Sepal.Width     Petal.Length    Petal.Width          Species  
# Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100   setosa    :50  
# 1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300   versicolor:50  
# Median :5.800   Median :3.000   Median :4.350   Median :1.300   virginica :50  
# Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199                  
# 3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800                  
# Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  

quantile(iris$Sepal.Length)
# 0%  25%  50%  75% 100% 
# 4.3  5.1  5.8  6.4  7.9

quantile(iris$Sepal.Length, c(.1, .3, .65))
# 10%  30%  65% 
# 4.80 5.27 6.20 

#mean() => ดูค่าเฉลี่ย
mean(iris$Sepal.Length)

#median() => ดูค่ากลาง
median(iris$Sepal.Length)

#range() => ดูช่วง
range(iris$Sepal.Length)

#var() => ดูค่าความแปรปรวน (variance)
var(iris)

#hist() => ใช้ plot กราฟ histogram
hist(iris$Sepal.Length)

#density() => ดูค่าความหนาแน่น (density)
density(iris$Sepal.Length)

#table() => เพื่อดูค่าความถี่เฉลี่ยของข้อมูลชนิด nominal
table(iris)

#pie() => pie( ) เพื่อดูกราฟพาย
pie(iris$Sepal.Length)

#barplot() => เพื่อดูกราฟบาร์
barplot(iris$Sepal.Length)


#การพิจารณาข้อมูลหลายคอลัมน์พร้อม ๆ กัน (multiple variables)
#cov() => เพื่อแสดงความแปรปรวนร่วม (covariance)
cov(iris$Sepal.Length, iris$Petal.Length)

#cor() => เพื่อแสดงความสัมพันธ์ร่วม (correlation)
cor(iris[, 1:4])

#aggregate() เราสามารถค านวณค่าสถิติของคอลัมน์ Sepal.Length ของทุก Species ด้วยฟังกชัน ์ aggregate( )
aggregate(Sepal.Length ~ Species, summary, data = iris)

#boxplot() => เพื่อแสดงกราฟ box (อาจจะเรียกวา ่ box-and-whisker plot) เพื่อแสดง
# ค่า median, ค่าควอไทล์, และค่าที่อยูนอกกลุ ่ ่ม (outlier) โดยขีดกลางคือ ค่า median, ขอบกล่อง บน และล่าง คือ
# ค่า 75% และ 25% (ระยะห่างคือค่า IR=Intr Quartile Range=ขอบกล่อง บน-ล่าง) ข้อมูล outlier แสดงด้วยจุด
# วงกลม
boxplot(Sepal.Length ~ Species, data = iris)

#plot() => เพื่อแสดงกราฟจุดที่แสดงความสัมพันธ์ระหวางแกน ่ x กบแกน ั y
#with เพื่อไม่ต้องระบุ iris$
with(iris, plot(Sepal.Length, Sepal.Width, col=Species, pch=as.numeric(Species)))

#ในการแสดงกราฟบางครั้งจุดอาจจะซ้อนทับกน เราสามารถใช้ ั jitter( ) เพื่อให้เห็นชัดเจนขึ้น
plot(jitter(iris$Sepal.Length), jitter(iris$Setal.Width))

#pairs() => ) เพื่อแสดง scatter plots ของทุกคอลัมน์ (จับคู่กน) ที่เป็นไปได้ทัั้งหมด
pairs(iris)

#การสำรวจข้อมูลเพิมเติม
library(scatterplot3d)
scatterplot3d(iris$Petal.Width, iris$Sepal.Length, iris$Sepal.Width)

#plot3d() => plot3d( ) เพื่อแสดง interactive 3D scatter plot
library(rgl)
plot3d(iris$Petal.Width, iris$Sepal.Length, iris$Sepal.Width)

#heatmap() => ใช้แสดงการจับคู่ที่เรียกวา ่ heat map ในลักษณะ 2D ของข้อมูลเมตริกซ์
distMatrix <- as.matrix(dist(iris[, 1:4]))
heatmap(distMatrix)

#levelplot() => เพื่อแสดงกราฟชนิด level และสามารถใช้ร่วมกับ grey.colors( ), rainbow( ) เพื่อแสดงสีต่างๆ
library(lattice)
levelplot(Petal.Width ~ Sepal.Length*Sepal.Width, iris, cuts=9, col.regions=grey.colors(10)[10:1])

#contour(), filled.contour() ใช้แสดงกราฟเชิงพื้นที่
filled.contour(volcano, color=terrain.colors, asp = 1, plot.axes = contour(volcano, add = T))
#ในการแสดงข้อมูลตัวเลขที่มี 3 มิติ (3 คอลัมน์)
#persp()
persp(volcano, theta = 25, phi = 30, expand = 0.5, col = "lightblue")

#ในการแสดงข้อมูลลายเส้นในรูปแบบขนาน (parallel coordinate) โดยการใช้ parcoord()
library(MASS)
parcoord(iris[1:4], col=iris$Species)

library(lattice)
parallelplot(~iris[1:4] / Species, data = iris)

library(ggplot2)
qplot(Sepal.Length, Sepal.Width, data=iris, facets=Species ~ .)


#การบันทึกรูปกราฟลงไฟล์
pdf("myPlot.pdf")
x <- 1:50
plot(x, log(x))
graphics.off()

#save script file
postscript("myPlot2.ps")
x <- -20:20
plot(x, x^2)
graphics.off()


