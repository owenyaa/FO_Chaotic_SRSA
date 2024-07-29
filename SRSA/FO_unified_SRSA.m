%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : Stepwise response and sensitivity: Fractional-Order unified system
% Model ref: Parameter Estimation of Fractional-Order Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis

function Y=FO_unified_SRSA(parameter_a, T_data, Y0,jjj)
global x_cal_data 
%   FO unified system
%   D^q x(t) = (25a+10)(y(t)-x(t))
%   D^q y(t) = (28-35a)x(t) - x(t)z(t) + (29a-1)y(t)
%   D^q z(t) = x(t)y(t) - (a+8)z(t)/3

%% the jjj step
n=jjj+1;
h=T_data(2)-T_data(1);
x=x_cal_data(1:n-1,1)';y=x_cal_data(1:n-1,2)';z=x_cal_data(1:n-1,3)';
%% System parameter
a=parameter_a(1); 
q=parameter_a(2);  % q=0.9;
%% initial value of the binomial coefficient
cp1=1; cp2=1; 
%% Initial condition
x(1)=Y0(1); y(1)=Y0(2); z(1)=Y0(3);
x1(1)=Y0(4); y1(1)=Y0(5); z1(1)=Y0(6);

%% The initial value and calculation of binomial coefficients
for j=1:n
    c1(j)=(1-(1+q)/j)*cp1;
    cp1=c1(j); 
end
x(n)=((25*a+10)*(y(n-1)-x(n-1)))*h^q - rzz(x, c1, n);
y(n)=((28-35*a)*x(n) - x(n)*z(n-1) + (29*a-1)*y(n-1))*h^q - rzz(y, c1, n);
z(n)=(x(n)*y(n) - (a+8)*z(n-1)/3)*h^q - rzz(z, c1, n);
Y(1,1)=x(1,n);
Y(1,2)=y(1,n);
Y(1,3)=z(1,n);

%% a sensitivity
x1(2)=(25*(y(n-1)-x(n-1))+(25*a+10)*(y1(2-1)-x1(2-1)))*h^q - rzz(x1, c1, 2);
y1(2)=(-35*x(n)+(28-35*a)*x1(2) - x1(2)*z(n-1) - x(n)*z1(2-1) + 29*y(n-1) + (29*a-1)*y1(2-1))*h^q - rzz(y1, c1, 2);
z1(2)=(x1(2)*y(n) + x(n)*y1(2) - z(n-1)/3 - (a+8)*z1(2-1)/3)*h^q - rzz(z1, c1, 2);
Y(1,4)=x1(1,2);
Y(1,5)=y1(1,2);
Y(1,6)=z1(1,2);

%% q sensitivity
delta=0.000001;
q_delta=q-delta;
for j=1:n
    c2(j)=(1-(1+q_delta)/j)*cp2;
    cp2=c2(j); 
end
x2=((25*a+10)*(y(n-1)-x(n-1)))*h^q_delta - rzz(x, c2, n);
y2=((28-35*a)*x2 - x2*z(n-1) + (29*a-1)*y(n-1))*h^q_delta - rzz(y, c2, n);
z2=(x2*y2 - (a+8)*z(n-1)/3)*h^q_delta - rzz(z, c2, n);
Y(1,7)=(x(1,n)-x2)/delta;
Y(1,8)=(y(1,n)-y2)/delta;
Y(1,9)=(z(1,n)-z2)/delta;  
    
