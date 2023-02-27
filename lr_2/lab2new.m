clc
close all
clear all

file = fopen('data11.txt');
array = fscanf(file, '%f', [3 inf])';
fclose(file);
N = size(array);
N = N(1)
x = array(:, 1);
y = array(:, 2);

figure;
plot(x, y);
hold on;
grid on;
title('y(x)')
xlabel('x')
ylabel('y')

disp('1 - Показательный, 2 - Хи квадрат, 3 - Бета');

q1 = [1 1]; %начальное приближение
res1 = nlinfit(x, y, @pokazatelny, q1);
f1 = pokazatelny(res1, x);
disp('Показательный');
disp(res1);

q2 = 2;
res2 = nlinfit(x, y, @hihi, q2);
f2 = hihi(res2, x);
disp('ХиХи');
disp(res2);

q3 = [0.14 0.35];
res3 = nlinfit(x, y, @beta, q3);
f3 = beta(res3, x);
disp('Бета');
disp(res3);

plot(x, f1, 'k');
plot(x, f2, 'g');
plot(x, f3, 'm');

% u1, u2, u3 - степени свободы
u1 = N - 2 - 1;   %N - число параметров - 1
u2 = N - 1 - 1;
u3 = N - 2 - 1;
x_kv_1 = 0;
x_kv_2 = 0;
x_kv_3 = 0;

figure;
plot(x, y);
hold on;
grid on;
plot(x, f3, 'm');
title('Наилучшая аппроксимация Бета-функцией')
xlabel('x')
ylabel('y')

%среднеквадратическое отклонение
sygm = array(:,3);

% сумма квадратов отклонений значений
for i = 1:N
    x_kv_1 = x_kv_1 + ((f1(i) - y(i))/sygm(i))^2;
    x_kv_2 = x_kv_2 + ((f2(i) - y(i))/sygm(i))^2;
    x_kv_3 = x_kv_3 + ((f3(i) - y(i))/sygm(i))^2;
end;

% нормировка
x_kv_1 = x_kv_1/u1
x_kv_2 = x_kv_2/u2
x_kv_3 = x_kv_3/u3

% взвешенные остатки
R1 = zeros(1, N);
R2 = zeros(1, N);
R3 = zeros(1, N);

for i = 1:N
    R1(i) = (y(i) - f1(i))/sygm(i);
    R2(i) = (y(i) - f2(i))/sygm(i);
    R3(i) = (y(i) - f3(i))/sygm(i);
end;
figure;
plot(R1);
title('Взвешенные остатки 1');
figure;
plot(R2);
title('Взвешенные остатки 2');
figure;
plot(R3);
title('Взвешенные остатки 3');


[res3, r, J, covb] = nlinfit(x, y, @beta, q3);

% автокорреляционная функция взвешенных остатков
A1 = zeros(N/2);
A2 = zeros(N/2);
A3 = zeros(N/2);

for k = 1:(N/2)
    S1 = 0;
    for i = 1:(N-k+1)
        S1 = S1 + R1(i)*R1(i+k-1);
    end;
    S2 = 0;
    for i = 1:N
        S2 = S2 + (R1(i))^2;
    end;
    S2 = S2/N;
    A1(k) = (1/(N-k+1))*S1/S2;
    
    S1 = 0;
    for i = 1:(N-k+1)
        S1 = S1 + R2(i)*R2(i+k-1);
    end;
    S2 = 0;
    for i = 1:N
        S2 = S2 + (R2(i))^2;
    end;
    S2 = S2/N;
    A2(k) = (1/(N-k+1))*S1/S2;
    
    S1 = 0;
    for i = 1:(N-k+1)
        S1 = S1 + R3(i)*R3(i+k-1);
    end;
    S2 = 0;
    for i = 1:N
        S2 = S2 + (R3(i))^2;
    end;
    S2 = S2/N;
    A3(k) = (1/(N-k+1))*S1/S2;
end;    

k = 1:1:N/2;
figure;
plot(k, A1);
title('Автокорреляционная функция 1');
figure;
plot(k, A2);
title('Автокорреляционная функция 2');
figure;
plot(k, A3);
title('Автокорреляционная функция 3');

dov = nlparci(res3, r, 'covar', covb, 'alpha', 0.32) %доверительный интервал 

t1 = tinv(0.16, u3);
t2 = tinv(0.84, u3);
C = diag(covb);
dov_teor = zeros(2);
for i = 1:2
    for j = 1:2
        if j==1
            dov_teor(i,j) = res3(i) + t1*sqrt(C(i));  
        else
            dov_teor(i,j) = res3(i) + t2*sqrt(C(i));  
        end;            
    end;
end;
dov_teor

