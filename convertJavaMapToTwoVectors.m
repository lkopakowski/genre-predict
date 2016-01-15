function [x y] = convertJavaMapToTwoVectors(map)
% Converts a java map to two vectors.
    iterator = map.entrySet.iterator;
	i = 1;
	x = cell(map.size, 1);
	y = zeros(map.size, 1);
    for i = 1 : map.size
		entry = iterator.next;
        x{i} = entry.getKey;
        y(i) = entry.getValue;
	end
end