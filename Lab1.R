v1<-1:5
v2<-c(3,6,1,2,9)
v3<-seq(from=1, to=5, by=1)
v4<-c(0,0,0,0,0)
v5<-seq(from=0, to=0, length.out = 5)
#print(v1)
#print(v2)
#print(v3)
#print(v4)
#print(v5)


#Column 
# | | | | |
# | | | | |
cbind(v1, v2, v3, v4, v5)

#Row
#- - - - 
#- - - -
#rbind(v1, v2, v3, v4, v5)
v <- seq(from = 1, to = 20, by = 1)
m1 <- matrix(v, nrow = 4, ncol = 5)
print(m1)
m2 <- matrix(v, nrow = 4, ncol = 5, byrow = TRUE)
print(m2)
colnames(m2) <- c("Col1","Col2","Col3","Col4","Col5")
rownames(m2) <- c("Row1", "Row2", "Row3", "Row4")
v[3]
m2[, "Col2"]
m2["Row4" ,]
m2["Row4", "Col2"]
m2[4, 2]
length(v)
nrow(m2)
ncol(m2)

set.seed(10)
#The Normal Distribution
norm_vec <- rnorm(n=10,mean = 5,sd=2)
print(norm_vec)

#The Exponential Distribution
exp_vec <- rexp(n=100,rate=3)
print(exp_vec)

#The Poisson Distribution
pois_vec <- rpois(n=50,lambda = 6)
print(pois_vec)

#The Uniform Distribution
unif_vec <- runif(n=20,min=1,max=9)
print(unif_vec)

#The Binomial Distribution
bin_vec <- rbinom(n=20,size=1000,prob=0.7)
print(bin_vec)

#Random Samples and Permutations
sample(exp_vec,size=25,replace=FALSE)
print(sample(exp_vec,size=25,replace=FALSE))

#Ctrl + Enter -> run 1 line
#Ctrl + Shift + C -> Comment
#CSV -> Comma Separated value
