#!/usr/bin/env python3

import argparse
import os
import stat
import jinja2
import shutil
from datetime import date
from jinja2 import Template
from jinja2 import Environment, PackageLoader, FileSystemLoader

# *****************************************************************************
# Project Generator
# *****************************************************************************
def generate_project (  debug               
                      , proj_name            
                      , name    
                      , surname  
                      , email):
    """
    Walk the template directory and render any templates found into the destination directory
    """
    dest_dir = proj_name + "_verif"
    # Create the template rendering environment
    env = Environment(loader=jinja2.FileSystemLoader('empty_project'))

# *****************************************************************************
    project = {}                                        #**********************
    project['author']  = name + " " + surname           #**********************
    project['email']   = email                          #**********************
    project['company'] = "KVT Verification Team"        #**********************
    project['date']    = str(date.today())              #**********************
    project['name']    = proj_name                      #**********************
# *****************************************************************************

    # Create destination path if required
    if not os.path.exists(dest_dir):
        os.mkdir(dest_dir)

    template_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), "empty_project")

    for dir, subdir_list, file_list in os.walk(template_path):
        if debug:
            print('In directory: %s' % dir)
        # Replicate any subdir structure into the destination
        try:
            not_used,template_subdir = dir.split("empty_project/")
        except ValueError:
            template_subdir = ""
        dest_path = os.path.join(dest_dir, template_subdir)
        if not os.path.exists(dest_path):
            os.mkdir(dest_path)

        if(len(template_subdir) != 0):
            if debug:
                print ('Dir to make: %s' % template_subdir)
            dest_path = os.path.join(dest_dir, template_subdir)
            if not os.path.exists(dest_path):
                os.mkdir(dest_path)
        
        for fname in file_list:
            project['file'] = os.path.splitext(fname)[0]
            if debug:
                print('\tFound File: %s' % fname)
            template = env.get_template(os.path.join(template_subdir, fname))
            rendered_template = template.render(project=project)
            
            if (dir.split("/")[-1] == "run") or (fname == "tb_top.sv") or (fname == "README.md") or (fname == ".gitignore") or (fname == ".gitmodules") or (fname == ".gitlab-ci.yml") or ('submodules' in dir.split("/")):
                if debug:
                    print('\tCopy File: %s' % fname)
                dest_filename = fname
                dest_filename = os.path.join(dest_path, dest_filename)
            else:
                dest_filename = "kvt_" + proj_name + fname
                dest_filename = os.path.join(dest_path, dest_filename)
            if debug:
                print('\tCreating File: %s' % dest_filename)
            with open(dest_filename, 'w') as dp:
                dp.write(rendered_template)
                fname_tmp = dest_filename.split(".")
                if((fname_tmp[-1] == "sh" ) or (fname_tmp[-1] == "py" )):
                    print('\tFound File: %s' % dest_filename)
                    st = os.stat(dest_filename)
                    os.chmod(dest_filename, st.st_mode | stat.S_IEXEC)
                

    os.remove(dest_dir + "/kvt_" + proj_name +"_base.sv")

    cwd = os.getcwd() 

# *****************************************************************************
# Program Flow
# *****************************************************************************
# -------------------------------------
# Parse the command line options
# -------------------------------------
def main():
    parser = argparse.ArgumentParser(description='Project Generator')
    parser.add_argument('-debug', action='store_true',
                       help='Print Debug Messages')
    parser.add_argument('--proj_name', action='store', required=True,
                       help='Project Name')

    parser.add_argument('--name', action='store',required=True,
                       help='Author Name')
    
    parser.add_argument('--surname', action='store',required=True,
                       help='Author Surname')
    
    parser.add_argument('--email', action='store',required=True,
                       help='Author Email')

    args = parser.parse_args()

    # -------------------------------------
    # Actually do the work we intend to do here
    # -------------------------------------
    generate_project(   args.debug
                     ,  args.proj_name
                     ,  args.name
                     ,  args.surname
                     ,  args.email)

    print('\t-------------------------------------------------------------------------------------------------\n')
    print('\tNew project %s_verif was create!\n' % args.proj_name)
    print('\t-------------------------------------------------------------------------------------------------\n')
    print('\tAfter that')
    print('\t1 Copy folders ./%s_verif/* in your repo' % args.proj_name)
    print('\tBUT NOT ./%s_verif/submodules FOLDER!!!\t\n' % args.proj_name)
    print('\t-------------------------------------------------------------------------------------------------\n')
    print('\t2 Add kvt_clk_rst_vip like submodule in your repo')
    print('\tgit submodule add https://github.com/kkurenkov/kvt_clk_rst_vip.git submodules/kvt_clk_rst_vip\n')
    print('\t-------------------------------------------------------------------------------------------------\n')
    print("\t3 For run project")
    print("\tcd ./%s_verif/verification/run/" % args.proj_name)
    print("\tmake base_test SEED=1\n")
    print('\t-------------------------------------------------------------------------------------------------\n')
    print("\tThat's all! Have a good day!")

# -------------------------------------
if __name__ == "__main__":
    main()
