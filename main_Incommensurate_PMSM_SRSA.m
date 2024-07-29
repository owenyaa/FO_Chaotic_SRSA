%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : main program: Fractional-Order Incommensurate PMSM system
% Model ref: Parameter Estimation of Fractional Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis

clear;clc;close all;
addpath('./SRSA');

global parameter_a x_cal_data Tdata x_cal_iden
%% Model setting and data
parameter_a=[55;10;0.9;0.9;0.9];
ini_parameter_a=parameter_a;


parameter_a_judge=@(parameter_a)(min(parameter_a(1))>0);  
load simple_fre_data.mat; % load observed data --- Tdata and Xdata
gammaT=1.414;rhob=0.5; % parameter for trust-region algorithm
parameter_a_record=parameter_a; 
TR_record=[];  % recording the parameter_a during trust region

x_cal_start=x_cal_data(1:end-1,:);
x_cal_end=x_cal_data(2:end,:);
Tstart=Tdata(1:end-1);
Tend  =Tdata(2:end);
Psize=size(x_cal_data);
Psize=[Psize(1),18];
% options=odeset('RelTol',1e-6,'AbsTol',1e-8); % error tolerence setting
%% Response sensitivity iteration
Nmax=1000;   % maximum number for response sensitivity iteration
Ntr=20;      % maximum number for trust region iteration
%% response sensitivity Solution by ode45
NT=length(x_cal_data(:,1))-1;
for iii=1:Nmax
    % compute response and response sensitivity for each incremental
    Etol=1e-10;  % Relative error tolerance for convergence of the RS algorithm
    %%
    x_cal_iden=zeros(Psize(1),Psize(2));
    x_cal_iden(1,1:3)=x_cal_data(1,1:3);
    for jjj=1:NT
        x_cal_iden_j=cal_Incommensurate_PMSM_step(parameter_a,[Tstart(jjj),Tend(jjj)],[x_cal_start(jjj,1:3),zeros(1,6)]',jjj);
        x_cal_iden(jjj+1,:)=x_cal_iden_j;
    end
    
    %% SSSÎªÏìÓ¦ÁéÃô¶È¾ØÕó
    SSS1=[x_cal_iden(2:end,4);x_cal_iden(2:end,5);x_cal_iden(2:end,6)];
    SSS2=[x_cal_iden(2:end,7);x_cal_iden(2:end,8);x_cal_iden(2:end,9)];
    SSS3=[x_cal_iden(2:end,10);x_cal_iden(2:end,11);x_cal_iden(2:end,12)];
    SSS4=[x_cal_iden(2:end,13);x_cal_iden(2:end,14);x_cal_iden(2:end,15)];
    SSS5=[x_cal_iden(2:end,16);x_cal_iden(2:end,17);x_cal_iden(2:end,18)];
    SSS=[SSS1,SSS2,SSS3,SSS4,SSS5];
    % determine initial lambda by L-curve method
    dR1=x_cal_end(:,1)-x_cal_iden(2:end,1);
    dR2=x_cal_end(:,2)-x_cal_iden(2:end,2);
    dR3=x_cal_end(:,3)-x_cal_iden(2:end,3);
    dR=[dR1;dR2;dR3];
    [U,s,V]=csvd(SSS);
    lambda_inverse=l_curve(U,s,dR);
    atemp=parameter_a;
    % trust-region algorithm
    for trust=1:Ntr
        da=tikhonov(U,s,V,dR,lambda_inverse);
        if ~parameter_a_judge(atemp+da)     
            lambda_inverse=lambda_inverse*gammaT; %  update of lambda
            continue;
        end
        da=tikhonov(U,s,V,dR,lambda_inverse);
        parameter_a=atemp+da;
        %% new parameter_a=atemp+da
        x_cal_da=zeros(Psize(1),Psize(2));
        x_cal_da(1,1:3)=x_cal_data(1,1:3);
        for jjj=1:NT
            x_cal_da_j=cal_Incommensurate_PMSM_step(parameter_a,[Tstart(jjj),Tend(jjj)],[x_cal_start(jjj,1:3),zeros(1,6)]',jjj);
            x_cal_da(jjj+1,:)=x_cal_da_j;
        end
        dR1temp=x_cal_end(:,1)-x_cal_da(2:end,1);
        dR2temp=x_cal_end(:,2)-x_cal_da(2:end,2);
        dR3temp=x_cal_end(:,3)-x_cal_da(2:end,3);
        dRtemp=[dR1temp;dR2temp;dR3temp];
        LdR=SSS*da-dR;
        rhos=(dR'*dR-dRtemp'*dRtemp)/(dR'*dR-LdR'*LdR);  % agreement indicator
        if rhos>=rhob
            break;
        end
        lambda_inverse=lambda_inverse*gammaT;
    end
    da=tikhonov(U,s,V,dR,lambda_inverse);
    parameter_a=atemp+da;
    
    tolt=norm(da)/norm(parameter_a);
    parameter_a_record=[parameter_a_record,parameter_a];
    TR_record=[TR_record;lambda_inverse];
    parameter_a
    if tolt<=Etol
        break;
    end
    every_a(iii).parameter_a=parameter_a;
    iii
end
% system real parameter
real_parameter_a=[50;4;0.98;1;0.99];
relative_error=(parameter_a-real_parameter_a)./real_parameter_a*100
a1=zeros(1,iii);a2=a1;a3=a1;
a4=a1;a5=a1;
relative_error_1=a1;relative_error_2=a1;relative_error_3=a1;
relative_error_4=a1;relative_error_5=a1;
relative_error_1(1,1)=(ini_parameter_a(1)-real_parameter_a(1))/real_parameter_a(1)*100;
relative_error_2(1,1)=(ini_parameter_a(2)-real_parameter_a(2))/real_parameter_a(2)*100;
relative_error_3(1,1)=(ini_parameter_a(3)-real_parameter_a(3))/real_parameter_a(3)*100;
relative_error_4(1,1)=(ini_parameter_a(4)-real_parameter_a(4))/real_parameter_a(4)*100;
relative_error_5(1,1)=(ini_parameter_a(5)-real_parameter_a(5))/real_parameter_a(5)*100;



a1(1)=ini_parameter_a(1);a2(1)=ini_parameter_a(2);a3(1)=ini_parameter_a(3);
a4(1)=ini_parameter_a(4);a5(1)=ini_parameter_a(5);
for i=2:iii
    a=every_a(i-1).parameter_a;
    a1(i)=a(1);a2(i)=a(2);a3(i)=a(3);
    a4(i)=a(4);a5(i)=a(5);
    relative_error_1(i)=(a(1)-real_parameter_a(1))/real_parameter_a(1)*100;
    relative_error_2(i)=(a(2)-real_parameter_a(2))/real_parameter_a(2)*100;
    relative_error_3(i)=(a(3)-real_parameter_a(3))/real_parameter_a(3)*100;
    relative_error_4(i)=(a(4)-real_parameter_a(4))/real_parameter_a(4)*100;
    relative_error_5(i)=(a(5)-real_parameter_a(5))/real_parameter_a(5)*100;
end
figure;
plot(1:1:iii,relative_error_1,'r-','LineWidth',1.5);
hold on;
plot(1:1:iii,relative_error_2,'b--','LineWidth',1.5);
hold on;
plot(1:1:iii,relative_error_3,'k-.','LineWidth',1.5);
hold on;
plot(1:1:iii,relative_error_4,'g--.','LineWidth',1.5);
hold on;
plot(1:1:iii,relative_error_5,'r-.','LineWidth',1.5);
set(gca,'LineWidth',1.5);set(gca,'FontSize',15);

figure;
plot(1:1:iii,a1,'r-','LineWidth',1.5);
hold on;
plot(1:1:iii,a2,'b--','LineWidth',1.5);
hold on;
plot(1:1:iii,a3,'k-.','LineWidth',1.5);
hold on;
plot(1:1:iii,a4,'g--.','LineWidth',1.5);
hold on;
plot(1:1:iii,a5,'r-.','LineWidth',1.5);
set(gca,'LineWidth',1.5);set(gca,'FontSize',15);
h1=legend('$$a$$','$$b$$','$$q_1$$','$$q_2$$','$$q_3$$');
set(h1,'Interpreter','latex','FontSize',15);
set(gca,'FontName','Times New Roman','FontSize',15,'LineWidth',1.5);
ini_parameter_a