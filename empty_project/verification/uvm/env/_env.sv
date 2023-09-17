{% extends "_base.sv" %}
{% block body %}

    class kvt_{{ project.name }}_env extends uvm_env;
        `uvm_component_utils(kvt_{{ project.name }}_env)

        // Configuration handle
        kvt_{{ project.name }}_env_cfg      cfg;

        // Scoreboard handle
        // kvt_{{ project.name }}_scoreboard   kvt_{{ project.name }}_scoreboard_h

        // User-defined variables

        // Constrains

        // Function/Tasks List
        // ----------------------------------------------------------------------------
        // Constructor
        // ----------------------------------------------------------------------------
        extern         function        new                     (string name = "kvt_{{ project.name }}_env",
                                                            uvm_component parent=null);
        // ----------------------------------------------------------------------------
        // Primary UVM functions/tasks
        // ----------------------------------------------------------------------------
        extern virtual function void   build_phase             (uvm_phase phase);
        extern virtual function void   connect_phase           (uvm_phase phase);
        extern virtual function void   end_of_elaboration_phase(uvm_phase phase);
        // ----------------------------------------------------------------------------
        // User-defined functions/tasks
        // ----------------------------------------------------------------------------

    endclass : kvt_{{ project.name }}_env


    // ----------------------------------------------------------------------------
    // Constructor
    // ----------------------------------------------------------------------------
    function kvt_{{ project.name }}_env::new(string name = "kvt_{{ project.name }}_env",
                    uvm_component parent=null);
        super.new(name, parent);

    endfunction : new


    // ----------------------------------------------------------------------------
    // function build_phase
    // ----------------------------------------------------------------------------
    function void kvt_{{ project.name }}_env::build_phase(uvm_phase phase);
        super.build_phase(phase);
        //------------------------------------------------------------------------------------------
        // Create agents and configuration objects
        //------------------------------------------------------------------------------------------

        cfg_is_not_null: assert(uvm_config_db#(kvt_{{ project.name }}_env_cfg)::get(this, "", "cfg", cfg))
        else
        `uvm_fatal(get_full_name(), $sformatf("cfg is null: %s.cfg", get_full_name()))

        // Create a new kvt_{{ project.name }}_scoreboard
        // kvt_{{ project.name }}_scoreboard_h = kvt_{{ project.name }}_scoreboard::type_id::create("kvt_{{ project.name }}_scoreboard_h");

    endfunction : build_phase


    // ----------------------------------------------------------------------------
    // function connect_phase
    // ----------------------------------------------------------------------------
    function void kvt_{{ project.name }}_env::connect_phase(uvm_phase phase);
        super.connect_phase(phase);

    endfunction : connect_phase


    // ----------------------------------------------------------------------------
    // function end_of_elaboration_phase
    // ----------------------------------------------------------------------------
    function void kvt_{{ project.name }}_env::end_of_elaboration_phase(uvm_phase phase);
        string test_verbosity;
        uvm_cmdline_processor cmd_inst;
        super.end_of_elaboration_phase(phase);

        cmd_inst = uvm_cmdline_processor::get_inst();
        void'(cmd_inst.get_arg_value("+UVM_VERBOSITY",test_verbosity));
        test_verbosity = test_verbosity.substr(1,test_verbosity.len()-1);
        
    endfunction : end_of_elaboration_phase       


{% endblock %}
