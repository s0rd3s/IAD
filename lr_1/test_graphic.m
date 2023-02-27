clc
close all
clear all

x=0:0.1:6.28; % Объявление вектора аргумента 0<x<6.28 с шагом 0.1
y=sin(x); % Вычисление значений функции в заданных точках
plot(x,y); % Построение графика функции
grid on; % Отображение сетки
title ('Function sin(x)') % Заголовок графика
xlabel('Argument x') % Подпись по оси x
ylabel('Function y') % Подпись по оси y
print -dtiff -r200 Graphic
