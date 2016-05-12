#!/usr/bin/env python
#####################################################################
# Author Yatish Jain
####################################################################
# This program takes two input, sdf file and name of ouput file csv format.
# This program runs through each molecule of sdf file and
# extracts the all the properties and converts it into csv.
###################################################################
# sample execution line: python smiles.py molecules.sdf molecules.csv
##################################################################
import sys
from openeye.oechem import *

def main(argv=[__name__]):
    if len(argv) != 3:
        OEThrow.Usage("%s <infile> <outFile> " % argv[0])

    infile = argv[1]
    outfile = argv[2]
    ifs = oemolistream()
    if not ifs.open(infile):
        OEThrow.Fatal("Unable to open %s for reading" % argv[1])    

    ofs = oemolostream()
    ofs.SetFormat(OEFormat_CSV)
    if not ofs.open(outfile):
        OEThrow.Fatal("Cannot open output file!")

    hit = OEGraphMol()
    for mol in ifs.GetOEGraphMols():
	#smi = OEMolToSmiles(mol)
	OEWriteMolecule(ofs, mol)



if __name__ == "__main__":
    sys.exit(main(sys.argv))
