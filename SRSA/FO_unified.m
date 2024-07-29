%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : Numerical response: FO chaotic unified system
% Model ref: Parameter Estimation of Fractional-Order Chaotic Systems Based on Stepwise Integration and Response Sensitivity Analysis

function Y=FO_unified(parameter_a, Tdata, Y0)
global h
%%   FO unified system
%   D^q x(t) = (25a+10)(y(t)-x(t))
%   D^q y(t) = (28-35a)x(t) - x(t)z(t) + (29a-1)y(t)
%   D^q z(t) = x(t)y(t) - (a+8)z(t)/3
n=length(Tdata);


%% System parameter
a=parameter_a(1); 
q=parameter_a(2); 
% q=0.9; 
%% initial value of the binomial coefficient
cp1=1; 
%% Initial condition
x(1)=Y0(1); y(1)=Y0(2); z(1)=Y0(3);



%% The initial value and calculation of binomial coefficients
for j=1:n
    c1(j)=(1-(1+q)/j)*cp1;
    cp1=c1(j); 
end
for i=2:n
    x(i)=((25*a+10)*(y(i-1)-x(i-1)))*h^q - rzz(x, c1, i);
    y(i)=((28-35*a)*x(i) - x(i)*z(i-1) + (29*a-1)*y(i-1))*h^q - rzz(y, c1, i);
    z(i)=(x(i)*y(i) - (a+8)*z(i-1)/3)*h^q - rzz(z, c1, i);
end
for j=1:n
    Y(j,1)=x(1,j);
    Y(j,2)=y(1,j);
    Y(j,3)=z(1,j);
end