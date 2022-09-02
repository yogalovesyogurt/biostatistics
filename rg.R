ridgeregression=function(x,y)
{
  lamda=rep(0,100)
  error=rep(1,100)
  for(i in 1:100)
  {
  index=nrow(x)
  index1=sample(index,round(0.7*index))
  trainingx=x[index1,]
  trainingy=y[index1,]
  testingx=x[-index1,]
  testingy=y[-index1,]
   lamda1=runif(100,0,10)
   error1=rep(1,100)
   for(j in 1:100)
   {
   b=solve(t(trainingx)%*%trainingx+lamda1[j]*diag(1,7))%*%t(trainingx)%*%trainingy
   et_y=testingx%*%b
   error1[j]=sqrt(sum((et_y-testingy)^2))
   }
   error[i]=min(error1)
   lamda[i]=lamda1[which.min(error1)]
  }
  lam=lamda[which.min(error)]
  estimated_b=solve(t(x)%*%x+lam*diag(1,7))%*%t(x)%*%y
  result=rbind(estimated_b,lam)
   return(result)
}