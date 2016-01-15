function genresByIndexPerBook = genresByIndexPerBook(genresColumn, genresToProcess)
% This function takes a cell array of genre data where each row corresponds to a book and is a comma separated
% list of id:genre pairs and a cell array of genres to process. For each book/row in genresColumn, the
% index of each genre is obtained and added to a cell array (where each row is a book) of arrays
% (where each entry is an index).  For example, a row of the cell array for a book with genres: 'fiction',
% science fiction' would be the array [1, 3] if 'fiction' was the first genre in genresToProcess and 'science
% fiction' was the third.

    fprintf('\nGenerating genre indices per book...\n', i);
	numBooks = size(genresColumn, 1);
	genresByIndexPerBook = cell(numBooks, 1);

	for i = 1 : numBooks
		fflush(stdout);
		genreList = genresColumn{i};
		genreList = lower(genreList); 
		fprintf('processing book %d\r', i);
    	genresPerBook = strsplit(genreList, ',');
    	if strcmp(genresPerBook{1}, '') == 1
     		 continue;
    	end

    	genreIndices = [];

        % TODO: deduplicate code from genreCountsMapFromDataVector
		for f = 1 : size(genresPerBook, 2)
      		genre = genresPerBook{f};

      		genre = strsplit(genre, ":"){2};
      		genre = strrep(genre, '"', '');
      		genre = strrep(genre, '}', '');
      		genre = strrep(genre, '{', '');
      		genre = strtrim(genre);

      		for k = 1 : length(genresToProcess)
      			if strcmp(genre, genresToProcess{k}) == 1
      				genreIndices = [genreIndices k];
      			end
      		end
		end
		genresByIndexPerBook{i} = genreIndices;
	end
end