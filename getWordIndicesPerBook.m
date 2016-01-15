function wordIndicesByBook = getWordIndicesPerBook(summaryColumn, wordsToProcess)
% This function takes a cell array of plot summary strings and a cell array of words to process. For each book/
% row in summaryColumn, the
% index of each word is obtained and added to a cell array (where each row is a book) of arrays
% (where each entry is an index for the word).  For example, a row of the cell array for a book with summary:
% 'this is a book' would be the array [1, 10, 4, 2] if 'this' was the first word in wordsToProcess and 'is' was
% the 10th etc..
	fprintf('\nGenerating word indices per book...\n');
	wordMap = javaObject("java.util.HashMap");
	
	wordIndexLookup = javaObject("java.util.HashMap");
	for p = 1 : length(wordsToProcess)
		wordIndexLookup.put(wordsToProcess{p}, p);
	end

	numBooks = size(summaryColumn, 1);
	wordIndicesByBook = cell(numBooks, 1);
	%wordMap = struct();
	for i = 1 : numBooks

		summary = summaryColumn{i};
		summary = lower(summary); 
		fprintf('processing book %d\r', i);
		fflush(stdout);
		wordSet = javaObject("java.util.HashSet");
		%wordSet = struct();
		while ~isempty(summary)

			[str, summary] = ...
       			strtok(summary, ...
              	[' .,''">_<;%']);

      	    % Remove any non alphanumeric characters
    		str = regexprep(str, '[^a-zA-Z0-9]', '');
      		str = strtrim(str);

            try str = porterStemmer(strtrim(str)); 
    		catch str = ''; continue;
    		end;

    		 % Skip the word if it is too short
    		 if length(str) < 1
       			continue;
   			 end

    		
   			 wordSet.add(str);
		end

		wordIndices = [];
		iterator = wordSet.iterator;
		while iterator.hasNext
			word = iterator.next;
			if wordIndexLookup.containsKey(word)
				index = wordIndexLookup.get(word);
				wordIndices = [wordIndices index];
			end
		end
		wordIndicesByBook{i} = wordIndices;
	end

end