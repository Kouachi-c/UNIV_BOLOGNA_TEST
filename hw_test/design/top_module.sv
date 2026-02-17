/*
@author: Kouachi Corneille EKON
*/


`include "params.sv"


module top_module
import fifo_package::*;
#(

)(
    input  logic clk,
    input  logic rst_n,

    input  logic [DATA_WIDTH-1:0] data_i   ,
    input  logic                  valid_i  ,
    output logic                  grant_o  ,

    input  logic                  grant_i  ,
    output logic [DATA_WIDTH-1:0] data_o   ,
    output logic                  valid_o  

);

// Internal connexions
logic grant_connect;
logic valid_connect;

fifo fifo_inst (
    .clk            (clk            )  ,
    .rst_n          (rst_n          )  ,
    .push_data_i    (data_i         )  ,
    .push_valid_i   (valid_i        )  ,
    .push_grant_o   (grant_o        )  ,
    .pop_grant_i    (grant_connect  )  ,
    .pop_data_o     (data_o         )  ,
    .pop_valid_o    (valid_connect  )
);

parity_check parity_check_inst (
    .clk            (clk            )  ,
    .rst_n          (rst_n          )  ,
    .data_i         (data_o         )  ,
    .pop_valid_o_i  (valid_connect  )  ,
    .pop_grant_i_o  (grant_connect  )  ,
    .valid_o        (valid_o        )  ,
    .grant_i        (grant_i        )
);


endmodule