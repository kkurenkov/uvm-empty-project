// ----------------------------------------------------------------------------
// Author:   Konstantin Kurenkov
// Email:    krendkrend@gmail.com
// Create date: 19/10/2022
// FileName: kvt_proj_name_test_pkg.sv
//
// Description: test environment package
//
// ----------------------------------------------------------------------------

`ifndef INC_KVT_proj_name_TEST_PKG
`define INC_KVT_proj_name_TEST_PKG

`include "kvt_proj_name_env_pkg.sv"

package kvt_proj_name_test_pkg;
    /** Import UVM Base Package */
    import uvm_pkg::*;
    import kvt_proj_name_env_pkg::*;

    `include "kvt_base_report_catcher.sv"
    `include "kvt_proj_name_base_test.sv"
endpackage :  kvt_proj_name_test_pkg

`endif // INC_KVT_proj_name_TEST_PKG
