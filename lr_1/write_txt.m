clc;
clear all;
close all;

x = 0 : 0.1 : 5; 
y = 2*x.^2 + x - 1; 
M = [x; y]; 
% Формирование заголовка данных 
str='Значения функции y = 2*x^2 + x - 1';
% Открытие файла с идентификатором fid для записи
fid = fopen('MyFile.txt','wt'); 
% Запись заголовок данных
fprintf(fid,'%s\n',str);
% Запись данных (матрица M) в файл в формате действительных чисел
fprintf(fid,'%6.2f %12.8f\n',M); 
% Закрытие файла с идентификатором fid
fclose(fid); 


