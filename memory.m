% The line below is the original
% call one would use
% for opening the file
% fid=fopen('mydata.dat','r');

% Instead, open a "memory file"
fid=mfile('memory.mem');

% Read some integer values, 4 ints
% at a time, skipping 32 bytes in
% between and storing the data in
% int32 format
val1=fread(fid,10,...
'4*int32=>int32',32);
% Go 16 bytes from the beginning of
% the file
fseek(fid,16,'bof');
% Read some float32 values, 8 floats
% at a time, skipping 32 bytes in
% between and storing the data in
% double format
val2=fread(fid,8,'single=>double');