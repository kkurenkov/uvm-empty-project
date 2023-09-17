#!/usr/bin/python
from sys import argv
import random

random.seed(argv[1])

param_name  = argv[2]
file_name   = argv[2]+"_pkg.sv"
pkg_name    = argv[2]+"_pkg"
word_size   = int(argv[3]);
word_num    = int(argv[4]);

word_size_hex   = int(word_size/4)

#------------------------------------

file = open(file_name, 'w')
file.write("package %s"%(pkg_name) + ";\n")
file.write("\tparameter bit [%d:0][%d:0] %s =\n" %(word_num-1, word_size-1, param_name))
file.write("\t{\n")
for i in range (word_num):
    if (i == word_num-1):
        file.write("\t\t" + "%d'h"%(word_size) + "%s"%(format(random.getrandbits(word_size), 'X')).zfill(word_size_hex) + "\t//%x\n"%(i))
    else:
        file.write("\t\t" + "%d'h"%(word_size) + "%s"%(format(random.getrandbits(word_size), 'X')).zfill(word_size_hex) + ",\t//%x\n"%(i))
file.write("\t};\n")
file.write("endpackage")
file.close()