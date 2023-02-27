clc
close all
clear all

G = my_gauss_gen(100000, 0, 2);
Mx = mean(G);
Dx = var(G);
hist(G,-6:0.25:6);