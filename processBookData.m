
% Process data from 'booksummaries.txt' which is a tab separated file containing wikiId, 
% freebaseId, author, publish date, genres and plot summary.  This function parses this 
% file into a vectors/cell array for each column. The genre column is parsed and counted 
% and the top n genres are selected.  The Y matrix has a row per book and n columns 
% and is 1 or 0 coresponding to whether a book is considered the genre 
% at that index. For the input data, the word count (only counted once per book) of the 
% summary column is taken and the top m words are selected.  X then has a row per book 
% and m columns and is 1 or 0 corresponding to whether the plot summary contains that word.  
% Note that any books with no genres listed are removed.
function processBookData(genresCountMinimum, wordsCountMinimum)

	fprintf("\nLoading booksummaries.txt\n");
    fflush(stdout);
 	[wikiIdColumn freebaseIdColumn titleColumn authorColumn pubDateColumn genresColumn summaryColumn] = textread( 'booksummaries.txt', '%s %s %s %s %s %s %s' ,'delimiter' , "\t");
    save bookData.mat wikiIdColumn freebaseIdColumn titleColumn authorColumn pubDateColumn genresColumn summaryColumn;
    fprintf("\nProcessing genres column and using genres with a minimum count of %d\n", genresCountMinimum);
    fflush(stdout);
	genreCounts = getGenreCountsMapFromDataVector(genresColumn);
	genresToUse = generateGenresToUse(genreCounts, genresCountMinimum);
	genresByIndexPerBook = genresByIndexPerBook(genresColumn, genresToUse);
	save processedGenreData.mat genresToUse genresByIndexPerBook;

    fprintf("\nGenerating output data Y...\n");
    fflush(stdout);
	numberOfBooks = size(genresByIndexPerBook, 1);
	numberOfGenres = size(genresToUse, 1);
	Y_withEmpty = zeros(numberOfBooks, numberOfGenres);
	for i = 1 : numberOfBooks
		Y_withEmpty(i, genresByIndexPerBook{i}) = 1;
	end
	Y = Y_withEmpty(any(Y_withEmpty,2), :);
	save Y.mat Y Y_withEmpty;

    fprintf("\nProcessing word data from the plot summary column and minimum word count of %d\n", wordsCountMinimum);
    fflush(stdout);
	wordCountsMap = getWordCountsMapFromSummaryColumn(summaryColumn);
    [words wordsCount] = convertJavaMapToTwoVectors(wordCountsMap);
	words = words(find(wordsCount > wordsCountMinimum));
	wordIndicesByBook = getWordIndicesPerBook(summaryColumn, words);
	save processedWordsData.mat words wordIndicesByBook

    fprintf("\nGenerating input data X...\n.");
    fflush(stdout);
	numberOfWords = size(words, 1);
	X = zeros(numberOfBooks, numberOfWords);
	for i = 1 : numberOfBooks
		X(i, wordIndicesByBook{i}) = 1;
	end
	X = X(any(Y_withEmpty,2), :);
	save X.mat X;
%end