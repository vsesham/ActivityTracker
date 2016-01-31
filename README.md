**Introduction**

This assignment is aimed at creating a tidy dataset by using various data analysis, cleaning and merging techniques in R. Steps outlined here are in the order of functions used in run_analysis.R script. The output of this script is a csv file "tidyData.csv".

1.Reading train and test datasets using read.table() function

data <- read.table(file location, header=FALSE)

2.Merging test and train feature datasets, since there are equal no of variables, we are using rbind reading feature names. 

Ex: rrbind(...)

3.Assigning descriptive feature names to merged feature data

names(x) = dataset$columnname 

4.Reading activity test and train files

data <- read.table(file location, header=FALSE)

5.Merging test and train activities

rbind(...)

6.Reading activity labels

data <- read.table(file location, header=FALSE)

7.Assigning descriptive labels to merged activity data

factor(dataset$columnname, levels, labels)

8.Reading subject test and train datasets

read.table(file path, header=FALSE)

9.Merging test and train Subject data

rbind(...)

10.Getting feature names that only contain mean()-mean and std()-standard deviation

data <- grep("",dataset$columnname, value=T)

11.Subsetting merged data to get only featureSubset

subset(data, select)

12.Adding column Activity to filteredData dataset

data$columnname <- data

13.Adding column Subject t0 filteredData dataset

data$columnname <- data

14.Reordering columns so that Activiyt and Subject are 1st and 2nd columns in the dataset

subset(x, subset, select, ...)

15.Renaming first character t=Time and f=Frequency for column names

gsub(pattern, replacement, x, ignore.case = FALSE)

16.Getting mean of each variable group by Activity, Subject

aggregate(. ~ Species, data = iris, mean)

17.Sort the data by Subject, Activity

arrange(.data, ...)

18.Writing tidy data to csv file

write.csv(x, file = "foo.csv", row.names = FALSE)
