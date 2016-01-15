function genres = generateGenresToUse(map, threshold)
% Takes a map (genre as key, count as value) and threshold value and outputs a cell array of genres with counts
% greater than that threshold.
	iterator = map.entrySet.iterator;
	genres = cell(map.size, 1);
	i = 1;
	while iterator.hasNext == 1
		entry = iterator.next;
		key = entry.getKey;
		value = entry.getValue;

		if value > threshold
            genres{i} = key;
            i = i + 1;
            fprintf('\n Key: %s, Value: %d \n', key, value);
		end
		fflush(stdout);
	end

	genres = genres(~cellfun(@isempty, genres));
end