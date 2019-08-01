#Lab 2
#1. Write an R program to take input from the user (name and age) and
# display the values and their types. 
name <- readline(prompt = "Enter name: ")
#as.integer() make sure input will be integer
age <- as.integer(readline(prompt = "Enter age: "))
#age_numberic <- as.numeric(age)
print(paste("Your name is :", name))
print(paste("youe age is : ", age))


# 2. Write an R program to create a sequence of numbers from 20 to 50
# and find the mean of numbers from 20 to 60 and sum of numbers from
# 51 to 91.
#create a sequence of numbers from 20 to 50
seq_num_20_50 <- seq(from = 20, to = 50, by = 1)

#find the mean of numbers from 20 to 60
#create seq num 20 to 60
seq_num_20_60 <- seq(from = 20, to = 60, by = 1)
mean_20to60 <- mean(seq_num_20_60)

# sum of numbers from 51 to 91
#create seq num 51 to 91
seq_num_51_91 <- seq(from = 51, to = 91, by = 1)
sum_51to90 <- sum(seq_num_51_91)


# 3. Write an R program to create a vector which contains 100 random
# integer values between -5 and 5
ran_5to5 <- c(runif(100, min = -5, max = 5))
#or
# ran_5to5 <- c(sample(-5:5, 100, replace = T))

# 4. Write an R program to get the first 9 Fibonacci numbers and put them
# into the vector,then put them into the matrix.
recurse_fibonacci <- function(n) {
  if(n <= 1) {
    return(n)
  } else {
    return(recurse_fibonacci(n-1) + recurse_fibonacci(n-2))
  }
}
nterms <- 9
#create list for store fibo from loop
fibo_list = list()
#create n terms fibo
for(i in 0:(nterms-1)) {
  fibo_list[i+1] <- c(recurse_fibonacci(i))
}
#convert list to vector
fibo_9 <- unlist(fibo_list)
fibo_matrix <- matrix(fibo_9)


# 5. Write an R program to print the numbers from 44 to 100 and print
# "Fizz" for multiples of 2, print "Buzz" for multiples of 3, and print
# "FizzBuzz" for multiples of both.
for (i in 44:100) {
  if (i %% 2 == 0 & i %% 3 == 0) {
    print(paste("i = ", i, " FizzBuzz"))
  } else if (i %% 2 == 0) {
    print(paste("i = ", i, " Fizz"))
  } else if (i %% 3 == 0) {
    print(paste("i = ", i, " Buzz"))
  } else {
    print(i)
  }
}

# 6. Write an R program to find the maximum and the minimum value of a
# given vector.
#create vector from random
vec_random <- c(runif(100, min = -5, max = 10))
vec_random_min <- min(vec_random)
vec_random_max <- max(vec_random)

# 7. Write an R program to create three vectors a,b,c with 3 integers.
# Combine the three vectors to become a 3×3 matrix where each column
# represents a vector. Print the content of the matrix.
#replace = F is Not random number repeate
a <- c(sample(1:20, 3, replace = F))
b <- c(sample(1:20, 3, replace = F))
c <- c(sample(1:20, 3, replace = F))
matrix_3_3 <- cbind(a, b, c)
print(matrix_3_3)


# 8. Write an R program to create a vector of random numbers in normal
# distribution and count occurrences of each value.
vector_normal_dis <- c(rnorm(50, mean = 5, sd = 2))
# vector_normal_dis <- c(sample(1:20, 50, replace = T))
count = list()
temp_vect_nor = list()
index = 0
isRepeate = F
for (i in vector_normal_dis) {
  print(i)
  if (index == 0) {
    index <- index + 1
    print("index = 1")
    temp_vect_nor[index] <- i
    count[index] <- 1
  } else {
    for (j in 1:index) {
        print(paste("j  = ", temp_vect_nor[j]))
        if (temp_vect_nor[j] == i) {
          count[j] <- as.numeric(count[j]) + 1
          isRepeate = T
        } 
    }
    if (!isRepeate) {
      index <- index + 1
      temp_vect_nor[index] <- i
      count[index] <- 1
    }
  }
  isRepeate = F
}
print(vector_normal_dis)

# 9. Write an R program to read the .csv file and display the content.
grades_set <- read.csv("C:\\cygwin64\\home\\AphiratNimanussonkul\\data-analysis\\grade_csv.csv", header = TRUE, sep = ",")
print(grades_set)

# 10. Write an R program to print row 2-3-4 of the .csv file.
#[row, col]
print(grades_set[2:4, ])
