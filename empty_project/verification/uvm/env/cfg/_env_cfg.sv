{% extends "_base.sv" %}
{% block body %}
  class kvt_{{ project.name }}_env_cfg extends uvm_object;
      virtual kvt_{{ project.name }}_env_if vif;
      bit has_cov   = 0;
      bit has_check = 0;
      bit has_clk   = 0;
      bit has_rst   = 0;
      `uvm_object_utils(kvt_{{ project.name }}_env_cfg)

      kvt_clk_cfg       clk_cfg; 
      kvt_rst_cfg       rst_cfg;

      extern function new(string name = "kvt_{{ project.name }}_env_cfg");
      extern function void set_vif(virtual kvt_{{ project.name }}_env_if _vif);
      extern function void create_clk();
      extern function void create_rstn();
      extern virtual function void enable_all_agents();
      extern virtual function void build();

  endclass : kvt_{{ project.name }}_env_cfg

  // ----------------------------------------------------------------------------
  // function new
  // ----------------------------------------------------------------------------
  function kvt_{{ project.name }}_env_cfg::new(string name = "kvt_{{ project.name }}_env_cfg");
    super.new(name);
  endfunction

  // ----------------------------------------------------------------------------
  // function set_vif
  // ----------------------------------------------------------------------------
  function void kvt_{{ project.name }}_env_cfg::set_vif(virtual kvt_{{ project.name }}_env_if _vif);
    if(_vif == null) `uvm_fatal(get_full_name(), $sformatf("arg ref passed to %s is null", get_full_name()))
    vif = _vif;
  endfunction

  // ----------------------------------------------------------------------------
  // function void enable_all_agents
  // ----------------------------------------------------------------------------
  function void kvt_{{ project.name }}_env_cfg::enable_all_agents();
      has_clk = 1;
      has_rst = 1;
  endfunction


  // ----------------------------------------------------------------------------
  // function void build
  // ----------------------------------------------------------------------------
  function void kvt_{{ project.name }}_env_cfg::build();
      if(has_clk) 
          create_clk();
      if(has_rst)   
          create_rstn();
  endfunction

  // ----------------------------------------------------------------------------
  // function void create_clk
  // ----------------------------------------------------------------------------
  function void kvt_{{ project.name }}_env_cfg::create_clk();
    clk_cfg = kvt_clk_cfg::type_id::create("clk_cfg");
    clk_cfg.set_vif(vif.{{ project.name }}_clk_if);
  endfunction

  // ----------------------------------------------------------------------------
  // function void create_rstn
  // ----------------------------------------------------------------------------
  function void kvt_{{ project.name }}_env_cfg::create_rstn();
      rst_cfg = kvt_rst_cfg::type_id::create("rst_cfg");
      rst_cfg.set_vif(vif.{{ project.name }}_rstn_if);
  endfunction
{% endblock %}