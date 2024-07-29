%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : Numerical response from Fractional-Order Incommensurate PMSM system
% Model ref: Parameter Estimation of Fractional-Order Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis


function x_cal=cal_Incommensurate_PMSM(parameter_a)
global Tdata 
% initial values
Y0=[42;4;4];
x_cal=FO_Incommensurate_PMSM(parameter_a, Tdata, Y0);
