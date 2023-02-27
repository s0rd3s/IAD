clear all
clc
n=5; % Количество строк
m=5; % Количество столбцов
sum=0;
% Формируем нулевую матрицу Q размером n x m
A = zeros(n,m);
% В цикле заполняем матрицу Q новыми значениями
for k = 1:n
 for j = 1:m
 A(k,j) = round(5*rand);
 end
end
disp(A)
for i = 1:size(A, 1)
      for j = 1:size(A, 2)
            if mod(i, 2) == 0 && mod(j, 2) == 0
                sum = sum + A(i, j);
            end
      end
end

sum2 = 0;
    % Используем два вложенных цикла для прохода по всем элементам матрицы
    for i = 1:size(A, 1)
        for j = 1:size(A, 2)
            % Добавляем значение текущего элемента к сумме
            sum2 = sum2 + A(i,j);
        end
    end
disp("Сумма элементов с четными индексами: " + sum);
disp("Сумма всех элементов: " + sum2);
