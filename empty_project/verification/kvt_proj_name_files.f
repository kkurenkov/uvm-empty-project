# Subsystem interconnect

##########################  incdirs for files #######################
# -incdir <dirs>            Specify directories to search for `include files

-incdir ${VE_HOME}/verification
-incdir ${VE_HOME}/verification/uvm/env
-incdir ${VE_HOME}/verification/uvm/env/cfg
-incdir ${VE_HOME}/verification/tests

##########################  Files necessary for simulation #######################
#-F <filename>              Scan file for args relative to file location
#-f <filename>              Scan file for args relative to xrun invocation

# -f ${VE_HOME}/submodules/*.f
# -F ${VE_HOME}/submodules/proj_name/*.f

${VE_HOME}/verification/kvt_proj_name_inc.sv