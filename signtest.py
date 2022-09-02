#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2019-04-25 14:44:53
# @Author  : Roujia Li (liroujia0314@outlook.com)

import random
import numpy as np
from scipy import stats
import math
# T=random.randint(10,100)#total
# n=random.randint(1,T)#nonzero
# c=random.randint(0,n)#positive
sampleone=np.random.randint(0,60,[30,1])
sampletwo=np.random.randint(0,60,[30,1])
print(sampleone.T)
print(sampletwo.T)
def signtest(x,y):
	d=x-y
	n=0
	c=0
	for i in range(d.shape[0]):
		if d[i]!=0:
			n=n+1
			if d[i]>0:
				c=c+1
	print(n,c)
	#normal method
	if n>20:
		if c>n/2:
			pvalue=2*(1-stats.norm.cdf((c-n/2-0.5)/math.sqrt(n/4)))
		elif c<n/2:
			pvalue=2*stats.norm.cdf((c-n/2+0.5)/math.sqrt(n/4))
		else:
			pvalue=1
	#binominal method
	else:
		if c>n/2:
			pvalue=2*(1-stats.binom.cdf(c-1,n,0.5))
		elif c<n/2:
			pvalue=2*stats.binom.cdf(c,n,0.5)
		else:
			pvalue=1
	return pvalue
# data=np.append(sampleone,sampletwo,1)
# print(data)
pvalue_cal=signtest(sampleone,sampletwo)
print(pvalue_cal)
