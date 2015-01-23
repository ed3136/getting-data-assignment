# Directory /UCI HAR Dataset/ incluing subdirectory should be in the working directory

#####Step 1 : read data and merge 
#read measurement column name
cname <- read.table ("./UCI HAR Dataset/features.txt")

#read test data +Cbind together
test_data<- read.table("./UCI HAR Dataset/test/X_test.txt",
                      sep="")
test_activity<- read.table("./UCI HAR Dataset/test/Y_test.txt")
test_subject<- read.table("./UCI HAR Dataset/test/subject_test.txt")
test <- cbind( test_subject, test_activity, test_data)

#read train data + Cbind together
train_data<- read.table("./UCI HAR Dataset/train/X_train.txt",
                        sep="")
train_activity<- read.table("./UCI HAR Dataset/train/Y_train.txt")
train_subject<- read.table("./UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train_subject, train_activity,train_data )
#merge test+train
TT <- rbind(test,train)

##### Step 2: Extract mean & SD
### Step 4: Add variables column names
cnameV <- as.character(cname[,2])
cnameV2 <- c("subject","activity",cnameV)
colnames(TT) <- cnameV2
#Extract "subject|activity|mean|std" columns ignore.case +subject,activity
data<- TT[,grepl("subject|activity|std|mean", cnameV2, ignore.case=TRUE)]

##### Step3 +descriptive activity names 
#read activiy name
aname <- read.table ("./UCI HAR Dataset/activity_labels.txt")
anameV <- as.character(aname[,2])
data$subject<- as.factor(data$subject)
data$activity <- factor(data$activity, labels=anameV)

##### Step5: Creat 2nd data set 
result<- aggregate( . ~ subject+activity, data, mean)
#order by subject
result2<-result[order(result$subject),]
#write to .txt
write.table(result2, file="average_data.txt", row.name=FALSE)

 
