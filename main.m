%硬币
p=rand(3,1);
p=p/sum(p);%paik 抽到各个硬币的概率
x=randi(10,5,1)%N回抽取分别正面次数
q=rand(3,1);%K枚硬币各自正面朝上的概率
[a,b]=coinem(3,5,10,p,x,q)

%高斯
mu1=[0 0];  %均值
S1=[0.1 0 ;0 0.1];  %协方差
data1=mvnrnd(mu1,S1,5);   %产生高斯分布数据
mu2=[1 1];
S2=[0.1 0 ;0 0.1];
data2=mvnrnd(mu2,S2,5);
mu3=[-1 1];
S3=[0.1 0 ;0 0.1];
data3=mvnrnd(mu3,S3,5);
data=[data1;data2;data3];%利用三个不同的高斯分布产生的数据作为样本
l=length(data);
pg=rand(3,1);
pg=pg/sum(pg);%paik 初始属于各个分布的概率
u0=[mean(data1);mean(data2);mean(data3)];%设定初始均值
s0=[cov(data1);cov(data2);cov(data3)];%设定初始方差
[a2,b2,c2]=gaussem(2,3,15,pg,u0,s0,data)%参数收敛
[a22,b22,c22]=gaussem2(2,3,15,pg,u0,s0,data)%对数似然函数收敛

%基因数据
genedata=csvread('gene.csv',0,2,[0,2,498,7]);
%plot(genedata(:,1),genedata(:,2),'b*')
pg2=rand(2,1);
pg2=pg2/sum(pg2)%paik 初始属于各个分布的概率;
u1=[genedata(randi(499),:);genedata(randi(499),:)];
s1=[cov(genedata);cov(genedata)];
[a3,b3,c3]=gaussem(6,2,499,pg2,u1,s1,genedata)
