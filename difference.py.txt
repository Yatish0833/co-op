from __future__ import print_function
import sys
import os
import csv

set1=set(line.strip() for line in open("HTS_Cmpds.txt"))
set2=set(line.strip() for line in open("Pfizer_Avail_Cmpds.txt"))

#print(set1)
li= list(set2-set1)
file=open("output.txt","w+a")
for item in li:
  file.write("%s\n"%item)

