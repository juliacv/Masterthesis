#!/usr/bin/env python
# coding: utf-8

#Import packages
import sys

#efficientdet-d0_49_1400.pth

filename = sys.argv[1]

#Find the compound_number
file_n = str(filename)
file_n = file_n.split("_")
file_n = file_n[0].split("-")
comp = file_n[1].replace("d","")

#Make a compound file
compound_file = "Effdet_compound.txt"

file = open(compound_file, "w")
file.write(f"{comp}")
file.close()


