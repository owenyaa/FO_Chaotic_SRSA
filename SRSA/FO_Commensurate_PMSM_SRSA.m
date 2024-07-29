%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : Stepwise response and sensitivity: Fractional-Order Commensurate PMSM system
% Model ref: Parameter Estimation of Fractional-Order Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis

function Y=FO_Commensurate_PMSM_SRSA(parameter_a, T_data, Y0,jjj)
global x_cal_data 
%   Fractional-Order Commensurate PMSM
%   D^q x(t) = -x(t) + z(t) y(t)
%   D^q y(t) = - y(t) - z(t) x(t) + az(t)
%   D^q z(t) =   b (y(t) - z(t))

%% the jjj step
n=jjj+1;
h=T_data(2)-T_data(1);
x=x_cal_data(1:n-1,1)';y=x_cal_data(1:n-1,2)';z=x_cal_data(1:n-1,3)';
%% System parameter
a=parameter_a(1); b=parameter_a(2); q=parameter_a(3); 
%% initial value of the binomial coefficient
cp1=1; cp2=1; 
%% Initial condition
x(1)=Y0(1); y(1)=Y0(2); z(1)=Y0(3);
x1(1)=Y0(4); y1(1)=Y0(5); z1(1)=Y0(6);
x2(1)=Y0(7); y2(1)=Y0(8); z2(1)=Y0(9);

%% The initial value and calculation of binomial coefficients
for j=1:n
    c1(j)=(1-(1+q)/j)*cp1;
    cp1=c1(j); 
end
x(n)=(-x(n-1)+z(n-1)*y(n-1))*h^q - rzz(x, c1, n);
y(n)=(-y(n-1)-x(n)*z(n-1)+a*z(n-1))*h^q - rzz(y, c1, n);
z(n)=(b*(y(n)-z(n-1)))*h^q - rzz(z, c1, n);
Y(1,1)=x(1,n);
Y(1,2)=y(1,n);
Y(1,3)=z(1,n);


%% 计算a的响应灵敏度
x1(2)=(-x1(2-1)+z(n-1)*y1(2-1)+z1(2-1)*y(n-1))*h^q - rzz(x1, c1, 2);
y1(2)=(-y1(2-1)-x(n)*z1(2-1)-x1(2)*z(n-1)+a*z1(2-1)+z(n-1))*h^q - rzz(y1, c1, 2);
z1(2)=(b*(y1(2)-z1(2-1)))*h^q - rzz(z1, c1, 2);
Y(1,4)=x1(1,2);
Y(1,5)=y1(1,2);
Y(1,6)=z1(1,2);


%% 计算b的响应灵敏度
x2(2)=(-x2(2-1)+z(n-1)*y2(2-1)+z2(2-1)*y(n-1))*h^q - rzz(x2, c1, 2);
y2(2)=(-y2(2-1)-x(n)*z2(2-1)-x2(2)*z(n-1)+a*z2(2-1))*h^q - rzz(y2, c1, 2);
z2(2)=(b*(y2(2)-z2(2-1))+(y(n)-z(n-1)))*h^q - rzz(z2, c1, 2);
Y(1,7)=x2(1,2);
Y(1,8)=y2(1,2);
Y(1,9)=z2(1,2);

%% 计算q的响应灵敏度, 用差分代替
delta=0.000001;
q_delta=q-delta;
for j=1:n
    c2(j)=(1-(1+q_delta)/j)*cp2;  
    cp2=c2(j); 
end

x3=(-x(n-1)+z(n-1)*y(n-1))*h^q_delta - rzz(x, c2, n);
y3=(-y(n-1)-x3*z(n-1)+a*z(n-1))*h^q_delta - rzz(y, c2, n);
z3=(b*(y3-z(n-1)))*h^q_delta - rzz(z, c2, n);
Y(1,10)=(x(1,n)-x3)/delta;
Y(1,11)=(y(1,n)-y3)/delta;
Y(1,12)=(z(1,n)-z3)/delta;  