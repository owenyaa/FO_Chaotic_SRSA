%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : Numerical response: Fractional-Order Commensurate PMSM system
% Model ref: Parameter Estimation of Fractional-Order Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis

function Y=FO_Commensurate_PMSM(parameter_a, Tdata, Y0)
global h
%   Fractional-Order Commensurate PMSM system
%   D^q x(t) = -x(t) + z(t) y(t)
%   D^q y(t) = - y(t) - z(t) x(t) + az(t)
%   D^q z(t) =   b (y(t) - z(t))

n=length(Tdata);

%% System parameter
a=parameter_a(1); b=parameter_a(2); q=parameter_a(3); 
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
    x(i)=(-x(i-1)+z(i-1)*y(i-1))*h^q - rzz(x, c1, i);
    y(i)=(-y(i-1)-x(i)*z(i-1)+a*z(i-1))*h^q - rzz(y, c1, i);
    z(i)=(b*(y(i)-z(i-1)))*h^q - rzz(z, c1, i);
end
for j=1:n
    Y(j,1)=x(1,j);
    Y(j,2)=y(1,j);
    Y(j,3)=z(1,j);
end