// ----------------------------------------------------------------------------
// Author:   Konstantin Kurenkov
// Email:    krendkrend@gmail.com
// Create date: 19/10/2022
// FileName: kvt_proj_name_tb_inc.sv
//
// Description: Main Include file for
//
// ----------------------------------------------------------------------------

`include "uvm_macros.svh"
`include "kvt_proj_name_test_pkg.sv"

import uvm_pkg::*;
import kvt_proj_name_test_pkg::*;

// include WRAPPER
`include "kvt_proj_name_wrapper.sv"

// include TOP!
`include "kvt_tb_top.sv"