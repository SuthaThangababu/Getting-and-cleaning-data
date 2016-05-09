library(reshape2)

filename <- "getdata_dataset.zip"

if (!file.exists(filename)){
  
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename,mode='wb')
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
# Load activity labels + features
my_activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
my_activity_labels[,2] <- as.character(my_activity_labels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
my_features<- grep(".*mean.*|.*std.*", features[,2])
my_features.names <- features[my_features,2]
my_features.names = gsub('-mean', 'Mean', my_features.names)
my_features.names = gsub('-std', 'Std', my_features.names)
my_features.names <- gsub('[-()]', '', my_features.names)


# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[my_features]
my_train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
my_train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(my_train_subjects, my_train_activities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[my_features]
my_test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
my_test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(my_test_subjects, my_test_activities, test)

# merge datasets and add labels
complete_data <- rbind(train, test)
colnames(complete_data) <- c("subject", "activity", my_features.names)

# turn activities & subjects into factors
complete_data$activity <- factor(complete_data$activity, levels = my_activity_labels[,1], labels = my_activity_labels[,2])
complete_data$subject <- as.factor(complete_data$subject)

complete_data.melted <- melt(complete_data, id = c("subject", "activity"))
complete_data.mean <- dcast(complete_data.melted, subject + activity ~ variable, mean)

write.table(complete_data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
