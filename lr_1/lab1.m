clear all;
close all;
clc;
M=[33 5 6;4 56 84;42 7 9; 59 14 37]
size(M)
a=[1; 5; 6]
min(M,[],2)
min(min(M,[],2))
N=M;
N(2,:)=[]
size(N)
x=inv(N)*a
N(2,3)
N(3,:)
b=[96 78 65]
c=a*b
size(c)
d=a.*(b')
size(d)