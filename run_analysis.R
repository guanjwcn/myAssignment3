
library(dplyr)

# reading test sample
x_test <- read.csv("./UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = ""); dim(x_test) # 2947x561
y_test <- read.csv("./UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "", col.names="Activity_ID",colClasses="factor"); dim(y_test) # 2947x1
subject_test <- read.csv("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "", col.names="Subject_ID",colClasses="factor"); dim(subject_test) # 2947x1

# reading training sample
x_train <- read.csv("./UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = ""); dim(x_train) # 7352x561
y_train <- read.csv("./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "", col.names="Activity_ID",colClasses="factor"); dim(y_train) # 7352x1
subject_train <- read.csv("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "", col.names="Subject_ID",colClasses="factor"); dim(subject_train) # 7352x1

# combining test and traning samples
x <- rbind(x_test, x_train); dim(x) # 10299x561
y <- rbind(y_test, y_train); dim(y) # 10299x1
subject <- rbind(subject_test,subject_train); dim(subject) # 10299x1

# reading features
features <- read.csv("./UCI HAR Dataset/features.txt", header = FALSE, sep = "")
feature_names <- as.character(unlist(features$V2))

# extracting x with measurement of mean and std
names(x) <- feature_names
position <- feature_names[grepl("-mean\\(\\)", feature_names) | grepl("-std\\(\\)", feature_names)]
y <- mutate(y,Activity_Desc=factor(y$Activity_ID, labels =  c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")))
xy <- cbind(subject,Activity_Desc=y$Activity_Desc, x)
xy_analysis <- xy[,c("Subject_ID","Activity_Desc",position)]

#creating tidy data set with the average of each variable
xy_tidy <- xy_analysis %>% group_by(Subject_ID,Activity_Desc) %>% 
  summarise_at(vars(position),funs(mean))

#save tidy dataset
write.table(xy_tidy,"TidyData.txt")

#creating code book
xy_var <- names(xy_tidy)
xy_mean <- c("NA","NA",paste(sapply(xy_tidy[,position],mean)))
xy_units <- c(length(unique(xy_tidy$Subject_ID)), length(unique(xy_tidy$Activity_Desc)),rep(dim(xy_analysis)[1],length(xy_var)-2))
write.table(cbind(xy_var,xy_mean,xy_units),"codebook.md", sep = "|", row.names=FALSE,col.names = c("Variables", "Mean", "Units"))


