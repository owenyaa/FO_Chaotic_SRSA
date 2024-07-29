%% Author : TAO ZHANG  * zt1996nic@gmail.com *
% Created Time : 2022-10-01 08:58
% Last Revised : TAO ZHANG ,2023-03-19
% Remark : binomial coefficients calculation
% Model ref: Parameter Estimation of Fractional-Order Chaotic Systems 
% Based on Stepwise Integration and Response Sensitivity Analysis

function [yo] = rzz(r, c, k)
temp = 0;
for j=1:k-1
   temp = temp + c(j)*r(k-j);
end
yo = temp;
