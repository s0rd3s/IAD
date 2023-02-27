clc
close all
clear all

Lx=-5; % Левая граница для x
Rx=5; % Правая граница для x
stepx=0.05; % Шаг по оси x
Ly=-5; % Левая граница для y
Ry=5; % Правая граница для y
stepy=0.05; % Шаг по оси y
% Создание сетки координат
xs=Lx:stepx:Rx;
ys=Ly:stepy:Ry;
% Вычисление данных для трехмерного графика
[X,Y] = meshgrid(xs,ys);
Z = vrosenbrock(X,Y);
% Построение трехмерного графика график
surfc(xs,ys,Z)