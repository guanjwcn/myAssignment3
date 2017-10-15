Data Source:

The data used in this anlaysis can be downloaded from here:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. Upon downloading, the data folder is supposed to put in current working directory. The folder structure is expected as follows:
.\UCI HAR Dataset
	.\test
	.\train
	.\activity_labels.txt
	.\features.txt
	.\features_info.txt
	.\README.txt

Libraries required by run_analysis.R:

The r_analysis code requires the library of dplyr. Make sure the library is installed properly before running the program.

Structure of run_analysis.R:

Run_analysis.R consists of the following main parts:
* reading in the test and training data sets: x, y, subject
* combining the test and training data sets: x, y, subject
* reading features and assigning column names to combined x based on features
* merging x, y, subject, and activity labels
* extracting data elements with mean and std, i.e., column names contain "-mean()" and "-std()". In this regard, column names with keywords, e.g., "-Freqmean()", will not be extracted.
* Performing summarize analysis
* output tidy_data
* a short code in the end creating the code book


