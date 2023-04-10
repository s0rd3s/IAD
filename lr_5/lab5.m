clc;
close all;
clear all;
fid = fopen('data11.txt', 'r');
clc
X = fscanf(fid, '%g %g ', [2 inf]);
X = X';
fclose(fid);

figure
hold on 
grid on
scatter(X(:,1), X(:,2), '*')
title ('X_1 and X_2')
xlabel('X_1')
ylabel('X_2')

N = 4; % количество центров кластеров
C = zeros(N,2); % задание начальных центров кластеров
for i = 1 : N
    C(i, :) = X(i , :);
end

U = zeros(length(X) , 2);
eps = 0.01;
Q = 1000;
q = 0;

% индексы кластеров, к которым относятся объекты  
% расстояния от объектов до центров кластеров
R = zeros(1,N);
for i = 1 : length(X) % расчёт расстояний до центров кластеров, заполнение матрицы U
        for n = 1 : N
        R(n) = pdist([X(i , :) ; C(n , :)],'minkowski', 4);
        end 

    for n = 1 : N
        if R(n) == min(R)
            U(i,1) = n;
            U(i,2) = R(n);
        end
    end
end
%качества кластеризации
itter= 0;
while abs(Q - q)>eps
    
    Q = q
    
    C = zeros(N,2); %зануление прежних координат, для того чтобы записать на их место новые
    for l = 1 : N  % расчёт новых центров кластеров, заполнение С
        n = 0;
        for j = 1 : length(U)
            if (U(j,1)==l)
                n = n+1;
                C(l, :) = C(l, :) + X(j , :);
            end
        end
        C(l, :) = C(l, :)./n; %поделили сумму всех координат точек принадлежащих этому кластеру на число этих точек - получили координаты центра этого кластера
    end
    
    R = zeros(1,N);
    for i = 1 : length(X) % расчёт расстояний до центров кластеров, заполнение матрицы U
        for n = 1 : N
        R(n) = pdist([X(i , :) ; C(n , :)],'minkowski', 4);
        end 

        for n = 1 : N
            if R(n) == min(R)
                U(i,1) = n;
                U(i,2) = R(n);
            end
        end
    end 
    
    q = zeros(1,N);
    for l = 1 : N  % расчёт и заполнение Q
        for j = 1 : length(U)
            if (U(j,1)==l)
                q(l) = q(l)+(U(j,2))^2;
            end
        end
    end
    q = sum(q); % пересчитанный параметр
  
end

figure
gscatter(X(:,1), X(:,2), U(:,1))
hold on
scatter(C(:,1),C(:,2),'filled')    

   