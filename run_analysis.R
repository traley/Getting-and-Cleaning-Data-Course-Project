##After dataset has been downloaded to working directory.

##Combine the data from Training and Test sets into a single data set
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

subject_test <- read.table("test/subject_test.txt")
  
x_data <- rbind(x_train, x_test)

y_data <- rbind(y_train, y_test)

subject_data <- rbind(subject_train, subject_test)

##Collect mean and SD for each test 

features <- read.table("features.txt")
 
mean_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
 
x_data <- x_data[, mean_std_features]

names(x_data) <- features[mean_std_features, 2]

activities <- read.table("activity_labels.txt")

y_data[, 1] <- activities[y_data[, 1], 2]
 
names(y_data) <- "activity"

##Change the Column names 
names(subject_data) <- "subject"
 
all_data <- cbind(x_data, y_data, subject_data)
 
library(plyr)
 
average_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

##Send output to a text file
 
write.table(average_data, "average_data_variable.txt", row.names=FALSE)

