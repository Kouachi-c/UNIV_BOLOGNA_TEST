/*
@author Kouachi Corneille EKON
*/

`include "params.sv"


module sram
import fifo_package::*;
#(

)(
    input  wire                  clk      ,

    input  wire [ADDR_WIDTH-1:0] addr_i   ,
    input  wire [DATA_WIDTH-1:0] wdata_i  ,
    input  wire                  we_i     ,

    output wire [DATA_WIDTH-1:0] rdata_o  

);

// SRAM memory array
reg [DATA_WIDTH-1:0] sram_mem [0:SRAM_DEPTH-1];

// read data register
reg [DATA_WIDTH-1:0] rdata_o_reg;


always @(posedge clk) begin
    if (we_i) begin
        sram_mem[addr_i] <= wdata_i;
    end

    rdata_o_reg <= sram_mem[addr_i];
end


assign rdata_o = rdata_o_reg;


endmodule