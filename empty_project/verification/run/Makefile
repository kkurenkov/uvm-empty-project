#| ----------------------------------------------------------------------------
#| Author:   Konstantin Kurenkov
#| Email:    krendkrend@gmail.com
#| Create date: 19/10/2022
#| ----------------------------------------------------------------------------

export VE_HOME      ?= ../..
export COVERAGE_DIR ?= ../coverage
export TESTS_DIR    ?= ../tests
GUI ?= 0
UVM_VERB ?= UVM_MEDIUM

ifeq ($(GUI), 0)
	ENGUI= +ADD_CLI_FORMATTER=1
else 
	ENGUI= -gui
endif

ifndef SEED
  seed := $(strip $(shell head -1 /dev/urandom | od -N 2 -D -A n | awk '{print $1}') )
else
  seed := ${SEED}
endif
##############################

TESTNAME 	?= base_test
ITERATIONS  ?= 1

##############################

TOOL = xrun
TOOL_OPTS  = -64bit
TOOL_OPTS += -l ../logs/$@_${seed}.log
TOOL_OPTS += -v93
TOOL_OPTS += -relax
TOOL_OPTS += -namemap_mixgen
TOOL_OPTS += -sv
TOOL_OPTS += -timescale 1ns/1ns
TOOL_OPTS += -vtimescale 1ns/1ns
TOOL_OPTS += -bb_sigsize 40000
TOOL_OPTS += -disable_sem2009
TOOL_OPTS += -libext .v
TOOL_OPTS += -libext .sv
TOOL_OPTS += -warn_multiple_driver
TOOL_OPTS += -pathpulse
TOOL_OPTS += -access +rwc
# TOOL_OPTS += top tb_top
############################
UVM_OPTS  = -uvmhome CDNS-1.2
UVM_OPTS  += +UVM_NO_RELNOTES
UVM_OPTS  += +UVM_VERBOSITY=${UVM_VERB}
############################

COVERAGE ?= 0
COV_OPTS = 
ifeq ($(COVERAGE), 1)
	COV_OPTS = +EN_COVERAGE
	COV_OPTS += -coverage a
# COV_OPTS += -covdut     ${TBENCH_NAME}
	COV_OPTS += -covtest    ${TESTNAME}_${seed}
	COV_OPTS += -covworkdir ${COVERAGE_DIR}
	COV_OPTS += -covfile    ./covfile.ccf
	COV_OPTS += -covoverwrite
endif

#######################################################
log_pars += sh parse_build_log.sh
#######################################################
SOURCE_LIST += -f ${VE_HOME}/verification/kvt_proj_name_files.f
#######################################################


.DEFAULT_GOAL := help

.PHONY: help
help: ## Print this message
	@echo
	@echo "|------------------------------------------------------------------------"
	@echo "Usage: make <testname> [SEED=<value>] [COVERAGE=1] [BUILDONLY=1] [UVM_VERB=<verbosity>] [GUI=y]"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo "|------------------------------------------------------------------------"
	@echo

.PHONY: get_tests
get_tests: ## Get list of available tests with small description
	@./get_tests.py ${TESTS_DIR}

.PHONY: base_test
base_test: ## Run UVM base_test
	${TOOL} $(TOOL_OPTS) $(UVM_OPTS) $(RTL_OPTS) ${ENGUI} ${USER_DEF_OPTS} -svseed ${seed} ${SOURCE_LIST} +UVM_TESTNAME=kvt_proj_name_base_test

.PHONY: ci_regression
ci_regression: ## run regression test [TESTNAME=NAME_TEST] [ITERATIONS=2]
	make clean ;
	for ((i=0; i < $(ITERATIONS); i++)) ; do make $(TESTNAME) ;  done ||:
	${log_pars}

.PHONY: parsing_all_logs
parsing_all_logs:
	${log_pars}

.PHONY: cov_merge
cov_merge: ## Merge coverage dbs into one
	imc -64bit -exec ./merge_coverage.tcl

.PHONY: clean
clean:
	@rm -rf *.cmd*
	@rm -rf *.log*
	@rm -rf INCA*
	@rm -rf xcelium.d
	@rm -rf .si*
	@rm -rf waves*
	@rm -rf *history
	@rm -rf *.diag
	@rm -rf *.key
	@rm -rf ../logs/*