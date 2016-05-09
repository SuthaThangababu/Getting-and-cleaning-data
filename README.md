# Getting-and-cleaning-data

This project has a R-Script, run_analysis.R. The purpose of this R-Script are as below.

- Download the dataset.
- Load the activity labels along with the feature information.
- Extracts the data only on mean and standard deviation
- Loads the activity and subject data for each dataset, and merges those columns with the dataset
- Merges the datasets and labels
- Converts the activity and subject columns into factors
- Creates a tidy dataset. This dataset will have value of each variable for each subject and activity pair.
- The final output is saved in a file.
- Can check the tidy resultset in the file named - tidy.txt
