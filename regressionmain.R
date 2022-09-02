#模拟数据
b=as.matrix(c(0,0,0,1,0,1,0))
x=cbind(matrix(1,10,1),runif(10,1,2),runif(10,3,4),runif(10,5,6),runif(10,2,3),runif(10,11,12),runif(10,8,9))
y=x%*%b

#最小二乘
source("ls.R")
b_ls=ls(x,y)
error_ls=sqrt(sum((b_ls-b)^2))
b_ls
error_ls

#岭回归
source("rg.R")
result_rg=ridgeregression(x,y)
b_rg=result_rg[1:7]
lamda_rg=result_rg[8]
error_rg=sqrt(sum((b_rg-b)^2))
b_rg
lamda_rg
error_rg

#LASSO
source("lasso.R")
result_lasso=lasso(x,y)
b_lasso=result_lasso[1:7]
lamda_lasso=result_lasso[8]
error_lasso=sqrt(sum((b_lasso-b)^2))
b_lasso
lamda_lasso
error_lasso