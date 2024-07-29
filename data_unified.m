%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : forward problem: get data----Fractional-Order unified system
% Model ref: Parameter Estimation of Fractional Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis


clear;clc;close all;
addpath('./SRSA');
%% problem setting for the FO chaotic: unified system
global tf h parameters n Tdata

% system paramter
a=0.5;q=0.95;           %--------------case1
% a=0.4;q=0.9;           %--------------case2
% a=0.8;q=0.9;           %--------------case3
tf=20;h=0.005;Tdata=(0:h:tf)';
n=length(Tdata);
%% parameter and initial setting
parameters=[a,q];
x_cal=cal_unified(parameters);

%% add noise
fr1=0.1;                        
fr2=0.1;
fr3=0.1;                        
for j=1:length(x_cal(:,1))
    x_cal(j,1)=x_cal(j,1)+fr1*(2*rand-1);
    x_cal(j,2)=x_cal(j,2)+fr2*(2*rand-1);
    x_cal(j,3)=x_cal(j,3)+fr3*(2*rand-1);
end
x_cal_data=x_cal(:,1:3);
savefile='simple_fre_data.mat';
save(savefile,'Tdata','x_cal_data');

%% plot
figure;
plot(Tdata,x_cal(:,1),'k-');
hold on;
plot(Tdata,x_cal(:,2),'r-');
hold on;
plot(Tdata,x_cal(:,3),'b-');
h1=legend('$$\alpha_1$$','$$\alpha_2$$','$$\alpha_3$$');
set(h1,'Interpreter','latex','FontSize',15);
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1.5);

figure;
plot3(x_cal(:,1),x_cal(:,2),x_cal(:,3),'k-');
view(-110,30);
xlabel('x');ylabel('y');zlabel('z');
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1.5);