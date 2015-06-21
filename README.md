The script run_analysis.R reads files from the "Human Activity Recognition Using Smartphones" research, extracts measurements of means and standard deviations only, and combines them into a final tidy data set averaging the measurements by subject-activity pairs.

There are three types of data files in the data set, and each has a test version and a training version.

The measurement files (X) contain the data captured by the study. A feature vector (features) indicates the variables associated with each measurement.

The activities files (y) indicate which activity (walking, sitting, etc) is associated with each measurement.

The subject files (subject) indicate which subject is associated with each measurement.

First the script reads the feature vector and the measurement files, using the feature vector to assign column names. The test and training files are combined into one measurement data frame.

Next, the script reads the activities files, and combines the data into one activities vector, labled "Activity". The activity_labels file is also read and converted to a vector which is used to replace the levels in the activities file with descriptive labels.

Next, the script reads the subject files, and combines the data into one subject vector, labeled "Subject"

Before combining the measurement dataframe with the activity and subject vectors, it is necessary to extract only those variables that correspond to the mean and standard variation of the various measurement variables. From inspecting the features vector, it is apparent that these variables include the pattern "mean()" or "std()" in their variable names.  Using grepl, these variables are identified and used to construct a vector that in turn is used to select the proper columns from the measurement data frame.

As a final step, the resulting condensed data frame is combined with the subject and activity vectors, and then melted and cast to yield the final tidy data set, "finalcast".