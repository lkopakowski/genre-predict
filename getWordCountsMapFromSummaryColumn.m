function wordCountsMap = getWordCountsMapFromSummaryColumn(summariesColumn)
% This function takes a cell array of plot summary strings and outputs a Java hash map where the key is the word
% and value is the number of books that word appeared in.
fprintf('\nGetting word counts from the plot summaries column...\n');

    wordCountsMap = javaObject("java.util.HashMap");
	numBooks = size(summariesColumn, 1);

	for i = 1 : numBooks
		fflush(stdout);
		summary = summariesColumn{i};
		summary = lower(summary); 
		fprintf('processing book %d\r', i);
		wordSet = javaObject("java.util.HashSet");

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
        
		iterator = wordSet.iterator;
		while iterator.hasNext
			word = iterator.next;
			if wordCountsMap.containsKey(word) == 1
   			 	wordCountsMap.put(word, wordCountsMap.get(word) + 1);
   			 else
   			 	wordCountsMap.put(word, 1);
   			 end
		end
	end
end