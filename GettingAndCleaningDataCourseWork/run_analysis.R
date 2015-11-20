library(plyr)
##This script assumes the data file
##https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##has been downloaded and extracted to a directory where only those data files exist.
##If the working directory is not set to the folder containing the files
##then please paste the path in the setwd() command below and uncomment the line
##setwd("Please paste directory path to files here")

#if the files do not exist then the script will display a message and exit
if(!file.exists("activity_labels.txt")
   && !file.exists("features.txt")
   && !file.exists("./test")
   && !file.exists("./train")){
  stop("The files required for script do not exist or the working directory has not been set.")
}

##set the directory variables
curwd <- getwd()
traind <- paste(curwd,"/train",sep="")
testd <- paste(curwd,"/test",sep="")

##Load all the required files
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")
setwd(traind)
subject_train <- read.table("subject_train.txt")
xtrain <- read.table("X_train.txt")
ytrain <- read.table("y_train.txt")

setwd(testd)
subject_test <- read.table("subject_test.txt")
xtest <- read.table("X_test.txt")
ytest <- read.table("y_test.txt")

##set the column names of the test data
colnames(xtest) <- features[,2]
colnames(xtrain) <- features[,2]

##filter down xtest & xtrain to mean & std cols only
xtest <- xtest[,grep("mean|std",colnames(xtest))]
xtrain <- xtrain[,grep("mean|std",colnames(xtrain))]

##add on the activity labels
ytest <- join(ytest,activity_labels,by="V1")
ytrain <- join(ytrain,activity_labels,by="V1")

## Merge the training and the test sets to create one data set
testdata <- cbind(subject_test,"activity" = ytest[,2],xtest)
traindata <- cbind(subject_train,"activity" = ytrain[,2],xtrain)
rawdata <- rbind(testdata,traindata)

##Create the tidy data set
tidydata <- aggregate(rawdata[,-c(1,2)],by = list("Subject" = rawdata$V1,"Activity" = rawdata$activity),FUN = mean)

##Get the names of the columns to clean up
tdnames <- names(tidydata)

##Substitute out redundant characters and apply Pascal casing
tdnames <- sub("-std.(.)","Std",sub("-mean.(.)","Mean",tdnames))
##Add a descriptive prefix to the column name
tdnames[3:length(tdnames)] <- paste("Mean-",tdnames[3:length(tdnames)],sep="")
##Put the column names back
colnames(tidydata) <- tdnames

##Output the tidy data
setwd(curwd)
write.table(tidydata,file="TidyData.txt",row.name=FALSE)
