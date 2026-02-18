/*
@author Kouachi Corneille EKON
*/

`include "params.sv"


module sram
import fifo_package::*;
#(

)(
    input  logic                  clk      ,

    input  logic [ADDR_WIDTH-1:0] addr_i   ,
    input  logic [DATA_WIDTH-1:0] wdata_i  ,
    input  logic                  we_i     ,

    output logic [DATA_WIDTH-1:0] rdata_o  

);

// SRAM memory array
reg [DATA_WIDTH-1:0] sram_mem [0:DEPTH-1];

// read data register
reg [DATA_WIDTH-1:0] rdata_o_reg = 0;
/*
initial begin : SRAM_INIT
    integer i;
    for (i = 0; i < DEPTH; i = i + 1) begin
        sram_mem[i] = 0; // Initialize SRAM memory to 0
    end
end
*/

always @(posedge clk) begin
    if (we_i) begin
        sram_mem[addr_i] <= wdata_i;
    end

    rdata_o_reg <= sram_mem[addr_i];
end


assign rdata_o = rdata_o_reg;


endmodule