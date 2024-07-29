%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : Stepwise response from Fractional-Order unified system
% Model ref: Parameter Estimation of Fractional-Order Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis

function x_cal=cal_unified_step(parameter_a,T_data,Y0,jjj)

x_cal=FO_unified_SRSA(parameter_a, T_data,Y0,jjj);