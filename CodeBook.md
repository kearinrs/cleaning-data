The script run_analysis.Rperforms the 5 steps described in the course project's definition.

  plyr package is used to allow large datasets to be dplit up into manageable parts, altered by a function and then merged back together
  Cbind was used to combine all the training data and the test data into two combined variables. This was after all the datasests were read into R.
  Cbind() combines objects by columns
  Rbind was then used to combine the new training and test data variables to be within one variable. This allowed for the easier extraction of the standard deviation and mean.
  Rbind() combines objects by rows 
  Every coloumn was assigned a descriptive label using rbind and the features dataset
  Then, only those columns with the mean and standard deviation measures are extraced from the whole dataset. 
  Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called averages_data.txt, and uploaded to this repository.

  

 

Variables

    X_train, y_train, X_test, y_test, subject_train and subject_test contain the data from the downloaded files.
    x_data, y_data and subject_data merge the previous datasets to further analysis.
    features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
    A similar approach is taken with activity names through the activities variable.
    all_data merges x_data, y_data and subject_data in a big dataset.
    Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.

activities:

    WALKING (value 1): subject was walking during the test
    WALKING_UPSTAIRS (value 2): subject was walking up a staircase during the test
    WALKING_DOWNSTAIRS (value 3): subject was walking down a staircase during the test
    SITTING (value 4): subject was sitting during the test
    STANDING (value 5): subject was standing during the test
    LAYING (value 6): subject was laying down during the test
