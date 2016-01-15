function outputMap = printMapContents(map)
	iterator = map.entrySet.iterator;
	outputMap = cell(map.size, 1);
	i = 1;
	while iterator.hasNext == 1
		entry = iterator.next;
		key = entry.getKey;
		value = entry.getValue;

		if value > 30
		outputMap{i} = key;
		i = i + 1;
		fprintf('\n Key: %s, Value: %d \n', key, value);
		end
		fflush(stdout);
	end

	outputMap = outputMap(~cellfun(@isempty, outputMap));
end