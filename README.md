# health-insurance-econometrics
Survey-weighted econometric analysis of health insurance and healthcare access using NHIS data
# Health Insurance and Healthcare Access (NHIS)

## Overview
This project analyzes disparities in healthcare utilization by insurance status using nationally representative data from the National Health Interview Survey (NHIS).

The analysis focuses on:
- Predictors of uninsurance
- Underinsurance measured through cost-related delays in care
- Differences in healthcare access driven by affordability barriers

## Data
- Source: National Health Interview Survey (NHIS), IPUMS extract
- Sample: U.S. adults (18+)
- Survey weights, strata, and PSU variables applied for nationally representative estimates

## Methods
- Survey-weighted generalized linear models (svyglm)
- Quasi-binomial specification to account for overdispersion
- Dependent variable: Delay of medical care due to cost
- Key predictors: Insurance status, cost barriers, unemployment, administrative factors

## Key Findings
- Approximately 8.8% of U.S. adults were uninsured
- Uninsured adults were ~5.3 times more likely to delay needed care due to cost
- Cost and premium increases were the primary drivers of uninsurance

## Tools
- R
- Survey package
- Excel (summary tables)
