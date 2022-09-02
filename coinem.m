function [pnew,qnew]=coinem(K,N,D,p,x,q)
%K个硬币
%抽取N回
%每回扔D次
f=zeros(K,N);
m=zeros(K,N);
pnew=zeros(K,1);
qnew=zeros(K,1);
temp1=zeros(K,N);
temp2=zeros(K,N);
for n=1:N
    for k=1:K
        m(k,n)=p(k)* binopdf(x(n),D,q(k));
        f(k,n)=m(k,n)./sum(m(:,n));
        pnew(k)=sum(f(k,:))/N;
        temp1(:,n)=x(n).*f(:,n);
        temp2(:,n)=D.*f(:,n);
        qnew(k)=sum(temp1(k,:))/sum(temp2(k,:));
    end    
end
pold=p;
qold=q; 
if norm([pold;qold]-[pnew;qnew])>0.000001
    pold=pnew;
    qold=qnew;
    for n=1:N
    for k=1:K
        m(k,n)=pold(k)* binopdf(x(n),D,qold(k));
        f(k,n)=m(k,n)./sum(m(:,n));
        pnew(k)=sum(f(k,:))/N;
        temp1(:,n)=x(n).*f(:,n);
        temp2(:,n)=D.*f(:,n);
        qnew(k)=sum(temp1(k,:))/sum(temp2(k,:));
    end
    end  
end







