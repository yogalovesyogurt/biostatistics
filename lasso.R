lasso=function(x,y)
{
  b_es=matrix(0,7,1)
  error=5
  for(i in 1:100)
  {
    index=nrow(x)
    index1=sample(index,round(0.7*index))
    trainingx=x[index1,]
    trainingy=y[index1,]
    testingx=x[-index1,]
    testingy=y[-index1,]
    b0=as.matrix(runif(7,0,1))
    b1=matrix(0,7,1)
    lamda=runif(100,0,10)
    for(j in 1:100)
    {
      if(dist(b0,b1)>1e-06)
      {
        b1=b0
        for(m in 1:7)
      {
          r=trainingy
          for(k in 1:7)
        {
          if(k!=m)
          r=r-trainingx[,k]*b0[k]
        }
          N=crossprod(trainingx[,m],r)/(0.7*index)
          if(abs(N)<=lamda[j])
            b0[m]=0
          else
            b0[m]=sign(N)*(abs(N)-lamda[j])*7/crossprod(trainingx[,m],trainingx[,m])
      }
      }
      testingy_et=testingx%*%b0
      error1=dist(testingy,testingy_et)
      if(error>=error1)
        {
        error=error1
        b_es=b0
        lam=lamda[j]
        }
      else
        {
        error=error
        b_es=b_es
        }
    }
  }
  result=rbind(b_es,lam)
  return(result)
}

dist=function(a,b)
{
  return(sqrt(sum((a-b)^2)))
}