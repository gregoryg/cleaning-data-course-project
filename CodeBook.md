# Data set
  The data set created by run_analysis.R contains the mean and standard deviations fields
  from the Human Activity Recognition Using Smartphones Dataset, summarized by activity
  and subject.  

# Code book for source data

The code book for the source data set can be found at the following site

<https://github.com/gregoryg/cleaning-data-course-project>

# Description of methodology and types of measurementsa

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six
activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant
rate of 50Hz. The experiments have been video-recorded to label the
data manually. The obtained dataset has been randomly partitioned into
two sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by
applying noise filters and then sampled in fixed-width sliding windows
of 2.56 sec and 50% overlap (128 readings/window). The sensor
acceleration signal, which has gravitational and body motion
components, was separated using a Butterworth low-pass filter into
body acceleration and gravity. The gravitational force is assumed to
have only low frequency components, therefore a filter with 0.3 Hz
cutoff frequency was used. From each window, a vector of features was
obtained by calculating variables from the time and frequency
domain. 


# Variables (columns)
## subject is an identifier; a factor in the range 1:30 inclusive
## activity is a factor in the range 1-6
   1. WALKING
   2. WALKING_UPSTAIRS
   3. WALKING_DOWNSTAIRS
   4. SITTING
   5. STANDING
   6. LAYING

## Columns 3-81 Summarized mean and standard deviation from accelerometer and gyroscope measurements
