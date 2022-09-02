#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2019-04-25 15:38:28
# @Author  : Roujia Li (liroujia0314@outlook.com)

import numpy as np
from scipy import stats
import math

abs=np.array(range(1,11)).reshape(10,1)
negative=np.random.randint(0,6,size=(10,1))
positive=np.random.randint(0,6,size=(10,1))
number=negative+positive
n=np.sum(number)

n_ne=np.sum(negative)
n_po=np.sum(positive)
x1=np.random.randint(12,50,[n_ne,1])
y1=np.zeros((n_ne,1))
i=0
for j in range(0,10):
	for k in range(0,int(negative[j])):
		y1[i]=x1[i]+10-j
		i=i+1
		pass
	pass
x2=np.random.randint(12,50,[n_po,1])
y2=np.zeros((n_po,1))
t=0
for j in range(0,10):
	for k in range(0,int(positive[j])):
		y2[t]=x2[t]-(10-j)
		t=t+1
		pass
	pass
sampleone=np.append(x1,x2,0)
sampletwo=np.append(y1,y2,0)
#print(sampleone.T)
#print(sampletwo.T)
rank=np.zeros(10).reshape(10,1)
count=0
for i in range(0,10):
	rank[i]=(count+1+count+1+number[i]-1)/2
	count=count+number[i]
D=np.hstack((abs,negative,positive,number,rank))
print(D)
R1=np.dot(positive.T,rank)
temp=0
for i in range(0,10):	
	if positive[i]!=0&negative[i]!=0:
		temp=temp+number[i]**3-number[i]
		pass
if R1!=n*(n+1)/4:
	if temp==0:
		T=(np.abs(R1-n*(n+1)/4)-0.5)/math.sqrt(n*(n+1)*(2*n+1)/24)
	else:
		T=(np.abs(R1-n*(n+1)/4)-0.5)/math.sqrt(n*(n+1)*(2*n+1)/(24-temp/48))
else:
	T=0
pvalue=2*(1-stats.norm.cdf(T))
print(pvalue)

if pvalue<0.05:
	print("reject H0,significant difference")
else:
	print("accept H0,no difference")

print(stats.wilcoxon(np.array(sampleone).flatten(),np.array(sampletwo).flatten(),zero_method='wilcox',correction=True))
