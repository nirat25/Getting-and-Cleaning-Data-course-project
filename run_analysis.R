#Using read.table and default " " separator read in all the required data

features <- read.table("~/R/Assignments/UCI HAR Dataset/features.txt")
activity_labels <- read.table("~/R/Assignments/UCI HAR Dataset/activity_labels.txt")

#Reading in Training dataset
Xtrain <- read.table("~/R/Assignments/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("~/R/Assignments/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("~/R/Assignments/UCI HAR Dataset/train/subject_train.txt")

#Reading in Test data set
Xtest <- read.table("~/R/Assignments/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("~/R/Assignments/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("~/R/Assignments/UCI HAR Dataset/test/subject_test.txt")

#Get column names for Xtrain and Xtest datasets
colnames <- features[,2]

#Clean up the variable/Column names by removing hyphen "-"
colnames <- gsub("-","",colnames)

#Assign the cleaned column names to Xtrain and Xtest
names(Xtest) <- colnames
names(Xtrain) <- colnames

#Merge all the training and test datasets using rbind 
Xmerged <- rbind(Xtrain,Xtest)
ymerged <- rbind(ytrain,ytest)
subjectmerged <- rbind(subject_train,subject_test)

#From the previosuly loaded data assign the column names to ...
#Activity labels and subject identifier

names(ymerged) <- c("activity")
names(subjectmerged) <- c("subject")

#Extract the columns with only mean and std measurements
Xsub <- Xmerged[,c(grep("mean()",names(Xmerged)),grep("std()",names(Xmerged)))]

#Assign appropriate labels to various activity numbers
ymerged$activity <- factor(ymerged$activity, levels = c(1,2,3,4,5,6), labels = activity_labels[,2])

#Get the complete dataset by using cbind to bind all the columns
Xcomplete <- cbind(Xsub,subjectmerged,ymerged)

#load reshape2 package
library(reshape2)

#Melt the complete dataset by subject and activity ...
#to perform functions on other variables
Xmelt <- melt(Xcomplete,id=c("subject","activity"))

#Get the final tidy dataset with mean for each variable by each activity and ...
#each subject
tidydataset <- dcast(Xmelt,subject+activity~variable,mean)

#Write the final tidy dataset out in a .txt file for easy distribution
write.table(tidydataset,"tidydata.txt",sep="\t")
