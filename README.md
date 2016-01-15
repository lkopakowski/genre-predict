# genre-predict
##Summary
Machine Learning algorithm used to predict a book's genre from its plot summary


##Goal
To predict a book's genre using its plot summary.

##Language
Octave

##Model
Use logistic regression with the following properties:

    - **Input** A vector of 1's and 0's corresponding to whether a book contains the word at that index from an array of words. The list of words is obtained by getting a count of words that appear in the set of books (once per book).  A subset of words is selected by choosing all words with counts over a specified threshold.

    - **Output** A vector of decimal values between 0 and 1 denoting the probability that a book is the genre at that index from a list of genres. The list of genres is obtained by getting a count of genres that appear in the set of books.  A subset of genres is selected by choosing all genres with counts over a specified threshold.

##Neural Network Model
My neural network model but was performing poorly as measured by recall and precision.  I decided to simplify things to see if I could get decent performance from logistic regression.  However, the code remains for neural network in trainNeuralNetwork.m

##Usage:
    1. Open octave
    2. (optional)* Run processBookData(genresCountMinimum, wordsCountMinimum) where genresCountMinimum is the count cutoff for which genres will be used in the output and wordsCountMinimum is the count cutoff for which words will be used to train and run the model.  I suggest using something betwen 30 and 100 for both.
    3. (optional) Run runLR
    4. Paste a plot summary in yourPlotSummary.txt (or use the one provided, Harry Potter book 1)
    5. Run predictGenreFromSummary and see the predicted genres in the output
    
    **Note**: Processing the data can take a while so instead of running processBook Data, you can use the data that has already been processed and stored in the *.mat files and start with step 3.  Also, I haven't uploaded the porter stemmer I'm using as I'm unclear bout the distribution rights I have to Coursera content.  I will need to find a different one or implement my own in the future.  If you use the data already processed in .mat files, this won't be a problem.  If you use reprocess the data, then the model probably won't work as well because the words won't be stemmed.

##Notes:
    This is an ongoing project and it needs quite a bit of work.  

##Analysis:
The F-measure seems pretty low, around 60% when I use a threshold for word counts and genre counts of 40 and the optimized lambda and probability thresholds computed by the program.  

##Possible areas of improvement:
    - Try using more or less words as input
    - Prune unused inputs (with low weights)
    - Create more debugging and intermediate verification to make sure the model is running as expected
    - Make output more readable and user friendly

##Possible Data Issues:
It's unclear how standardized the genre classifications and plot summaries are.  It's possible that the data isn't precise enough to train this type of model. 


##Tech Debt TO DOs:
- Speed up book processing algorithms
- Clean up code and add more documentation/comments
- Implement my own porter stemmer or find one online
- Organize files better

**Note**: Some of this code was taken from the Coursera Machine Learning course assignments. I have tried not to use any functions that I did not implement which is why the porterStemmer.m file is empty.  The fmincg.m file is included since it appears to be distributable based on the comments.