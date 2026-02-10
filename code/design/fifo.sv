/* 
@author: Kouachi Corneille EKON

*/

`include "params.sv"
import fifo_package::*;

module fifo
#(

)(
    input  wire clk;
    input  wire rst_n;

    input  wire [DATA_WIDTH-1:0] push_data_i   ;
    input  wire                  push_valid_i  ;
    output wire                  push_grant_o  ;

    input  wire                  pop_grant_i   ;
    output wire [DATA_WIDTH-1:0] pop_data_o    ;
    output wire                  pop_valid_o   ;
    
   
)

// FIFO DEPTH checker
FIFO_DEPTH_CHEKER : assert (FIFO_DEPTH >= 2) else $display("FIFO_DEPTH must be >= 2");


reg [ADDR_WIDTH-1:0] write_ptr; // Write pointer for the FIFO
reg [ADDR_WIDTH-1:0] read_ptr;  // Read pointer for the FIFO

reg [ADDR_WIDTH-1:0] fifo_addr; // Address for the SRAM
reg fifo_we; // Write enable for the FIFO
reg fifo_full; // Flag to indicate if the FIFO is full
reg fifo_empty; // Flag to indicate if the FIFO is empty

/////////////////////////////////////////////////
//       CONTROL LOGIC                         //
/////////////////////////////////////////////////

/*TODO
- push_grant_o
- pop_valid_o


*/

always_comb begin : FIFO_PUSH_LOGIC
    if (rst_n == 1'b0) begin
        fifo_we = 1'b0; // Disable write on reset
    end else if (push_valid_i && push_grant_o) begin
        fifo_we = 1'b1; // Enable write when valid and granted
    end else begin
        fifo_we = 1'b0; // Disable write otherwise
    end

end 


always_comb begin : FIFO_POP_LOGIC

end











/////////////////////////////////////////////////
//          DATA PATH                          //
/////////////////////////////////////////////////





// sram instance
sram sram_inst (
    .clk        (clk          )  ,
    .addr_i     (             )  , // TODO
    .wdata_i    (push_data_i  )  ,
    .we_i       (             )  , // TODO
    .rdata_o    (pop_data_o   )
);





endmodule