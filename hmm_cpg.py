#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2019-05-01 14:07:12
# @Author  : Roujia Li (liroujia0314@outlook.com)

import numpy as np
from hmmlearn import hmm
from sklearn.preprocessing import LabelEncoder
from random import randint

states = ["G", "I"]
n_states = len(states)

emissions = ["C", "G", "A", "T"]
n_emissions = len(emissions)

discrete_emissions = LabelEncoder().fit_transform(emissions)
print ("LabelEncoder().fit_transform(emissions) = ", discrete_emissions)
emission_dict = dict(zip(emissions, discrete_emissions))
print ("emission_dict = ", emission_dict)

start_probability = np.array([0.99,0.01])
transition_probability = np.array([[0.99999, 0.00001],[0.001,0.999]])
emission_probability = np.array([
  [0.2, 0.3, 0.3, 0.2],
  [0.3, 0.2, 0.2, 0.3],
])

model = hmm.MultinomialHMM(n_components = n_states, params = "ste", init_params = "ste", n_iter = 50)
model.startprob_ = start_probability
model.transmat_ = transition_probability
model.emissionprob_ = emission_probability
sample_seq1 = []
delimiters=['\n','\r',' ']
with open('hmm_dataset.txt', 'r') as f: 
    # Read in entire sequence in file and remove all carriage returns "\n"
    sample_seq1 = list(f.read().replace('\n', ''))
    f.closed

sample_seq1=[x for x in sample_seq1 if x not in delimiters]
sample_seq2 = [emission_dict[e] for e in sample_seq1]

sample_seq = np.array([sample_seq2]).T

model = model.fit(sample_seq)

model_parameters = model.get_params(deep = True)
print ("Model Parameters = ", model_parameters)
print ("Changed emission probabilities:")
print(model.emissionprob_)
print("Changed initial probabilities:")
print(model.startprob_)
print("Changed transition probabilities:")
print(model.transmat_)
print ("")

logprob, hidden_model = model.decode(sample_seq, algorithm="viterbi")
print ("Length Of Sample Sequence = ", len(sample_seq1))
state_sequence=[]
state_sequence=list(map(lambda x: states[x], hidden_model))
print ("Hidden Model (i.e., from  Viterbi Algorithm):")
print ("-------------------------------------------------------")
print (state_sequence)

i=1
count=0
while i <= (len(state_sequence)-2):
    if (state_sequence[i]=='G' and state_sequence[i+1]=='G' and i+1<len(state_sequence)):
        str=sample_seq1[i-1]
        index=i
        while state_sequence[i+1]=='G':
            str=str+sample_seq1[i]
            i=i+1
        str=str+sample_seq1[i]+sample_seq1[i+1]
        #print ("start index:",index,"->",str,"->",i)
        count=count+1
        i=i+1
    else:
        i=i+1
print ("")
print ("Total number of CpG pairs encountered in Viterbi algo:",count)

print (">>> Compute the log probability under the model.")
model_score = model.score(sample_seq)
print ("Model Score = ", model_score)
print(logprob)
print (">>> Compute the model posteriors (using Forward & Backward algorithm).")
model_posterior_probs = model.predict_proba(sample_seq)
print ("Model Posterior Probss = ")
print(model_posterior_probs)
print ("Length of Posteriors = ", len(model_posterior_probs))
