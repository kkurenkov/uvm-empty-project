// ----------------------------------------------------------------------------
// Author:   Konstantin Kurenkov
// Email:    krendkrend@gmail.com
// Create date: 19/10/2022
// FileName: kvt_proj_name_base_test.sv
//
// Description: Base test for block environment
//
// ----------------------------------------------------------------------------

`ifndef INC_KVT_proj_name_BASE_TEST
`define INC_KVT_proj_name_BASE_TEST

class kvt_proj_name_base_test extends uvm_test;
    string msg_tag = "proj_name_base_test";
    string test_verbosity;
    uvm_cmdline_processor   cmd_inst;
    kvt_base_report_catcher cli_formatter;

    kvt_proj_name_env env;
    kvt_proj_name_env_cfg cfg;
    int num_rst;
    int watchdog_timeout_val;
    
    rand longint num_pre_wait_rst_cycles;
    
    constraint num_pre_wait_rst_cycles_c {
        soft num_pre_wait_rst_cycles inside {[2:40000]};
    }
      
    `uvm_component_utils(kvt_proj_name_base_test)

    function new(string name = "kvt_proj_name_base_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction : new


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // If we run in CLI mode - add output formatter
        if($test$plusargs("ADD_CLI_FORMATTER")) begin
            cli_formatter = new("cli_formatter");
            uvm_report_cb::add(null, cli_formatter);
        end

        if(!$value$plusargs("watchdog_timeout_val=%d", watchdog_timeout_val))
            watchdog_timeout_val = 1000000;

        env = kvt_proj_name_env::type_id::create("env", this);
        cfg = kvt_proj_name_env_cfg::type_id::create("cfg");

        void'(uvm_config_db#(virtual kvt_proj_name_env_if)::get(this, "", "vif", cfg.vif));
        cfg.enable_all_agents();

        if($test$plusargs("en_cov"))
          cfg.has_cov = 1'b1;

        cfg.build();
        uvm_config_db#(kvt_proj_name_env_cfg)::set(this, "env", "cfg", cfg);

        /* Set basic timeout, keep overridable */
        uvm_top.set_timeout(5000000us);
    endfunction : build_phase


    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);

        // get current test verbosity
        cmd_inst = uvm_cmdline_processor::get_inst();
        void'(cmd_inst.get_arg_value("+UVM_VERBOSITY",test_verbosity));

        // cut "=" from string
        test_verbosity = test_verbosity.substr(1,test_verbosity.len()-1);

        // Print full VE hierarchy if we are in debug mode
        if (test_verbosity inside {"UVM_FULL", "UVM_DEBUG"}) begin
            uvm_top.print_topology();
        end
    endfunction: end_of_elaboration_phase

    function void report_phase(uvm_phase phase);
        uvm_report_server svr;
        uvm_cmdline_processor cmd_inst;
        int str_len;
        string test_name;
        string test_status;

        super.report_phase(phase);
        svr      = uvm_report_server::get_server();
        cmd_inst = uvm_cmdline_processor::get_inst();

        void'(cmd_inst.get_arg_value("+UVM_TESTNAME",test_name));
        // cut "=" from string
        test_name = test_name.substr(1, test_name.len()-1);

        if (svr.get_severity_count(UVM_FATAL) +
            svr.get_severity_count(UVM_ERROR) == 0)
            test_status = "PASSED";
        else
            test_status = "FAILED";

        $write("\n** UVM TEST NAME  : %s **", test_name);
        $write("\n** UVM TEST STATUS: %s **", test_status);
        $write("\n** SV_SEED        : %0d ** \n\n",$get_initial_random_seed);
    endfunction : report_phase

    function void final_phase(uvm_phase phase);
        super.final_phase(phase);
        $assertkill;
    endfunction : final_phase

    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        // Generate configurations set
    endfunction : start_of_simulation_phase


    virtual task pre_reset_phase(uvm_phase phase);
      super.pre_reset_phase(phase);
      // Setup clocks
      // phase.raise_objection(this, "Starting sequences");
      // phase.drop_objection(this, "Ending sequences");
    endtask : pre_reset_phase


  virtual task reset_phase(uvm_phase phase);
      super.reset_phase(phase);
      // Run resets
      // phase.raise_objection(this, "Starting sequences");
      // phase.drop_objection(this, "Ending sequences");
  endtask : reset_phase


  // ----------------------------------------------------------------------------
  // task run_rst_on_the_fly
  // ----------------------------------------------------------------------------

  task run_rst_on_the_fly();
    
    if(!$value$plusargs("rst_on_the_fly_pre_wait_cycles=%d", num_pre_wait_rst_cycles)) begin
      randomization_is_successfull: assert(this.randomize(num_pre_wait_rst_cycles))
      else `uvm_fatal(get_full_name(), "Randomization is failed!")
    end

    if(num_rst == 0) // No reset on the fly anymore
      wait(1);       // infinite wait
      
    repeat(num_pre_wait_rst_cycles)
      // @env.cfg.vif.proj_name_clk_if.clk;

    `uvm_info(get_name(), "Reset on the fly is started!", UVM_MEDIUM)
  endtask


  // ----------------------------------------------------------------------------
  // task watchdog_timer_process
  // ----------------------------------------------------------------------------

  task watchdog_timer_process(int unsigned num_clk_cycles);
      // repeat(num_clk_cycles)
        // @env.cfg.vif.proj_name_clk_if.clk;

      `uvm_fatal(get_name(), "watchdog timer is counted to zero")
  endtask

  // ----------------------------------------------------------------------------
  // function phase_ready_to_end
  // ----------------------------------------------------------------------------

  function void phase_ready_to_end(uvm_phase phase);
    if(phase.get_imp() == uvm_shutdown_phase::get() && num_rst > 0) begin
      num_rst--;
      phase.jump(uvm_reset_phase::get());
    end
  endfunction

endclass : kvt_proj_name_base_test
`endif // INC_KVT_proj_name_BASE_TEST
