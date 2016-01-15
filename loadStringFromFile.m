function contentsString = loadStringFromFile(file)
% Opens a file and returns its contents as a string.
fid = fopen(file);
if fid
    contentsString = fscanf(fid, '%c', inf);
    fclose(fid);
else
    contentsString = '';
    fprintf('Error opening file %s\n', file);
end

end


