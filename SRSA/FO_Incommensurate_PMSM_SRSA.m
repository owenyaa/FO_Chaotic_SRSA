%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : Stepwise response and sensitivity: Fractional-Order Incommensurate PMSM system
% Model ref: Parameter Estimation of Fractional-Order Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis


function Y=FO_Incommensurate_PMSM_SRSA(parameter_a, T_data, Y0,jjj)
global x_cal_data 
%   Fractional-Order Incommensurate PMSM
%   D^q1 x(t) = -x(t) + z(t) y(t)
%   D^q2 y(t) = - y(t) - z(t) x(t) + az(t)
%   D^q3 z(t) =   b (y(t) - z(t))

%% the jjj step
n=jjj+1;
h=T_data(2)-T_data(1);
x=x_cal_data(1:n-1,1)';y=x_cal_data(1:n-1,2)';z=x_cal_data(1:n-1,3)';
%% System parameter
a=parameter_a(1); b=parameter_a(2); 
q1=parameter_a(3); 
q2=parameter_a(4);
q3=parameter_a(5);
%% initial value of the binomial coefficient
cp1=1; cp2=1; cp3=1;
cp4=1; cp5=1; cp6=1;
%% Initial condition
x(1)=Y0(1); y(1)=Y0(2); z(1)=Y0(3);
x1(1)=Y0(4); y1(1)=Y0(5); z1(1)=Y0(6);
x2(1)=Y0(7); y2(1)=Y0(8); z2(1)=Y0(9);
%% The initial value and calculation of binomial coefficients
for j=1:n
    c1(j)=(1-(1+q1)/j)*cp1;
    c2(j)=(1-(1+q2)/j)*cp2;
    c3(j)=(1-(1+q3)/j)*cp3;
    cp1=c1(j); cp2=c2(j); cp3=c3(j);
end
x(n)=(-x(n-1)+z(n-1)*y(n-1))*h^q1 - rzz(x, c1, n);
y(n)=(-y(n-1)-x(n)*z(n-1)+a*z(n-1))*h^q2 - rzz(y, c2, n);
z(n)=(b*(y(n)-z(n-1)))*h^q3 - rzz(z, c3, n);
Y(1,1)=x(1,n);
Y(1,2)=y(1,n);
Y(1,3)=z(1,n);


%% 计算a的响应灵敏度
x1(2)=(-x1(2-1)+z(n-1)*y1(2-1)+z1(2-1)*y(n-1))*h^q1 - rzz(x1, c1, 2);
y1(2)=(-y1(2-1)-x(n)*z1(2-1)-x1(2)*z(n-1)+a*z1(2-1)+z(n-1))*h^q2 - rzz(y1, c2, 2);
z1(2)=(b*(y1(2)-z1(2-1)))*h^q3 - rzz(z1, c3, 2);
Y(1,4)=x1(1,2);
Y(1,5)=y1(1,2);
Y(1,6)=z1(1,2);


%% 计算b的响应灵敏度
x2(2)=(-x2(2-1)+z(n-1)*y2(2-1)+z2(2-1)*y(n-1))*h^q1 - rzz(x2, c1, 2);
y2(2)=(-y2(2-1)-x(n)*z2(2-1)-x2(2)*z(n-1)+a*z2(2-1))*h^q2 - rzz(y2, c2, 2);
z2(2)=(b*(y2(2)-z2(2-1))+(y(n)-z(n-1)))*h^q3 - rzz(z2, c3, 2);
Y(1,7)=x2(1,2);
Y(1,8)=y2(1,2);
Y(1,9)=z2(1,2);

%%%%%%%%%%%%%%
delta=0.000001;
q1_delta=q1-delta;
q2_delta=q2-delta;
q3_delta=q3-delta;
for j=1:n
    c4(j)=(1-(1+q1_delta)/j)*cp4;
    c5(j)=(1-(1+q2_delta)/j)*cp5; 
    c6(j)=(1-(1+q3_delta)/j)*cp6;     
    cp4=c4(j); cp5=c5(j); cp6=c6(j);
end
%% 计算q1的响应灵敏度, 用差分代替
x3=(-x(n-1)+z(n-1)*y(n-1))*h^q1_delta - rzz(x, c4, n);
y3=(-y(n-1)-x3*z(n-1)+a*z(n-1))*h^q2 - rzz(y, c2, n);
z3=(b*(y3-z(n-1)))*h^q3 - rzz(z, c3, n);
Y(1,10)=(x(1,n)-x3)/delta;
Y(1,11)=(y(1,n)-y3)/delta;
Y(1,12)=(z(1,n)-z3)/delta;  

%% 计算q2的响应灵敏度, 用差分代替
x4=(-x(n-1)+z(n-1)*y(n-1))*h^q1 - rzz(x, c1, n);
y4=(-y(n-1)-x4*z(n-1)+a*z(n-1))*h^q2_delta - rzz(y, c5, n);
z4=(b*(y4-z(n-1)))*h^q3 - rzz(z, c3, n);
Y(1,13)=(x(1,n)-x4)/delta;
Y(1,14)=(y(1,n)-y4)/delta;
Y(1,15)=(z(1,n)-z4)/delta;  

%% 计算q3的响应灵敏度, 用差分代替
x5=(-x(n-1)+z(n-1)*y(n-1))*h^q1 - rzz(x, c1, n);
y5=(-y(n-1)-x5*z(n-1)+a*z(n-1))*h^q2 - rzz(y, c2, n);
z5=(b*(y5-z(n-1)))*h^q3_delta - rzz(z, c6, n);
Y(1,16)=(x(1,n)-x5)/delta;
Y(1,17)=(y(1,n)-y5)/delta;
Y(1,18)=(z(1,n)-z5)/delta;  