##MERGE TRAINING AND TEST SETS

##combine measurements (variables) into one file

feature_vector <- features[,2]

testvars <- read.table("./test/X_test.txt", sep="", col.names=feature_vector)

trainvars <- read.table("./train/X_train.txt", sep="", col.names=feature_vector)

combovars <- rbind(testvars,trainvars)

##combine activities into one file and give them good names - not done, trying to
##figure out how to name the activities

testactivities <- read.table("./test/y_test.txt", col.names="Activity")

trainactivities <- read.table("./train/y_train.txt", col.names="Activity")

comboactivities <- rbind(testactivities, trainactivities)

activitylabels <- read.table("./activity_labels.txt")

activityvector <- activitylabels[,2]

comboactivities$Activity <- factor(comboactivities$Activity, levels = c(1,2,3,4,5,6),
                                   labels = activityvector)

##combine subjects into one file

testsubjects <- read.table("./test/subject_test.txt", col.names="Subject")

trainsubjects <- read.table("./train/subject_train.txt", col.names="Subject")

combosubjects <- rbind(testsubjects, trainsubjects)

##extract means and std, which are the first 2 out of 17 measurements of each variable

## first, define a measurement vector to identify which columns to extract

mean_pattern <- "mean()"
std_pattern <- "std()"

##below - go through feature_vector; if pattern matches element (using grepl), then add that index
##to mean_std_vector (using append)

mean_std_vector <- c()

for(i in 1:length(feature_vector)){
        if((grepl(mean_pattern,feature_vector[i]) | grepl(std_pattern,feature_vector[i]))){
                mean_std_vector <- append(mean_std_vector,i, after = length(mean_std_vector))
        }
}

library(dplyr)

means_and_stds <- select(combovars, mean_std_vector)

final_set <- cbind(combosubjects, comboactivities, means_and_stds)

finalmelt <- melt(final_set, id=c("Subject", "Activity"), measure.vars=colvector)

finalcast <- dcast(finalmelt, Subject + Activity ~ variable, mean)