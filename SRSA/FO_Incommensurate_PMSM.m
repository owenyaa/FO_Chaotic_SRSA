%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : Numerical response: Fractional-Order Incommensurate PMSM system
% Model ref: Parameter Estimation of Fractional-Order Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis

function Y=FO_Incommensurate_PMSM(parameter_a, Tdata, Y0)
global h

%   Fractional-Order Incommensurate PMSM system
%   D^q1 x(t) = -x(t) + z(t) y(t)
%   D^q2 y(t) = - y(t) - z(t) x(t) + az(t)
%   D^q3 z(t) =   b (y(t) - z(t))

n=length(Tdata);

%% System parameter
a=parameter_a(1); b=parameter_a(2); 
q1=parameter_a(3); 
q2=parameter_a(4);
q3=parameter_a(5);
%% initial value of the binomial coefficient
cp1=1; cp2=1; cp3=1;
%% Initial condition
x(1)=Y0(1); y(1)=Y0(2); z(1)=Y0(3);
%% The initial value and calculation of binomial coefficients
for j=1:n
    c1(j)=(1-(1+q1)/j)*cp1;
    c2(j)=(1-(1+q2)/j)*cp2;
    c3(j)=(1-(1+q3)/j)*cp3;
    cp1=c1(j); cp2=c2(j); cp3=c3(j);
end
for i=2:n
    x(i)=(-x(i-1)+z(i-1)*y(i-1))*h^q1 - rzz(x, c1, i);
    y(i)=(-y(i-1)-x(i)*z(i-1)+a*z(i-1))*h^q2 - rzz(y, c2, i);
    z(i)=(b*(y(i)-z(i-1)))*h^q3 - rzz(z, c3, i);
end
for j=1:n
    Y(j,1)=x(1,j);
    Y(j,2)=y(1,j);
    Y(j,3)=z(1,j);
end