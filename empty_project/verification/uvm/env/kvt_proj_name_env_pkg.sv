// ----------------------------------------------------------------------------
// Author:   Konstantin Kurenkov
// Email:    krendkrend@gmail.com
// Create date: 19/10/2022
// FileName: kvt_proj_name_env_pkg.sv
//
// Description: test environment package
//
// ----------------------------------------------------------------------------

`ifndef INC_KVT_proj_name_ENV_PKG
`define INC_KVT_proj_name_ENV_PKG

`include "kvt_proj_name_define.sv"
`include "kvt_proj_name_env_if.sv"

package kvt_proj_name_env_pkg;

    /** Import UVM Base Package */
    import uvm_pkg::*;

    `include "kvt_proj_name_env_cfg.sv"
    `include "kvt_proj_name_env.sv"

endpackage :  kvt_proj_name_env_pkg

`endif // INC_KVT_proj_name_ENV_PKG
