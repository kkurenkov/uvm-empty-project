# Introduction

UVM environment generator

Create your UVM folder fot verification

## The structure of empty project

```bash
├── submodules               - git-subrepo;
└── verification             - verification directory;
    ├── docs                 - documentation;
    ├── libs                 - some useful files for project;
    ├── uvm                  - uvm environment;
    ├── logs                 - simulation logs;
    ├── run                  - directory with scripts;
    └── tests                - library with tests;
```

## Run help

* for create project you must prepare project_gen.cfg files

```bash
./kvt_generate_project.py -h
usage: kvt_generate_project.py [-h] [-debug] --proj_name PROJ_NAME --name NAME --surname SURNAME --email EMAIL

Project Generator

optional arguments:
  -h, --help            show this help message and exit
  -debug                Print Debug Messages
  --proj_name PROJ_NAME Project Name
  --name NAME           Author Name
  --surname SURNAME     Author Surname
  --email EMAIL         Author Email
```

## Example project

* Run the kvt_generate_project.py script at the command line. It requires only one argument

```bash
$ ./kvt_generate_project.py --proj_name i2c --name Konstantin --surname Kurenkov --email kkurenkov
```

* Result in terminal

```bash
    -------------------------------------------------------------------------------------------------

    New project i2c_verif was create!

    -------------------------------------------------------------------------------------------------

    After that
    1 Copy folders ./i2c_verif/* in your repo
    BUT NOT ./i2c_verif/submodules FOLDER!!!

    -------------------------------------------------------------------------------------------------

    2 Add kvt_clk_rst_vip like submodule in your repo
    git submodule add https://github.com/kkurenkov/kvt_clk_rst_vip.git submodules/kvt_clk_rst_vip

    -------------------------------------------------------------------------------------------------

    3 For run project
    cd ./i2c_verif/verification/run/
    make base_test SEED=1

    -------------------------------------------------------------------------------------------------

    That's all! Have a good day!
```

* Inside Folder

```bash
$ ll ./i2c_verif/
total 8
-rw-rw-r-- 1 kurenkov kurenkov 5001 июл 26 09:45 README.md
drwxrwxr-x 3 kurenkov kurenkov   37 июл 26 09:45 submodules
drwxrwxr-x 5 kurenkov kurenkov  161 июл 26 09:45 verification
```

* Run test project

```bash
$ cd ./i2c_verif/verification/run/
$ make base_test SEED=1
```

* Run result

```bash
UVM_INFO @ 0: reporter [RNTST] Running test kvt_i2c_base_test...

** UVM TEST NAME  : kvt_i2c_base_test **
** UVM TEST STATUS: PASSED **
** SV_SEED        : 1 ** 

--- UVM Report Summary ---

** Report counts by severity
UVM_INFO :               2
UVM_WARNING :            0
UVM_ERROR :              0
UVM_FATAL :              0
** Report counts by id
[RNTST]                  1
[UVM/REPORT/CATCHER]     1
```

```bash
      ****************
    *****************    ***     *********                                             ********
  ******************    *****    *********                                             ********
 ******************    *******   *********      ********** *********      *********    ********
*******       ****    *********  *********      ********** *********      *********    ********
*****        ******************* *********     *********** *********      ********* **************
****        ******************** *********   ************* *********      ********* **************
***        ********    ********* ********* *************   *********      ********* **************
**        ********     ********* *********************     *********     *********     ********   
**       ********      ********  *********************      *********   *********      ********   
***     ********      *********  **********************      ********* *********       ********   
 ***   ********      *********   ************************     *****************        ********   
  ***               *********    ***********  ************     ***************         ********  
    ***          **********      *********      **********      *************          ***********
      *******************        *********       *********       ***********           ***********
         *************           *********        ********        *********             **********
```