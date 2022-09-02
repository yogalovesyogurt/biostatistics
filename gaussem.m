function[pnew,unew,snew]=gaussem(m,K,N,p,u,s,data)
%参数收敛作为收敛条件
%K 高斯分布个数
%N 点个数
%m高斯维数
z=ones(N,K);
q=ones(N,K);
for n=1:N
    for k=1:K
        q(n,k)=p(k)*mvnpdf(data(n,:),u(k,:),s(m*(k-1)+1:m*k,:));
        z(n,k)=q(n,k)/sum(q(n,:));
    end
end
pnew=sum(z)'/N;
unew=ones(K,m);
snew=zeros(m*K,m);
for k=1:K
    unew(k,:)=sum(z(:,k).*data)./sum(z(:,k));
    for n=1:N
    snew(m*(k-1)+1:m*k,:)=snew(m*(k-1)+1:m*k,:)+z(n,k)*(data(n,:)-unew(k,:))'*(data(n,:)-unew(k,:))/sum(z(:,k));
    end
end
pold=p;
uold=u;
sold=s;

if norm(pold-pnew)>0.000001||norm(uold-unew)>0.000001||norm(sold-snew)>0.000001
    pold=pnew;
    uold=unew;
    sold=snew;
    snew=zeros(m*K,m);
    for n=1:N
    for k=1:K
        q(n,k)=pold(k)*mvnpdf(data(n,:),uold(k,:),sold(m*(k-1)+1:m*k,:));
        z(n,k)=q(n,k)/sum(q(n,:));
    end
    end
    pnew=sum(z)'/N;
    for k=1:K
    unew(k,:)=sum(z(:,k).*data)./sum(z(:,k));
    for n=1:N
    snew(m*(k-1)+1:m*k,:)=snew(m*(k-1)+1:m*k,:)+z(n,k)*(data(n,:)-unew(k,:))'*(data(n,:)-unew(k,:))/sum(z(:,k));
    end
    end
end
end