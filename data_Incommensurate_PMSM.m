%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : forward problem: get data----Fractional-Order Incommensurate PMSM system
% Model ref: Parameter Estimation of Fractional Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis

clear;clc;close all;
addpath('./SRSA');
%% problem setting for the nonlinear dynamic problem
global tf h parameters n Tdata

% system paramter
a=50;b=4;
q1=0.98;q2=1;q3=0.99;

tf=20;h=0.005;Tdata=(0:h:tf)';
% Tdata=(0:h:0.01)'£»
n=length(Tdata);
%% parameter and initial setting
parameters=[a,b,q1,q2,q3];
x_cal=cal_Incommensurate_PMSM(parameters);

%% add noise
fr1=0.05;                        % level of the noise
fr2=0.05;                        
fr3=0.05;                        % level of the noise
for j=1:length(x_cal(:,1))
    x_cal(j,1)=x_cal(j,1)+fr1*(2*rand-1);
    x_cal(j,2)=x_cal(j,2)+fr2*(2*rand-1);
    x_cal(j,3)=x_cal(j,3)+fr3*(2*rand-1);
end
x_cal_data=x_cal(:,1:3);
savefile='simple_fre_data.mat';
save(savefile,'Tdata','x_cal_data');
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
plot3(x_cal(:,1),x_cal(:,2),x_cal(:,3),'k-');
xlabel('x');ylabel('y');zlabel('z');
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1.5);