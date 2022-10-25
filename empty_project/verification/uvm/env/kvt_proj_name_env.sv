// ----------------------------------------------------------------------------
// Author:   Konstantin Kurenkov
// Email:    krendkrend@gmail.com
// Create date: 19/10/2022
// FileName: kvt_proj_name_env.sv
// Description: test environment
//
// ----------------------------------------------------------------------------

`ifndef INC_KVT_proj_name_ENV
`define INC_KVT_proj_name_ENV

class kvt_proj_name_env extends uvm_env;
    kvt_proj_name_env_cfg    cfg;

    `uvm_component_utils(kvt_proj_name_env)

    function new(string name = "kvt_proj_name_env", uvm_component parent=null);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        //------------------------------------------------------------------------------------------
        // Create agents and configuration objects
        //------------------------------------------------------------------------------------------

        cfg_is_not_null: assert(uvm_config_db#(kvt_proj_name_env_cfg)::get(this, "", "cfg", cfg))
        else
        `uvm_fatal(get_full_name(), $sformatf("cfg is null: %s.cfg", get_full_name()))
    endfunction : build_phase


    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction : connect_phase

    // Reduce amount of information printed by VIP
    virtual function void end_of_elaboration_phase(uvm_phase phase);
        string test_verbosity;
        uvm_cmdline_processor cmd_inst;
        super.end_of_elaboration_phase(phase);

        cmd_inst = uvm_cmdline_processor::get_inst();
        void'(cmd_inst.get_arg_value("+UVM_VERBOSITY",test_verbosity));
        test_verbosity = test_verbosity.substr(1,test_verbosity.len()-1);
    endfunction : end_of_elaboration_phase

endclass : kvt_proj_name_env

`endif // INC_KVT_proj_name_ENV