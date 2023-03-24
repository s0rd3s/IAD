clc
close all
clear all

file = fopen('Learning_data11.txt', 'r');
Learning = fscanf(file, '%f', [8 inf]);
fclose(file);

mini = min(Learning, [], 2); % минимальный среди объектов по i-ому признаку
maxi = max(Learning, [], 2);
T = [mini(1) maxi(1); mini(2) maxi(2); mini(3) maxi(3); mini(4) maxi(4); 
    mini(5) maxi(5); mini(6) maxi(6); mini(7) maxi(7); mini(8) maxi(8)]; % минимакс
%Создать нейронную сеть (например, 2x2) на основе карт Кохонена
razm1 = 2;
razm2 = 2;
net = newsom(T, [razm1 razm2]); % для создания самоорганизующейся карты Кохонена
net.trainParam.epochs = 100; % one epoch of training is defined as a single presentation of all input vectors to the network
net = train(net, Learning); %обучение сети соответсвующим набором
%Классифицировать исходные объекты в кластеры с использованием разработанной нейронной сети
W = sim(net, Learning); % Simulate dynamic system, классификация векторов входов по разработанной нейросети
Klasters = vec2ind(W); %конвертирует классифицированные объекты в индексы нейронов, какой объект к какому кластеру

file = fopen('PCA_data11.txt', 'r');
PCA = fscanf(file, '%f', [2 inf]); % исходные данные в координатах первых двух главных компонент
fclose(file);

%Сгруппировать объекты в кластеры
Obj1 = find(Klasters==1);
s1 = length(Obj1);
Obj2 = find(Klasters==2);
s2 = length(Obj2);
Obj3 = find(Klasters==3);
s3 = length(Obj3);
Obj4 = find(Klasters==4);
s4 = length(Obj4);
C1 = zeros(s1, 2); C2 = zeros(s2, 2); C3 = zeros(s3, 2); C4 = zeros(s4, 2);
clust1 = zeros(s1, 8); clust2 = zeros(s2, 8); clust3 = zeros(s3, 8); clust4 = zeros(s4, 8);

for i = 1:s1 % цикл по всем элементам i-го кластера
        C1(i,:) = PCA(:,Obj1(i)); % переписать в новую матрицу только те объекты которые в p-ом кластере 
        clust1(i,:) = Learning(:,Obj1(i));
end 
for i = 1:s2 
        C2(i,:) = PCA(:,Obj2(i)); 
        clust2(i,:) = Learning(:,Obj2(i));
end 
for i = 1:s3 
        C3(i,:) = PCA(:,Obj3(i)); 
        clust3(i,:) = Learning(:,Obj3(i));
end 
for i = 1:s4 
        C4(i,:) = PCA(:,Obj4(i)); 
        clust4(i,:) = Learning(:,Obj4(i));
end 

%Центры кластеров данных из PCA
M_PCA(1,:) = mean(C1);
M_PCA(2,:) = mean(C2);
M_PCA(3,:) = mean(C3);
M_PCA(4,:) = mean(C4);

%Отображение центров кластеров
figure
gscatter(PCA(1,:), PCA(2,:), Klasters);
hold on
plot(M_PCA(:,1), M_PCA(:,2), '*');
hold off

%Cредние значения по каждому признаку в кластерах
M(1,:) = mean(clust1);
M(2,:) = mean(clust2);
M(3,:) = mean(clust3);
M(4,:) = mean(clust4);
M

%График средних значений признаков объектов попавших в кластер
figure
plot(M(1, :), 'r');
axis([1 8 1 10]); % границы по осям [x1 x2 y1 y2] 
hold on
plot(M(2, :), 'g');
plot(M(3, :), 'c');
plot(M(4, :), 'b');
title('График средних значений признаков');
