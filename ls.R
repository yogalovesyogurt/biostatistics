ls=function(x,y)
{
  estimated_b=solve(t(x)%*%x)%*%t(x)%*%y
  return(estimated_b)
}