%Name: Chuan He
%Date: 11/30/2022
%Latest Modification: 11/30/2022
%Aim: Scanned data analysis

clear
clc
close all

% (modify: load file)
% load FBS_Baseline_0_0_X_Face.txt
% Point_Cloud = FBS_Baseline_0_0_X_Face;
% clear load FBS_Baseline_0_0_X_Face

load Baseline_FBS_xneg80_y0.txt
Point_Cloud = Baseline_FBS_xneg80_y0;
clear Baseline_FBS_xneg80_y0

figure
subplot(1,2,1)
scatter3(Point_Cloud(:,1),Point_Cloud(:,2),Point_Cloud(:,3),'*');

x1 = min(Point_Cloud(:,1));
x2 = max(Point_Cloud(:,1));
y1 = min(Point_Cloud(:,2));
y2 = max(Point_Cloud(:,2));
z1 = min(Point_Cloud(:,3));
z2 = max(Point_Cloud(:,3));

x_width = x2-x1;
y_length = y2-y1;
z_height = z2-z1;

P = [0, 0, 0;...
    x_width, 0, 0;...
    0, y_length, 0;...
    x_width, y_length, 0];

Q = [x1, y2, z1;...
    x2, y1, z1;...
    x1, y2, z2;...
    x2, y1, z2]; % load FBS_Baseline_0_0_X_Face

%
Centroid_P = mean(P);
Centroid_Q = mean(Q);

decentrailzed_P = P-Centroid_P;
decentrailzed_Q = Q-Centroid_Q;

[U,S,V] = svd(decentrailzed_Q'*decentrailzed_P);
R = V*U';
t = Centroid_P'-R*Centroid_Q';
New_Point_Cloud = R*Point_Cloud'+t;
New_Point_Cloud = New_Point_Cloud';

subplot(1,2,2)
scatter3(New_Point_Cloud(:,1),New_Point_Cloud(:,2),New_Point_Cloud(:,3),'*');

std_dev = std(New_Point_Cloud(:,3))

figure
colormap jet;
pcshow(New_Point_Cloud, 'BackgroundColor', 'w')
grid off
% xlabel('X [mm]')
% ylabel('Z [mm]')
colorbar
caxis([-0.6,0.6])
% caxis([-1.0,1.0])
