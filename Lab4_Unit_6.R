#Clustering Lab 4 Unit 6
#K-Means Clustering
iris2 <- iris #สร้างตัวแปร iris2 จาก iris (ต้นฉบับ)
#delete col species out because we have to clustering species of iris
iris2$Species <- NULL #ลบข้อมูลใน col species เพื่อจะใช้ทดลองการจัดกลุ่ม
(kmeans.result <- kmeans(iris2, 3)) #ทำการจัดกลุ่มโดยใช้ kmeans (ชุดข้อมูล, จำนวน K กลุ่ม)

##ตรวจสอบว่า สามารถแยก species ได้ถูกต้องมากน้อยเพียงใด
table(iris$Species, kmeans.result$cluster)

plot(iris2[c("Sepal.Length", "Sepal.Width")], col = kmeans.result$cluster) #plot แสดงผลการจัดกลุ่ม โดยใช้สีแสดงกลุ่มข้อมูล
#plot x center pointer of data set
points(kmeans.result$centers[, c("Sepal.Length", "Sepal.Width")], col = 1:3, pch = 8, cex = 2) #plot ค่ากึ่งกลางของกลุ่มข้อมูล


#K-Medoids Clustering
library(fpc)
pamk.result <- pamk(iris2) #จัดกลุ่มข้อมูลโดยใช้ algorithms pamk
pamk.result$nc #show number of clusters
table(pamk.result$pamobject$clustering, iris$Species) #check clustering againts actual species

layout(matrix(c(1,2), 1, 2)) #2 graphs per page

plot(pamk.result$pamobject) #plot ผลลัพธ์การจัดกลุ่มด้วย pamk

layout(matrix(1)) #check back to one graph per page
#Hierarchical Clustering
idx <- sample(1:dim(iris)[1], 40) #สุ่มตัวเลข 1 - จำนวนข้อมูลของ iris (1-150) จำนวน 40 ค่า
irisSample <- iris[idx,] #เอาค่าจากตัวแปร iris มา ตามค่า index ที่สุ่มมาข้างต้น
irisSample$Species <- NULL #set ค่าใน col species ให้ว่างเพื่อทำการจัดกลุ่ม
hc <- hclust(dist(irisSample), method = "ave") #จัดกลุ่มโดยใช้ algorithms heierarchical
plot(hc, hang = -1, labels = iris$Species[idx]) #plot ผลลัพธ์การจัดกลุ่ม
#cut tree into 3 clusters
rect.hclust(hc, k = 3) #วาดเส้นแบ่งกลุ่มข้อมูล (3 กลุ่ม)
groups <- cutree(hc, k = 3) #แบ่งกลุ่มข้อมูลจากการตัดกิ่งต้นไม้ โดยแทนตัวเลข 1, 2, 3 แทนว่าอยู่กลุ่มไหน


#Density-base Clustering
library(fpc)
#ทำการสร้างข้อมูล iris2 จาก iris โดยเอา col 1-4 ไม่เอา col 5
iris2 <- iris[-5] #remove classs tags
ds <- dbscan(iris2, eps = 0.42, MinPts = 5) #ทำการจัดกลุ่มโดยใช้ dbscan
#compare clusters with original class lables
table(ds$cluster, iris$Species) #ดูผลลัพธ์การจัดกลุ่ม
plot(ds, iris2) #plot ทั้งหมด

#plot iris2 col 1 and 4
plot(ds, iris2[c(1,4)])

plotcluster(iris2, ds$cluster) #แสดงกลุ่มข้อมูลที่จัดกลุ่ม แทนที่ด้วยตัวเลข ตามจำนวนกลุ่มข้อมูล


#Create a new dataset for labeling
set.seed(435)
idx <- sample(1:nrow(iris), 10) #สร้าง index ข้อมูลจากการสุ่ม 1 - 150 (ขนาดข้อมูลของ iris) 10 จำนวน
newData <- iris[idx, -5] #-5 is not use column 5

#plus matrix random data 
#สร้าง matrix จากการสุ่ม 40 ค่า ค่าน้อยที่สุด 0 มากที่สุด 0.2 เป็น matrix 10*4 เพื่อเอาไปบวกค่าใน newData
newData <- newData + matrix(runif(10*4, min = 0, max = 0.2), nrow = 10, ncol = 4)

#label new data
myPred <- predict(ds, iris2, newData) #ทดสอบการจัดกลุ่ม จากค่าที่เพิ่มเข้าไปใหม่
#plot result
plot(iris2[c(1,4)], col = 1 + ds$cluster)
points(newData[c(1,4)], pch = "ast", col = 1 + myPred, cex =3)

#check cluster lables
table(myPred, iris$Species[idx]) #ดูผลการจัดกลุ่ม


library(fpc)
library(factoextra)
data("multishapes", package = "factoextra") #เอาข้อมูล multishapes มาใช้ทดลอง
# retrieve all data point from columns x and y
df <- multishapes[, 1:2] #เอาข้อมูลจาก multishapes row = all, col 1&2
# radius 0.15 unit, minimum neighbor point = 5
db <- fpc::dbscan(df, eps = 0.15, MinPts = 5) #ทดสอบการจัดกลุ่มโดยใช้ dbscan
plot(db, df, frame = FALSE) #plot ผลลัพธ์การจัดกลุ่ม
