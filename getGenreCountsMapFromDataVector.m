function [genreMap] = getGenreCountsMapFromDataVector(genres)
% Takes a cell array of genres where each row is a comma separated list of id:genre pairs.
% This function strips out the genre (lowercase) string and adds it to a Java hash map that keeps a
% record of the number of times that genre has appeared.  The map with key: genre and
% value: count is returned.

    fprintf('\nParsing and counting genres...\n', i);
    genreMap = javaObject("java.util.HashMap");
    numBooks = size(genres, 1);

    for i = 1 : numBooks
        fflush(stdout);
        genreList = genres{i};
        genreList = lower(genreList); 
        fprintf('processing book %d\r', i);
        genresPerBook = strsplit(genreList, ',');

        if strcmp(genresPerBook{1}, '') == 1
            continue;
        end

        for f = 1 : size(genresPerBook, 2)
            genre = genresPerBook{f};

            genre = strsplit(genre, ":"){2};
            genre = strrep(genre, '"', '');
            genre = strrep(genre, '}', '');
            genre = strrep(genre, '{', '');
            genre = strtrim(genre);

             if genreMap.containsKey(genre) == 1
                newCount = genreMap.get(genre) + 1;
                genreMap.put(genre, newCount);
             else
                genreMap.put(genre, 1);
             end

        end
    end
end