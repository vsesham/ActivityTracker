# ***********************************************
# This scripts performs the following operations
# Merges training and test datasets for features, activities and subjects
# Substitutes abbreviated names with descriptive names for activities & variables
# Creates a subset of dataset with only mean and standard deviation values
# Creates a tidy dataset with the average of each variable grouped by activity and subject
# ***********************************************
# loading libraries
library(dplyr)
library(data.table)

# reading train and test datasets
dataFeatTest <- read.table("/Users/vinaysesham/Documents/datasciencecoursera/ActivityTracker/UCIHARDataset/test/X_test.txt", header=FALSE)
dataFeatTrain <- read.table("/Users/vinaysesham/Documents/datasciencecoursera/ActivityTracker/UCIHARDataset/train/X_train.txt", header=FALSE)

# merging test and train feature datasets
mergedData <- rbind(dataFeatTest, dataFeatTrain) # since there are equal no of variables, we are using rbind
# reading feature names
dataFeatureNames <- read.table("/Users/vinaysesham/Documents/datasciencecoursera/ActivityTracker/UCIHARDataset/features.txt")
# assigning descriptive feature names to merged feature data
names(mergedData) <- dataFeatureNames$V2 #assigning feature names to merged data

# reading activity test and train files

activityTest <- read.table("/Users/vinaysesham/Documents/datasciencecoursera/ActivityTracker/UCIHARDataset/test/y_test.txt", header=FALSE)
activityTrain <- read.table("/Users/vinaysesham/Documents/datasciencecoursera/ActivityTracker/UCIHARDataset/train/y_train.txt", header=FALSE)

# merging test and train activities

mergedActivity <- rbind(activityTest, activityTrain)

# reading activity labels
activityLabels <- read.table("/Users/vinaysesham/Documents/datasciencecoursera/ActivityTracker/UCIHARDataset/activity_labels.txt", header=FALSE)
# assigning descriptive labels to merged activity data
mergedActivity <- factor(mergedActivity$V1, levels=activityLabels$V1, labels=activityLabels$V2)

# reading subject test and train datasets
subjectTest <- read.table("/Users/vinaysesham/Documents/datasciencecoursera/ActivityTracker/UCIHARDataset/test/subject_test.txt",header=FALSE)
subjectTrain <- read.table("/Users/vinaysesham/Documents/datasciencecoursera/ActivityTracker/UCIHARDataset/train/subject_train.txt",header=FALSE)

# merging test and train Subject data
mergedSubject <- rbind(subjectTest, subjectTrain)
names(mergedSubject) <- c("Subject")

# getting feature names that only contain mean()-mean and std()-standard deviation

featureSubset <- grep("\\mean\\(\\)|std\\(\\)",dataFeatureNames$V2, value = T)

# subsetting merged data to get only featureSubset

filteredData <- subset(mergedData, select=featureSubset)

# Adding column Activity to filteredData dataset

filteredData$Activity <- mergedActivity

# Adding column Subject t0 filteredData dataset

filteredData$Subject <- mergedSubject$Subject

# ordering columns so that Activiyt and Subject are 1st and 2nd columns in the dataset

filteredDataOrdered <- subset(filteredData,select=c(67, 68, 1:66))

# renaming first character t=Time and f=Frequency for column names

names(filteredDataOrdered) <- gsub("^[tT]", "Time", names(filteredDataOrdered),ignore.case=T)

names(filteredDataOrdered) <- gsub("^[fF]", "Frequency", names(filteredDataOrdered),ignore.case=T)

# getting mean of each variable group by Activity, Subject

meanOffilteredDataOrdered <- aggregate(. ~ Activity + Subject, filteredDataOrdered, mean)

# sort the data by Subject, Activity

tidyData <- arrange(meanOffilteredDataOrdered, Subject, Activity)

# Writing tidy data to csv file

write.table(tidyData,file="/Users/vinaysesham/Documents/datasciencecoursera/ActivityTracker/tidyData.txt",row.names=FALSE)






