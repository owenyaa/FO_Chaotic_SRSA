%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : Numerical response from Fractional-Order Commensurate PMSM system
% Model ref: Parameter Estimation of Fractional-Order Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis

function x_cal=cal_Commensurate_PMSM(parameter_a)
global Tdata 

Y0=[100;8;8];
x_cal=FO_Commensurate_PMSM(parameter_a, Tdata, Y0);
