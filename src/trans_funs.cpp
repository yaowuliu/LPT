#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector TransKernelY (NumericVector Y, double b){
    if (b <= 0 ){
        stop("bandwidth b must be greater than 0!");
    }

    const int n = Y.length();
    double diff = 0.0;
    double Ex_val = 0.0;
    double Exd_val = 0.0;
    double SumEx_i = 0.0;
    double SumExd_i= 0.0;

    double thresh = 6.2*b;
    NumericVector Ytrans(n);

    NumericVector Ex(n);
    NumericVector Exd(n);


    for (int i = 0; i < n; i++){
        SumEx_i = Ex[i]+1;
        SumExd_i= -Exd[i];

        for (int j = (i+1); j< n; j++){
            diff = Y[i] - Y[j];
            if (abs(diff) < thresh){
                Ex_val = exp(-(pow(diff/b,2)/2));
                Exd_val = Ex_val*diff;

                SumEx_i += Ex_val;
                SumExd_i += Exd_val;
                Ex[j] += Ex_val;
                Exd[j] += Exd_val;
            }
        }

        Ytrans[i] = SumExd_i/SumEx_i;
    }

    return(Ytrans);
}

