/*
@author: Kouachi Corneille EKON
*/


`include "params.sv"
import fifo_package::*;

module parity_check
#(

)(
    input  wire                  clk      ;
    input  wire                  rst_n    ;

    input  wire [DATA_WIDTH-1:0] data_i   ;

    input  wire                  valid_i  ;
    output wire                  grant_o  ;
    output wire                  valid_o  ;
    input  wire                  grant_i  ;
)


/////////////////////////////////////////////////
//       CONTROL LOGIC                         //
/////////////////////////////////////////////////












/////////////////////////////////////////////////
//          DATA PATH                          //
/////////////////////////////////////////////////



endmodule