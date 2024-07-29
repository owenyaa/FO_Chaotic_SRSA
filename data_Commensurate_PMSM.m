%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : forward problem: get data----Fractional-Order Commensurate PMSM system
% Model ref: Parameter Estimation of Fractional Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis

clear;clc;close all;
addpath('./SRSA');
%% problem setting for the nonlinear dynamic problem
global tf h parameters n Tdata

% system paramter
a=100;b=10;q=0.95; 

tf=20;h=0.005;Tdata=(0:h:tf)';
n=length(Tdata);
%% parameter and initial setting
parameters=[a,b,q];
x_cal=cal_Commensurate_PMSM(parameters);

%% add noise
fr1=0.5;                        % level of the noise
fr2=0.5;
fr3=0.5;                        % level of the noise
for j=1:length(x_cal(:,1))
    x_cal(j,1)=x_cal(j,1)+fr1*(2*rand-1);
    x_cal(j,2)=x_cal(j,2)+fr2*(2*rand-1);
    x_cal(j,3)=x_cal(j,3)+fr3*(2*rand-1);
end
x_cal_data=x_cal(1:1:end,:);
savefile='simple_fre_data.mat';
save(savefile,'Tdata','x_cal_data');


%% plot
figure;
plot(Tdata,x_cal(:,1),'k-');
hold on;
plot(Tdata,x_cal(:,2),'r-');
hold on;
plot(Tdata,x_cal(:,3),'b-');
h1=legend('$$x$$','$$y$$','$$z$$');
set(h1,'Interpreter','latex','FontSize',15);
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1.5);

figure;
plot3(x_cal_data(:,1),x_cal_data(:,2),x_cal_data(:,3),'k-');
view(-35,30);
xlabel('x');ylabel('y');zlabel('z');
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1.5);