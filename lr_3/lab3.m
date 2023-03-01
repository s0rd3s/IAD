clc
close all
clear all

file = fopen('data11.txt');
X = fscanf(file, '%d', [8 inf])' % объекты и их 8 признаков
fclose(file);

X_mat = mean(X)
sredn_otkl = std(X);
N = size(X);
K = N(2);
N = N(1);

% нормировка входных данных для устранения неоднородности матожидания по столбцам
% матожидание становится нулевым во всех столбцах
X_norm = zeros(N, K);
for i = 1:N
    for j = 1:K
        X_norm(i,j) = (X(i,j) - X_mat(j))/sredn_otkl(j);
    end;
end;

% матрица ковариации, совпадает с корреляционной из-за нормализации, размерность КхК
R = (X_norm'*X_norm)/(N-1)

% проверка матрицы корреляции (берётся верхний трегольник без диагонали) на отличие от единичной
d = 0;
for i = 1:K
    for j = (i+1):K
        d = d + (R(i,j))^2;
    end;
end;
d = d*N % >x_kv тогда ок
x_kv = chi2inv(0.95, K*(K-1)/2)

[A, Lam] = eig(R); % A - собственные векторы, Lam - диагональная матрица с собственными значениями 
A = fliplr(A);
Lam = flipud(Lam); % чтобы по убыванию
Lam = fliplr(Lam);
Z = X_norm*A % проекции объектов на главные компоненты

% суммы дисперсий должны совпадать
sum_comp = sum(var(Z)) % сумма выборочных дисперсий проекций объектов на главные компоненты
sum_prizn = sum(var(X_norm)) % сумма выборочных дисперсий исходных признаков

otn_d_rasbr = var(Z) / sum_comp % относительная долю разброса, приходящаяся на главные компоненты
ariazia = cov(Z) % матрица ковариации для проекций объектов на главные компоненты

otn_d_rasbr_1_2 = otn_d_rasbr(1) + otn_d_rasbr(2); % относительная доля разброса для первых двух компонент

% размерность данных была 8, стала 2
% первые две компоненты выбраны по принципу наибольшего собственного значения, то есть наибольшей дисперсии
figure;
scatter(Z(:,1),Z(:,2), 35, 'filled');
title('Диаграмма рассеяния для первых двух компонент');
xlabel('Z1');
ylabel('Z2');
