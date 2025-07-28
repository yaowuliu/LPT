# LPT
This package provides the Locally Powerful Transformation (LPT) for quantitative responses in linear regression models. In particular, this transformation is powerful for detecting weak genetic signals in genetic assocation studies, and is computationally efficient for biobank-scale data.

## Installation
```
library(devtools)
devtools::install_github("yaowuliu/LPT")
```

## Usage
The code below provides an example about applying the transformation to variant set analysis in genetic association studies.

```
if (!requireNamespace("MORST", quietly = TRUE)) {
    library(devtools)
    devtools::install_github("yaowuliu/MORST")
}

library(MORST) # For set-based tests
library(LPT)

# Generate random phenotype data under null hypothesis
set.seed(123)
n = 1000 ## number of individuals
p = 20 ## number of SNPs

# obtain simulated genotype data
G <- matrix(sample(0:2, n * p, replace = TRUE),nrow = n, ncol = p)
Z <- rnorm(n) # covariates

# Generate standard normal phenotype under H0
Y = Z*1.2+rnorm(n)
Y_res = lm(Y~Z)$residuals

# Transform phenotype using the proposed LPT method
Y_trans = LPT(Y_res)

# Fit null model (without genetic variants)
nullmodel = Null_model_glm(Y_trans,Z)

# Example of runing set-based association tests
# SetBasedTests will give Burden, SKAT, ACAT, MORST results
# weights.beta controls the weighting of rare vs. common variants
SetBasedTests(G,obj = nullmodel,weights.beta = c(1,1))
#              Burden     SKAT    ACAT-V     MORST
#Beta(1,1) 0.03726069 0.608356 0.4328397 0.5943914
```
