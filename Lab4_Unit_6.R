#Clustering Lab 4 Unit 6
#K-Means Clustering
iris2 <- iris
#delete col species out because we have to clustering species of iris
iris2$Species <- NULL
(kmeans.result <- kmeans(iris2, 3))

#ตรวจสอบว่า สามารถแยก species ได้ถูกต้องมากน้อยเพียงใด
table(iris$Species, kmeans.result$cluster)

plot(iris2[c("Sepal.Length", "Sepal.Width")], col = kmeans.result$cluster)
#plot x center pointer of data set
points(kmeans.result$centers[, c("Sepal.Length", "Sepal.Width")], col = 1:3, pch = 8, cex = 2)


#K-Medoids Clustering
library(fpc)
pamk.result <- pamk(iris2)
pamk.result$nc #show number of clusters
table(pamk.result$pamobject$clustering, iris$Species) #check clustering againts actual species

layout(matrix(c(1,2), 1, 2)) #2 graphs per page

plot(pamk.result$pamobject)

layout(matrix(1)) #check back to one graph per page

#Hierarchical Clustering
idx <- sample(1:dim(iris)[1], 40)
irisSample <- iris[idx,]
irisSample$Species <- NULL
hc <- hclust(dist(irisSample), method = "ave")
plot(hc, hang = -1, labels = iris$Species[idx])
#cut tree into 3 clusters
rect.hclust(hc, k = 3)
groups <- cutree(hc, k = 3)


#Density-base Clustering
library(fpc)
iris2 <- iris[-5] #remove classs tags
ds <- dbscan(iris2, eps = 0.42, MinPts = 5)
#compare clusters with original class lables
table(ds$cluster, iris$Species)
plot(ds, iris2)

#plot iris2 col 1 and 4
plot(ds, iris2[c(1,4)])

plotcluster(iris2, ds$cluster)


#Create a new dataset for labeling
set.seed(435)
idx <- sample(1:nrow(iris), 10)
newData <- iris[idx, -5] #-5 is not use column 5

#plus matrix random data 
newData <- newData + matrix(runif(10*4, min = 0, max = 0.2), nrow = 10, ncol = 4)

#label new data
myPred <- predict(ds, iris2, newData)
#plot result
plot(iris2[c(1,4)], col = 1 + ds$cluster)
points(newData[c(1,4)], pch = "ast", col = 1 + myPred, cex =3)

#check cluster lables
table(myPred, iris$Species[idx])


library(fpc)
library(factoextra)
data("multishapes", package = "factoextra")
# retrieve all data point from columns x and y
df <- multishapes[, 1:2]
# radius 0.15 unit, minimum neighbor point = 5
db <- fpc::dbscan(df, eps = 0.15, MinPts = 5) 
plot(db, df, frame = FALSE)
