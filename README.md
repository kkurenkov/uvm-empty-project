## Introduction

UVM environment generator

Create your UVM folder fot verification 

### The structure of empty project

```
├── submodules               - git-сабмодули;
├── syn                      - synthesis scripts;
└── verification             - verification directory;
    ├── <module>             - the same for every modules
    ├──  ...
    └── proj_name            - directory for proj_name;
        ├── docs             - documentation;
        ├── jg               - formal verification;
        ├── uvm              - uvm environment;
        ├── logs             - simulation logs;
        ├── run              - directory with scripts;
        └── tests            - library with tests;
```

## Generate project

* Run the kvt_generate_project.py script at the command line. It requires only one argument

```bash
    ./kvt_generate_project.py name_of_your_project
```


