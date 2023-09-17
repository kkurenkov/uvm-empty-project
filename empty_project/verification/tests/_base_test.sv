{% extends "_base.sv" %}
{% block body %}
  class kvt_{{ project.name }}_base_test extends uvm_test;
    `uvm_component_utils(kvt_{{ project.name }}_base_test)

    // Environmetn handle
    kvt_{{ project.name }}_env      env;
    // Configuration handle
    kvt_{{ project.name }}_env_cfg  cfg;
    // UVM command line processor
    uvm_cmdline_processor   cmd_inst;
    // PRoject catcher
    kvt_{{ project.name }}_base_report_catcher cli_formatter;

    // User-defined variables
    string        msg_tag = "{{ project.name }}_base_test";
    string        test_verbosity; 
    int           num_rst;
    int           watchdog_timeout_val;
    rand longint  num_pre_wait_rst_cycles;  
      
    // Constrains
    constraint num_pre_wait_rst_cycles_c {
        soft num_pre_wait_rst_cycles inside {[2:40000]};
    }  
      
    // Function/Tasks List
    // ----------------------------------------------------------------------------
    // Constructor
    // ----------------------------------------------------------------------------
    extern         function      new                     (string name = "kvt_{{ project.name }}_base_test",
                                                    uvm_component parent=null);
    // ----------------------------------------------------------------------------
    // Primary UVM functions/tasks
    // ----------------------------------------------------------------------------
    extern virtual function void build_phase               (uvm_phase phase);
    extern virtual function void end_of_elaboration_phase  (uvm_phase phase);
    extern virtual function void report_phase              (uvm_phase phase);
    extern virtual function void final_phase               (uvm_phase phase);
    extern virtual function void start_of_simulation_phase (uvm_phase phase);
    extern virtual task          pre_reset_phase           (uvm_phase phase);
    extern virtual task          reset_phase               (uvm_phase phase);
    extern virtual function void phase_ready_to_end        (uvm_phase phase);
    // ----------------------------------------------------------------------------
    // User-defined functions/tasks
    // ----------------------------------------------------------------------------
    extern virtual task          run_rst_on_the_fly        ();
    extern virtual task          watchdog_timer_process    (int unsigned num_clk_cycles);

  endclass : kvt_{{ project.name }}_base_test


  // ----------------------------------------------------------------------------
  // Constructor
  // ----------------------------------------------------------------------------
  function kvt_{{ project.name }}_base_test::new(string name = "kvt_{{ project.name }}_base_test",
                                                  uvm_component parent=null);
    super.new(name, parent);

  endfunction : new


  // ----------------------------------------------------------------------------
  // function build_phase
  // ----------------------------------------------------------------------------
  function void kvt_{{ project.name }}_base_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
    // If we run in CLI mode - add output formatter
    if($test$plusargs("ADD_CLI_FORMATTER")) begin
        cli_formatter = new("cli_formatter");
        uvm_report_cb::add(null, cli_formatter);
    end

    if(!$value$plusargs("watchdog_timeout_val=%d", watchdog_timeout_val))
        watchdog_timeout_val = 1000000;

    // Create a new environment
    env = kvt_{{ project.name }}_env::type_id::create("env", this);
    // Create a new configuration
    cfg = kvt_{{ project.name }}_env_cfg::type_id::create("cfg");

    void'(uvm_config_db#(virtual kvt_{{ project.name }}_env_if)::get(this, "", "vif", cfg.vif));
    cfg.enable_all_agents();

    if($test$plusargs("en_cov"))
      cfg.has_cov = 1'b1;

    cfg.build();
    uvm_config_db#(kvt_{{ project.name }}_env_cfg)::set(this, "env", "cfg", cfg);

    /* Set basic timeout, keep overridable */
    uvm_top.set_timeout(5000000us);
    
  endfunction : build_phase


  // ----------------------------------------------------------------------------
  // function reset_end_of_elaboration_phasephase
  // ----------------------------------------------------------------------------
  function void kvt_{{ project.name }}_base_test::end_of_elaboration_phase(uvm_phase phase);
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


  // ----------------------------------------------------------------------------
  // function report_phase
  // ----------------------------------------------------------------------------
  function void kvt_{{ project.name }}_base_test::report_phase(uvm_phase phase);
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

    // $write("\n\n** MATCH = %0d     MISMATCH = %0d **", env.scoreboard.match, env.scoreboard.mismatch );
    $write("\n** UVM TEST NAME  : %s **", test_name);
    $write("\n** UVM TEST STATUS: %s **", test_status);
    $write("\n** SV_SEED        : %0d ** \n\n",$get_initial_random_seed);

  endfunction : report_phase


  // ----------------------------------------------------------------------------
  // function final_phase
  // ----------------------------------------------------------------------------
  function void kvt_{{ project.name }}_base_test::final_phase(uvm_phase phase);
    super.final_phase(phase);
    $assertkill;

  endfunction : final_phase


  // ----------------------------------------------------------------------------
  // function start_of_simulation_phase
  // ----------------------------------------------------------------------------
  function void kvt_{{ project.name }}_base_test::start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    // Generate configurations set
    assert(env.cfg.clk_cfg.randomize());

  endfunction : start_of_simulation_phase
      

  // ----------------------------------------------------------------------------
  // task pre_reset_phase
  // ----------------------------------------------------------------------------
  task kvt_{{ project.name }}_base_test::pre_reset_phase(uvm_phase phase);
    super.pre_reset_phase(phase);
    // Setup clocks
    phase.raise_objection(this, "Starting sequences");
      env.cfg.vif.{{ project.name }}_clk_if.start(env.cfg.clk_cfg.clk_period_ns); 
    phase.drop_objection(this, "Ending sequences");

  endtask : pre_reset_phase


  // ----------------------------------------------------------------------------
  // task reset_phase
  // ----------------------------------------------------------------------------
  task kvt_{{ project.name }}_base_test::reset_phase(uvm_phase phase);
    super.reset_phase(phase);
    // Run resets
    phase.raise_objection(this, "Starting sequences");
      env.cfg.vif.{{ project.name }}_rstn_if.init_sync(5*env.cfg.clk_cfg.clk_period_ns);
    phase.drop_objection(this, "Ending sequences");

  endtask : reset_phase

    
  // ----------------------------------------------------------------------------
  // task run_rst_on_the_fly
  // ----------------------------------------------------------------------------
  task kvt_{{ project.name }}_base_test::run_rst_on_the_fly();
    
    if(!$value$plusargs("rst_on_the_fly_pre_wait_cycles=%d", num_pre_wait_rst_cycles)) begin
      randomization_is_successfull: assert(this.randomize(num_pre_wait_rst_cycles))
      else `uvm_fatal(get_full_name(), "Randomization is failed!")
    end

    if(num_rst == 0) // No reset on the fly anymore
      wait(0);       // infinite wait
      
    repeat(num_pre_wait_rst_cycles)
      @env.cfg.vif.{{ project.name }}_clk_if.clk;

    `uvm_info(get_name(), "Reset on the fly is started!", UVM_MEDIUM)

  endtask


  // ----------------------------------------------------------------------------
  // task watchdog_timer_process
  // ----------------------------------------------------------------------------
  task kvt_{{ project.name }}_base_test::watchdog_timer_process(int unsigned num_clk_cycles);
    repeat(num_clk_cycles)
      @env.cfg.vif.{{ project.name }}_clk_if.clk;
    `uvm_fatal(get_name(), "watchdog timer is counted to zero")
    
  endtask 

    
  // ----------------------------------------------------------------------------
  // function phase_ready_to_end
  // ----------------------------------------------------------------------------
  function void kvt_{{ project.name }}_base_test::phase_ready_to_end(uvm_phase phase);
    if(phase.get_imp() == uvm_shutdown_phase::get() && num_rst > 0) begin
      num_rst--;
      phase.jump(uvm_reset_phase::get());
    end

  endfunction  

{% endblock %}
