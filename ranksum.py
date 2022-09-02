#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2019-04-25 21:36:17
# @Author  : Roujia Li (liroujia0314@outlook.com)

import numpy as np
from scipy import stats
import math
cate=np.array(range(1,9)).reshape(8,1)
sample_one=np.array([5,9,6,3,2,0,0,0]).reshape(8,1)
sample_two=np.array([1,5,4,4,8,5,2,1]).reshape(8,1)
number=sample_one+sample_two
n1=np.sum(sample_one)
n2=np.sum(sample_two)
print(n1,n2)
rank=np.zeros(8).reshape(8,1)
count=0
for i in range(0,8):
	rank[i]=(count+1+count+1+number[i]-1)/2
	count=count+number[i]
D=np.hstack((cate,sample_one,sample_two,number,rank))
print(D)
R1=np.dot(sample_one.T,rank)
temp=0
for i in range(0,8):	
	if sample_one[i]!=0&sample_two[i]!=0:
		temp=temp+number[i]**3-number[i]
	else:
		pass
if R1!=n1*(n1+n2+1)/2:
	if temp==0:
		T=(np.abs(R1-n1*(n1+n2+1)/2)-0.5)/math.sqrt(n1*n2*(n1+n2+1)/12)
	else:
		T=(np.abs(R1-n1*(n1+n2+1)/2)-0.5)/math.sqrt(n1*n2*(n1+n2+1-temp/((n1+n2)*(n1+n2+1))/12))
else:
	T=0
print('检验统计量T值为：')
print(T)
pvalue=2*(1-stats.norm.cdf(T))
print('pvalue为：')
print(pvalue)

if pvalue<0.05:
	print("reject H0,significant difference")
else:
	print("accept H0,no difference")

print('the result of scipy.stats.ranksums:')

print(stats.ranksums([5,9,6,3,2,0,0,0], [1,5,4,4,8,5,2,1]))
