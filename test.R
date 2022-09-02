b=as.matrix(c(0,0,0,1,0,1,0))
x=cbind(matrix(1,10,1),runif(10,1,2),runif(10,3,4),runif(10,5,6),runif(10,2,3),runif(10,11,12),runif(10,8,9))
y=x%*%b
b_es=matrix(0,7,1)
error=5
for(i in 1:5)
{
  index=nrow(x)
  index1=sample(index,round(0.7*index))
  trainingx=x[index1,]}
  trainingy=as.matrix(y[index1,])
  testingx=x[-index1,]
  testingy=as.matrix(y[-index1,])
  b0=as.matrix(sample(0:1,7,replace = T))
  b1=matrix(0,7,1)
  lamda=runif(10,0,10)
  for(j in 1:10)
  {
    if(dist(b0,b1)>1e-03)
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
        N=crossprod(trainingx[,m],r)/7
        if(abs(N)<=lamda[j])
          b0[m]=0
        else
          b0[m]=sign(N)*(abs(N)-lamda[j])*7/crossprod(trainingx[,m],trainingx[,m])
        
      }
      print(b0)
    }
    testingy_et=testingx%*%b0
    error1=dist(testingy,testingy_et)
    print(error1)
    if(error>=error1)
    {
      error=error1
      b_es=b0
    }
    else
    {
      error=error
      b_es=b_es
    }
  }
print(b_es)
print(error)

dist=function(a,b)
{
  return(sqrt(sum((a-b)^2)))
}