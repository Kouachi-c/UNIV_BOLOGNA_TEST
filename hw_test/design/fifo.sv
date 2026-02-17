/* 
@author: Kouachi Corneille EKON

*/

`include "params.sv"


module fifo
import fifo_package::*;
#(

)(
    input  logic clk,
    input  logic rst_n,

    input  logic [DATA_WIDTH-1:0] push_data_i   ,
    input  logic                  push_valid_i  ,
    output logic                  push_grant_o  ,

    input  logic                  pop_grant_i   ,
    output logic [DATA_WIDTH-1:0] pop_data_o    ,
    output logic                  pop_valid_o   
    
   
);

// FIFO DEPTH checker
initial begin : FIFO_DEPTH_CHEKER
    assert (DEPTH >= 2) else $error("ERR : DEPTH must be >= 2");
end



reg [ADDR_WIDTH:0] write_ptr ; // Write pointer
reg [ADDR_WIDTH:0] read_ptr  ; // Read pointer 

reg [ADDR_WIDTH-1:0] fifo_addr; // Address for the SRAM
reg fifo_we; // Write enable for the FIFO
reg fifo_re; // Read enable for the FIFO
reg fifo_full; // Flag to indicate if the FIFO is full
reg fifo_empty; // Flag to indicate if the FIFO is empty

reg push_grant_o_reg; // Register for push grant output
reg pop_valid_o_reg;  // Register for pop valid output


/////////////////////////////////////////////////
//       CONTROL LOGIC                         //
/////////////////////////////////////////////////


always_comb begin : FIFO_STATUS_LOGIC
    if (!rst_n) begin
        fifo_full  = 1'b0; // FIFO is not full on reset
        fifo_empty = 1'b1; // FIFO is empty on reset
    end else begin
        fifo_full  = ((write_ptr[ADDR_WIDTH]     != read_ptr[ADDR_WIDTH]) && 
                      (write_ptr[ADDR_WIDTH-1:0] == read_ptr[ADDR_WIDTH-1:0])); // FIFO is full when write and read pointers are at the same position but different MSB
        
        fifo_empty = (write_ptr == read_ptr); // FIFO is empty when write and read pointers are equal
    end
end


always_comb begin : FIFO_GRANT_LOGIC
    if (!rst_n) begin
        push_grant_o_reg = 1'b0; // No grant on reset
    end else if (!fifo_full) begin
        push_grant_o_reg = 1'b1; // Grant push when valid and not full
    end else begin
        push_grant_o_reg = 1'b0; // No grant otherwise
    end
end


always_comb begin : FIFO_POP_VALID_LOGIC
    if (!rst_n) begin
        pop_valid_o_reg = 1'b0; // No valid data on reset
    end else if (!fifo_empty) begin
        pop_valid_o_reg = 1'b1; // Valid data when not empty
    end else begin
        pop_valid_o_reg = 1'b0; // No valid data otherwise
    end
end


always_comb begin : FIFO_PUSH_LOGIC
    if (!rst_n) begin
        fifo_we   = 1'b0; // Disable write on reset
        write_ptr = 0;  // Reset write pointer
    end else if (push_valid_i && push_grant_o_reg) begin
        fifo_we   = 1'b1; // Enable write when valid and granted
        write_ptr = write_ptr + 1; // Increment write pointer
    end else begin
        fifo_we   = 1'b0; // Disable write otherwise
    end

end 


always_comb begin : FIFO_POP_LOGIC
    if (!rst_n) begin
        read_ptr = 0; // Reset read pointer on reset
        fifo_re = 1'b0; // Disable read on reset
    end else if (pop_grant_i && pop_valid_o_reg) begin
        fifo_re = 1'b1; // Enable read when granted and valid
        read_ptr = read_ptr + 1; // pop_valid_o_reg Increment read pointer when granted and not empty
    end else begin
        fifo_re = 1'b0; // Disable read otherwise
    end
end


always_comb begin : FIFO_ADDR_LOGIC 
    if(!rst_n) begin 
        fifo_addr = 0; 
    end else begin 
        case ({fifo_we, fifo_re})
            2'b10:   fifo_addr = write_ptr[ADDR_WIDTH-1:0] - 1; // Address for write operation 
            2'b01:   fifo_addr = read_ptr[ADDR_WIDTH-1:0] - 1;  // Address for read operation 
            default: fifo_addr = 0; // Default address (can be optimized) 
        endcase 
    end
end




assign push_grant_o = push_grant_o_reg;
assign pop_valid_o  = pop_valid_o_reg;




/////////////////////////////////////////////////
//          DATA PATH                          //
/////////////////////////////////////////////////

// sram instance
sram sram_inst (
    .clk        (clk          )  ,
    .addr_i     (fifo_addr    )  , 
    .wdata_i    (push_data_i  )  ,
    .we_i       (fifo_we      )  , 
    .rdata_o    (pop_data_o   )
);





endmodule