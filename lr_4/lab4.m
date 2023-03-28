clc;
close all;
clear all;
fid = fopen('data11.txt', 'r');
clc
X = fscanf(fid, '%g %g ', [2 inf]);
X = X'
fclose(fid);

figure
hold on 
grid on
scatter(X(:,1), X(:,2), '*')
title ('X_1 and X_2')
xlabel('Z_1')
ylabel('Z_2')
% Расстояние между объектами(Стадантизированное Евклидово, Минковского, Чебышева)
Y_seuc = pdist(X, 'seuclidean');
Y_maha = pdist(X, 'mahalanobis');
Y_cheb = pdist(X, 'chebychev');

D_seuc = squareform(Y_seuc);
D_maha = squareform(Y_maha);
D_cheb = squareform(Y_cheb);

% групировка элементов в дендограммы
Z_single_seuc = linkage(Y_seuc, 'single');
Z_complete_seuc = linkage(Y_seuc, 'complete');
Z_average_seuc = linkage(Y_seuc, 'average');

Z_single_maha = linkage(Y_maha, 'single');
Z_complete_maha = linkage(Y_maha, 'complete');
Z_average_maha = linkage(Y_maha, 'average');

Z_single_cheb = linkage(Y_cheb, 'single');
Z_complete_cheb = linkage(Y_cheb, 'complete');
Z_average_cheb = linkage(Y_cheb, 'average');



% figure
% dendrogram(Z_single_seuc)
% title ('Dengrogramm Z_s_i_n_g_l_e_ _s_e_u_c')
% 
% figure
% dendrogram(Z_complete_seuc)
% title ('Dengrogramm Z_c_o_m_p_l_e_t_e_ _s_e_u_c')
% 
% figure
% dendrogram(Z_average_seuc)
% title ('Dengrogramm Z_a_v_e_r_a_g_e_ _s_e_u_c')
% 
% 
% 
% figure 
% dendrogram(Z_single_maha)
% title ('Dengrogramm Z_s_i_n_g_l_e_ _m_a_h_a')
% 
% figure 
% dendrogram(Z_complete_maha)
% title ('Dengrogramm Z_c_o_m_p_l_e_t_e_ _m_a_h_a')
% 
% figure 
% dendrogram(Z_average_maha)
% title ('Dengrogramm Z_a_v_e_r_a_g_e_ _m_a_h_a')
% 
% 
% 
figure 
dendrogram(Z_single_cheb)
title ('Dengrogramm Z_s_i_n_g_l_e_ _c_h_e_b')
% 
% figure 
% dendrogram(Z_complete_cheb)
% title ('Dengrogramm Z_c_o_m_p_l_e_t_e_ _c_h_e_b')
% 
% figure 
% dendrogram(Z_average_cheb)
% title ('Dengrogramm Z_a_v_e_r_a_g_e_ _c_h_e_b')
% 
% Расчет коэффициента качества разбиения исходных данных на кластеры
Cohernet(1,1) = cophenet(Z_single_seuc,Y_seuc);
Cohernet(1,2) = cophenet(Z_complete_seuc,Y_seuc);
Cohernet(1,3) = cophenet(Z_average_seuc,Y_seuc);
Cohernet(2,1) = cophenet(Z_single_maha,Y_maha);
Cohernet(2,2) = cophenet(Z_complete_maha,Y_maha);
Cohernet(2,3) = cophenet(Z_average_maha,Y_maha);
Cohernet(3,1) = cophenet(Z_single_cheb,Y_cheb);
Cohernet(3,2) = cophenet(Z_complete_cheb,Y_cheb);
Cohernet(3,3) = cophenet(Z_average_cheb,Y_cheb);
Cohernet

max = max(max(Cohernet));
min = min(min(Cohernet));
C = cluster(Z_average_seuc,'maxclust',4);

figure
hold on
grid on
gscatter(X(:,1), X(:,2), C)

% номера объектов
% значения меры сходства












