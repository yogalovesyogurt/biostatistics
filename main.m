%Ӳ��
p=rand(3,1);
p=p/sum(p);%paik �鵽����Ӳ�ҵĸ���
x=randi(10,5,1)%N�س�ȡ�ֱ��������
q=rand(3,1);%KöӲ�Ҹ������泯�ϵĸ���
[a,b]=coinem(3,5,10,p,x,q)

%��˹
mu1=[0 0];  %��ֵ
S1=[0.1 0 ;0 0.1];  %Э����
data1=mvnrnd(mu1,S1,5);   %������˹�ֲ�����
mu2=[1 1];
S2=[0.1 0 ;0 0.1];
data2=mvnrnd(mu2,S2,5);
mu3=[-1 1];
S3=[0.1 0 ;0 0.1];
data3=mvnrnd(mu3,S3,5);
data=[data1;data2;data3];%����������ͬ�ĸ�˹�ֲ�������������Ϊ����
l=length(data);
pg=rand(3,1);
pg=pg/sum(pg);%paik ��ʼ���ڸ����ֲ��ĸ���
u0=[mean(data1);mean(data2);mean(data3)];%�趨��ʼ��ֵ
s0=[cov(data1);cov(data2);cov(data3)];%�趨��ʼ����
[a2,b2,c2]=gaussem(2,3,15,pg,u0,s0,data)%��������
[a22,b22,c22]=gaussem2(2,3,15,pg,u0,s0,data)%������Ȼ��������

%��������
genedata=csvread('gene.csv',0,2,[0,2,498,7]);
%plot(genedata(:,1),genedata(:,2),'b*')
pg2=rand(2,1);
pg2=pg2/sum(pg2)%paik ��ʼ���ڸ����ֲ��ĸ���;
u1=[genedata(randi(499),:);genedata(randi(499),:)];
s1=[cov(genedata);cov(genedata)];
[a3,b3,c3]=gaussem(6,2,499,pg2,u1,s1,genedata)
