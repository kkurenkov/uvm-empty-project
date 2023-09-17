// ----------------------------------------------------------------------------
// Author:                 {{ project.author }}
// Email:                  {{ project.email }}
// FileName:               {{ project.file }}.sv
// Create date:            {{ project.date }}
// Company:                {{ project.company }}
// ----------------------------------------------------------------------------
`ifndef INC_{{ project.file|upper }}
  `define INC_{{ project.file|upper }}
  {% block body %}

    `include "uvm_macros.svh"
    `include "kvt_{{ project.name }}_test_pkg.sv"

    import uvm_pkg::*;
    import kvt_{{ project.name }}_test_pkg::*;

    // Include wrapper
    `include "kvt_{{ project.name }}_wrapper.sv"

  module tb_top();

  // Connecting environment
  kvt_{{ project.name }}_env_if {{ project.name }}_env_intf();

  // Connecting DUT
  //   kvt_{{ project.name }}_wrapper dut({{ project.name }}_env_intf);

  // -----------------------------------------------------------------------------
  /** UVM test phase initiator */
  // -----------------------------------------------------------------------------
      initial begin
          uvm_config_db#(virtual kvt_{{ project.name }}_env_if)::set(uvm_root::get(), "uvm_test_top", "vif", {{ project.name }}_env_intf);
          /**
          * Invoke run_test after set_config_db calls in other/peer initial blocks have been executed
          */
          /** Start the UVM tests */
          run_test();
      end

  endmodule : tb_top
  {% endblock %}
`endif // INC_{{ project.file|upper }}
