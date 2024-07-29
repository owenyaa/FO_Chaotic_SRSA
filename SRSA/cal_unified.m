%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : Numerical response from Fractional-Order unified system
% Model ref: Parameter Estimation of Fractional-Order Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis

function x_cal=cal_unified(parameter_a)
global Tdata 

% initial values
Y0=[5;8;10;0;0;0;5;8;10];
x_cal=FO_unified(parameter_a, Tdata, Y0);
