Sys.setlocale(locale = "Thai")

#Unit 4 Decistion Tree and Random Forest
#การทำโมเดล Decision Tree by package party
#ctree() => ) เพื่อสร้างโมเดล Decision Tree เพื่อคาดการณ์คอลัมน์ Species ของดอกไม้ iris 
# ฟังกชัน ์ predict( ) ใช้ในการคาดการณ์ข้อมูลใหม่วามี ่ specie อะไร
set.seed(1234)
#nrow มีเท่ากับ ข้อมูลของ iris
#ind คือค่าที่สุ่มว่าจะเอาค่าไหนของ iris ไป train, test โดยมีค่า 1, 2 
#prob คือ เอา % การสุ่มอยู่ที่ 70:30
ind <- sample(2, nrow(iris), replace = TRUE, prob = c(0.7, 0.3))
#tranData เอาข้อมูลจาก iris row ที่ ind = 1 
trainData <- iris[ind == 1, ]
testData <- iris[ind == 2, ]

# ฟังกชัน ์ ctree( ) มีพารามิเตอร์คือ MinSplit, MinBusket, MaxSurrogate, MaxDepth ซึ่งจะอธิบายอยาง่
# ละเอียดในบทที่13 ถ้าไม่มีการระบุพารามิเตอร์ถือวาใช้ค ่ ่า default

library(party)
myFormula <- Species  ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width

iris_ctree <- ctree(myFormula, data = trainData)

table(predict(iris_ctree), trainData$Species)

print(iris_ctree)

plot(iris_ctree)

plot(iris_ctree, type="simple")

testPred <- predict(iris_ctree, newdata = testData)
table(testPred, testData$Species)
# จุดด้อยของ ctree( ) คือไม่สามารถจัดการ missing value (ใน version 0.9-9995)

# การสร้างโมเดลทรีด้วย package rpart
# เราสามารถสร้างโมเดลทรีด้วยฟังกชัน ์ rpart( ) ซึ่งอยูใน ่ package rpart และทดสอบข้อมูล Test ด้วย
# ฟังกชัน ์ predict( ) ในที่นี้จะใช้กบข้อมูล ั bodyfat
titanic_train <- read.csv("C://cygwin64//home//AphiratNimanussonkul//data-analysis/titanic_train.csv")
titanic_test <- read.csv("C://cygwin64//home//AphiratNimanussonkul//data-analysis/titanic_test.csv")

#as.factor ใช้แปลงค่า int จาก คอลัม survied ให้เป็นตัวแปร factor tree ต้องใช้ ตัวแปรแบบ factor เท่าน้น
titanic_train$Survived <- as.factor(titanic_train$Survived)
titanic_test$Survived <- as.factor(titanic_test$Survived)

library(rpart)
library(rpart.plot)
#create model
tree_fit <- rpart(Survived ~ ., data = titanic_train)
#cp => change cptable for change accurency should select minimal value
#for this data set maximum value is right
tree_fit <- prune(tree_fit, cp = 0.444444)
#test model
#type = class is ต้องระบุการ predict class => classification
p <- predict(tree_fit, newdata = titanic_test, type = "class")
#หาค่าความแม่นยำของ Model จะได้ค่า 0.901 * 100 %
mean(p == titanic_test$Survived)
table(p, titanic_test$Survived)

# p     0   1
# 0 267  31
# 1  10 110
#วิธีคิด 267 + 110 / 267+31+10+110 = 90.01

rpart.plot(tree_fit)


# การสร้างโมเดล Random Forest (กลุ่มของโมเดลทรี)
# โดยใช้ฟังกชัน ์ randomForest( ) จาก package randomForest
# ข้อ ด้อยของฟังกชันนี ์ ้คือ
# 1.ไม่สามารถใช้กบข้อมูลที่มี ั missing value (จะต้องจัดการกบั missing valueก่อนท างาน)
# 2. แต่ละคอลัมน์ที่เป็นชนิด categorical จะมีค่าที่ต่างกนไม ั ่เกิน 32 ค่า (อาจจะใช้ cforest( ) จาก package party
#                                                                                   แทนก็ได้เพราะไม่มีข้อจ ากดนี ั ้)
# ในที่นี้จะใช้ข้อมูล iris ในการศึกษาและทดสอบ
library(party)
library(randomForest)

#create forest
output.forest <- randomForest(nativeSpeaker ~ age + shoeSize + score, data = readingSkills)

#view forest result
print(output.forest)

#importance of each predicter
print(importance(output.forest, type = 2))

titanic_train <- read.csv("C://cygwin64//home//AphiratNimanussonkul//data-analysis/titanic_train.csv")
titanic_test <- read.csv("C://cygwin64//home//AphiratNimanussonkul//data-analysis/titanic_test.csv")

#as.factor ใช้แปลงค่า int จาก คอลัม survied ให้เป็นตัวแปร factor tree ต้องใช้ ตัวแปรแบบ factor เท่าน้น
titanic_train$Survived <- as.factor(titanic_train$Survived)
titanic_test$Survived <- as.factor(titanic_test$Survived)

rf <- randomForest(Survived ~ ., data = titanic_train, ntree = 100)
p <- predict(rf, newdata = titanic_test)
mean(p == titanic_test$Survived)
plot(rf)
plot(margin(rf, titanic_test$Survived))

#as.factor ใช้แปลงค่า int จาก คอลัม survied ให้เป็นตัวแปร factor tree ต้องใช้ ตัวแปรแบบ factor เท่าน้น
titanic_train$Survived <- as.factor(titanic_train$Survived)
titanic_test$Survived <- as.factor(titanic_test$Survived)

rf <- randomForest(Survived ~ ., data = titanic_train, ntree = 100)
p <- predict(rf, newdata = titanic_test)
mean(p == titanic_test$Survived)
plot(rf)
plot(margin(rf, titanic_test$Survived))

