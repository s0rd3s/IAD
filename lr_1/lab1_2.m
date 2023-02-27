clear all;
close all;
clc;
x=0:0.1:6.28; % Объявление вектора аргумента 0<x<6.28 с шагом 0.1
y=sin(x); % Вычисление значений функции в заданных точках
z=cos(x);


plot(x,y,'c:*') % Построение графика функции
grid on; % Отображение сетки
title ('Function sin(x)') % Заголовок графика
xlabel('Argument x') % Подпись по оси x
ylabel('Function y') % Подпись по оси y
ax.ColorOrder = [];
hold on;
plot(x,z,'y--')

grid on;
title ('Function cos(x)') % Заголовок графика
xlabel('Argument x') % Подпись по оси x
ylabel('Function y') % Подпись по оси y
hold off;


figure
plot(x,y,'c*',x,z,'y--')
grid on;
title ('Function cos(x)') % Заголовок графика
xlabel('Argument x') % Подпись по оси x
ylabel('Function y') % Подпись по оси y
print -dtiff -r1200 Graphic;
