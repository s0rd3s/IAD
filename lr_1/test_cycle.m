clc
close all
clear all

n=5; % Количество строк
m=10; % Количество столбцов
% Формируем нулевую матрицу Q размером n x m
Q = zeros(n,m);
% В цикле заполняем матрицу Q новыми значениями
for k = 1:n
for j = 1:m
Q(k,j) = round(10*rand);
end
end
disp(Q);

sum = 0;
for k = 1:n
    for j = 1:m
        sum = sum + Q(k,j);
    end
end
sum