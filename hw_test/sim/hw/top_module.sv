/*
@author: Kouachi Corneille EKON
*/


`include "params.sv"


module top_module
import fifo_package::*;
#(

)(
    input  wire clk,
    input  wire rst_n,

    input  wire [DATA_WIDTH-1:0] data_i   ,
    input  wire                  valid_i  ,
    output wire                  grant_o  ,

    input  wire                  grant_i  ,
    output wire [DATA_WIDTH-1:0] data_o   ,
    output wire                  valid_o  

);

// Internal connexions
wire grant_connect;
wire valid_connect;

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