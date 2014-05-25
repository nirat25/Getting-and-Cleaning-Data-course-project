### READ ME

This document describes the process for transforming the activity data gathered from Samsung Galaxy S2 phones into a tidy dataset which can be used for further downstream analysis.

This document serves as code book too. The code book section is described later.

Follow these steps to get tidy data from the collected data obtained from UCI machine learning repository.

1. Download the data from UCI repository and unzip it in the working directory.

2. The folder UCI HAR Dataset should appear in the working directory .

3. Since the data has lots of variables like accelaration mean, standard deviation, max etc. and there are 30 subjects performing 6 activities we are most interested in the mean and standard deviation variables.

4.The tidy data should be such that for each subject and each activity we should have average of all the mean and standard deviation variables. This means 180 rows of all the variables (in this case 81).

5. Following steps explain the working of code to get tidy data:
        - Read in the features.txt and activity_labels.txt for column names of test and train data and to translate activity from code to labels.
        - Now read in the training data which is X_train.txt, y_train.txt, subject_train.txt
        - Similarly read in the test data X_test.txt, y_test.txt, subject_test.txt
        - Merge the X_train and X_test data, y_train and y_test data, subject_test and subject_train data using rbind
        - Since we are only interested in mean() and std() use grep and extract the columns having "mean()" and "std()" from the merged X dataset.
        - Assign proper column names for all the datasets using the label files read in before
        - Using factors translate activity code into activity labels
        - For proper variable names remove"-" from the column names in the final combined dataset
        - finally using reshape2 package functions melt and dcast create a tidy dataset with average of each variable for each subject and each activity
        -Write tidy dataset out in a .txt file

All the above steps are done in run_analysis.R file

Variables:

The variables in the dataset come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

From these we selected the variables with mean() and std().

So now we have:

tBodyAccXYZ
tGravityAccXYZ
tBodyAccJerkXYZ
tBodyGyroXYZ
tBodyGyroJerkXYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAccXYZ
fBodyAccJerkXYZ
fBodyGyroXYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

variables with 

mean(): Mean value
std(): Standard deviation

for each subject coded from 1 to 30 and each activity.

##FINAL TIDY DATASET

The tidy dataset will have first two columns of $subject and $activity and the remaining columns with the average of the variables which are mentioned above i.e. 79 columns

