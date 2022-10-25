// ----------------------------------------------------------------------------
// Author:   Konstantin Kurenkov
// Email:    krendkrend@gmail.com
// FileName: kvt_tb_top.sv
// Create date: 18/10/2022
//
// Description: Top-level testbench for 
//
// ----------------------------------------------------------------------------

`ifndef INC_KVT_TB_TOP
`define INC_KVT_TB_TOP

module tb_top();


  kvt_proj_name_env_if proj_name_env_intf();
//   kvt_proj_name_wrapper dut(proj_name_env_intf);

// -----------------------------------------------------------------------------
/** UVM test phase initiator */
// -----------------------------------------------------------------------------
    initial begin
        uvm_config_db#(virtual kvt_proj_name_env_if)::set(uvm_root::get(), "uvm_test_top", "vif", proj_name_env_intf);
        /**
        * Invoke run_test after set_config_db calls in other/peer initial blocks have been executed
        */
        /** Start the UVM tests */
        run_test();
    end

endmodule : tb_top

`endif // INC_KVT_TB_TOP