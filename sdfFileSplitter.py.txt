#!/usr/bin/env python
from __future__ import print_function
import sys, os

#######################################################################################
# This program takes 2 input. sdf input file and number of molecules for split.
# Split the big sdf file into several files with each file containing the above
# mentioned molecules in the directory named output.
#######################################################################################
# Sample execution line: python sdfFileSplitter.py molecules.sdf 10
######################################################################################

input_sdf = open(sys.argv[1],"r")
max_molecules = sys.argv[2]
counter=1
mol=""
ctr=1

path='output/'
if not os.path.exists(path):
	os.makedirs(path)

o= open("output/filename_"+str(ctr) + ".sdf","w")

for line in input_sdf:
	mol+=line
	if "$$$$" in line:
		o.write(mol)
		if counter > 0 and counter % max_molecules == 0:
			o.close()
			ctr+=1
			o= open("output/filename_"+str(ctr) + ".sdf","w")
		mol=""
		counter+=1
o.close()

