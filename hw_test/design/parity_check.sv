/*
@author: Kouachi Corneille EKON
*/


`include "params.sv"


module parity_check
import fifo_package::*;
#(

)(
    input  wire                  clk      ,
    input  wire                  rst_n    ,

    input  wire [DATA_WIDTH-1:0] data_i   ,

    input  wire                  pop_valid_o_i  ,    // Valid signal from pop_valid_o of FIFO
    output wire                  pop_grant_i_o  ,    // Grant signal to pop_grant_i of FIFO
    output wire                  valid_o  ,
    input  wire                  grant_i  
);

reg parity_bit;         // Register to hold the parity bit
reg [WIDTH-1:0] data;   // Register to hold data without parity bit
reg valid_o_reg; 

/////////////////////////////////////////////////
//       CONTROL LOGIC                         //
/////////////////////////////////////////////////

// Parity bit extraction logic
always_comb begin : PARITY_BIT_EXTRACTION
    if(PARITY_BIT == "MSB") begin
        parity_bit = data_i[DATA_WIDTH-1]; // Extract parity bit from MSB
        data = data_i[DATA_WIDTH-2:0]; // Extract data without parity bit
    end else begin
        parity_bit = data_i[0]; // Extract parity bit from LSB
        data = data_i[DATA_WIDTH-1:1]; // Extract data without parity bit 
    end
end


// Parity check logic
always_comb begin : PARITY_CHECK_LOGIC
    if(PARITY_TYPE == "EVEN") begin
        if (pop_valid_o_i && grant_i) begin
            valid_o_reg = (parity_bit == ~(^data)); // Valid if parity bit matches even parity of data
        end else begin
            valid_o_reg = 1'b0; // No valid data, set valid_o to 0
        end
    end else begin
        if (pop_valid_o_i && grant_i) begin
            valid_o_reg = (parity_bit == ^data); // Valid if parity bit matches odd parity of data
        end else begin
            valid_o_reg = 1'b0; // No valid data, set valid_o to 0
        end 
    end
end


assign valid_o = valid_o_reg; 
assign pop_grant_i_o = grant_i; // Grant signal to FIFO is directly connected to grant_i



/////////////////////////////////////////////////
//          DATA PATH                          //
/////////////////////////////////////////////////



endmodule