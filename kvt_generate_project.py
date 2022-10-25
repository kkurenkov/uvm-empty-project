#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os
import shutil
import sys
import argparse

def main():
	discr='Creating an UVM enviroment with base test. \t  \t  \t '
	parser = argparse.ArgumentParser(description=discr, usage ="python proj_name")
	parser.add_argument("proj_name", type=str, help= "The parameter proj_name determines the name of unit for testing.\n This parameter is required.")
	args = parser.parse_args()
	
	EMPTY_PROJ_DIRECTORY = os.getcwd() + "/empty_project"
	NEW_PROJ_DIRECTORY = os.getcwd() + "/" +  args.proj_name + "_verif"

	# print("NEW_PROJ_DIRECTORY = ", NEW_PROJ_DIRECTORY)
	# print("EMPTY_PROJ_DIRECTORY = ", EMPTY_PROJ_DIRECTORY)

	try:
		shutil.copytree(EMPTY_PROJ_DIRECTORY, NEW_PROJ_DIRECTORY)
	except Exception:
		print("ERROR! Folder  " + NEW_PROJ_DIRECTORY + " EXIST! ")
		sys.exit(2)

	p = os.walk(NEW_PROJ_DIRECTORY)

	for root, dirs, files in p:
		for file in files:
			if((file.find(".f") != -1) or (file.find(".sv") != -1)):
				# print(file)
				template_f = open(os.path.join(root, file), "r")
				template_f_context = template_f.read()
				user_f_name = file.replace("proj_name", args.proj_name)
				# print(user_f_name)
				user_f_context = template_f_context.replace("proj_name", args.proj_name)
				user_f_context = user_f_context.replace("proj_name".upper(), args.proj_name.upper())
				user_f = open(os.path.join(root, user_f_name), "w")
				user_f.write(user_f_context)
				user_f.close()
				template_f.close()
				if(user_f_name != file):
					os.remove(os.path.join(root, file))
				# print("Creating file:", user_f_name)
			else:
				out = open(os.path.join(root, file+"_copy"), "w")
				template_f = open(os.path.join(root, file), "r")
				for line in template_f:
					line = line.replace("proj_name", args.proj_name)
					out.write(line)
				out.close()
				template_f.close()
				os.system("mv " + root + "/" + file+"_copy " + root + "/" + file)

	print("\n\n")
	print("Your project located in -> ", NEW_PROJ_DIRECTORY)
	print("\nAll ok! \n")


if __name__ == "__main__":
	main()
