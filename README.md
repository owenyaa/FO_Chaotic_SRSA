This repository contains codes and data for the following publication:
* Tao Zhang, Zhong-rong Lu, Ji-ke Liu, Guang, Liu*. [Parameter Estimation of Fractional Chaotic Systems Based on Stepwise Integration and Response Sensitivity Analysis]

SRSA is a parameter estimation approach for fractional chaotic systems based on stepwise integration and response sensitivity analysis. 

## Framework
FO_Chaotic_SRSA
This program corresponds to the several numerical examples of this article

## Repository Overview
 # forward problem
  * data_unified.m - Codes for obtaining the measured data of fractional order unified system.
  * data_Commensurate_PMSM.m - Codes for obtaining the measured data of commensurate fractional order PMSM system.
  * data_Incommensurate_PMSM.m - Codes for obtaining the measured data of incommensurate fractional order PMSM system.
 # main program
  * main_unified_SRSA.m - Codes for the parameter identification of fractional order unified system.
  * main_Commensurate_PMSM_SRSA.m - Codes for the parameter identification of commensurate fractional order PMSM system.
  * main_Incommensurate_PMSM_SRSA.m - Codes for the parameter identification of incommensurate fractional order PMSM system.
 # SRSA package
  * FO_unified.m - Codes for the numerical response of fractional order unified system.
  * FO_Commensurate_PMSM.m - Codes for the numerical response of commensurate fractional order PMSM system.
  * FO_Incommensurate_PMSM.m - Codes for the numerical response of incommensurate fractional order PMSM system.
  * FO_unified_SRSA.m - Codes for the Stepwise response and sensitivity of fractional order unified system.
  * FO_Commensurate_PMSM_SRSA.m - Codes for the Stepwise response and sensitivity of commensurate fractional order PMSM system.
  * FO_Incommensurate_PMSM_SRSA.m - Codes for the Stepwise response and sensitivity of incommensurate fractional order PMSM system.
  * rzz.m - Codes for the binomial coefficients calculation.
  * settick.m - Codes for figures.
  * csvd.m  l_corner.m  l_curve.m  lcfun.m  polt_lc.m  tikhonov.m  - Codes form the Regularization Tools by Per Christian Hansen and IMM.
  
  
## Citation
Please cite the following paper if you find the work relevant and useful in your research:
