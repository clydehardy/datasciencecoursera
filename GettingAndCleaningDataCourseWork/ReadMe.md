## run_analysis.R read me file

These are the steps that the run_analysis.R file performs to construct the tidy
data set and mirror the comments within the run_analysis.R file.

The script uses the "plyr" package and that will need to be installed if it has not
been already.

* The site where the data was obtained:                                              
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
This script assumes the data file
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
has been downloaded and extracted to a directory where only those data files exist.
If the working directory is not set to the folder containing the files
then the setwd() set the working directory. 

If the files do not exist then the script will display a message and exit

The directory paths are saved to variables
Then by changing to the relevant directories all the required files are loaded.

Using the features.txt file the column names are set on the xtest and xtrain data
frames.

The xtest & xtrain data frames are subsetted to only the columns containing the 
words "mean" and "std" by using the grep command

The script then joins on the activity labels to the ytest and ytrain data.

The raw data set is then created by joining the following data frames together, 
a column bind of subject test, the second column of ytest which is now the activity labels
from the previous step and the xtest data frame to complete the testdata data frame.
The same column bind is done for the train data of subject train, the second column of
ytrain and the xtrain data frame to complete the traindata data frame.
The testdata and traindata data frames are then row binded to create the raw data.

We then create the tidy data set by performing the mean (average) aggregate on all the 
data columns by activity and subject.

Further clean up is done by retrieving the column names and applying some formatting by 
substituting out redundant characters and applying Pascal casing to the names. Then lastly
"Mean-" is appended to the data columns to give a more descriptive name for the 
aggregation opperation that was performed on the data.
The cleaned up column names are then applied back on to the tidy data set.

Lastly the tidy data set is outputted to the file "TidyData.txt" using the write.table 
command.

In the same repository is the CodeBook.md that describes the variables in the tidy data set.