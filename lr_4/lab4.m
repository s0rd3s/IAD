clc
close all
clear all

% Евклидово расстояние, метрика города, расстояние Минковского
% метод ближнего соседа, центроидный метод, метод медианной связи

file = fopen('data11.txt');
X = fscanf(file, '%f', [2 inf])';
fclose(file);
% X1 = X; % прикол-тест больше лучше точек посмотреть как разбивает на кластеры, штук 10 поставить ниже
% X1(:,1) = X(:,1)*10*rand;
% X1(:,2) = X(:,2)*rand;
% X = [X; X1];
x = X(:,1);
y = X(:,2);
N = size(X);
K = N(2);
N = N(1);

figure;
scatter(x, y, 35, 'filled');
title('Экспериментальные данные');
xlabel('X2');
ylabel('X1');

% расстояния между объектами
% pdist по матрице из первого аргумента рассчитывает по метрике из второго
% аргумента расстояния каждого с каждым. Например, в матрице 4 строки и 2
% столбца, первый столбец это иксы, второй игреки. pdist возвращает вектор.
% Тогда первым элементом будет расстояние между (x1;y1) и (x2;y2), вторым -
% между (x1;y1) и (x3;y3), третьим - между (x1;y1) и (x4;y4), четвёртым -
% между (x2;y2) и (x3;y3) и так далее по порядку, пока не будет найдено
% расстояние между всеми объектами
d_evkl = pdist(X, 'euclidean');
d_town = pdist(X, 'cityblock');
% xex = squareform(d_town, 'tomatrix') % в виде матрицы, так наглядно понятно кто с кем по какому расстоянию, i-ый с j-ым
d_mahal = pdist(X, 'minkowski', 4); % 4 для Минковского только особенность такая

% create hierarchical cluster tree
% linkage возвращает матрицу из трёх столбцов. В первом и втором столбцах
% находятся номера листьев дерева (см. дендрограмму). 18 исходных и их
% объединения (например, объединение 7 и 13 это новый лист с другим
% номером, объединение этого объединения с 4 - ещё один лист, и так вверх.
% В третьем столбце находится расстояние между этими листьями, вычисленное по соответствующей метрике
link_evkl_sing = linkage(d_evkl, 'single');
link_evkl_centr = linkage(d_evkl, 'centroid');
link_evkl_media = linkage(d_evkl, 'median');
link_town_sing = linkage(d_town, 'single');
link_town_centr = linkage(d_town,'centroid');
link_town_media = linkage(d_town, 'median');
link_mink_sing = linkage(d_mahal, 'single');
link_mink_centr = linkage(d_mahal, 'centroid');
link_mink_media = linkage(d_mahal, 'median');

% анализ качества кластеризации (cophenetic correlation coefficien)
coph_corr_coeff = zeros(3);
coph_corr_coeff(1,1) = cophenet(link_evkl_sing, d_evkl);
coph_corr_coeff(2,1) = cophenet(link_evkl_centr, d_evkl);
coph_corr_coeff(3,1) = cophenet(link_evkl_media, d_evkl);

coph_corr_coeff(1,2) = cophenet(link_town_sing, d_town);
coph_corr_coeff(2,2) = cophenet(link_town_centr, d_town); 
coph_corr_coeff(3,2) = cophenet(link_town_media, d_town);

coph_corr_coeff(1,3) = cophenet(link_mink_sing, d_mahal);
coph_corr_coeff(2,3) = cophenet(link_mink_centr, d_mahal); 
coph_corr_coeff(3,3) = cophenet(link_mink_media, d_mahal);

coph_corr_coeff

% находим самый эффективный и самый неэффективный способ
disp('Самый эффективный: метрика города + центроидный метод'); % просто посмотрел, к чему относится max, и записал
max_effective = max(max(coph_corr_coeff))
disp('Самый неэффективный: расстояние Минковского + метод ближнего соседа');
min_effective = min(min(coph_corr_coeff))

figure;
dendrogram(link_town_centr);
title('метрика города + центроидный метод');
% figure; % худшее, показывать не просят, но просто интересно жеж
% dendrogram(link_evkl_sing);
% title('расстояние Минковского + метод ближнего соседа');

% фиксированное число кластеров, на которое хочется разбить объекты
N_clust = 3; % на глаз кажется, что 3 подходит 

% первый элемент clust обозначает номер кластера, к которому относится
% первый объект, второй элемент обозначает номер кластера, к которому
% относится второй объект, и так далее
clust = cluster(link_mink_media, 'maxclust', N_clust); % construct clusters from linkages

figure;
gscatter(x, y, clust); % scatter plot by group, отображает сами объекты кластеров разноцветом
hold on;

% центры кластеров
clust_centr = zeros(N_clust, K); % матрица x и y координат центров
% расстояния между центрами кластеров
rast_betw_clust = zeros(N_clust, N_clust);
% радиусы кластеров
clust_rad = zeros(N_clust, 1);
% дисперсии кластеров
clust_disp = zeros(N_clust, 1);

disp('Расстояния от элементов кластера до центра');
for k = 1:N_clust
    disp(['№', num2str(k)]);
    % находим все объекты кластера
    obj = find(clust == k); % какие по счёту из clust относятся к текущему кластеру
    N_obj = length(obj); % их количество
    singl_clust = zeros(N_obj, K); % координаты всех объектов конкретного кластера (на итерации, 
    % после вычисления очередного кластера предыдущее значение теряется за ненадобностью), матрица x и y
    
    % находим центр и элементы кластера
    for i = 1:N_obj
        singl_clust(i,:) = X(obj(i),:);
        clust_centr(k,:) = clust_centr(k,:) + singl_clust(i,:);
    end;
    clust_centr(k,:) = clust_centr(k,:)/N_obj; 
    
    % расстояния (геометрические) до центра от всех элементов кластера
    clust_rast_centr = zeros(N_obj, 1);
    for i = 1:N_obj
        for l = 1:K
            clust_rast_centr(i) = clust_rast_centr(i) + (singl_clust(i,l) - clust_centr(k,l))^2;
        end;
        % тут мне сказали, что надо бы использовать функцию pdist.
        % Например, сделать временную матрицу, в которую добавить
        % clust_centr(номер_кластера, :) и singl_clust целиком, 
        % потом это всё передать первым аргументом в pdist, вторым поставить 'euclidean;, 
        % таким образом рассчитать расстояния между центром и всеми
        % элементами
        
        % дисперсия кластера
        clust_disp(k) = clust_disp(k) + clust_rast_centr(i);
        clust_rast_centr(i) = sqrt(clust_rast_centr(i));
    end;
    clust_disp(k) = clust_disp(k)/N_obj;
    clust_rast_centr
    % радиус кластера 
    clust_rad(k) = max(clust_rast_centr);
end;

% геометрическое расстояние между центрами
for i = 1:N_clust
    for j = i+1:N_clust
        for l = 1:K
            rast_betw_clust(i,j) = rast_betw_clust(i,j) + (clust_centr(i,l) - clust_centr(j,l))^2;
            % тут, наверное, тоже pdist лучше, но и так окэй
        end;
        rast_betw_clust(i,j) = sqrt(rast_betw_clust(i,j));
    end;
end;
disp('Расстояния между центрами кластеров');
rast_betw_clust
disp('Дисперсии кластеров');
clust_disp
disp('Радиусы кластеров');
clust_rad

% отображаем центры
scatter(clust_centr(:,1), clust_centr(:,2), 20, 'k', 'filled');
t = 0:pi/180:2*pi;
for i = 1:N_clust
    x = clust_rad(i)*cos(t) + clust_centr(i,1);
    y = clust_rad(i)*sin(t) + clust_centr(i,2);
    plot(x, y, 'k'); % рисует овальные границы
end;
title('Найденные кластеры и их центры');
xlabel('X2');
ylabel('X1');
