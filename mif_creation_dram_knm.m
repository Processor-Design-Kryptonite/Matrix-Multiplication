clear;
clc;
close all;
k=2;
n=3;
m=3;

size1=k*n;
size2=n*m;

Original_Matrix1=randi(63,k,n);    %Create the original 8*8 matrix with 0-15 integers
Transpose_Matrix1=Original_Matrix1';                                          
vector1=Transpose_Matrix1(:);     %get the column vector

Original_Matrix2=randi(63,n,m);    %Create the original 8*8 matrix with 0-15 integers
Transpose_Matrix2=Original_Matrix2';                                          
vector2=Transpose_Matrix2(:);     %get the column vector

fid=fopen('D:\FPGA\Exe1.0\Design1.0\converted_data_knm1.mif','w');     %create and open the .mif file to be written
fprintf(fid,'WIDTH=16;\n');              %Defining word size
fprintf(fid,'DEPTH=256;\n');             %Defining memory depth
fprintf(fid,'ADDRESS_RADIX=UNS;\n');    %Write address type is unsigned integer
fprintf(fid,'DATA_RADIX=UNS;\n');       %write The input data type is unsigned integer
fprintf(fid,'CONTENT BEGIN\n');
fprintf(fid,'\t%d : %d;\n',0, k);
fprintf(fid,'\t%d : %d;\n',1, n);
fprintf(fid,'\t%d : %d;\n',2, m);
fprintf(fid,'\t%d : %d;\n',3, 0);
for i=0:size1-1                              %Starting content
    fprintf(fid,'\t%d : %d;\n',i+4, vector1(i+1));
end
for i=0:size2-1                              %Starting content
    fprintf(fid,'\t%d : %d;\n',i+size1+4, vector2(i+1));
end
fprintf(fid,'END;\n');
fclose(fid);                            %Close the file 