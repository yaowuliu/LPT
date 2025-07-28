

#' Applies the locally most powerful kernel-based transformation to a vector of quantitative responses.

#'@param Y a numeric vectors of quantitative responses (or residuals).
#'@return The transformed responses.

#'@references Liu, Y. and Wang, T. (2025+). A powerful transformation of quantitative responses for biobank-scale association studies.  \emph{Journal of the American Statistical Association}, To apprear.
#'@examples An example about how to apply the transformation to variant set analysis in genetic association studies.
#'@examples library(MORST) # For set-based tests
#'@examples
#'@examples # Generate random phenotype data under null hypothesis
#'@examples set.seed(123)
#'@examples n = 1000 ## number of individuals
#'@examples p = 20 ## number of SNPs
#'@examples
#'@examples # obtain simulated genotype data
#'@examples G <- matrix(sample(0:2, n * p, replace = TRUE),nrow = n, ncol = p)
#'@examples Z <- rnorm(n) # covariates
#'@examples
#'@examples # Generate standard normal phenotype under H0
#'@examples Y = Z*1.2+rnorm(n)
#'@examples Y_res = lm(Y~Z)$residuals
#'@examples
#'@examples # Transform phenotype using the proposed LPT method
#'@examples Y_trans = LPT(Y_res)
#'@examples
#'@examples # Fit null model (without genetic variants)
#'@examples nullmodel = Null_model_glm(Y_trans,Z)
#'@examples 
#'@examples # Example of runing set-based association tests
#'@examples # SetBasedTests will give Burden, SKAT, ACAT, MORST results
#'@examples # weights.beta controls the weighting of rare vs. common variants
#'@examples SetBasedTests(G,obj = nullmodel,weights.beta = c(1,1))



LPT <- function(Y){
    return(TransKernelY(Y,b=bw.nrd(Y)))
}

