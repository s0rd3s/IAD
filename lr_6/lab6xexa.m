clc
close all
clear all

xax = fopen('data11.txt','r');
xe = fscanf(xax, '%f', [2 inf])';
fclose(xax);
xaxa = xe(:,1);
axex = xe(:,2);
xoxo = size(xe);
axax = xoxo(2); 
xoxo = xoxo(1); 

figure;
scatter(xaxa, axex, 35);

axaxex = 4; 
xexixoxo = zeros(axaxex, 2); 

for axxax = 1:axaxex
    xexixoxo(axxax,:) = xe(axxax,:); 
end
xexixoxo

xexi = 10000;
xux = 0.1435;
xix = zeros(1, axaxex);
xox = 1;
xexex = 0.01435;
while (true)
    xex = rand;
    xyx = ceil(5 + (xoxo-5)*xex); 
    for xaxaxa = 1:axaxex
         xix(xaxaxa) = pdist([xe(xyx,:); xexixoxo(xaxaxa,:)]); 
    end 
    [xaxaxax, xaxaxa] = min(xix);
    axxaxax = xexixoxo;
    axxaxax(xaxaxa,1) = xexixoxo(xaxaxa,1)+ xux*(xaxa(xyx) - xexixoxo(xaxaxa,1));
    axxaxax(xaxaxa,2) = xexixoxo(xaxaxa,2)+ xux*(axex(xyx) - xexixoxo(xaxaxa,2)); 
    if (xix(xaxaxa) <= xexex) || (xox == xexi)
        break
    end
    xox = xox+1;
    xexixoxo = axxaxax;    
end
xexixoxo
xox

xixix = zeros(1, axaxex);
xoxox = zeros(xoxo, 2);
for axxax = 1:xoxo
    for xaxaxa = 1:axaxex
    xixix(xaxaxa) = pdist([xe(axxax,:); xexixoxo(xaxaxa,:)]);
    end 
    [xaxaxax, xaxaxa] = min(xixix);
    xoxox(axxax,1) = xaxaxa;
    xoxox(axxax,2) = xixix(xaxaxa);
end

figure;
gscatter(xaxa, axex, xoxox(:,1));
title('Политические координаты');
hold on;
scatter(xexixoxo(:,1), xexixoxo(:,2), 20, 'k', 'filled');
